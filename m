From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic31xx: Rename AIF_IN from 'DAC
	IN' to 'AIF IN'" to the asoc tree
Date: Mon, 19 Feb 2018 12:18:46 +0000
Message-ID: <E1enkP8-0002ln-Ao@debutante>
References: <20180219094508.26662-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AB1C1267409
 for <alsa-devel@alsa-project.org>; Mon, 19 Feb 2018 13:18:48 +0100 (CET)
In-Reply-To: <20180219094508.26662-2-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, s.mueller-klieser@phytec.de, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, afd@ti.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic31xx: Rename AIF_IN from 'DAC IN' to 'AIF IN'

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 7d41bc28e9fa3fed28691019ca0fe36ed68d7b86 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 19 Feb 2018 11:45:07 +0200
Subject: [PATCH] ASoC: tlv320aic31xx: Rename AIF_IN from 'DAC IN' to 'AIF IN'

The audio interface is not really the DAC input. Use more generic name for
it.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic31xx.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic31xx.c b/sound/soc/codecs/tlv320aic31xx.c
index 7090342e8285..e5a1e2be17aa 100644
--- a/sound/soc/codecs/tlv320aic31xx.c
+++ b/sound/soc/codecs/tlv320aic31xx.c
@@ -468,7 +468,7 @@ static int mic_bias_event(struct snd_soc_dapm_widget *w,
 }
 
 static const struct snd_soc_dapm_widget common31xx_dapm_widgets[] = {
-	SND_SOC_DAPM_AIF_IN("DAC IN", "DAC Playback", 0, SND_SOC_NOPM, 0, 0),
+	SND_SOC_DAPM_AIF_IN("AIF IN", "Playback", 0, SND_SOC_NOPM, 0, 0),
 
 	SND_SOC_DAPM_MUX("DAC Left Input",
 			 SND_SOC_NOPM, 0, 0, &ldac_in_control),
@@ -584,12 +584,12 @@ static const struct snd_soc_dapm_widget aic310x_dapm_widgets[] = {
 static const struct snd_soc_dapm_route
 common31xx_audio_map[] = {
 	/* DAC Input Routing */
-	{"DAC Left Input", "Left Data", "DAC IN"},
-	{"DAC Left Input", "Right Data", "DAC IN"},
-	{"DAC Left Input", "Mono", "DAC IN"},
-	{"DAC Right Input", "Left Data", "DAC IN"},
-	{"DAC Right Input", "Right Data", "DAC IN"},
-	{"DAC Right Input", "Mono", "DAC IN"},
+	{"DAC Left Input", "Left Data", "AIF IN"},
+	{"DAC Left Input", "Right Data", "AIF IN"},
+	{"DAC Left Input", "Mono", "AIF IN"},
+	{"DAC Right Input", "Left Data", "AIF IN"},
+	{"DAC Right Input", "Right Data", "AIF IN"},
+	{"DAC Right Input", "Mono", "AIF IN"},
 	{"DAC Left", NULL, "DAC Left Input"},
 	{"DAC Right", NULL, "DAC Right Input"},
 
@@ -679,8 +679,8 @@ aic310x_audio_map[] = {
  */
 static const struct snd_soc_dapm_route
 common31xx_cm_audio_map[] = {
-	{"DAC Left Input", "Off", "DAC IN"},
-	{"DAC Right Input", "Off", "DAC IN"},
+	{"DAC Left Input", "Off", "AIF IN"},
+	{"DAC Right Input", "Off", "AIF IN"},
 
 	{"HPL", NULL, "DAC Left"},
 	{"HPR", NULL, "DAC Right"},
-- 
2.16.1
