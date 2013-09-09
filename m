From: <oku@iki.fi>
Subject: [PATCH RFC 6/8] ARM/dts: am33xx: Add mcasp0 and mcasp1
	device tree entries
Date: Mon, 9 Sep 2013 18:12:17 +0300
Message-ID: <a8dd2abf8c468f6a42557b2794d104d31da4649a.1378738436.git.jsarha@ti.com>
References: <cover.1378738436.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 3EE242650A0
 for <alsa-devel@alsa-project.org>; Mon,  9 Sep 2013 17:12:37 +0200 (CEST)
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
Cc: Darren Etheridge <detheridge@ti.com>, devicetree-discuss@lists.ozlabs.org, Pantelis Antoniou <panto@antoniou-consulting.com>, Jyri Sarha <jsarha@ti.com>, liam.r.girdwood@linux.intel.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Pantelis Antoniou <panto@antoniou-consulting.com>

Add missing mcasp entries in the am33xx.dtsi include file.

Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 0fdb949..2c0679a 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -552,5 +552,26 @@
 			#size-cells = <1>;
 			status = "disabled";
 		};
+
+		mcasp0: mcasp@48038000 {
+			compatible = "ti,omap2-mcasp-audio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcasp0";
+			reg = <0x48038000 0x2000>;
+			interrupts = <80 81>;
+			status = "disabled";
+		};
+
+		mcasp1: mcasp@4803C000 {
+			compatible = "ti,omap2-mcasp-audio";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			ti,hwmods = "mcasp1";
+			reg = <0x4803C000 0x2000>;
+			interrupts = <82 83>;
+			status = "disabled";
+		};
+
 	};
 };
-- 
1.7.9.5
