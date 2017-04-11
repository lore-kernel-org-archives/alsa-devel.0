From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: hisilicon: Add error returns even for
	cases that shouldn't happen." to the asoc tree
Date: Tue, 11 Apr 2017 21:42:07 +0100
Message-ID: <E1cy2c3-00081Z-W7@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 58066266DD5
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 22:42:15 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Stultz <john.stultz@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: hisilicon: Add error returns even for cases that shouldn't happen.

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

>From da13d7462b013ab58129fe20bfb3acb3aa73e07e Mon Sep 17 00:00:00 2001
From: John Stultz <john.stultz@linaro.org>
Date: Tue, 11 Apr 2017 12:15:16 -0700
Subject: [PATCH] ASoC: hisilicon: Add error returns even for cases that
 shouldn't happen.

This patch addresses feedback from Mark Brown, adding a few
extra error returns in cases that shouldn't happen

Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/hisilicon/hi6210-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/hisilicon/hi6210-i2s.c b/sound/soc/hisilicon/hi6210-i2s.c
index 45691b70060c..1909bfc6950a 100644
--- a/sound/soc/hisilicon/hi6210-i2s.c
+++ b/sound/soc/hisilicon/hi6210-i2s.c
@@ -395,6 +395,7 @@ static int hi6210_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 	default:
 		WARN_ONCE(1, "Invalid i2s->fmt MASTER_MASK. This shouldn't happen\n");
+		return -EINVAL;
 	}
 
 	switch (i2s->format & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -409,6 +410,7 @@ static int hi6210_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 	default:
 		WARN_ONCE(1, "Invalid i2s->fmt FORMAT_MASK. This shouldn't happen\n");
+		return -EINVAL;
 	}
 
 	val = hi6210_read_reg(i2s, HII2S_I2S_CFG);
-- 
2.11.0
