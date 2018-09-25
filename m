From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH 3/5] ASoC: dt-bindings: max98088: add external
	clock binding
Date: Tue, 25 Sep 2018 16:23:50 +0200
Message-ID: <20180925142352.24106-4-m.felsch@pengutronix.de>
References: <20180925142352.24106-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 340342678BB
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 16:24:27 +0200 (CEST)
In-Reply-To: <20180925142352.24106-1-m.felsch@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Allow setting the external clock called "mclk" in the device tree.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 Documentation/devicetree/bindings/sound/maxim,max98088.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98088.txt b/Documentation/devicetree/bindings/sound/maxim,max98088.txt
index a79ad5c7af88..c575806c9e18 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98088.txt
+++ b/Documentation/devicetree/bindings/sound/maxim,max98088.txt
@@ -6,10 +6,15 @@ Required properties:
 
 - compatible: "maxim,max98088" or "maxim,max98089".
 - reg: The I2C address of the device.
+- clocks: the clock provider of MCLK, see ../clock/clock-bindings.txt section
+  "consumer" for more information.
+- clock-names: must be set to "mclk"
 
 Example:
 
 max98089: codec@10 {
 	compatible = "maxim,max98089";
 	reg = <0x10>;
+	clocks = <&clks IMX6QDL_CLK_CKO2>;
+	clock-names = "mclk";
 };
-- 
2.19.0
