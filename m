From: Mark Brown <broonie@kernel.org>
Subject: Applied "dt-bindings: ASoC: Add Spreadtrum DMA
	platform documentation" to the asoc tree
Date: Tue, 29 Jan 2019 18:12:18 +0000 (GMT)
Message-ID: <20190129181218.DD4F31127D50@debutante.sirena.org.uk>
References: <15c562bcfd488fbf1979a69f96ddbd8df57f7e69.1548747137.git.baolin.wang@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 2069E2674B9
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 19:12:21 +0100 (CET)
In-Reply-To: <15c562bcfd488fbf1979a69f96ddbd8df57f7e69.1548747137.git.baolin.wang@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, baolin.wang@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.com, robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   dt-bindings: ASoC: Add Spreadtrum DMA platform documentation

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

>From 27e27e6555d3a1dd3c906796af6d8e7eb538857f Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Tue, 29 Jan 2019 16:04:44 +0800
Subject: [PATCH] dt-bindings: ASoC: Add Spreadtrum DMA platform documentation

Add documentation for Spreadtrum DMA platform driver.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/sprd-pcm.txt    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/sprd-pcm.txt

diff --git a/Documentation/devicetree/bindings/sound/sprd-pcm.txt b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
new file mode 100644
index 000000000000..4b23e84b2e57
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/sprd-pcm.txt
@@ -0,0 +1,23 @@
+* Spreadtrum DMA platfrom bindings
+
+Required properties:
+- compatible: Should be "sprd,pcm-platform".
+- dmas: Specify the list of DMA controller phandle and DMA request line ordered pairs.
+- dma-names: Identifier string for each DMA request line in the dmas property.
+  These strings correspond 1:1 with the ordered pairs in dmas.
+
+Example:
+
+	audio_platform:platform@0 {
+		compatible = "sprd,pcm-platform";
+		dmas = <&agcp_dma 1 1>, <&agcp_dma 2 2>,
+		     <&agcp_dma 3 3>, <&agcp_dma 4 4>,
+		     <&agcp_dma 5 5>, <&agcp_dma 6 6>,
+		     <&agcp_dma 7 7>, <&agcp_dma 8 8>,
+		     <&agcp_dma 9 9>, <&agcp_dma 10 10>;
+		dma-names = "normal_p_l", "normal_p_r",
+			"normal_c_l", "normal_c_r",
+			"voice_c", "fast_p",
+			"loop_c", "loop_p",
+			"voip_c", "voip_p";
+	};
-- 
2.20.1
