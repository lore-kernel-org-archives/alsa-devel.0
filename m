From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rk3036: Add binding doc of inno-rk3036
	codec driver" to the asoc tree
Date: Mon, 23 Nov 2015 14:38:22 +0000
Message-ID: <E1a0sG6-0007VI-Uo@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2D3F2657AB
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 15:38:33 +0100 (CET)
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
To: ZhengShunQian <zhengsq@rock-chips.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rk3036: Add binding doc of inno-rk3036 codec driver

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

>From 5f4f276077aeada88c3a7b9f1128c9c6284261cd Mon Sep 17 00:00:00 2001
From: ZhengShunQian <zhengsq@rock-chips.com>
Date: Mon, 9 Nov 2015 10:10:20 +0800
Subject: [PATCH] ASoC: rk3036: Add binding doc of inno-rk3036 codec driver

This patch add the binding document of inno-rk3036
audio codec driver.

Signed-off-by: ZhengShunQian <zhengsq@rock-chips.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/inno-rk3036.txt        | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/inno-rk3036.txt

diff --git a/Documentation/devicetree/bindings/sound/inno-rk3036.txt b/Documentation/devicetree/bindings/sound/inno-rk3036.txt
new file mode 100644
index 000000000000..758de8e27561
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/inno-rk3036.txt
@@ -0,0 +1,20 @@
+Inno audio codec for RK3036
+
+Inno audio codec is integrated inside RK3036 SoC.
+
+Required properties:
+- compatible : Should be "rockchip,rk3036-codec".
+- reg : The registers of codec.
+- clock-names : Should be "acodec_pclk".
+- clocks : The clock of codec.
+- rockchip,grf : The phandle of grf device node.
+
+Example:
+
+	acodec: acodec-ana@20030000 {
+		compatible = "rk3036-codec";
+		reg = <0x20030000 0x4000>;
+		rockchip,grf = <&grf>;
+		clock-names = "acodec_pclk";
+		clocks = <&cru ACLK_VCODEC>;
+	};
-- 
2.6.2
