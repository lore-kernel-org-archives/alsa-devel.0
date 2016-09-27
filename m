From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sst-bxt-da7219_max98357a: fix obsoleted
	initializers for array" to the asoc tree
Date: Tue, 27 Sep 2016 09:18:08 -0700
Message-ID: <E1bov56-0003ee-7r@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E44F3266860
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 18:18:21 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sst-bxt-da7219_max98357a: fix obsoleted initializers for array

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

>From 43d443dc257c00ef3a3f940b6abfb7537c4fcbe8 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 27 Sep 2016 07:45:09 +0900
Subject: [PATCH] ASoC: sst-bxt-da7219_max98357a: fix obsoleted initializers
 for array

Sparse reports below warnings.

bxt_da7219_max98357a.c:250:9: warning: obsolete array initializer, use C99 syntax
bxt_da7219_max98357a.c:275:9: warning: obsolete array initializer, use C99 syntax
bxt_da7219_max98357a.c:290:9: warning: obsolete array initializer, use C99 syntax
bxt_da7219_max98357a.c:304:9: warning: obsolete array initializer, use C99 syntax
bxt_da7219_max98357a.c:317:9: warning: obsolete array initializer, use C99 syntax

There's no need to use obsoleted way. This commit fixes it.

Fixes: 723bad3fef8b (ASoC: Intel: Add Broxton-P Dialog Maxim machine driver)
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_da7219_max98357a.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_da7219_max98357a.c b/sound/soc/intel/boards/bxt_da7219_max98357a.c
index bb4533c305c7..6532b8f0ab2f 100644
--- a/sound/soc/intel/boards/bxt_da7219_max98357a.c
+++ b/sound/soc/intel/boards/bxt_da7219_max98357a.c
@@ -302,7 +302,7 @@ static struct snd_soc_ops broxton_refcap_ops = {
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_dais[] = {
 	/* Front End DAI links */
-	[BXT_DPCM_AUDIO_PB]
+	[BXT_DPCM_AUDIO_PB] =
 	{
 		.name = "Bxt Audio Port",
 		.stream_name = "Audio",
@@ -318,7 +318,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &broxton_da7219_fe_ops,
 	},
-	[BXT_DPCM_AUDIO_CP]
+	[BXT_DPCM_AUDIO_CP] =
 	{
 		.name = "Bxt Audio Capture Port",
 		.stream_name = "Audio Record",
@@ -333,7 +333,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &broxton_da7219_fe_ops,
 	},
-	[BXT_DPCM_AUDIO_REF_CP]
+	[BXT_DPCM_AUDIO_REF_CP] =
 	{
 		.name = "Bxt Audio Reference cap",
 		.stream_name = "Refcap",
@@ -362,7 +362,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.dynamic = 1,
 		.ops = &broxton_dmic_ops,
 	},
-	[BXT_DPCM_AUDIO_HDMI1_PB]
+	[BXT_DPCM_AUDIO_HDMI1_PB] =
 	{
 		.name = "Bxt HDMI Port1",
 		.stream_name = "Hdmi1",
@@ -375,7 +375,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	[BXT_DPCM_AUDIO_HDMI2_PB]
+	[BXT_DPCM_AUDIO_HDMI2_PB] =
 	{
 		.name = "Bxt HDMI Port2",
 		.stream_name = "Hdmi2",
@@ -388,7 +388,7 @@ static struct snd_soc_dai_link broxton_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	[BXT_DPCM_AUDIO_HDMI3_PB]
+	[BXT_DPCM_AUDIO_HDMI3_PB] =
 	{
 		.name = "Bxt HDMI Port3",
 		.stream_name = "Hdmi3",
-- 
2.9.3
