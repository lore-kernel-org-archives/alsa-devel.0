From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Put DSP into low power state
	between loading and running" to the asoc tree
Date: Mon, 26 Sep 2016 09:15:39 -0700
Message-ID: <E1boYZ9-0005OY-4p@finisterre>
References: <1474881325-9466-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E0B82668C1
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2016 18:15:53 +0200 (CEST)
In-Reply-To: <1474881325-9466-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Put DSP into low power state between loading and running

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

>From 90d19ba54b428a6bc8cc51ef6c60c6e65e6e2f35 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 26 Sep 2016 10:15:23 +0100
Subject: [PATCH] ASoC: wm_adsp: Put DSP into low power state between loading
 and running

Between when we load the DSP and when it actually starts running put the
core into a lower power state where the memory is retained but nothing
is clocked.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4188c3763bc3..446f0297733f 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2259,6 +2259,11 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 
 	mutex_lock(&dsp->pwr_lock);
 
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				 ADSP2_MEM_ENA, ADSP2_MEM_ENA);
+	if (ret != 0)
+		goto err_mutex;
+
 	ret = wm_adsp2_ena(dsp);
 	if (ret != 0)
 		goto err_mutex;
@@ -2282,6 +2287,12 @@ static void wm_adsp2_boot_work(struct work_struct *work)
 
 	dsp->booted = true;
 
+	/* Turn DSP back off until we are ready to run */
+	ret = regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
+				 ADSP2_SYS_ENA, 0);
+	if (ret != 0)
+		goto err_ena;
+
 	mutex_unlock(&dsp->pwr_lock);
 
 	return;
@@ -2344,6 +2355,10 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		if (!dsp->booted)
 			return -EIO;
 
+		ret = wm_adsp2_ena(dsp);
+		if (ret != 0)
+			goto err;
+
 		/* Sync set controls */
 		ret = wm_coeff_sync_controls(dsp);
 		if (ret != 0)
@@ -2382,7 +2397,8 @@ int wm_adsp2_event(struct snd_soc_dapm_widget *w,
 		dsp->booted = false;
 
 		regmap_update_bits(dsp->regmap, dsp->base + ADSP2_CONTROL,
-				   ADSP2_CORE_ENA | ADSP2_START, 0);
+				   ADSP2_MEM_ENA | ADSP2_CORE_ENA | ADSP2_START,
+				   0);
 
 		/* Make sure DMAs are quiesced */
 		regmap_write(dsp->regmap, dsp->base + ADSP2_RDMA_CONFIG_1, 0);
-- 
2.9.3
