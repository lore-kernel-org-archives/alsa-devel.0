From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: remove IVI codec loop
	in skl_nau88l25_ssm4567 machine" to the asoc tree
Date: Wed, 02 Mar 2016 13:00:42 +0900
Message-ID: <E1aaxxq-0003b1-Bj@finisterre>
References: <1456799352-22653-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EDFB26152C
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2016 05:00:47 +0100 (CET)
In-Reply-To: <1456799352-22653-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeeja KP <jeeja.kp@intel.com>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: remove IVI codec loop in skl_nau88l25_ssm4567 machine

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

>From fdd69c57370dbd9f81072b14aaeb90d80ab0b2f9 Mon Sep 17 00:00:00 2001
From: Jeeja KP <jeeja.kp@intel.com>
Date: Tue, 1 Mar 2016 07:59:12 +0530
Subject: [PATCH] ASoC: Intel: Skylake: remove IVI codec loop in
 skl_nau88l25_ssm4567 machine

The IVI loop is removed in skl_nau88l25_ssm4567 machine as we
enable this path thru DAPM graph using the PCM device and not
thru loop

Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/skl_nau88l25_ssm4567.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
index f6a672c55be9..5f1ca99ae9b0 100644
--- a/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
+++ b/sound/soc/intel/boards/skl_nau88l25_ssm4567.c
@@ -156,14 +156,6 @@ static const struct snd_soc_dapm_route skylake_map[] = {
 	{ "Headset Mic", NULL, "Platform Clock" },
 };
 
-static const struct snd_soc_pcm_stream skl_ssm4567_loop_params = {
-	.formats = SNDRV_PCM_FMTBIT_S24_LE,
-	.rate_min = 48000,
-	.rate_max = 48000,
-	.channels_min = 4,
-	.channels_max = 4,
-};
-
 static struct snd_soc_codec_conf ssm4567_codec_conf[] = {
 	{
 		.dev_name = "i2c-INT343B:00",
@@ -508,16 +500,6 @@ static struct snd_soc_dai_link skylake_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	/* Codec-codec link */
-	{
-		.name = "Skylake IV loop",
-		.stream_name = "SKL IV Loop",
-		.cpu_dai_name = "SSP0 Pin",
-		.platform_name = "0000:00:1f.3",
-		.codecs = ssm4567_codec_components,
-		.num_codecs = ARRAY_SIZE(ssm4567_codec_components),
-		.params = &skl_ssm4567_loop_params,
-	},
 
 	/* Back End DAI links */
 	{
-- 
2.7.0
