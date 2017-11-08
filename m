From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514-spi: Let the buf_size to align
	with period_bytes" to the asoc tree
Date: Wed, 08 Nov 2017 16:08:01 +0000
Message-ID: <E1eCStV-0002CW-CH@debutante>
References: <1510140107-9920-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C4AED2674B2
 for <alsa-devel@alsa-project.org>; Wed,  8 Nov 2017 17:08:05 +0100 (CET)
In-Reply-To: <1510140107-9920-1-git-send-email-oder_chiou@realtek.com>
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
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514-spi: Let the buf_size to align with period_bytes

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

>From c4a71ff78e668a75a4a3cfd9ebbfbd5cbe8da5fb Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Wed, 8 Nov 2017 19:21:47 +0800
Subject: [PATCH] ASoC: rt5514-spi: Let the buf_size to align with period_bytes

The patch lets the buf_size to align with period_bytes to prevent the
buffer reading over the real size of the DSP buffer and also avoid to
calculate the wrong size of remaining data.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 12f2ecf3a4fe..0896817ffc3f 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -147,8 +147,13 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 
 static void rt5514_schedule_copy(struct rt5514_dsp *rt5514_dsp)
 {
+	size_t period_bytes;
 	u8 buf[8];
 
+	if (!rt5514_dsp->substream)
+		return;
+
+	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
 	rt5514_dsp->get_size = 0;
 
 	/**
@@ -176,6 +181,10 @@ static void rt5514_schedule_copy(struct rt5514_dsp *rt5514_dsp)
 
 	rt5514_dsp->buf_size = rt5514_dsp->buf_limit - rt5514_dsp->buf_base;
 
+	if (rt5514_dsp->buf_size % period_bytes)
+		rt5514_dsp->buf_size = (rt5514_dsp->buf_size / period_bytes) *
+			period_bytes;
+
 	if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
 		rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
 		schedule_delayed_work(&rt5514_dsp->copy_work, 0);
-- 
2.15.0
