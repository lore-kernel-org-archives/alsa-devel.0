From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: meson: use IRQ_RETVAL in the fifo irq
	handler" to the asoc tree
Date: Thu, 26 Jul 2018 16:02:01 +0100 (BST)
Message-ID: <20180726150201.7CC5C440078@finisterre.ee.mobilebroadband>
References: <20180726124544.14740-2-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 50C1226739D
 for <alsa-devel@alsa-project.org>; Thu, 26 Jul 2018 17:02:02 +0200 (CEST)
In-Reply-To: <20180726124544.14740-2-jbrunet@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Rob Herring <robh@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Carlo Caione <carlo@caione.org>, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: meson: use IRQ_RETVAL in the fifo irq handler

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

>From 036e4963bfb2d4513c30efd80e4bd50ff6c79e3e Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 26 Jul 2018 14:45:42 +0200
Subject: [PATCH] ASoC: meson: use IRQ_RETVAL in the fifo irq handler

Use IRQ_RETVAL instead of the open coded ternary operation.

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/meson/axg-fifo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-fifo.c b/sound/soc/meson/axg-fifo.c
index db367d85290f..30262550e37b 100644
--- a/sound/soc/meson/axg-fifo.c
+++ b/sound/soc/meson/axg-fifo.c
@@ -174,7 +174,7 @@ static irqreturn_t axg_fifo_pcm_irq_block(int irq, void *dev_id)
 	/* Ack irqs */
 	axg_fifo_ack_irq(fifo, status);
 
-	return !status ? IRQ_NONE : IRQ_HANDLED;
+	return IRQ_RETVAL(status);
 }
 
 static int axg_fifo_pcm_open(struct snd_pcm_substream *ss)
-- 
2.18.0
