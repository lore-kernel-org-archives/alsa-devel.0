From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Document snd-soc-dummy-dai purpose" to
	the asoc tree
Date: Mon, 31 Aug 2015 16:41:53 +0100
Message-ID: <E1ZWRDV-0003Oh-Ko@finisterre>
References: <1441034663-4372-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C43B92604F0
 for <alsa-devel@alsa-project.org>; Mon, 31 Aug 2015 17:42:29 +0200 (CEST)
In-Reply-To: <1441034663-4372-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Document snd-soc-dummy-dai purpose

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

>From d76f41982f2fc88492efd96c7c3178044f32e125 Mon Sep 17 00:00:00 2001
From: Anatol Pomozov <anatol.pomozov@gmail.com>
Date: Mon, 31 Aug 2015 08:24:23 -0700
Subject: [PATCH] ASoC: Document snd-soc-dummy-dai purpose

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-utils.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/soc-utils.c b/sound/soc/soc-utils.c
index 362c69a..53dd085 100644
--- a/sound/soc/soc-utils.c
+++ b/sound/soc/soc-utils.c
@@ -101,6 +101,15 @@ static struct snd_soc_codec_driver dummy_codec;
 			SNDRV_PCM_FMTBIT_S32_LE | \
 			SNDRV_PCM_FMTBIT_U32_LE | \
 			SNDRV_PCM_FMTBIT_IEC958_SUBFRAME_LE)
+/*
+ * The dummy CODEC is only meant to be used in situations where there is no
+ * actual hardware.
+ *
+ * If there is actual hardware even if it does not have a control bus
+ * the hardware will still have constraints like supported samplerates, etc.
+ * which should be modelled. And the data flow graph also should be modelled
+ * using DAPM.
+ */
 static struct snd_soc_dai_driver dummy_dai = {
 	.name = "snd-soc-dummy-dai",
 	.playback = {
-- 
2.5.0
