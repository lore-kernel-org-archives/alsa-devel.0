From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Set booted/running flags at
	the end of bring up" to the asoc tree
Date: Tue, 24 Jan 2017 18:39:10 +0000
Message-ID: <E1cW5zq-0006WD-8v@debutante>
References: <1485258241-10575-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B4E0266CC1
 for <alsa-devel@alsa-project.org>; Tue, 24 Jan 2017 19:39:20 +0100 (CET)
In-Reply-To: <1485258241-10575-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Set booted/running flags at the end of bring up

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

>From e779974b86491cc938dfdcbfbf8fb363a40bc9ea Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 24 Jan 2017 11:44:00 +0000
Subject: [PATCH] ASoC: wm_adsp: Set booted/running flags at the end of bring
 up

The booted and running flags should really only be set once all the
steps at that power level have been complete. Currently operations can
fail after the flags have been set, which would leave us in an
inconsistent state where the flags are set but the things expected to
reach that level have not happened. Whilst there isn't really any major
impact from this it is best to clean it up.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 09e50e5e7870..746a5e23cb8b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2469,14 +2469,14 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 	if (ret != 0)
 		goto err_ena;
 
-	dsp->booted = true;
-
 	/* Turn DSP back off until we are ready to run */
 	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
 				 ADSP2_SYS_ENA, 0);
 	if (ret != 0)
 		goto err_ena;
 
+	dsp->booted = true;
+
 	mutex_unlock(&dsp->pwr_lock);
 
 	return;
@@ -2616,14 +2616,14 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (ret != 0)
 			goto err;
 
-		dsp->running = true;
-
 		if (wm_adsp_fw[dsp->fw].num_caps != 0) {
 			ret = wm_adsp_buffer_init(dsp);
 			if (ret < 0)
 				goto err;
 		}
 
+		dsp->running = true;
+
 		mutex_unlock(&dsp->pwr_lock);
 
 		break;
-- 
2.11.0
