From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: add bindings for rk3399 i2s"
	to the asoc tree
Date: Mon, 22 Feb 2016 19:51:34 +0900
Message-ID: <E1aXo5X-0005gY-02@finisterre>
References: <1456129925-24569-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 99A412659D3
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 11:51:44 +0100 (CET)
In-Reply-To: <1456129925-24569-1-git-send-email-jay.xu@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh@kernel.org>, Jianqun Xu <jay.xu@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: add bindings for rk3399 i2s

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

>From 255edcdfab3d1a45b78d1dacd845d6da5fc64b03 Mon Sep 17 00:00:00 2001
From: Jianqun Xu <jay.xu@rock-chips.com>
Date: Mon, 22 Feb 2016 16:32:05 +0800
Subject: [PATCH] ASoC: rockchip: add bindings for rk3399 i2s

Add devicetree bindings for i2s controller found on rk3399
processors from rockchip.

It's helpful to add full set of compatible strings for serials
of Rockchip SoCs (rk3066, rk3188, rk3288, rk3399).

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 1 +
 sound/soc/rockchip/rockchip_i2s.c                        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index b7f3a9325ebd..6e86d8aa29b4 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -9,6 +9,7 @@ Required properties:
    - "rockchip,rk3066-i2s": for rk3066
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
    - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
+   - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: should contain the I2S interrupt.
diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 6561c4cc2edd..531a6d201d2e 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -575,6 +575,9 @@ static int rockchip_i2s_remove(struct platform_device *pdev)
 
 static const struct of_device_id rockchip_i2s_match[] = {
 	{ .compatible = "rockchip,rk3066-i2s", },
+	{ .compatible = "rockchip,rk3188-i2s", },
+	{ .compatible = "rockchip,rk3288-i2s", },
+	{ .compatible = "rockchip,rk3399-i2s", },
 	{},
 };
 
-- 
2.7.0
