From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: boards: fix off-by-one dailink
	id" to the asoc tree
Date: Wed, 18 Oct 2017 12:31:08 +0100
Message-ID: <E1e4mZ2-0003u9-P9@debutante>
References: <20171012233805.30055-9-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C25B2267453
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 13:31:21 +0200 (CEST)
In-Reply-To: <20171012233805.30055-9-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: boards: fix off-by-one dailink id

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

>From 149f77575906d7dca1c62ee5a5539b6b7e851f46 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 12 Oct 2017 18:38:04 -0500
Subject: [PATCH] ASoC: Intel: boards: fix off-by-one dailink id

For some reason the Atom/HiFi2 machine drivers use an id=1 instead
of zero as done on all other platforms. This gets in the way of
topology-based matching, realign for consistency. This should
not have any functional impact on existing solutions with don't rely
on topology.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bytcht_da7213.c       | 2 +-
 sound/soc/intel/boards/bytcht_es8316.c       | 2 +-
 sound/soc/intel/boards/bytcht_nocodec.c      | 2 +-
 sound/soc/intel/boards/bytcr_rt5640.c        | 2 +-
 sound/soc/intel/boards/bytcr_rt5651.c        | 2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c      | 2 +-
 8 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 24070bc06040..28a493e5318d 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -197,7 +197,7 @@ static struct snd_soc_dai_link dailink[] = {
 	/* back ends */
 	{
 		.name = "SSP2-Codec",
-		.id = 1,
+		.id = 0,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index 9ed4400c13b8..808e825c3b05 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -209,7 +209,7 @@ static struct snd_soc_dai_link byt_cht_es8316_dais[] = {
 		 * require SSP0 will not work.
 		 */
 		.name = "SSP2-Codec",
-		.id = 1,
+		.id = 0,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/bytcht_nocodec.c b/sound/soc/intel/boards/bytcht_nocodec.c
index 1dd9441806fa..511e87601104 100644
--- a/sound/soc/intel/boards/bytcht_nocodec.c
+++ b/sound/soc/intel/boards/bytcht_nocodec.c
@@ -145,7 +145,7 @@ static struct snd_soc_dai_link dais[] = {
 	/* back ends */
 	{
 		.name = "SSP2-LowSpeed Connector",
-		.id = 1,
+		.id = 0,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 339842adceed..6c7b71d7fed7 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -690,7 +690,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		/* back ends */
 	{
 		.name = "SSP2-Codec",
-		.id = 1,
+		.id = 0,
 		.cpu_dai_name = "ssp2-port", /* overwritten for ssp0 routing */
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index dc158466bd92..e0caee26fb0a 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -401,7 +401,7 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
 	/* back ends */
 	{
 		.name = "SSP2-Codec",
-		.id = 1,
+		.id = 0,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index c2e3b00ec89d..a2194d993615 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -361,7 +361,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	/* back ends */
 	{
 		.name = "SSP2-Codec",
-		.id = 1,
+		.id = 0,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 546f4abf2562..1901b3b8f4d2 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -457,7 +457,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	/* back ends */
 	{
 		.name = "SSP2-Codec",
-		.id = 1,
+		.id = 0,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 1dffe76d5a85..3464cf41c7d1 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -315,7 +315,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	{
 		/* SSP2 - Codec */
 		.name = "SSP2-Codec",
-		.id = 1,
+		.id = 0,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
-- 
2.14.1
