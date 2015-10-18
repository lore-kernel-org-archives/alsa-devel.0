From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 3/3] ALSA: oxfw: add an entry for TASCAM FireOne
Date: Sun, 18 Oct 2015 17:09:40 +0900
Message-ID: <1445155780-7600-4-git-send-email-o-takashi@sakamocchi.jp>
References: <1445155780-7600-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id A9D8626153F
 for <alsa-devel@alsa-project.org>; Sun, 18 Oct 2015 10:09:44 +0200 (CEST)
In-Reply-To: <1445155780-7600-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

TASCAM FireOne is based on OXFW971 and ALSA OXFW driver can support it.
These are values of identical registers.

$ ./firewire-request /dev/fw1 read 0xfffff0050000
result: 97100105

$ ./firewire-request /dev/fw1 read 0xfffff0090020
result: 39373100

This commit adds an entry for this model. This model has physical controls
and its MIDI control messages are transferred to second MIDI data stream
multiplexed in one MIDI conformant data channel.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/oxfw/oxfw.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/sound/firewire/oxfw/oxfw.c b/sound/firewire/oxfw/oxfw.c
index d606e3a..588b93f 100644
--- a/sound/firewire/oxfw/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -18,6 +18,7 @@
 #define VENDOR_GRIFFIN		0x001292
 #define VENDOR_BEHRINGER	0x001564
 #define VENDOR_LACIE		0x00d04b
+#define VENDOR_TASCAM		0x00022e
 
 #define MODEL_SATELLITE		0x00200f
 
@@ -154,6 +155,15 @@ static void detect_quirks(struct snd_oxfw *oxfw)
 	 */
 	if (vendor == VENDOR_LOUD && model == MODEL_SATELLITE)
 		oxfw->wrong_dbs = true;
+
+	/*
+	 * TASCAM FireOne has physical control and requires a pair of additional
+	 * MIDI ports.
+	 */
+	if (vendor == VENDOR_TASCAM) {
+		oxfw->midi_input_ports++;
+		oxfw->midi_output_ports++;
+	}
 }
 
 static int oxfw_probe(struct fw_unit *unit,
@@ -323,6 +333,13 @@ static const struct ieee1394_device_id oxfw_id_table[] = {
 		.specifier_id	= SPECIFIER_1394TA,
 		.version	= VERSION_AVC,
 	},
+	/* TASCAM, FireOne */
+	{
+		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
+				  IEEE1394_MATCH_MODEL_ID,
+		.vendor_id	= VENDOR_TASCAM,
+		.model_id	= 0x800007,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(ieee1394, oxfw_id_table);
-- 
2.1.4
