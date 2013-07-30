From: Richard Genoud <richard.genoud@gmail.com>
Subject: [PATCH v6 4/8] ARM: AT91: DTS: sam9x5: add SSC DMA parameters
Date: Tue, 30 Jul 2013 12:32:05 +0200
Message-ID: <1375180329-4860-5-git-send-email-richard.genoud@gmail.com>
References: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1375180329-4860-1-git-send-email-richard.genoud@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Nicolas Ferre <nicolas.ferre@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, Stephen Warren <swarren@wwwdotorg.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Richard Genoud <richard.genoud@gmail.com>, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index 20b6423..d6c9895 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -716,6 +716,9 @@
 				compatible = "atmel,at91sam9g45-ssc";
 				reg = <0xf0010000 0x4000>;
 				interrupts = <28 IRQ_TYPE_LEVEL_HIGH 5>;
+				dmas = <&dma0 1 AT91_DMA_CFG_PER_ID(13)>,
+				       <&dma0 1 AT91_DMA_CFG_PER_ID(14)>;
+				dma-names = "tx", "rx";
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_ssc0_tx &pinctrl_ssc0_rx>;
 				clocks = <&periph 28>;
-- 
1.7.10.4
