From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: pcm1681: Add DAPM support
Date: Tue, 13 Aug 2013 18:31:31 +0100
Message-ID: <1376415091-6096-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id CED782652C4
 for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2013 19:31:38 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Marek Belisko <marek.belisko@streamunlimited.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Provide DAPM for the device, ensuring operation with DAPM required by the
core and making it easier to hook up external hardware to it.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/pcm1681.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/codecs/pcm1681.c b/sound/soc/codecs/pcm1681.c
index 51b1866..651ce09 100644
--- a/sound/soc/codecs/pcm1681.c
+++ b/sound/soc/codecs/pcm1681.c
@@ -206,6 +206,28 @@ static const struct snd_soc_dai_ops pcm1681_dai_ops = {
 	.digital_mute	= pcm1681_digital_mute,
 };
 
+static const struct snd_soc_dapm_widget pcm1681_dapm_widgets[] = {
+SND_SOC_DAPM_OUTPUT("VOUT1"),
+SND_SOC_DAPM_OUTPUT("VOUT2"),
+SND_SOC_DAPM_OUTPUT("VOUT3"),
+SND_SOC_DAPM_OUTPUT("VOUT4"),
+SND_SOC_DAPM_OUTPUT("VOUT5"),
+SND_SOC_DAPM_OUTPUT("VOUT6"),
+SND_SOC_DAPM_OUTPUT("VOUT7"),
+SND_SOC_DAPM_OUTPUT("VOUT8"),
+};
+
+static const struct snd_soc_dapm_route pcm1681_dapm_routes[] = {
+	{ "VOUT1", NULL, "Playback" },
+	{ "VOUT2", NULL, "Playback" },
+	{ "VOUT3", NULL, "Playback" },
+	{ "VOUT4", NULL, "Playback" },
+	{ "VOUT5", NULL, "Playback" },
+	{ "VOUT6", NULL, "Playback" },
+	{ "VOUT7", NULL, "Playback" },
+	{ "VOUT8", NULL, "Playback" },
+};
+
 static const DECLARE_TLV_DB_SCALE(pcm1681_dac_tlv, -6350, 50, 1);
 
 static const struct snd_kcontrol_new pcm1681_controls[] = {
@@ -258,6 +280,10 @@ static const struct regmap_config pcm1681_regmap = {
 static struct snd_soc_codec_driver soc_codec_dev_pcm1681 = {
 	.controls		= pcm1681_controls,
 	.num_controls		= ARRAY_SIZE(pcm1681_controls),
+	.dapm_widgets		= pcm1681_dapm_widgets,
+	.num_dapm_widgets	= ARRAY_SIZE(pcm1681_dapm_widgets),
+	.dapm_routes		= pcm1681_dapm_routes,
+	.num_dapm_routes	= ARRAY_SIZE(pcm1681_dapm_routes),
 };
 
 static const struct i2c_device_id pcm1681_i2c_id[] = {
-- 
1.8.4.rc2
