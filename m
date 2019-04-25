From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: stm32: i2s: return the get_irq error" to the asoc tree
Date: Thu, 25 Apr 2019 20:26:29 +0100 (BST)
Message-ID: <20190425192629.C58A7441D56@finisterre.ee.mobilebroadband>
References: <1556119724-9873-1-git-send-email-fabien.dessenne@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556119724-9873-1-git-send-email-fabien.dessenne@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabien Dessenne <fabien.dessenne@st.com>
Cc: Alexandre@sirena.org.uk, alsa-devel@alsa-project.org, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Mark Brown <broonie@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Olivier Moysan <olivier.moysan@st.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: stm32: i2s: return the get_irq error

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.1

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

>From 0bbf4084e0cfbbbff8673f3b9867778d5d4b1d6f Mon Sep 17 00:00:00 2001
From: Fabien Dessenne <fabien.dessenne@st.com>
Date: Wed, 24 Apr 2019 17:28:44 +0200
Subject: [PATCH] ASoC: stm32: i2s: return the get_irq error

During probe, return the "get_irq" error value instead of -ENOENT. This
allows the driver to be deferred probed if needed.

Signed-off-by: Fabien Dessenne <fabien.dessenne@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 8968458eec62..e707d28cb203 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -845,8 +845,9 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	/* Get irqs */
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
-		return -ENOENT;
+		if (irq != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "no irq for node %s\n", pdev->name);
+		return irq;
 	}
 
 	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, IRQF_ONESHOT,
-- 
2.20.1
