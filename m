From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 8/9] ASoC: Intel: boards: fix off-by-one
	dailink id
Date: Thu, 12 Oct 2017 18:38:04 -0500
Message-ID: <20171012233805.30055-9-pierre-louis.bossart@linux.intel.com>
References: <20171012233805.30055-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id D06A7266F1C
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 01:38:21 +0200 (CEST)
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

For some reason the Atom/HiFi2 machine drivers use an id=1 instead
of zero as done on all other platforms. This gets in the way of
topology-based matching, realign for consistency. This should
not have any functional impact on existing solutions with don't rely
on topology.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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
index 0b1b881c9c0f..e763593bab76 100644
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
2.11.0
