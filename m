From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: atmel_ssc_dai: Don't unconditionally reset SSC on stream startup" to the asoc tree
Date: Tue, 16 Aug 2016 12:30:10 +0100
Message-ID: <E1bZcZO-0004ht-S1@debutante>
References: <1471280365-23452-1-git-send-email-pmeerw@pmeerw.net>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1471280365-23452-1-git-send-email-pmeerw@pmeerw.net>
Sender: stable-owner@vger.kernel.org
To: Christoph Huber <c.huber@bct-electronic.com>
Cc: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>, Mark Brown <broonie@kernel.org>, stable@vger.kernel.orgMark Brown <broonie@kernel.org>Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>, alsa-devel@alsa-project.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Songjun Wu <songjun.wu@microchip.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: atmel_ssc_dai: Don't unconditionally reset SSC on stream startup

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

>From 3e103a65514c2947e53f3171b21255fbde8b60c6 Mon Sep 17 00:00:00 2001
From: Christoph Huber <c.huber@bct-electronic.com>
Date: Mon, 15 Aug 2016 18:59:25 +0200
Subject: [PATCH] ASoC: atmel_ssc_dai: Don't unconditionally reset SSC on
 stream startup

commit cbaadf0f90d6 ("ASoC: atmel_ssc_dai: refactor the startup and
shutdown") refactored code such that the SSC is reset on every
startup; this breaks duplex audio (e.g. first start audio playback,
then start record, causing the playback to stop/hang)

Fixes: cbaadf0f90d6 (ASoC: atmel_ssc_dai: refactor the startup and shutdown)
Signed-off-by: Christoph Huber <c.huber@bct-electronic.com>
Signed-off-by: Peter Meerwald-Stadler <p.meerwald@bct-electronic.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 sound/soc/atmel/atmel_ssc_dai.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 54c09acd3fed..16e459aedffe 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -299,8 +299,9 @@ static int atmel_ssc_startup(struct snd_pcm_substream *substream,
 	clk_enable(ssc_p->ssc->clk);
 	ssc_p->mck_rate = clk_get_rate(ssc_p->ssc->clk);
 
-	/* Reset the SSC to keep it at a clean status */
-	ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
+	/* Reset the SSC unless initialized to keep it in a clean state */
+	if (!ssc_p->initialized)
+		ssc_writel(ssc_p->ssc->regs, CR, SSC_BIT(CR_SWRST));
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		dir = 0;
-- 
2.8.1
