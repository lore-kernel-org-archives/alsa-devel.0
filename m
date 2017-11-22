From: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
Subject: [PATCH 1/8] ASoC: spdif: Add S32_LE support for S/PDIF
	dummy codec drivers
Date: Wed, 22 Nov 2017 20:43:14 +0900
Message-ID: <20171122114321.29196-2-suzuki.katsuhiro@socionext.com>
References: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa0.perex.cz (Postfix) with ESMTP id 11871267700
 for <alsa-devel@alsa-project.org>; Wed, 22 Nov 2017 12:43:04 +0100 (CET)
In-Reply-To: <20171122114321.29196-1-suzuki.katsuhiro@socionext.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Jassi Brar <jaswinder.singh@linaro.org>, linux-arm-kernel@lists.infradead.org, Masami Hiramatsu <masami.hiramatsu@linaro.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

AIO on UniPhier can output S/PDIF where no codec is needed.
This patch adds S32_LE support for dummy codec drivers.

If one S/PDIF controller has its own limitation, its CPU DAI driver should
set the supported format by its own circumstance, since the soc-pcm driver
will use the intersection of cpu_dai's formats and codec_dai's formats.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 sound/soc/codecs/spdif_receiver.c    | 5 +++--
 sound/soc/codecs/spdif_transmitter.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/spdif_receiver.c b/sound/soc/codecs/spdif_receiver.c
index 7acd05140a81..c8fd6367f6c0 100644
--- a/sound/soc/codecs/spdif_receiver.c
+++ b/sound/soc/codecs/spdif_receiver.c
@@ -34,10 +34,11 @@ static const struct snd_soc_dapm_route dir_routes[] = {
 #define STUB_RATES	SNDRV_PCM_RATE_8000_192000
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
 			SNDRV_PCM_FMTBIT_S20_3LE | \
-			SNDRV_PCM_FMTBIT_S24_LE | \
+			SNDRV_PCM_FMTBIT_S24_LE  | \
+			SNDRV_PCM_FMTBIT_S32_LE | \
 			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
 
-static const struct snd_soc_codec_driver soc_codec_spdif_dir = {
+static struct snd_soc_codec_driver soc_codec_spdif_dir = {
 	.component_driver = {
 		.dapm_widgets		= dir_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(dir_widgets),
diff --git a/sound/soc/codecs/spdif_transmitter.c b/sound/soc/codecs/spdif_transmitter.c
index 063a64ff82d3..037aa1d45559 100644
--- a/sound/soc/codecs/spdif_transmitter.c
+++ b/sound/soc/codecs/spdif_transmitter.c
@@ -27,7 +27,8 @@
 #define STUB_RATES	SNDRV_PCM_RATE_8000_192000
 #define STUB_FORMATS	(SNDRV_PCM_FMTBIT_S16_LE | \
 			SNDRV_PCM_FMTBIT_S20_3LE | \
-			SNDRV_PCM_FMTBIT_S24_LE)
+			SNDRV_PCM_FMTBIT_S24_LE  | \
+			SNDRV_PCM_FMTBIT_S32_LE)
 
 static const struct snd_soc_dapm_widget dit_widgets[] = {
 	SND_SOC_DAPM_OUTPUT("spdif-out"),
@@ -37,7 +38,7 @@ static const struct snd_soc_dapm_route dit_routes[] = {
 	{ "spdif-out", NULL, "Playback" },
 };
 
-static const struct snd_soc_codec_driver soc_codec_spdif_dit = {
+static struct snd_soc_codec_driver soc_codec_spdif_dit = {
 	.component_driver = {
 		.dapm_widgets		= dit_widgets,
 		.num_dapm_widgets	= ARRAY_SIZE(dit_widgets),
-- 
2.15.0
