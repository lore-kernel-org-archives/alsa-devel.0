From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tlv320aic32x4: Implement resistors on
	input pins" to the asoc tree
Date: Thu, 21 Apr 2016 17:11:37 +0100
Message-ID: <E1atHCb-0002zo-Kv@debutante>
References: <1461177552-31809-2-git-send-email-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CE27B2666BD
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2016 18:11:42 +0200 (CEST)
In-Reply-To: <1461177552-31809-2-git-send-email-nh6z@nh6z.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeremy McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tlv320aic32x4: Implement resistors on input pins

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 20d2cecbb7b9c35235c97f0dfa520525c28f8841 Mon Sep 17 00:00:00 2001
From: Jeremy McDermond <nh6z@nh6z.net>
Date: Wed, 20 Apr 2016 11:39:11 -0700
Subject: [PATCH] ASoC: tlv320aic32x4: Implement resistors on input pins

The input pins of the aic3204 have resistors inline with them.  The
current code assumes that you want a 10k resistor inline with your
inputs and implements it as a simple switch.  This patch creates an enum
for each pin and allows you to switch between not connected, 10k, 20k
and 40k ohm values.  This more closely models the acutal aic3204 part.

These pin settings are documented in TI's SLAA557 pages 135 and 136
(http://www.ti.com/lit/ml/slaa557/slaa557.pdf).

Signed-off-by: Jeremy McDermond <nh6z@nh6z.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tlv320aic32x4.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 2f8480c93b3c..621f4210cd27 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -183,16 +183,34 @@ static const struct snd_kcontrol_new lor_output_mixer_controls[] = {
 	SOC_DAPM_SINGLE("R_DAC Switch", AIC32X4_LORROUTE, 3, 1, 0),
 };
 
+static const char * const resistor_text[] = {
+	"Off", "10 kOhm", "20 kOhm", "40 kOhm",
+};
+
+static SOC_ENUM_SINGLE_DECL(in1l_lpga_p_enum, AIC32X4_LMICPGAPIN, 6,
+		resistor_text);
+static SOC_ENUM_SINGLE_DECL(in2l_lpga_p_enum, AIC32X4_LMICPGAPIN, 4,
+		resistor_text);
+static SOC_ENUM_SINGLE_DECL(in3l_lpga_p_enum, AIC32X4_LMICPGAPIN, 2,
+		resistor_text);
+
 static const struct snd_kcontrol_new left_input_mixer_controls[] = {
-	SOC_DAPM_SINGLE("IN1_L P Switch", AIC32X4_LMICPGAPIN, 6, 1, 0),
-	SOC_DAPM_SINGLE("IN2_L P Switch", AIC32X4_LMICPGAPIN, 4, 1, 0),
-	SOC_DAPM_SINGLE("IN3_L P Switch", AIC32X4_LMICPGAPIN, 2, 1, 0),
+	SOC_DAPM_ENUM("IN1_L P Switch", in1l_lpga_p_enum),
+	SOC_DAPM_ENUM("IN2_L P Switch", in2l_lpga_p_enum),
+	SOC_DAPM_ENUM("IN3_L P Switch", in3l_lpga_p_enum),
 };
 
+static SOC_ENUM_SINGLE_DECL(in1r_rpga_p_enum, AIC32X4_RMICPGAPIN, 6,
+		resistor_text);
+static SOC_ENUM_SINGLE_DECL(in2r_rpga_p_enum, AIC32X4_RMICPGAPIN, 4,
+		resistor_text);
+static SOC_ENUM_SINGLE_DECL(in3r_rpga_p_enum, AIC32X4_RMICPGAPIN, 2,
+		resistor_text);
+
 static const struct snd_kcontrol_new right_input_mixer_controls[] = {
-	SOC_DAPM_SINGLE("IN1_R P Switch", AIC32X4_RMICPGAPIN, 6, 1, 0),
-	SOC_DAPM_SINGLE("IN2_R P Switch", AIC32X4_RMICPGAPIN, 4, 1, 0),
-	SOC_DAPM_SINGLE("IN3_R P Switch", AIC32X4_RMICPGAPIN, 2, 1, 0),
+	SOC_DAPM_ENUM("IN1_R P Switch", in1r_rpga_p_enum),
+	SOC_DAPM_ENUM("IN2_R P Switch", in2r_rpga_p_enum),
+	SOC_DAPM_ENUM("IN3_R P Switch", in3r_rpga_p_enum),
 };
 
 static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
-- 
2.8.0.rc3
