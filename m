From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514-spi: Get the period_bytes in the
	copy work to make sure the value correctly" to the asoc tree
Date: Mon, 17 Sep 2018 22:20:56 +0100 (BST)
Message-ID: <20180917212056.A8EFC440078@finisterre.ee.mobilebroadband>
References: <1537182189-13694-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8222C267889
 for <alsa-devel@alsa-project.org>; Mon, 17 Sep 2018 23:21:00 +0200 (CEST)
In-Reply-To: <1537182189-13694-1-git-send-email-oder_chiou@realtek.com>
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
Cc: jack.yu@realtek.com, alsa-devel@alsa-project.org, cychiang@google.com, lgirdwood@gmail.com, yuhsuan@google.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514-spi: Get the period_bytes in the copy work to make sure the value correctly

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

>From fbb673f7c6555d5434ad005f86b0d4368b1203d9 Mon Sep 17 00:00:00 2001
From: Oder Chiou <oder_chiou@realtek.com>
Date: Mon, 17 Sep 2018 19:03:09 +0800
Subject: [PATCH] ASoC: rt5514-spi: Get the period_bytes in the copy work to
 make sure the value correctly

The value of period_bytes will get the zero before the hw_params() is not
run completely. Move the function snd_pcm_lib_period_bytes() to copy work,
and make sure that is not zero.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 18686ffb0cd5..13809821e1f8 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -91,6 +91,14 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 
 	runtime = rt5514_dsp->substream->runtime;
 	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
+	if (!period_bytes) {
+		schedule_delayed_work(&rt5514_dsp->copy_work, 5);
+		goto done;
+	}
+
+	if (rt5514_dsp->buf_size % period_bytes)
+		rt5514_dsp->buf_size = (rt5514_dsp->buf_size / period_bytes) *
+			period_bytes;
 
 	if (rt5514_dsp->get_size >= rt5514_dsp->buf_size) {
 		rt5514_spi_burst_read(RT5514_BUFFER_VOICE_WP, (u8 *)&buf,
@@ -149,13 +157,11 @@ static void rt5514_spi_copy_work(struct work_struct *work)
 
 static void rt5514_schedule_copy(struct rt5514_dsp *rt5514_dsp)
 {
-	size_t period_bytes;
 	u8 buf[8];
 
 	if (!rt5514_dsp->substream)
 		return;
 
-	period_bytes = snd_pcm_lib_period_bytes(rt5514_dsp->substream);
 	rt5514_dsp->get_size = 0;
 
 	/**
@@ -183,10 +189,6 @@ static void rt5514_schedule_copy(struct rt5514_dsp *rt5514_dsp)
 
 	rt5514_dsp->buf_size = rt5514_dsp->buf_limit - rt5514_dsp->buf_base;
 
-	if (rt5514_dsp->buf_size % period_bytes)
-		rt5514_dsp->buf_size = (rt5514_dsp->buf_size / period_bytes) *
-			period_bytes;
-
 	if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
 		rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
 		schedule_delayed_work(&rt5514_dsp->copy_work, 0);
-- 
2.19.0
