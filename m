From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rockchip: add playback property" to the
	asoc tree
Date: Mon, 16 Nov 2015 17:51:49 +0000
Message-ID: <E1ZyNwT-0006oc-MB@debutante>
References: <1447140729-18267-3-git-send-email-sugar.zhang@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A7FEF2604EF
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 18:51:55 +0100 (CET)
In-Reply-To: <1447140729-18267-3-git-send-email-sugar.zhang@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sugar Zhang <sugar.zhang@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rockchip: add playback property

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

>From 7fd9093a7570f5d8bbdc8014c0a349da2afea97e Mon Sep 17 00:00:00 2001
From: Sugar Zhang <sugar.zhang@rock-chips.com>
Date: Tue, 10 Nov 2015 15:32:08 +0800
Subject: [PATCH] ASoC: rockchip: add playback property

rockchip,playback-channels: max playback channels, 8 channels default.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/rockchip-i2s.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
index 2267d249ca0e..b7f3a9325ebd 100644
--- a/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.txt
@@ -19,6 +19,7 @@ Required properties:
 - clock-names: should contain followings:
    - "i2s_hclk": clock for I2S BUS
    - "i2s_clk" : clock for I2S controller
+- rockchip,playback-channels: max playback channels, if not set, 8 channels default.
 - rockchip,capture-channels: max capture channels, if not set, 2 channels default.
 
 Example for rk3288 I2S controller:
@@ -31,5 +32,6 @@ i2s@ff890000 {
 	dma-names = "tx", "rx";
 	clock-names = "i2s_hclk", "i2s_clk";
 	clocks = <&cru HCLK_I2S0>, <&cru SCLK_I2S0>;
+	rockchip,playback-channels = <8>;
 	rockchip,capture-channels = <2>;
 };
-- 
2.6.2
