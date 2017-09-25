From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Change the dev getting function
	in rt5663_irq" to the asoc tree
Date: Mon, 25 Sep 2017 17:16:28 +0100 (BST)
Message-ID: <20170925161628.69522440056@finisterre.ee.mobilebroadband>
References: <1506309065-25802-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E1BFC266ECE
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:35:16 +0200 (CEST)
In-Reply-To: <1506309065-25802-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, alexlee@realtek.com, bardliao@realtek.com, shumingf@realtek.com, naveen.m@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Change the dev getting function in rt5663_irq

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

>From a16cc6326d58b32f12f2e60d0b0ec2c8771469a5 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Mon, 25 Sep 2017 11:11:05 +0800
Subject: [PATCH] ASoC: rt5663: Change the dev getting function in rt5663_irq

In the irq handler "rt5663_irq", while the codec is not initialized,
rt5663->codec will be null, and it will cause the kernel panic in the debug
print enabled.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index ab9e0ebff5a7..e45b895d8279 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1639,7 +1639,8 @@ static irqreturn_t rt5663_irq(int irq, void *data)
 {
 	struct rt5663_priv *rt5663 = data;
 
-	dev_dbg(rt5663->codec->dev, "%s IRQ queue work\n", __func__);
+	dev_dbg(regmap_get_device(rt5663->regmap), "%s IRQ queue work\n",
+		__func__);
 
 	queue_delayed_work(system_wq, &rt5663->jack_detect_work,
 		msecs_to_jiffies(250));
-- 
2.14.1
