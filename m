From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8960: boost switch should be closed
	when using L/RINPUT1" to the asoc tree
Date: Fri, 08 Jan 2016 13:44:40 +0000
Message-ID: <E1aHXLM-0003DR-J3@debutante>
References: <89e05efb7792deb496f216ed9e086e9c10053ba8.1452243310.git.zidan.wang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BCC4026581A
 for <alsa-devel@alsa-project.org>; Fri,  8 Jan 2016 14:44:51 +0100 (CET)
In-Reply-To: <89e05efb7792deb496f216ed9e086e9c10053ba8.1452243310.git.zidan.wang@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zidan Wang <zidan.wang@freescale.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8960: boost switch should be closed when using L/RINPUT1

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

>From 2d4a32602bc5d4d8f9a80c6b66a4e28d5f2d4798 Mon Sep 17 00:00:00 2001
From: Zidan Wang <zidan.wang@freescale.com>
Date: Fri, 8 Jan 2016 16:57:02 +0800
Subject: [PATCH] ASoC: wm8960: boost switch should be closed when using
 L/RINPUT1

L/RINPUT1 can line to Left/Right Boost Mixer through boost switch.
If boost switch is open, there will be no voice when using L/RINPUT1.

Signed-off-by: Zidan Wang <zidan.wang@freescale.com>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8960.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm8960.c b/sound/soc/codecs/wm8960.c
index 9e90b8e2b86e..28bfe39b5f34 100644
--- a/sound/soc/codecs/wm8960.c
+++ b/sound/soc/codecs/wm8960.c
@@ -413,8 +413,8 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Left Boost Mixer", "LINPUT2 Switch", "LINPUT2" },
 	{ "Left Boost Mixer", "LINPUT3 Switch", "LINPUT3" },
 
-	{ "Left Input Mixer", "Boost Switch", "Left Boost Mixer", },
-	{ "Left Input Mixer", NULL, "LINPUT1", },  /* Really Boost Switch */
+	{ "Left Input Mixer", "Boost Switch", "Left Boost Mixer" },
+	{ "Left Input Mixer", "Boost Switch", "LINPUT1" },  /* Really Boost Switch */
 	{ "Left Input Mixer", NULL, "LINPUT2" },
 	{ "Left Input Mixer", NULL, "LINPUT3" },
 
@@ -422,8 +422,8 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Right Boost Mixer", "RINPUT2 Switch", "RINPUT2" },
 	{ "Right Boost Mixer", "RINPUT3 Switch", "RINPUT3" },
 
-	{ "Right Input Mixer", "Boost Switch", "Right Boost Mixer", },
-	{ "Right Input Mixer", NULL, "RINPUT1", },  /* Really Boost Switch */
+	{ "Right Input Mixer", "Boost Switch", "Right Boost Mixer" },
+	{ "Right Input Mixer", "Boost Switch", "RINPUT1" },  /* Really Boost Switch */
 	{ "Right Input Mixer", NULL, "RINPUT2" },
 	{ "Right Input Mixer", NULL, "RINPUT3" },
 
@@ -431,11 +431,11 @@ static const struct snd_soc_dapm_route audio_paths[] = {
 	{ "Right ADC", NULL, "Right Input Mixer" },
 
 	{ "Left Output Mixer", "LINPUT3 Switch", "LINPUT3" },
-	{ "Left Output Mixer", "Boost Bypass Switch", "Left Boost Mixer"} ,
+	{ "Left Output Mixer", "Boost Bypass Switch", "Left Boost Mixer" },
 	{ "Left Output Mixer", "PCM Playback Switch", "Left DAC" },
 
 	{ "Right Output Mixer", "RINPUT3 Switch", "RINPUT3" },
-	{ "Right Output Mixer", "Boost Bypass Switch", "Right Boost Mixer" } ,
+	{ "Right Output Mixer", "Boost Bypass Switch", "Right Boost Mixer" },
 	{ "Right Output Mixer", "PCM Playback Switch", "Right DAC" },
 
 	{ "LOUT1 PGA", NULL, "Left Output Mixer" },
-- 
2.7.0.rc3
