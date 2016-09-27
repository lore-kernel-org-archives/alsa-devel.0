From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sst-bxt-rt298: fix obsoleted
	initializers for array" to the asoc tree
Date: Tue, 27 Sep 2016 09:18:06 -0700
Message-ID: <E1bov54-0003dv-Bt@finisterre>
References: <1469540517-32466-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id CC83F266707
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2016 18:18:20 +0200 (CEST)
In-Reply-To: <1469540517-32466-3-git-send-email-o-takashi@sakamocchi.jp>
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
Cc: Vinod Koul <vinod.koul@intel.com>, tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, Ramesh Babu <ramesh.babu@intel.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sst-bxt-rt298: fix obsoleted initializers for array

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

>From 5919a3898136aae4d2cb4b18b44f70f7b185aa47 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 27 Sep 2016 07:45:08 +0900
Subject: [PATCH] ASoC: sst-bxt-rt298: fix obsoleted initializers for array

Sparse reports below warnings.

bxt_rt298.c:275:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:290:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:304:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:317:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:331:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:344:9: warning: obsolete array initializer, use C99 syntax
bxt_rt298.c:357:9: warning: obsolete array initializer, use C99 syntax

There's no need to use obsoleted way. This commit fixes it.

Fixes: 76016322ec56 (ASoC: Intel: Add Broxton-P machine driver)
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Acked-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/boards/bxt_rt298.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/boards/bxt_rt298.c b/sound/soc/intel/boards/bxt_rt298.c
index 253d7bfbf511..d610bdca1608 100644
--- a/sound/soc/intel/boards/bxt_rt298.c
+++ b/sound/soc/intel/boards/bxt_rt298.c
@@ -271,7 +271,7 @@ static const struct snd_soc_ops broxton_rt286_fe_ops = {
 /* broxton digital audio interface glue - connects codec <--> CPU */
 static struct snd_soc_dai_link broxton_rt298_dais[] = {
 	/* Front End DAI links */
-	[BXT_DPCM_AUDIO_PB]
+	[BXT_DPCM_AUDIO_PB] =
 	{
 		.name = "Bxt Audio Port",
 		.stream_name = "Audio",
@@ -286,7 +286,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.dpcm_playback = 1,
 		.ops = &broxton_rt286_fe_ops,
 	},
-	[BXT_DPCM_AUDIO_CP]
+	[BXT_DPCM_AUDIO_CP] =
 	{
 		.name = "Bxt Audio Capture Port",
 		.stream_name = "Audio Record",
@@ -300,7 +300,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.dpcm_capture = 1,
 		.ops = &broxton_rt286_fe_ops,
 	},
-	[BXT_DPCM_AUDIO_REF_CP]
+	[BXT_DPCM_AUDIO_REF_CP] =
 	{
 		.name = "Bxt Audio Reference cap",
 		.stream_name = "refcap",
@@ -313,7 +313,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	[BXT_DPCM_AUDIO_DMIC_CP]
+	[BXT_DPCM_AUDIO_DMIC_CP] =
 	{
 		.name = "Bxt Audio DMIC cap",
 		.stream_name = "dmiccap",
@@ -327,7 +327,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.dynamic = 1,
 		.ops = &broxton_dmic_ops,
 	},
-	[BXT_DPCM_AUDIO_HDMI1_PB]
+	[BXT_DPCM_AUDIO_HDMI1_PB] =
 	{
 		.name = "Bxt HDMI Port1",
 		.stream_name = "Hdmi1",
@@ -340,7 +340,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
 		.nonatomic = 1,
 		.dynamic = 1,
 	},
-	[BXT_DPCM_AUDIO_HDMI2_PB]
+	[BXT_DPCM_AUDIO_HDMI2_PB] =
 	{
 		.name = "Bxt HDMI Port2",
 		.stream_name = "Hdmi2",
@@ -353,7 +353,7 @@ static struct snd_soc_dai_link broxton_rt298_dais[] = {
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
