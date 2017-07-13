From: Quentin Schulz <quentin.schulz@free-electrons.com>
Subject: [PATCH v3 7/9] ASoC: atmel-classd: remove aclk clock
	from DT binding
Date: Thu, 13 Jul 2017 09:49:25 +0200
Message-ID: <20170713074927.10882-8-quentin.schulz@free-electrons.com>
References: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 53A892671DC
 for <alsa-devel@alsa-project.org>; Thu, 13 Jul 2017 09:49:43 +0200 (CEST)
In-Reply-To: <20170713074927.10882-1-quentin.schulz@free-electrons.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, broonie@kernel.org, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com
Cc: thomas.petazzoni@free-electrons.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Quentin Schulz <quentin.schulz@free-electrons.com>, cyrille.pitchen@wedev4u.fr, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Since gclk (generated-clk) is now able to determine the rate of the
audio_pll, there is no need for classd to have a direct phandle to the
audio_pll while already having a phandle to gclk.

This binding is used by no board in mainline so it is safe to be
modified.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Mark Brown <broonie@kernel.org>
Acked-by: Rob Herring <robh@kernel.org>
---

added in v2

 Documentation/devicetree/bindings/sound/atmel-classd.txt | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/atmel-classd.txt b/Documentation/devicetree/bindings/sound/atmel-classd.txt
index 549e701cb7a1..898551076382 100644
--- a/Documentation/devicetree/bindings/sound/atmel-classd.txt
+++ b/Documentation/devicetree/bindings/sound/atmel-classd.txt
@@ -13,13 +13,11 @@ Required properties:
 	Must be "tx".
 - clock-names
 	Tuple listing input clock names.
-	Required elements: "pclk", "gclk" and "aclk".
+	Required elements: "pclk" and "gclk".
 - clocks
 	Please refer to clock-bindings.txt.
 - assigned-clocks
 	Should be <&classd_gclk>.
-- assigned-clock-parents
-	Should be <&audio_pll_pmc>.
 
 Optional properties:
 - pinctrl-names, pinctrl-0
@@ -45,10 +43,9 @@ classd: classd@fc048000 {
 			(AT91_XDMAC_DT_MEM_IF(0) | AT91_XDMAC_DT_PER_IF(1)
 			| AT91_XDMAC_DT_PERID(47))>;
 		dma-names = "tx";
-		clocks = <&classd_clk>, <&classd_gclk>, <&audio_pll_pmc>;
-		clock-names = "pclk", "gclk", "aclk";
+		clocks = <&classd_clk>, <&classd_gclk>;
+		clock-names = "pclk", "gclk";
 		assigned-clocks = <&classd_gclk>;
-		assigned-clock-parents = <&audio_pll_pmc>;
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_classd_default>;
-- 
2.11.0
