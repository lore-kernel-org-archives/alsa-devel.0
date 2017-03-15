From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: add bindings for rk3368 i2s"
	to the asoc tree
Date: Wed, 15 Mar 2017 18:13:59 +0000
Message-ID: <E1coDQt-0002TY-Lw@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07455267121
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 19:14:07 +0100 (CET)
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
To: Jianqun Xu <jay.xu@rock-chips.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: add bindings for rk3368 i2s

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

>From f49efce4ed6fdec17a32406eccb56fc167f43b6c Mon Sep 17 00:00:00 2001
From: Jianqun Xu <jay.xu@rock-chips.com>
Date: Wed, 15 Mar 2017 14:14:00 +0800
Subject: [PATCH] ASoC: rockchip: add bindings for rk3368 i2s

Add devicetree bindings for i2s controller found on rk3368
processors from rockchip.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index a6600f6dea64..206aba1b34bb 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -9,6 +9,7 @@ Required properties:
    - "rockchip,rk3066-i2s": for rk3066
    - "rockchip,rk3188-i2s", "rockchip,rk3066-i2s": for rk3188
    - "rockchip,rk3288-i2s", "rockchip,rk3066-i2s": for rk3288
+   - "rockchip,rk3368-i2s", "rockchip,rk3066-i2s": for rk3368
    - "rockchip,rk3399-i2s", "rockchip,rk3066-i2s": for rk3399
 - reg: physical base address of the controller and length of memory mapped
   region.
-- 
2.11.0
