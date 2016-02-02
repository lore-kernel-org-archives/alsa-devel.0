From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Return sample rate in
	wm_adsp_compr_pointer" to the asoc tree
Date: Tue, 02 Feb 2016 19:41:58 +0000
Message-ID: <E1aQgpq-0007s3-2p@debutante>
References: <1454431296-21622-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E934F26523B
 for <alsa-devel@alsa-project.org>; Tue,  2 Feb 2016 20:42:05 +0100 (CET)
In-Reply-To: <1454431296-21622-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Return sample rate in wm_adsp_compr_pointer

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

>From da2b33589013b4cb3dad163f50fae060896cb8b6 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Tue, 2 Feb 2016 16:41:36 +0000
Subject: [PATCH] ASoC: wm_adsp: Return sample rate in wm_adsp_compr_pointer

We should return a valid sample rate from the pointer callback, this
patch adds this into the driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 33806d487b8a..68b85ee67586 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -295,6 +295,8 @@ struct wm_adsp_compr {
 
 	u32 *raw_buf;
 	unsigned int copied_total;
+
+	unsigned int sample_rate;
 };
 
 #define WM_ADSP_DATA_WORD_SIZE         3
@@ -2471,6 +2473,8 @@ int wm_adsp_compr_set_params(struct snd_compr_stream *stream,
 	if (!compr->raw_buf)
 		return -ENOMEM;
 
+	compr->sample_rate = params->codec.sample_rate;
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp_compr_set_params);
@@ -2911,6 +2915,7 @@ int wm_adsp_compr_pointer(struct snd_compr_stream *stream,
 
 	tstamp->copied_total = compr->copied_total;
 	tstamp->copied_total += buf->avail * WM_ADSP_DATA_WORD_SIZE;
+	tstamp->sampling_rate = compr->sample_rate;
 
 out:
 	mutex_unlock(&dsp->pwr_lock);
-- 
2.7.0.rc3
