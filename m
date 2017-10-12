From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 9/9] ASoC: Intel: boards: remove hard-coded
	compressed dailinks
Date: Thu, 12 Oct 2017 18:38:05 -0500
Message-ID: <20171012233805.30055-10-pierre-louis.bossart@linux.intel.com>
References: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 5FF25266FA1
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:38:22 +0200 (CEST)
In-Reply-To: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The hard-coded compressed dailinks are not supported using
publicly-available firmwares, which creates unnecessary user
confusion [1]. Even if the firmware was available, the mainline
code does not have the required .dynamic=1 and .dpcm_playback=1
fields so probably never worked as is, and last and they conflict
with topology-defined streams.

Remove them and move on. This can be re-enabled with SOF later
in a more flexible manner.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2017-August/124868.html

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_da7213.c       |  9 ---------
 sound/soc/intel/boards/bytcht_es8316.c       |  9 ---------
 sound/soc/intel/boards/bytcht_nocodec.c      |  8 --------
 sound/soc/intel/boards/bytcr_rt5640.c        | 11 +----------
 sound/soc/intel/boards/bytcr_rt5651.c        | 11 +----------
 sound/soc/intel/boards/cht_bsw_max98090_ti.c |  8 --------
 sound/soc/intel/boards/cht_bsw_rt5645.c      |  8 --------
 sound/soc/intel/boards/cht_bsw_rt5672.c      |  8 --------
 8 files changed, 2 insertions(+), 70 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 28a493e5318d..296b50640f46 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -185,14 +185,6 @@ static struct snd_soc_dai_link dailink[] = {
 		.dpcm_playback = 1,
 		.ops = &aif1_ops,
 	},
-	[MERR_DPCM_COMPR] = {
-		.name = "Compressed Port",
-		.stream_name = "Compress",
-		.cpu_dai_name = "compress-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
-	},
 	/* CODEC<->CODEC link */
 	/* back ends */
 	{
@@ -243,7 +235,6 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 	card->dev = &pdev->dev;
 
 	/* fix index of codec dai */
-	dai_index = MERR_DPCM_COMPR + 1;
 	for (i = 0; i < ARRAY_SIZE(dailink); i++) {
 		if (!strcmp(dailink[i].codec_name, "i2c-DLGS7213:00")) {
 			dai_index = i;
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 808e825c3b05..6acacc0aeedb 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -194,15 +194,6 @@ static struct snd_soc_dai_link byt_cht_es8316_dais[] = {
 		.ops = &byt_cht_es8316_aif1_ops,
 	},
 
-	[MERR_DPCM_COMPR] = {
-		.name = "Compressed Port",
-		.stream_name = "Compress",
-		.cpu_dai_name = "compress-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
-	},
-
 		/* back ends */
 	{
 		/* Only SSP2 has been tested here, so BYT-CR platforms that
diff --git a/sound/soc/intel/boards/bytcht_nocodec.c b/sound/soc/intel/boards/bytcht_nocodec.c
index 511e87601104..b80ec027a0e8 100644
--- a/sound/soc/intel/boards/bytcht_nocodec.c
+++ b/sound/soc/intel/boards/bytcht_nocodec.c
@@ -133,14 +133,6 @@ static struct snd_soc_dai_link dais[] = {
 		.dpcm_playback = 1,
 		.ops = &aif1_ops,
 	},
-	[MERR_DPCM_COMPR] = {
-		.name = "Compressed Port",
-		.stream_name = "Compress",
-		.cpu_dai_name = "compress-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
-	},
 	/* CODEC<->CODEC link */
 	/* back ends */
 	{
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 6c7b71d7fed7..3eeb02036aa1 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -679,14 +679,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &byt_rt5640_aif1_ops,
 	},
-	[MERR_DPCM_COMPR] = {
-		.name = "Baytrail Compressed Port",
-		.stream_name = "Baytrail Compress",
-		.cpu_dai_name = "compress-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
-	},
 		/* back ends */
 	{
 		.name = "SSP2-Codec",
@@ -748,7 +740,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int ret_val = 0;
-	int dai_index;
+	int dai_index = 0;
 	int i;
 
 	is_bytcr = false;
@@ -762,7 +754,6 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(&byt_rt5640_card, priv);
 
 	/* fix index of codec dai */
-	dai_index = MERR_DPCM_COMPR + 1;
 	for (i = 0; i < ARRAY_SIZE(byt_rt5640_dais); i++) {
 		if (!strcmp(byt_rt5640_dais[i].codec_name, "i2c-10EC5640:00")) {
 			dai_index = i;
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index e0caee26fb0a..3076bfc0db5e 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -389,14 +389,6 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &byt_rt5651_aif1_ops,
 	},
-	[MERR_DPCM_COMPR] = {
-		.name = "Compressed Port",
-		.stream_name = "Compress",
-		.cpu_dai_name = "compress-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
-	},
 	/* CODEC<->CODEC link */
 	/* back ends */
 	{
@@ -440,7 +432,7 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int ret_val = 0;
-	int dai_index;
+	int dai_index = 0;
 	int i;
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_ATOMIC);
@@ -454,7 +446,6 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 	snd_soc_card_set_drvdata(&byt_rt5651_card, priv);
 
 	/* fix index of codec dai */
-	dai_index = MERR_DPCM_COMPR + 1;
 	for (i = 0; i < ARRAY_SIZE(byt_rt5651_dais); i++) {
 		if (!strcmp(byt_rt5651_dais[i].codec_name, "i2c-10EC5651:00")) {
 			dai_index = i;
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index e763593bab76..d3e1c7e12004 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -350,14 +350,6 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.dpcm_playback = 1,
 		.ops = &cht_aif1_ops,
 	},
-	[MERR_DPCM_COMPR] = {
-		.name = "Compressed Port",
-		.stream_name = "Compress",
-		.cpu_dai_name = "compress-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
-	},
 	/* back ends */
 	{
 		.name = "SSP2-Codec",
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 1901b3b8f4d2..83c923c39393 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -445,14 +445,6 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.dpcm_playback = 1,
 		.ops = &cht_aif1_ops,
 	},
-	[MERR_DPCM_COMPR] = {
-		.name = "Compressed Port",
-		.stream_name = "Compress",
-		.cpu_dai_name = "compress-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
-	},
 	/* CODEC<->CODEC link */
 	/* back ends */
 	{
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 3464cf41c7d1..d135640702e9 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -302,14 +302,6 @@ static struct snd_soc_dai_link cht_dailink[] = {
 		.dpcm_playback = 1,
 		.ops = &cht_aif1_ops,
 	},
-	[MERR_DPCM_COMPR] = {
-		.name = "Compressed Port",
-		.stream_name = "Compress",
-		.cpu_dai_name = "compress-cpu-dai",
-		.codec_dai_name = "snd-soc-dummy-dai",
-		.codec_name = "snd-soc-dummy",
-		.platform_name = "sst-mfld-platform",
-	},
 
 	/* Back End DAI links */
 	{
-- 
2.11.0
