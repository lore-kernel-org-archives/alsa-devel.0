From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Add the sanity checks of the
	buffer related address" to the asoc tree
Date: Tue, 01 Aug 2017 15:16:28 +0100
Message-ID: <E1dcXyG-0008Kv-NB@debutante>
References: <1501480063-32225-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 37D7126691A
 for <alsa-devel@alsa-project.org>; Tue,  1 Aug 2017 16:16:38 +0200 (CEST)
In-Reply-To: <1501480063-32225-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, hychao@google.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, chinyue@google.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5514: Add the sanity checks of the buffer related address

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

>From 818010dac09183e99ff02e35836544b2e1d659f3 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Mon, 31 Jul 2017 13:47:42 +0800
Subject: [PATCH] ASoC: rt5514: Add the sanity checks of the buffer related
 address

The patch add the sanity checks of the buffer related address to make sure
the addresses are valid.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514-spi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514-spi.c b/sound/soc/codecs/rt5514-spi.c
index 950d1ffdc06c..6f513cc4c56c 100644
--- a/sound/soc/codecs/rt5514-spi.c
+++ b/sound/soc/codecs/rt5514-spi.c
@@ -173,9 +173,14 @@ static irqreturn_t rt5514_spi_irq(int irq, void *data)
 	rt5514_dsp->buf_rp = buf[0] | buf[1] << 8 | buf[2] << 16 |
 				buf[3] << 24;
 
+	if (rt5514_dsp->buf_rp % 8)
+		rt5514_dsp->buf_rp = (rt5514_dsp->buf_rp / 8) * 8;
+
 	rt5514_dsp->buf_size = rt5514_dsp->buf_limit - rt5514_dsp->buf_base;
 
-	schedule_delayed_work(&rt5514_dsp->copy_work, 0);
+	if (rt5514_dsp->buf_base && rt5514_dsp->buf_limit &&
+		rt5514_dsp->buf_rp && rt5514_dsp->buf_size)
+		schedule_delayed_work(&rt5514_dsp->copy_work, 0);
 
 	return IRQ_HANDLED;
 }
-- 
2.13.2
