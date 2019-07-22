From: Mark Brown <broonie@kernel.org>
Subject: Applied "sound: soc: codecs: wcd9335: add irqflag IRQF_ONESHOT flag" to the asoc tree
Date: Mon, 22 Jul 2019 13:22:08 +0100 (BST)
Message-ID: <20190722122208.1E4492742B67@ypsilon.sirena.org.uk>
References: <20190710021627.GA13396@hari-Inspiron-1545>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710021627.GA13396@hari-Inspiron-1545>
Sender: linux-kernel-owner@vger.kernel.org
To: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Cc: alsa-devel@alsa-project.org, Dan Carpenter <dan.carpenter@oracle.com>, Gen Zhang <blackgod016574@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vkoul@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   sound: soc: codecs: wcd9335: add irqflag IRQF_ONESHOT flag

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From 866e55ac49a8be478d89f23c941155721187be9a Mon Sep 17 00:00:00 2001
From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Date: Wed, 10 Jul 2019 07:46:27 +0530
Subject: [PATCH] sound: soc: codecs: wcd9335: add irqflag IRQF_ONESHOT flag

Add IRQF_ONESHOT to ensure "Interrupt is not reenabled after the hardirq
handler finished".

fixes below issue reported by coccicheck

sound/soc/codecs/wcd9335.c:4068:8-33: ERROR: Threaded IRQ with no
primary handler requested without IRQF_ONESHOT

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Link: https://lore.kernel.org/r/20190710021627.GA13396@hari-Inspiron-1545
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wcd9335.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd9335.c b/sound/soc/codecs/wcd9335.c
index 1bbbe421b999..956602788d0e 100644
--- a/sound/soc/codecs/wcd9335.c
+++ b/sound/soc/codecs/wcd9335.c
@@ -4062,7 +4062,8 @@ static int wcd9335_setup_irqs(struct wcd9335_codec *wcd)
 
 		ret = devm_request_threaded_irq(wcd->dev, irq, NULL,
 						wcd9335_irqs[i].handler,
-						IRQF_TRIGGER_RISING,
+						IRQF_TRIGGER_RISING |
+						IRQF_ONESHOT,
 						wcd9335_irqs[i].name, wcd);
 		if (ret) {
 			dev_err(wcd->dev, "Failed to request %s\n",
-- 
2.20.1
