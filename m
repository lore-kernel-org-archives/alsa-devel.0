From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Change DAI link's be_id to a generic
	id" to the asoc tree
Date: Wed, 20 Apr 2016 17:19:50 +0100
Message-ID: <E1asur0-0006yB-7r@debutante>
References: <77b0bcda1d7f51457c0f11c9b5598df25666ad13.1461042239.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4730C2665E5
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 18:19:55 +0200 (CEST)
In-Reply-To: <77b0bcda1d7f51457c0f11c9b5598df25666ad13.1461042239.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mengdong Lin <mengdong.lin@linux.intel.com>
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, rakesh.a.ughreja@intel.com, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Change DAI link's be_id to a generic id

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

>From 2f0ad49104cbb19db24442af736614659363d2ab Mon Sep 17 00:00:00 2001
From: Mengdong Lin <mengdong.lin@linux.intel.com>
Date: Tue, 19 Apr 2016 13:12:35 +0800
Subject: [PATCH] ASoC: Change DAI link's be_id to a generic id

The generic ID can be used by topology:
- Toplogy can create FE links and set their ID, machine drivers will
  be notified and check this ID for machine-specific init.
- Toplogy can use the ID to find existing BE & CC links and further
  configure them.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h                             |  2 +-
 sound/soc/intel/boards/broadwell.c              |  2 +-
 sound/soc/intel/boards/bytcr_rt5640.c           |  2 +-
 sound/soc/intel/boards/bytcr_rt5651.c           |  2 +-
 sound/soc/intel/boards/cht_bsw_max98090_ti.c    |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5645.c         |  2 +-
 sound/soc/intel/boards/cht_bsw_rt5672.c         |  2 +-
 sound/soc/intel/boards/haswell.c                |  2 +-
 sound/soc/intel/boards/skl_nau88l25_max98357a.c | 12 ++++++------
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c   | 12 ++++++------
 sound/soc/intel/boards/skl_rt286.c              | 10 +++++-----
 11 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 02b4a215fd75..ef25e86d51ee 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1002,7 +1002,7 @@ struct snd_soc_dai_link {
 	 */
 	const char *platform_name;
 	struct device_node *platform_of_node;
-	int be_id;	/* optional ID for machine driver BE identification */
+	int id;	/* optional ID for machine driver link identification */
 
 	const struct snd_soc_pcm_stream *params;
 	unsigned int num_params;
diff --git a/sound/soc/intel/boards/broadwell.c b/sound/soc/intel/boards/broadwell.c
index 3f8a1e10bed0..7486a0022fde 100644
--- a/sound/soc/intel/boards/broadwell.c
+++ b/sound/soc/intel/boards/broadwell.c
@@ -201,7 +201,7 @@ static struct snd_soc_dai_link broadwell_rt286_dais[] = {
 	{
 		/* SSP0 - Codec */
 		.name = "Codec",
-		.be_id = 0,
+		.id = 0,
 		.cpu_dai_name = "snd-soc-dummy-dai",
 		.platform_name = "snd-soc-dummy",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index 032a2e753f0b..88efb62439ba 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -304,7 +304,7 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		/* back ends */
 	{
 		.name = "SSP2-Codec",
-		.be_id = 1,
+		.id = 1,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 1c95ccc886c4..35f591eab3c9 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -267,7 +267,7 @@ static struct snd_soc_dai_link byt_rt5651_dais[] = {
 	/* back ends */
 	{
 		.name = "SSP2-Codec",
-		.be_id = 1,
+		.id = 1,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index e609f089593a..6260df6bd49c 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -255,7 +255,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	/* back ends */
 	{
 		.name = "SSP2-Codec",
-		.be_id = 1,
+		.id = 1,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 2a6f80843bc9..0618a7f1025b 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -295,7 +295,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	/* back ends */
 	{
 		.name = "SSP2-Codec",
-		.be_id = 1,
+		.id = 1,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 2e5347f8f96c..df9d254baa18 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -273,7 +273,7 @@ static struct snd_soc_dai_link cht_dailink[] = {
 	{
 		/* SSP2 - Codec */
 		.name = "SSP2-Codec",
-		.be_id = 1,
+		.id = 1,
 		.cpu_dai_name = "ssp2-port",
 		.platform_name = "sst-mfld-platform",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/haswell.c b/sound/soc/intel/boards/haswell.c
index 22558572cb9c..863f1d5e2a2c 100644
--- a/sound/soc/intel/boards/haswell.c
+++ b/sound/soc/intel/boards/haswell.c
@@ -156,7 +156,7 @@ static struct snd_soc_dai_link haswell_rt5640_dais[] = {
 	{
 		/* SSP0 - Codec */
 		.name = "Codec",
-		.be_id = 0,
+		.id = 0,
 		.cpu_dai_name = "snd-soc-dummy-dai",
 		.platform_name = "snd-soc-dummy",
 		.no_pcm = 1,
diff --git a/sound/soc/intel/boards/skl_nau88l25_max98357a.c b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
index 72176b79a18d..9cc9240ed717 100644
--- a/sound/soc/intel/boards/skl_nau88l25_max98357a.c
+++ b/sound/soc/intel/boards/skl_nau88l25_max98357a.c
@@ -456,7 +456,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	{
 		/* SSP0 - Codec */
 		.name = "SSP0-Codec",
-		.be_id = 0,
+		.id = 0,
 		.cpu_dai_name = "SSP0 Pin",
 		.platform_name = "0000:00:1f.3",
 		.no_pcm = 1,
@@ -472,7 +472,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	{
 		/* SSP1 - Codec */
 		.name = "SSP1-Codec",
-		.be_id = 1,
+		.id = 1,
 		.cpu_dai_name = "SSP1 Pin",
 		.platform_name = "0000:00:1f.3",
 		.no_pcm = 1,
@@ -489,7 +489,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "dmic01",
-		.be_id = 2,
+		.id = 2,
 		.cpu_dai_name = "DMIC01 Pin",
 		.codec_name = "dmic-codec",
 		.codec_dai_name = "dmic-hifi",
@@ -501,7 +501,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "iDisp1",
-		.be_id = 3,
+		.id = 3,
 		.cpu_dai_name = "iDisp1 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi1",
@@ -512,7 +512,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "iDisp2",
-		.be_id = 4,
+		.id = 4,
 		.cpu_dai_name = "iDisp2 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi2",
@@ -523,7 +523,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "iDisp3",
-		.be_id = 5,
+		.id = 5,
 		.cpu_dai_name = "iDisp3 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi3",
diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index 5f1ca99ae9b0..53380b2cb1a8 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -505,7 +505,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	{
 		/* SSP0 - Codec */
 		.name = "SSP0-Codec",
-		.be_id = 0,
+		.id = 0,
 		.cpu_dai_name = "SSP0 Pin",
 		.platform_name = "0000:00:1f.3",
 		.no_pcm = 1,
@@ -523,7 +523,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	{
 		/* SSP1 - Codec */
 		.name = "SSP1-Codec",
-		.be_id = 1,
+		.id = 1,
 		.cpu_dai_name = "SSP1 Pin",
 		.platform_name = "0000:00:1f.3",
 		.no_pcm = 1,
@@ -540,7 +540,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "dmic01",
-		.be_id = 2,
+		.id = 2,
 		.cpu_dai_name = "DMIC01 Pin",
 		.codec_name = "dmic-codec",
 		.codec_dai_name = "dmic-hifi",
@@ -552,7 +552,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "iDisp1",
-		.be_id = 3,
+		.id = 3,
 		.cpu_dai_name = "iDisp1 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi1",
@@ -563,7 +563,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "iDisp2",
-		.be_id = 4,
+		.id = 4,
 		.cpu_dai_name = "iDisp2 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi2",
@@ -574,7 +574,7 @@ static struct snd_soc_dai_link skylake_dais[] = {
 	},
 	{
 		.name = "iDisp3",
-		.be_id = 5,
+		.id = 5,
 		.cpu_dai_name = "iDisp3 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi3",
diff --git a/sound/soc/intel/boards/skl_rt286.c b/sound/soc/intel/boards/skl_rt286.c
index 2016397a8e75..9e39fc1b89d3 100644
--- a/sound/soc/intel/boards/skl_rt286.c
+++ b/sound/soc/intel/boards/skl_rt286.c
@@ -375,7 +375,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 	{
 		/* SSP0 - Codec */
 		.name = "SSP0-Codec",
-		.be_id = 0,
+		.id = 0,
 		.cpu_dai_name = "SSP0 Pin",
 		.platform_name = "0000:00:1f.3",
 		.no_pcm = 1,
@@ -393,7 +393,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 	},
 	{
 		.name = "dmic01",
-		.be_id = 1,
+		.id = 1,
 		.cpu_dai_name = "DMIC01 Pin",
 		.codec_name = "dmic-codec",
 		.codec_dai_name = "dmic-hifi",
@@ -405,7 +405,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 	},
 	{
 		.name = "iDisp1",
-		.be_id = 2,
+		.id = 2,
 		.cpu_dai_name = "iDisp1 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi1",
@@ -416,7 +416,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 	},
 	{
 		.name = "iDisp2",
-		.be_id = 3,
+		.id = 3,
 		.cpu_dai_name = "iDisp2 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi2",
@@ -427,7 +427,7 @@ static struct snd_soc_dai_link skylake_rt286_dais[] = {
 	},
 	{
 		.name = "iDisp3",
-		.be_id = 4,
+		.id = 4,
 		.cpu_dai_name = "iDisp3 Pin",
 		.codec_name = "ehdaudio0D2",
 		.codec_dai_name = "intel-hdmi-hifi3",
-- 
2.8.0.rc3
