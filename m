From: <oku@iki.fi>
Subject: [PATCH RFC 7/8] ARM/dts: am33xx: mcasp: Add new dma
	related properties
Date: Mon, 9 Sep 2013 18:12:18 +0300
Message-ID: <e4f85aad7a8162dcfb4145e7e9e580a3f0010bb9.1378738436.git.jsarha@ti.com>
References: <cover.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id D32CB26511C
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:12:39 +0200 (CEST)
In-Reply-To: <cover.1378738436.git.jsarha@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Darren Etheridge <detheridge@ti.com>, devicetree-discuss@lists.ozlabs.org, Jyri Sarha <jsarha@ti.com>, "Hebbar,
 Gururaja" <gururaja.hebbar@ti.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Jyri Sarha <jsarha@ti.com>

This patch adds couple of dma related mcasp properies to DT which may
not be needed after dmaengine implementaion of davinci audio is ready.

Signed-off-by: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 2c0679a..57f2b4a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -558,9 +558,16 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcasp0";
-			reg = <0x48038000 0x2000>;
+			reg = <0x48038000 0x2000>,
+			      <0x46400000 0x400000>,
+			      <0x46400000 0x400000>;
+			reg-names = "mpu", "dma-tx", "dma-rx";
 			interrupts = <80 81>;
 			status = "disabled";
+			asp-chan-q = <2>;	/* EVENTQ_2 */
+			dmas = <&edma 8
+				&edma 9>;
+			dma-names = "tx", "rx";
 		};
 
 		mcasp1: mcasp@4803C000 {
@@ -568,9 +575,16 @@
 			#address-cells = <1>;
 			#size-cells = <0>;
 			ti,hwmods = "mcasp1";
-			reg = <0x4803C000 0x2000>;
+			reg = <0x4803C000 0x2000>,
+			      <0x46400000 0x400000>,
+			      <0x46400000 0x400000>;
+			reg-names = "mpu", "dma-tx", "dma-rx";
 			interrupts = <82 83>;
 			status = "disabled";
+			asp-chan-q = <2>;	/* EVENTQ_2 */
+			dmas = <&edma 10
+				&edma 11>;
+			dma-names = "tx", "rx";
 		};
 
 	};
-- 
1.7.9.5
