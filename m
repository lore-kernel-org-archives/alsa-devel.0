From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm2602: Fix ADC powerup sequencing" to
	the asoc tree
Date: Wed,  6 Feb 2019 16:58:18 +0000 (GMT)
Message-ID: <20190206165818.83C7D1127EA4@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B83F6267979
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 17:58:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Marco Felsch <m.felsch@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm2602: Fix ADC powerup sequencing

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

>From 37768e3917405e82611af8e693ccac1a20df38b5 Mon Sep 17 00:00:00 2001
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Wed, 6 Feb 2019 16:29:47 +0100
Subject: [PATCH] ASoC: ssm2602: Fix ADC powerup sequencing

According to the ssm2603 data sheet (control register sequencing), the
digital core should be activated only after all necessary bits in the
power register are enabled, and a delay determined by the decoupling
capacitor on the VMID pin has passed. If the digital core is activated
too early, or even before the ADC is powered up, audible artifacts
appear at the beginning of the recorded signal.

The digital core is also needed for playback, so when recording starts
it may already be enabled. This means we cannot get the power sequence
correct when we want to be able to start recording after playback.

As a workaround put the MIC mute switch into the DAPM routes. This
way we can keep the recording disabled until the MIC Bias has settled
and thus get rid of audible artifacts.

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
m.felsch@pengutronix.de: adapt commit message
m.felsch@pengutronix.de: drop of configuration as mentioned by Mark:
			 https://patchwork.kernel.org/patch/10407449/
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ssm2602.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index 501a4e73b185..6f79cb0fbc63 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -26,6 +26,7 @@
  * 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -111,7 +112,6 @@ SOC_SINGLE_TLV("Sidetone Playback Volume", SSM2602_APANA, 6, 3, 1,
 
 SOC_SINGLE("Mic Boost (+20dB)", SSM2602_APANA, 0, 1, 0),
 SOC_SINGLE("Mic Boost2 (+20dB)", SSM2602_APANA, 8, 1, 0),
-SOC_SINGLE("Mic Switch", SSM2602_APANA, 1, 1, 1),
 };
 
 /* Output Mixer */
@@ -121,10 +121,31 @@ SOC_DAPM_SINGLE("HiFi Playback Switch", SSM2602_APANA, 4, 1, 0),
 SOC_DAPM_SINGLE("Mic Sidetone Switch", SSM2602_APANA, 5, 1, 0),
 };
 
+static const struct snd_kcontrol_new mic_ctl =
+	SOC_DAPM_SINGLE("Switch", SSM2602_APANA, 1, 1, 1);
+
 /* Input mux */
 static const struct snd_kcontrol_new ssm2602_input_mux_controls =
 SOC_DAPM_ENUM("Input Select", ssm2602_enum[0]);
 
+static int ssm2602_mic_switch_event(struct snd_soc_dapm_widget *w,
+				struct snd_kcontrol *kcontrol, int event)
+{
+	/*
+	 * According to the ssm2603 data sheet (control register sequencing),
+	 * the digital core should be activated only after all necessary bits
+	 * in the power register are enabled, and a delay determined by the
+	 * decoupling capacitor on the VMID pin has passed. If the digital core
+	 * is activated too early, or even before the ADC is powered up, audible
+	 * artifacts appear at the beginning and end of the recorded signal.
+	 *
+	 * In practice, audible artifacts disappear well over 500 ms.
+	 */
+	msleep(500);
+
+	return 0;
+}
+
 static const struct snd_soc_dapm_widget ssm260x_dapm_widgets[] = {
 SND_SOC_DAPM_DAC("DAC", "HiFi Playback", SSM2602_PWR, 3, 1),
 SND_SOC_DAPM_ADC("ADC", "HiFi Capture", SSM2602_PWR, 2, 1),
@@ -146,6 +167,9 @@ SND_SOC_DAPM_MIXER("Output Mixer", SSM2602_PWR, 4, 1,
 SND_SOC_DAPM_MUX("Input Mux", SND_SOC_NOPM, 0, 0, &ssm2602_input_mux_controls),
 SND_SOC_DAPM_MICBIAS("Mic Bias", SSM2602_PWR, 1, 1),
 
+SND_SOC_DAPM_SWITCH_E("Mic Switch", SSM2602_APANA, 1, 1, &mic_ctl,
+		ssm2602_mic_switch_event, SND_SOC_DAPM_PRE_PMU),
+
 SND_SOC_DAPM_OUTPUT("LHPOUT"),
 SND_SOC_DAPM_OUTPUT("RHPOUT"),
 SND_SOC_DAPM_INPUT("MICIN"),
@@ -178,9 +202,11 @@ static const struct snd_soc_dapm_route ssm2602_routes[] = {
 	{"LHPOUT", NULL, "Output Mixer"},
 
 	{"Input Mux", "Line", "Line Input"},
-	{"Input Mux", "Mic", "Mic Bias"},
+	{"Input Mux", "Mic", "Mic Switch"},
 	{"ADC", NULL, "Input Mux"},
 
+	{"Mic Switch", NULL, "Mic Bias"},
+
 	{"Mic Bias", NULL, "MICIN"},
 };
 
-- 
2.20.1
