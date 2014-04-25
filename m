From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 24/49] fireworks/firewire-lib: Add a quirk for wrong dbs in tx
	packets
Date: Fri, 25 Apr 2014 22:45:05 +0900
Message-ID: <1398433530-13136-25-git-send-email-o-takashi@sakamocchi.jp>
References: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1398433530-13136-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

One of Fireworks firmware, named  as 'AudioFire9', seems to transmit
packets with wrong value of dbs. It's always 0x11 but actual size of
data block is different.

This commit adds a flag for this quirk and some codes to calculate
correct size.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c                      | 2 ++
 sound/firewire/amdtp.h                      | 3 +++
 sound/firewire/fireworks/fireworks.c        | 2 ++
 sound/firewire/fireworks/fireworks.h        | 3 +++
 sound/firewire/fireworks/fireworks_stream.c | 3 +++
 5 files changed, 13 insertions(+)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 51aad68..3903387 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -653,6 +653,8 @@ static void handle_in_packet(struct amdtp_stream *s,
 				cip_header[0]);
 			goto err;
 		}
+		if (s->flags & CIP_WRONG_DBS)
+			data_block_quadlets = s->data_block_quadlets;
 
 		data_blocks = (payload_quadlets - 2) / data_block_quadlets;
 	}
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 1ca1a19..f334ae5 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -21,6 +21,8 @@
  * @CIP_EMPTY_WITH_TAG0: Only for in-stream. Empty in-packets have TAG0.
  * @CIP_DBC_IS_END_EVENT: Only for in-stream. The value of dbc in an in-packet
  *	corresponds to the end of event in the packet. Out of IEC 61883.
+ * @CIP_WRONG_DBS: Only for in-stream. The value of dbs is wrong in in-packets.
+ *	The value of data_block_quadlets is used instead of reported value.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -28,6 +30,7 @@ enum cip_flags {
 	CIP_SYNC_TO_DEVICE	= 0x02,
 	CIP_EMPTY_WITH_TAG0	= 0x04,
 	CIP_DBC_IS_END_EVENT	= 0x08,
+	CIP_WRONG_DBS		= 0x10,
 };
 
 /**
diff --git a/sound/firewire/fireworks/fireworks.c b/sound/firewire/fireworks/fireworks.c
index 307fb2f..02b3259 100644
--- a/sound/firewire/fireworks/fireworks.c
+++ b/sound/firewire/fireworks/fireworks.c
@@ -205,6 +205,8 @@ efw_probe(struct fw_unit *unit,
 	err = get_hardware_info(efw);
 	if (err < 0)
 		goto error;
+	if (entry->model_id == MODEL_ECHO_AUDIOFIRE_9)
+		efw->is_af9 = true;
 
 	err = snd_efw_stream_init_duplex(efw);
 	if (err < 0)
diff --git a/sound/firewire/fireworks/fireworks.h b/sound/firewire/fireworks/fireworks.h
index ce511be..9534e93 100644
--- a/sound/firewire/fireworks/fireworks.h
+++ b/sound/firewire/fireworks/fireworks.h
@@ -61,6 +61,9 @@ struct snd_efw {
 	u32 seqnum;
 	bool resp_addr_changable;
 
+	/* for quirks */
+	bool is_af9;
+
 	unsigned int midi_in_ports;
 	unsigned int midi_out_ports;
 
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index d687b04..7447af7 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -198,6 +198,9 @@ int snd_efw_stream_init_duplex(struct snd_efw *efw)
 	efw->tx_stream.flags |= CIP_EMPTY_WITH_TAG0;
 	/* Fireworks has its own meaning for dbc. */
 	efw->tx_stream.flags |= CIP_DBC_IS_END_EVENT;
+	/* AudioFire9 always reports wrong dbs. */
+	if (efw->is_af9)
+		efw->tx_stream.flags |= CIP_WRONG_DBS;
 
 	err = init_stream(efw, &efw->rx_stream);
 	if (err < 0) {
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
