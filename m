From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Fix the issue that the variable
	dereferenced before checking" to the asoc tree
Date: Wed, 22 Jun 2016 16:28:24 +0100
Message-ID: <E1bFk4m-0002Ed-5a@debutante>
References: <1466132544-22916-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ED625266967
 for <alsa-devel@alsa-project.org>; Wed, 22 Jun 2016 17:28:30 +0200 (CEST)
In-Reply-To: <1466132544-22916-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Fix the issue that the variable dereferenced before checking

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

>From b63d4d13ac7b8f947407a7eb44fdc40fadc8c5b8 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Fri, 17 Jun 2016 11:02:23 +0800
Subject: [PATCH] ASoC: rt5514: Fix the issue that the variable dereferenced
 before checking

The patch fixes the issue that variable dereferenced before checking
'rt5514_dsp->substream'. Move the assignment to after the variable
checking of 'rt5514_dsp->substream'.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 8a9382e9787a..743f509d48b7 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -80,7 +80,7 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 {
 	struct rt5514_dsp *rt5514_dsp =
 		container_of(work, struct rt5514_dsp, copy_work.work);
-	struct snd_pcm_runtime *runtime = rt5514_dsp->substream->runtime;
+	struct snd_pcm_runtime *runtime;
 	size_t period_bytes, truncated_bytes = 0;
 
 	mutex_lock(&rt5514_dsp->dma_lock);
@@ -89,6 +89,7 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 		goto done;
 	}
 
+	runtime = rt5514_dsp->substream->runtime;
 	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
 
 	if (rt5514_dsp->buf_size - rt5514_dsp->dsp_offset <  period_bytes)
-- 
2.8.1
