From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ASoC: Handle startup sequencing of WM8958
	DSP2 with deferred clocking
Date: Wed, 16 Mar 2011 15:48:52 +0000
Message-ID: <1300290532-30555-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1300290532-30555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D149124498
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2011 16:49:02 +0100 (CET)
In-Reply-To: <1300290532-30555-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

The DSP2 startup requires that the clock be enable so if we've deferred
clock startup we need to defer DSP2 startup

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8958-dsp2.c |   35 ++++++++++++++---------------------
 sound/soc/codecs/wm8994.c      |    3 +++
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/sound/soc/codecs/wm8958-dsp2.c b/sound/soc/codecs/wm8958-dsp2.c
index 4b4c93c..f07775e 100644
--- a/sound/soc/codecs/wm8958-dsp2.c
+++ b/sound/soc/codecs/wm8958-dsp2.c
@@ -69,6 +69,13 @@ static void wm8958_mbc_apply(struct snd_soc_codec *codec, int mbc, int start)
 		if (reg & WM8958_DSP2_ENA)
 			return;
 
+		/* If neither AIFnCLK is not yet enabled postpone */
+		if (!(snd_soc_read(codec, WM8994_AIF1_CLOCKING_1)
+		      & WM8994_AIF1CLK_ENA_MASK) &&
+		    !(snd_soc_read(codec, WM8994_AIF2_CLOCKING_1)
+		      & WM8994_AIF2CLK_ENA_MASK))
+			return;
+
 		/* Switch the clock over to the appropriate AIF */
 		snd_soc_update_bits(codec, WM8994_CLOCKING_1,
 				    WM8958_DSP2CLK_SRC | WM8958_DSP2CLK_ENA,
@@ -120,32 +127,18 @@ int wm8958_aif_ev(struct snd_soc_dapm_widget *w,
 		  struct snd_kcontrol *kcontrol, int event)
 {
 	struct snd_soc_codec *codec = w->codec;
-	int mbc;
-
-	switch (w->shift) {
-	case 13:
-	case 12:
-		mbc = 2;
-		break;
-	case 11:
-	case 10:
-		mbc = 1;
-		break;
-	case 9:
-	case 8:
-		mbc = 0;
-		break;
-	default:
-		BUG();
-		return -EINVAL;
-	}
+	int i;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		wm8958_mbc_apply(codec, mbc, 1);
+	case SND_SOC_DAPM_PRE_PMU:
+		for (i = 0; i < 3; i++)
+			wm8958_mbc_apply(codec, i, 1);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
-		wm8958_mbc_apply(codec, mbc, 0);
+	case SND_SOC_DAPM_PRE_PMD:
+		for (i = 0; i < 3; i++)
+			wm8958_mbc_apply(codec, i, 0);
 		break;
 	}
 
diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 96e1379..328f328 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -759,6 +759,9 @@ static int late_enable_ev(struct snd_soc_dapm_widget *w,
 		break;
 	}
 
+	/* We may also have postponed startup of DSP, handle that. */
+	wm8958_aif_ev(w, kcontrol, event);
+
 	return 0;
 }
 
-- 
1.7.4.1
