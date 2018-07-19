From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Ensure DSP boot work complete
	before preloader_put return" to the asoc tree
Date: Thu, 19 Jul 2018 17:58:23 +0100
Message-ID: <E1fgCFz-0005Z6-TR@debutante>
References: <20180719105039.28312-3-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3564D267600
 for <alsa-devel@alsa-project.org>; Thu, 19 Jul 2018 18:58:26 +0200 (CEST)
In-Reply-To: <20180719105039.28312-3-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, patches@opensource.cirrus.com, lgirdwood@gmail.com, stuarth@opensource.cirrus.com, rf@opensource.cirrus.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Ensure DSP boot work complete before preloader_put return

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 868e49a4a00afaca07d2c450a02e49581eaece6c Mon Sep 17 00:00:00 2001
From: Stuart Henderson <stuarth@opensource.cirrus.com>
Date: Thu, 19 Jul 2018 11:50:37 +0100
Subject: [PATCH] ASoC: wm_adsp: Ensure DSP boot work complete before
 preloader_put return

All controls derived from the loaded firmware should be created prior
to returning from the preloader's put function, such that they are
immediately available to user-space.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b7b914963c62..4e7f8525449e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2672,6 +2672,8 @@ int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 
 	snd_soc_dapm_sync(dapm);
 
+	flush_work(&dsp->boot_work);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_preloader_put);
-- 
2.18.0
