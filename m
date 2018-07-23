From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip-i2s: add description for px30"
	to the asoc tree
Date: Mon, 23 Jul 2018 20:11:07 +0100 (BST)
Message-ID: <20180723191107.662AB112387B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id B48B1267637
 for <alsa-devel@alsa-project.org>; Mon, 23 Jul 2018 21:11:08 +0200 (CEST)
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
To: Liang Chen <cl@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip-i2s: add description for px30

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

>From 2f562a4739602d96928de0b040ce46b00d8d3adc Mon Sep 17 00:00:00 2001
From: Liang Chen <cl@rock-chips.com>
Date: Mon, 23 Jul 2018 17:25:21 +0800
Subject: [PATCH] ASoC: rockchip-i2s: add description for px30

Add "rockchip,px30-i2s", "rockchip,rk3066-i2s" for i2s on px30 platform.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Liang Chen <cl@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index b208a752576c..54aefab71f2c 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -7,6 +7,7 @@ Required properties:
 
 - compatible: should be one of the following:
    - "rockchip,rk3066-i2s": for rk3066
+   - "rockchip,px30-i2s", "rockchip,rk3066-i2s": for px30
    - "rockchip,rk3036-i2s", "rockchip,rk3066-i2s": for rk3036
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
    - "rockchip,rk3228-i2s", "rockchip,rk3066-i2s": for rk3228
-- 
2.18.0
