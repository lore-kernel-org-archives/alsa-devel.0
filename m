From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 2/6] bebob: Reducing function callers for
	simplicity
Date: Mon, 21 Jul 2014 11:10:01 +0900
Message-ID: <1405908605-8105-3-git-send-email-o-takashi@sakamocchi.jp>
References: <1405831835-26499-1-git-send-email-weiyj_lk@163.com>
 <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 693862650DA
 for <alsa-devel@alsa-project.org>; Mon, 21 Jul 2014 04:10:15 +0200 (CEST)
In-Reply-To: <1405908605-8105-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de, perex@perex.cz
Cc: alsa-devel@alsa-project.org, darrena092@gmail.com, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

M-Audio Firewire 1814 and ProjectMix I/O change their stream formation
according to current digital format for input/output, although drivers
cannot recognize current formation by any commands. Thus the drivers
need to remember the formations. The special_stream_formation_set() is
for this purpose.

This function is expected to be called just after current digital formats
are changed. The way to change current digital format is to call
avc_maudio_set_special_clk() and there is no other ways.

For simplicity, this commit make the avc_maudio_set_special_clk() as a sole
caller for the special_stream_formation_set().

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/bebob/bebob_maudio.c | 62 ++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/sound/firewire/bebob/bebob_maudio.c b/sound/firewire/bebob/bebob_maudio.c
index 0a33045..83f8d5b 100644
--- a/sound/firewire/bebob/bebob_maudio.c
+++ b/sound/firewire/bebob/bebob_maudio.c
@@ -160,6 +160,35 @@ end:
 	return err;
 }
 
+static void
+special_stream_formation_set(struct snd_bebob *bebob)
+{
+	static const unsigned int ch_table[2][2][3] = {
+		/* AMDTP_OUT_STREAM */
+		{ {  6,  6,  4 },	/* SPDIF */
+		  { 12,  8,  4 } },	/* ADAT */
+		/* AMDTP_IN_STREAM */
+		{ { 10, 10,  2 },	/* SPDIF */
+		  { 16, 12,  2 } }	/* ADAT */
+	};
+	struct special_params *params = bebob->maudio_special_quirk;
+	unsigned int i, max;
+
+	max = SND_BEBOB_STRM_FMT_ENTRIES - 1;
+	if (!params->is1814)
+		max -= 2;
+
+	for (i = 0; i < max; i++) {
+		bebob->tx_stream_formations[i + 1].pcm =
+			ch_table[AMDTP_IN_STREAM][params->dig_in_fmt][i / 2];
+		bebob->tx_stream_formations[i + 1].midi = 1;
+
+		bebob->rx_stream_formations[i + 1].pcm =
+			ch_table[AMDTP_OUT_STREAM][params->dig_out_fmt][i / 2];
+		bebob->rx_stream_formations[i + 1].midi = 1;
+	}
+}
+
 /*
  * dig_fmt: 0x00:S/PDIF, 0x01:ADAT
  * clk_lock: 0x00:unlock, 0x01:lock
@@ -212,6 +241,8 @@ avc_maudio_set_special_clk(struct snd_bebob *bebob, unsigned int clk_src,
 	params->dig_out_fmt	= buf[8];
 	params->clk_lock	= buf[9];
 
+	special_stream_formation_set(bebob);
+
 	if (params->ctl_id_sync)
 		snd_ctl_notify(bebob->card, SNDRV_CTL_EVENT_MASK_VALUE,
 			       params->ctl_id_sync);
@@ -221,34 +252,6 @@ end:
 	kfree(buf);
 	return err;
 }
-static void
-special_stream_formation_set(struct snd_bebob *bebob)
-{
-	static const unsigned int ch_table[2][2][3] = {
-		/* AMDTP_OUT_STREAM */
-		{ {  6,  6,  4 },	/* SPDIF */
-		  { 12,  8,  4 } },	/* ADAT */
-		/* AMDTP_IN_STREAM */
-		{ { 10, 10,  2 },	/* SPDIF */
-		  { 16, 12,  2 } }	/* ADAT */
-	};
-	struct special_params *params = bebob->maudio_special_quirk;
-	unsigned int i, max;
-
-	max = SND_BEBOB_STRM_FMT_ENTRIES - 1;
-	if (!params->is1814)
-		max -= 2;
-
-	for (i = 0; i < max; i++) {
-		bebob->tx_stream_formations[i + 1].pcm =
-			ch_table[AMDTP_IN_STREAM][params->dig_in_fmt][i / 2];
-		bebob->tx_stream_formations[i + 1].midi = 1;
-
-		bebob->rx_stream_formations[i + 1].pcm =
-			ch_table[AMDTP_OUT_STREAM][params->dig_out_fmt][i / 2];
-		bebob->rx_stream_formations[i + 1].midi = 1;
-	}
-}
 
 static int add_special_controls(struct snd_bebob *bebob);
 int
@@ -280,8 +283,6 @@ snd_bebob_maudio_special_discover(struct snd_bebob *bebob, bool is1814)
 	if (err < 0)
 		goto end;
 
-	special_stream_formation_set(bebob);
-
 	if (params->is1814) {
 		bebob->midi_input_ports = 1;
 		bebob->midi_output_ports = 1;
@@ -513,7 +514,6 @@ static int special_dig_in_iface_ctl_set(struct snd_kcontrol *kctl,
 		dev_err(&bebob->unit->device,
 			"fail to set digital input interface: %d\n", err);
 end:
-	special_stream_formation_set(bebob);
 	mutex_unlock(&bebob->mutex);
 	return err;
 }
-- 
1.9.1
