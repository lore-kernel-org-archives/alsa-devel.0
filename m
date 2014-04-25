From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 26/49] fireworks/firewire-lib: Add a quirk to reset data block
	counter at bus reset
Date: Fri, 25 Apr 2014 22:45:07 +0900
Message-ID: <1398433530-13136-27-git-send-email-o-takashi@sakamocchi.jp>
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

Fireworks has a quirk to reset data block counter at bus reset.

This commit adds a flag of CIP_SKIP_DBC_ZERO_CHECK. This flag has an effect
to skip checking dbc continuity when dbc is zero.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/amdtp.c                      | 4 +++-
 sound/firewire/amdtp.h                      | 3 +++
 sound/firewire/fireworks/fireworks_stream.c | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/firewire/amdtp.c b/sound/firewire/amdtp.c
index 4a7cc1f..5e13b3f 100644
--- a/sound/firewire/amdtp.c
+++ b/sound/firewire/amdtp.c
@@ -662,7 +662,9 @@ static void handle_in_packet(struct amdtp_stream *s,
 
 	/* Check data block counter continuity */
 	data_block_counter = cip_header[0] & AMDTP_DBC_MASK;
-	if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
+	if ((s->flags & CIP_SKIP_DBC_ZERO_CHECK) && data_block_counter == 0) {
+		lost = false;
+	} else if (!(s->flags & CIP_DBC_IS_END_EVENT)) {
 		lost = data_block_counter != s->data_block_counter;
 	} else {
 		if ((data_blocks > 0) && (s->tx_dbc_interval > 0))
diff --git a/sound/firewire/amdtp.h b/sound/firewire/amdtp.h
index 05f1b8b..42c75c9 100644
--- a/sound/firewire/amdtp.h
+++ b/sound/firewire/amdtp.h
@@ -23,6 +23,8 @@
  *	corresponds to the end of event in the packet. Out of IEC 61883.
  * @CIP_WRONG_DBS: Only for in-stream. The value of dbs is wrong in in-packets.
  *	The value of data_block_quadlets is used instead of reported value.
+ * @SKIP_DBC_ZERO_CHECK: Only for in-stream.  Packets with zero in dbc is
+ *	skipped for detecting discontinuity.
  */
 enum cip_flags {
 	CIP_NONBLOCKING		= 0x00,
@@ -31,6 +33,7 @@ enum cip_flags {
 	CIP_EMPTY_WITH_TAG0	= 0x04,
 	CIP_DBC_IS_END_EVENT	= 0x08,
 	CIP_WRONG_DBS		= 0x10,
+	CIP_SKIP_DBC_ZERO_CHECK	= 0x20,
 };
 
 /**
diff --git a/sound/firewire/fireworks/fireworks_stream.c b/sound/firewire/fireworks/fireworks_stream.c
index c75c2ef..3a3f203 100644
--- a/sound/firewire/fireworks/fireworks_stream.c
+++ b/sound/firewire/fireworks/fireworks_stream.c
@@ -198,6 +198,8 @@ int snd_efw_stream_init_duplex(struct snd_efw *efw)
 	efw->tx_stream.flags |= CIP_EMPTY_WITH_TAG0;
 	/* Fireworks has its own meaning for dbc. */
 	efw->tx_stream.flags |= CIP_DBC_IS_END_EVENT;
+	/* Fireworks reset dbc at bus reset. */
+	efw->tx_stream.flags |= CIP_SKIP_DBC_ZERO_CHECK;
 	/* AudioFire9 always reports wrong dbs. */
 	if (efw->is_af9)
 		efw->tx_stream.flags |= CIP_WRONG_DBS;
-- 
1.8.3.2


------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
