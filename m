From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Simplify WM9081 speaker startup by using
	widgets for spaker output
Date: Tue,  8 Mar 2011 18:52:35 +0000
Message-ID: <1299610355-17455-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CAF74246AE
	for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2011 19:52:12 +0100 (CET)
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

Now we have a register write minimisation code in DAPM we don't need to
worry about the ordering of the enable and disable of the PGA and the
output stage.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9081.c |   32 ++++++--------------------------
 1 files changed, 6 insertions(+), 26 deletions(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index effaf75..55cdf29 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -389,27 +389,6 @@ SOC_DAPM_SINGLE("IN2 Switch", WM9081_ANALOGUE_MIXER, 2, 1, 0),
 SOC_DAPM_SINGLE("Playback Switch", WM9081_ANALOGUE_MIXER, 4, 1, 0),
 };
 
-static int speaker_event(struct snd_soc_dapm_widget *w,
-			 struct snd_kcontrol *kcontrol, int event)
-{
-	struct snd_soc_codec *codec = w->codec;
-	unsigned int reg = snd_soc_read(codec, WM9081_POWER_MANAGEMENT);
-
-	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
-		reg |= WM9081_SPK_ENA;
-		break;
-
-	case SND_SOC_DAPM_PRE_PMD:
-		reg &= ~WM9081_SPK_ENA;
-		break;
-	}
-
-	snd_soc_write(codec, WM9081_POWER_MANAGEMENT, reg);
-
-	return 0;
-}
-
 struct _fll_div {
 	u16 fll_fratio;
 	u16 fll_outdiv;
@@ -747,9 +726,8 @@ SND_SOC_DAPM_MIXER_NAMED_CTL("Mixer", SND_SOC_NOPM, 0, 0,
 
 SND_SOC_DAPM_PGA("LINEOUT PGA", WM9081_POWER_MANAGEMENT, 4, 0, NULL, 0),
 
-SND_SOC_DAPM_PGA_E("Speaker PGA", WM9081_POWER_MANAGEMENT, 2, 0, NULL, 0,
-		   speaker_event,
-		   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+SND_SOC_DAPM_PGA("Speaker PGA", WM9081_POWER_MANAGEMENT, 2, 0, NULL, 0),
+SND_SOC_DAPM_PGA("Speaker", WM9081_POWER_MANAGEMENT, 1, 0, NULL, 0),
 
 SND_SOC_DAPM_OUTPUT("LINEOUT"),
 SND_SOC_DAPM_OUTPUT("SPKN"),
@@ -780,8 +758,10 @@ static const struct snd_soc_dapm_route wm9081_audio_paths[] = {
 	{ "Speaker PGA", NULL, "TOCLK" },
 	{ "Speaker PGA", NULL, "CLK_SYS" },
 
-	{ "SPKN", NULL, "Speaker PGA" },
-	{ "SPKP", NULL, "Speaker PGA" },
+	{ "Speaker", NULL, "Speaker PGA" },
+
+	{ "SPKN", NULL, "Speaker" },
+	{ "SPKP", NULL, "Speaker" },
 };
 
 static int wm9081_set_bias_level(struct snd_soc_codec *codec,
-- 
1.7.2.3
