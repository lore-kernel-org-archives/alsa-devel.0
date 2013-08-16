From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] ASoC: tlv320aic26: Add basic DAPM support
Date: Fri, 16 Aug 2013 12:32:05 +0100
Message-ID: <1376652725-26857-3-git-send-email-broonie@kernel.org>
References: <1376652725-26857-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id B9A352616B9
 for <alsa-devel@alsa-project.org>; Fri, 16 Aug 2013 13:32:19 +0200 (CEST)
In-Reply-To: <1376652725-26857-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Provide external widgets for the CODEC to ensure the device continues to
function with DAPM mandatory and to make it easier to hook the device up
to other components.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/codecs/tlv320aic26.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index 93cf692..7b8f3d9 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -119,6 +119,22 @@ static int aic26_reg_write(struct snd_soc_codec *codec, unsigned int reg,
 	return 0;
 }
 
+static const struct snd_soc_dapm_widget tlv320aic26_dapm_widgets[] = {
+SND_SOC_DAPM_INPUT("MICIN"),
+SND_SOC_DAPM_INPUT("AUX"),
+
+SND_SOC_DAPM_OUTPUT("HPL"),
+SND_SOC_DAPM_OUTPUT("HPR"),
+};
+
+static const struct snd_soc_dapm_route tlv320aic26_dapm_routes[] = {
+	{ "Capture", NULL, "MICIN" },
+	{ "Capture", NULL, "AUX" },
+
+	{ "HPL", NULL, "Playback" },
+	{ "HPR", NULL, "Playback" },
+};
+
 /* ---------------------------------------------------------------------
  * Digital Audio Interface Operations
  */
@@ -402,6 +418,10 @@ static struct snd_soc_codec_driver aic26_soc_codec_dev = {
 	.write = aic26_reg_write,
 	.reg_cache_size = AIC26_NUM_REGS,
 	.reg_word_size = sizeof(u16),
+	.dapm_widgets = tlv320aic26_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(tlv320aic26_dapm_widgets),
+	.dapm_routes = tlv320aic26_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(tlv320aic26_dapm_routes),
 };
 
 /* ---------------------------------------------------------------------
-- 
1.8.4.rc2
