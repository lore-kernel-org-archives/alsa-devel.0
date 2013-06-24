From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/5] ASoC: codecs: tas5086: add DAPM mux
	controls
Date: Mon, 24 Jun 2013 16:25:31 +0200
Message-ID: <1372083932-4318-4-git-send-email-zonque@gmail.com>
References: <1372083932-4318-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id C00AB265086
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 16:25:31 +0200 (CEST)
In-Reply-To: <1372083932-4318-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: broonie@kernel.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The TAS5086 has two muxes, one for connecting I2S inputs to internal
channels, and another one for selecting which internal channel should
be routed to which PWM output pin.

This patch adds DAPM widgets and routes for this driver.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 sound/soc/codecs/tas5086.c | 200 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/sound/soc/codecs/tas5086.c b/sound/soc/codecs/tas5086.c
index b2aea5d..99e190d 100644
--- a/sound/soc/codecs/tas5086.c
+++ b/sound/soc/codecs/tas5086.c
@@ -471,6 +471,202 @@ static const struct snd_kcontrol_new tas5086_controls[] = {
 			    tas5086_get_deemph, tas5086_put_deemph),
 };
 
+/* Input mux controls */
+static const char *tas5086_dapm_sdin_texts[] =
+{
+	"SDIN1-L", "SDIN1-R", "SDIN2-L", "SDIN2-R",
+	"SDIN3-L", "SDIN3-R", "Ground (0)", "nc"
+};
+
+static const struct soc_enum tas5086_dapm_input_mux_enum[] = {
+	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 20, 8, tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 16, 8, tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 12, 8, tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 8,  8, tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 4,  8, tas5086_dapm_sdin_texts),
+	SOC_ENUM_SINGLE(TAS5086_INPUT_MUX, 0,  8, tas5086_dapm_sdin_texts),
+};
+
+static const struct snd_kcontrol_new tas5086_dapm_input_mux_controls[] = {
+	SOC_DAPM_ENUM("Channel 1 input", tas5086_dapm_input_mux_enum[0]),
+	SOC_DAPM_ENUM("Channel 2 input", tas5086_dapm_input_mux_enum[1]),
+	SOC_DAPM_ENUM("Channel 3 input", tas5086_dapm_input_mux_enum[2]),
+	SOC_DAPM_ENUM("Channel 4 input", tas5086_dapm_input_mux_enum[3]),
+	SOC_DAPM_ENUM("Channel 5 input", tas5086_dapm_input_mux_enum[4]),
+	SOC_DAPM_ENUM("Channel 6 input", tas5086_dapm_input_mux_enum[5]),
+};
+
+/* Output mux controls */
+static const char *tas5086_dapm_channel_texts[] =
+	{ "Channel 1 Mux", "Channel 2 Mux", "Channel 3 Mux",
+	  "Channel 4 Mux", "Channel 5 Mux", "Channel 6 Mux" };
+
+static const struct soc_enum tas5086_dapm_output_mux_enum[] = {
+	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 20, 6, tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 16, 6, tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 12, 6, tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 8,  6, tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 4,  6, tas5086_dapm_channel_texts),
+	SOC_ENUM_SINGLE(TAS5086_PWM_OUTPUT_MUX, 0,  6, tas5086_dapm_channel_texts),
+};
+
+static const struct snd_kcontrol_new tas5086_dapm_output_mux_controls[] = {
+	SOC_DAPM_ENUM("PWM1 Output", tas5086_dapm_output_mux_enum[0]),
+	SOC_DAPM_ENUM("PWM2 Output", tas5086_dapm_output_mux_enum[1]),
+	SOC_DAPM_ENUM("PWM3 Output", tas5086_dapm_output_mux_enum[2]),
+	SOC_DAPM_ENUM("PWM4 Output", tas5086_dapm_output_mux_enum[3]),
+	SOC_DAPM_ENUM("PWM5 Output", tas5086_dapm_output_mux_enum[4]),
+	SOC_DAPM_ENUM("PWM6 Output", tas5086_dapm_output_mux_enum[5]),
+};
+
+static const struct snd_soc_dapm_widget tas5086_dapm_widgets[] = {
+	SND_SOC_DAPM_INPUT("SDIN1-L"),
+	SND_SOC_DAPM_INPUT("SDIN1-R"),
+	SND_SOC_DAPM_INPUT("SDIN2-L"),
+	SND_SOC_DAPM_INPUT("SDIN2-R"),
+	SND_SOC_DAPM_INPUT("SDIN3-L"),
+	SND_SOC_DAPM_INPUT("SDIN3-R"),
+	SND_SOC_DAPM_INPUT("SDIN4-L"),
+	SND_SOC_DAPM_INPUT("SDIN4-R"),
+
+	SND_SOC_DAPM_OUTPUT("PWM1"),
+	SND_SOC_DAPM_OUTPUT("PWM2"),
+	SND_SOC_DAPM_OUTPUT("PWM3"),
+	SND_SOC_DAPM_OUTPUT("PWM4"),
+	SND_SOC_DAPM_OUTPUT("PWM5"),
+	SND_SOC_DAPM_OUTPUT("PWM6"),
+
+	SND_SOC_DAPM_MUX("Channel 1 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_input_mux_controls[0]),
+	SND_SOC_DAPM_MUX("Channel 2 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_input_mux_controls[1]),
+	SND_SOC_DAPM_MUX("Channel 3 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_input_mux_controls[2]),
+	SND_SOC_DAPM_MUX("Channel 4 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_input_mux_controls[3]),
+	SND_SOC_DAPM_MUX("Channel 5 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_input_mux_controls[4]),
+	SND_SOC_DAPM_MUX("Channel 6 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_input_mux_controls[5]),
+
+	SND_SOC_DAPM_MUX("PWM1 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_output_mux_controls[0]),
+	SND_SOC_DAPM_MUX("PWM2 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_output_mux_controls[1]),
+	SND_SOC_DAPM_MUX("PWM3 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_output_mux_controls[2]),
+	SND_SOC_DAPM_MUX("PWM4 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_output_mux_controls[3]),
+	SND_SOC_DAPM_MUX("PWM5 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_output_mux_controls[4]),
+	SND_SOC_DAPM_MUX("PWM6 Mux", SND_SOC_NOPM, 0, 0,
+			 &tas5086_dapm_output_mux_controls[5]),
+};
+
+static const struct snd_soc_dapm_route tas5086_dapm_routes[] = {
+	/* SDIN inputs -> channel muxes */
+	{ "Channel 1 Mux", "SDIN1-L", "SDIN1-L" },
+	{ "Channel 1 Mux", "SDIN1-R", "SDIN1-R" },
+	{ "Channel 1 Mux", "SDIN2-L", "SDIN2-L" },
+	{ "Channel 1 Mux", "SDIN2-R", "SDIN2-R" },
+	{ "Channel 1 Mux", "SDIN3-L", "SDIN3-L" },
+	{ "Channel 1 Mux", "SDIN3-R", "SDIN3-R" },
+
+	{ "Channel 2 Mux", "SDIN1-L", "SDIN1-L" },
+	{ "Channel 2 Mux", "SDIN1-R", "SDIN1-R" },
+	{ "Channel 2 Mux", "SDIN2-L", "SDIN2-L" },
+	{ "Channel 2 Mux", "SDIN2-R", "SDIN2-R" },
+	{ "Channel 2 Mux", "SDIN3-L", "SDIN3-L" },
+	{ "Channel 2 Mux", "SDIN3-R", "SDIN3-R" },
+
+	{ "Channel 2 Mux", "SDIN1-L", "SDIN1-L" },
+	{ "Channel 2 Mux", "SDIN1-R", "SDIN1-R" },
+	{ "Channel 2 Mux", "SDIN2-L", "SDIN2-L" },
+	{ "Channel 2 Mux", "SDIN2-R", "SDIN2-R" },
+	{ "Channel 2 Mux", "SDIN3-L", "SDIN3-L" },
+	{ "Channel 2 Mux", "SDIN3-R", "SDIN3-R" },
+
+	{ "Channel 3 Mux", "SDIN1-L", "SDIN1-L" },
+	{ "Channel 3 Mux", "SDIN1-R", "SDIN1-R" },
+	{ "Channel 3 Mux", "SDIN2-L", "SDIN2-L" },
+	{ "Channel 3 Mux", "SDIN2-R", "SDIN2-R" },
+	{ "Channel 3 Mux", "SDIN3-L", "SDIN3-L" },
+	{ "Channel 3 Mux", "SDIN3-R", "SDIN3-R" },
+
+	{ "Channel 4 Mux", "SDIN1-L", "SDIN1-L" },
+	{ "Channel 4 Mux", "SDIN1-R", "SDIN1-R" },
+	{ "Channel 4 Mux", "SDIN2-L", "SDIN2-L" },
+	{ "Channel 4 Mux", "SDIN2-R", "SDIN2-R" },
+	{ "Channel 4 Mux", "SDIN3-L", "SDIN3-L" },
+	{ "Channel 4 Mux", "SDIN3-R", "SDIN3-R" },
+
+	{ "Channel 5 Mux", "SDIN1-L", "SDIN1-L" },
+	{ "Channel 5 Mux", "SDIN1-R", "SDIN1-R" },
+	{ "Channel 5 Mux", "SDIN2-L", "SDIN2-L" },
+	{ "Channel 5 Mux", "SDIN2-R", "SDIN2-R" },
+	{ "Channel 5 Mux", "SDIN3-L", "SDIN3-L" },
+	{ "Channel 5 Mux", "SDIN3-R", "SDIN3-R" },
+
+	{ "Channel 6 Mux", "SDIN1-L", "SDIN1-L" },
+	{ "Channel 6 Mux", "SDIN1-R", "SDIN1-R" },
+	{ "Channel 6 Mux", "SDIN2-L", "SDIN2-L" },
+	{ "Channel 6 Mux", "SDIN2-R", "SDIN2-R" },
+	{ "Channel 6 Mux", "SDIN3-L", "SDIN3-L" },
+	{ "Channel 6 Mux", "SDIN3-R", "SDIN3-R" },
+
+	/* Channel muxes -> PWM muxes */
+	{ "PWM1 Mux", "Channel 1 Mux", "Channel 1 Mux" },
+	{ "PWM2 Mux", "Channel 1 Mux", "Channel 1 Mux" },
+	{ "PWM3 Mux", "Channel 1 Mux", "Channel 1 Mux" },
+	{ "PWM4 Mux", "Channel 1 Mux", "Channel 1 Mux" },
+	{ "PWM5 Mux", "Channel 1 Mux", "Channel 1 Mux" },
+	{ "PWM6 Mux", "Channel 1 Mux", "Channel 1 Mux" },
+
+	{ "PWM1 Mux", "Channel 2 Mux", "Channel 2 Mux" },
+	{ "PWM2 Mux", "Channel 2 Mux", "Channel 2 Mux" },
+	{ "PWM3 Mux", "Channel 2 Mux", "Channel 2 Mux" },
+	{ "PWM4 Mux", "Channel 2 Mux", "Channel 2 Mux" },
+	{ "PWM5 Mux", "Channel 2 Mux", "Channel 2 Mux" },
+	{ "PWM6 Mux", "Channel 2 Mux", "Channel 2 Mux" },
+
+	{ "PWM1 Mux", "Channel 3 Mux", "Channel 3 Mux" },
+	{ "PWM2 Mux", "Channel 3 Mux", "Channel 3 Mux" },
+	{ "PWM3 Mux", "Channel 3 Mux", "Channel 3 Mux" },
+	{ "PWM4 Mux", "Channel 3 Mux", "Channel 3 Mux" },
+	{ "PWM5 Mux", "Channel 3 Mux", "Channel 3 Mux" },
+	{ "PWM6 Mux", "Channel 3 Mux", "Channel 3 Mux" },
+
+	{ "PWM1 Mux", "Channel 4 Mux", "Channel 4 Mux" },
+	{ "PWM2 Mux", "Channel 4 Mux", "Channel 4 Mux" },
+	{ "PWM3 Mux", "Channel 4 Mux", "Channel 4 Mux" },
+	{ "PWM4 Mux", "Channel 4 Mux", "Channel 4 Mux" },
+	{ "PWM5 Mux", "Channel 4 Mux", "Channel 4 Mux" },
+	{ "PWM6 Mux", "Channel 4 Mux", "Channel 4 Mux" },
+
+	{ "PWM1 Mux", "Channel 5 Mux", "Channel 5 Mux" },
+	{ "PWM2 Mux", "Channel 5 Mux", "Channel 5 Mux" },
+	{ "PWM3 Mux", "Channel 5 Mux", "Channel 5 Mux" },
+	{ "PWM4 Mux", "Channel 5 Mux", "Channel 5 Mux" },
+	{ "PWM5 Mux", "Channel 5 Mux", "Channel 5 Mux" },
+	{ "PWM6 Mux", "Channel 5 Mux", "Channel 5 Mux" },
+
+	{ "PWM1 Mux", "Channel 6 Mux", "Channel 6 Mux" },
+	{ "PWM2 Mux", "Channel 6 Mux", "Channel 6 Mux" },
+	{ "PWM3 Mux", "Channel 6 Mux", "Channel 6 Mux" },
+	{ "PWM4 Mux", "Channel 6 Mux", "Channel 6 Mux" },
+	{ "PWM5 Mux", "Channel 6 Mux", "Channel 6 Mux" },
+	{ "PWM6 Mux", "Channel 6 Mux", "Channel 6 Mux" },
+
+	/* The PWM muxes are directly connected to the PWM outputs */
+	{ "PWM1", NULL, "PWM1 Mux" },
+	{ "PWM2", NULL, "PWM2 Mux" },
+	{ "PWM3", NULL, "PWM3 Mux" },
+	{ "PWM4", NULL, "PWM4 Mux" },
+	{ "PWM5", NULL, "PWM5 Mux" },
+	{ "PWM6", NULL, "PWM6 Mux" },
+
+};
+
 static const struct snd_soc_dai_ops tas5086_dai_ops = {
 	.hw_params	= tas5086_hw_params,
 	.set_sysclk	= tas5086_set_dai_sysclk,
@@ -585,6 +781,10 @@ static struct snd_soc_codec_driver soc_codec_dev_tas5086 = {
 	.resume			= tas5086_soc_resume,
 	.controls		= tas5086_controls,
 	.num_controls		= ARRAY_SIZE(tas5086_controls),
+	.dapm_widgets		= tas5086_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(tas5086_dapm_widgets),
+	.dapm_routes		= tas5086_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(tas5086_dapm_routes),
 };
 
 static const struct i2c_device_id tas5086_i2c_id[] = {
-- 
1.8.1.4
