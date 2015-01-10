From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: sn95031: Replace w->codec
	snd_soc_dapm_to_codec(w->dapm)
Date: Sat, 10 Jan 2015 15:44:08 +0100
Message-ID: <1420901048-5756-5-git-send-email-lars@metafoo.de>
References: <1420901048-5756-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-109.synserver.de (smtp-out-109.synserver.de
 [212.40.185.109])
 by alsa0.perex.cz (Postfix) with ESMTP id 2EBE92606F3
 for <alsa-devel@alsa-project.org>; Sat, 10 Jan 2015 15:44:30 +0100 (CET)
In-Reply-To: <1420901048-5756-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Support Opensource <support.opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The codec field of the snd_soc_widget struct is eventually going to be
removed, use snd_soc_dapm_to_codec(w->dapm) instead.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/sn95031.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/sn95031.c b/sound/soc/codecs/sn95031.c
index 1f451a1..47b257e 100644
--- a/sound/soc/codecs/sn95031.c
+++ b/sound/soc/codecs/sn95031.c
@@ -233,16 +233,18 @@ static int sn95031_set_vaud_bias(struct snd_soc_codec *codec,
 static int sn95031_vhs_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		pr_debug("VHS SND_SOC_DAPM_EVENT_ON doing rail startup now\n");
 		/* power up the rail */
-		snd_soc_write(w->codec, SN95031_VHSP, 0x3D);
-		snd_soc_write(w->codec, SN95031_VHSN, 0x3F);
+		snd_soc_write(codec, SN95031_VHSP, 0x3D);
+		snd_soc_write(codec, SN95031_VHSN, 0x3F);
 		msleep(1);
 	} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
 		pr_debug("VHS SND_SOC_DAPM_EVENT_OFF doing rail shutdown\n");
-		snd_soc_write(w->codec, SN95031_VHSP, 0xC4);
-		snd_soc_write(w->codec, SN95031_VHSN, 0x04);
+		snd_soc_write(codec, SN95031_VHSP, 0xC4);
+		snd_soc_write(codec, SN95031_VHSN, 0x04);
 	}
 	return 0;
 }
@@ -250,14 +252,16 @@ static int sn95031_vhs_event(struct snd_soc_dapm_widget *w,
 static int sn95031_vihf_event(struct snd_soc_dapm_widget *w,
 		    struct snd_kcontrol *kcontrol, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
+
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
 		pr_debug("VIHF SND_SOC_DAPM_EVENT_ON doing rail startup now\n");
 		/* power up the rail */
-		snd_soc_write(w->codec, SN95031_VIHF, 0x27);
+		snd_soc_write(codec, SN95031_VIHF, 0x27);
 		msleep(1);
 	} else if (SND_SOC_DAPM_EVENT_OFF(event)) {
 		pr_debug("VIHF SND_SOC_DAPM_EVENT_OFF doing rail shutdown\n");
-		snd_soc_write(w->codec, SN95031_VIHF, 0x24);
+		snd_soc_write(codec, SN95031_VIHF, 0x24);
 	}
 	return 0;
 }
@@ -265,6 +269,7 @@ static int sn95031_vihf_event(struct snd_soc_dapm_widget *w,
 static int sn95031_dmic12_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *k, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	unsigned int ldo = 0, clk_dir = 0, data_dir = 0;
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
@@ -273,15 +278,16 @@ static int sn95031_dmic12_event(struct snd_soc_dapm_widget *w,
 		data_dir = BIT(7);
 	}
 	/* program DMIC LDO, clock and set clock */
-	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(5)|BIT(4), ldo);
-	snd_soc_update_bits(w->codec, SN95031_DMICBUF0123, BIT(0), clk_dir);
-	snd_soc_update_bits(w->codec, SN95031_DMICBUF0123, BIT(7), data_dir);
+	snd_soc_update_bits(codec, SN95031_MICBIAS, BIT(5)|BIT(4), ldo);
+	snd_soc_update_bits(codec, SN95031_DMICBUF0123, BIT(0), clk_dir);
+	snd_soc_update_bits(codec, SN95031_DMICBUF0123, BIT(7), data_dir);
 	return 0;
 }
 
 static int sn95031_dmic34_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *k, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	unsigned int ldo = 0, clk_dir = 0, data_dir = 0;
 
 	if (SND_SOC_DAPM_EVENT_ON(event)) {
@@ -290,22 +296,23 @@ static int sn95031_dmic34_event(struct snd_soc_dapm_widget *w,
 		data_dir = BIT(1);
 	}
 	/* program DMIC LDO, clock and set clock */
-	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(5)|BIT(4), ldo);
-	snd_soc_update_bits(w->codec, SN95031_DMICBUF0123, BIT(2), clk_dir);
-	snd_soc_update_bits(w->codec, SN95031_DMICBUF45, BIT(1), data_dir);
+	snd_soc_update_bits(codec, SN95031_MICBIAS, BIT(5)|BIT(4), ldo);
+	snd_soc_update_bits(codec, SN95031_DMICBUF0123, BIT(2), clk_dir);
+	snd_soc_update_bits(codec, SN95031_DMICBUF45, BIT(1), data_dir);
 	return 0;
 }
 
 static int sn95031_dmic56_event(struct snd_soc_dapm_widget *w,
 			struct snd_kcontrol *k, int event)
 {
+	struct snd_soc_codec *codec = snd_soc_dapm_to_codec(w->dapm);
 	unsigned int ldo = 0;
 
 	if (SND_SOC_DAPM_EVENT_ON(event))
 		ldo = BIT(7)|BIT(6);
 
 	/* program DMIC LDO */
-	snd_soc_update_bits(w->codec, SN95031_MICBIAS, BIT(7)|BIT(6), ldo);
+	snd_soc_update_bits(codec, SN95031_MICBIAS, BIT(7)|BIT(6), ldo);
 	return 0;
 }
 
-- 
1.8.0
