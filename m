From: Baoyou Xie <baoyou.xie@linaro.org>
Subject: [PATCH v2 2/3] dt: ASoC: zx-i2s: Document for the ZTE
	zx296718 I2S controller
Date: Tue,  7 Feb 2017 11:02:50 +0800
Message-ID: <1486436571-8682-2-git-send-email-baoyou.xie@linaro.org>
References: <1486436571-8682-1-git-send-email-baoyou.xie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f54.google.com (mail-pg0-f54.google.com [74.125.83.54])
 by alsa0.perex.cz (Postfix) with ESMTP id C4F87266F02
 for <alsa-devel@alsa-project.org>; Tue,  7 Feb 2017 04:03:36 +0100 (CET)
Received: by mail-pg0-f54.google.com with SMTP id 194so34063406pgd.2
 for <alsa-devel@alsa-project.org>; Mon, 06 Feb 2017 19:03:36 -0800 (PST)
In-Reply-To: <1486436571-8682-1-git-send-email-baoyou.xie@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, jun.nie@linaro.org, baoyou.xie@linaro.org, mturquette@baylibre.com, sboyd@codeaurora.org, perex@perex.cz, tiwai@suse.com, shawn.guo@linaro.org, vinod.koul@intel.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, xie.baoyou@zte.com.cn, linux-kernel@vger.kernel.org, chen.chaokai@zte.com.cn, wang.qiang01@zte.com.cn, shawnguo@kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch documents the devicetree for the ZTE's zx296718
I2S audio controller.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
index 7e5aa6f..c405561 100644
--- a/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
+++ b/Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
@@ -1,10 +1,12 @@
 ZTE ZX296702 I2S controller
 
 Required properties:
- - compatible : Must be "zte,zx296702-i2s"
+ - compatible : Should include one of the following strings:
+	"zte,zx296702-i2s","zte,zx296718-i2s".
  - reg : Must contain I2S core's registers location and length
  - clocks : Pairs of phandle and specifier referencing the controller's clocks.
- - clock-names: "tx" for the clock to the I2S interface.
+ - clock-names: "tx" for the wclk, "pclk" for the pclk to the I2S interface.
+	must contain pclk for zx296718 SoC.
  - dmas: Pairs of phandle and specifier for the DMA channel that is used by
    the core. The core expects two dma channels for transmit.
  - dma-names : Must be "tx" and "rx"
-- 
2.7.4
