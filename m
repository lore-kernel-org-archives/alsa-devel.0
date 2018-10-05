From: Marco Felsch <m.felsch@pengutronix.de>
Subject: [PATCH v2 3/5] ASoC: dt-bindings: max98088: add
	external clock binding
Date: Fri,  5 Oct 2018 09:58:10 +0200
Message-ID: <20181005075812.13986-4-m.felsch@pengutronix.de>
References: <20181005075812.13986-1-m.felsch@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [85.220.165.71])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A110267905
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 09:58:26 +0200 (CEST)
In-Reply-To: <20181005075812.13986-1-m.felsch@pengutronix.de>
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

Allow setting the clock provider for the external clock called "mclk".

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
 .../devicetree/bindings/sound/maxim,max98088.txt          | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/maxim,max98088.txt b/Documentation/devicetree/bindings/sound/maxim,max98088.txt
index a79ad5c7af88..da764d913319 100644
--- a/Documentation/devicetree/bindings/sound/maxim,max98088.txt
+++ b/Documentation/devicetree/bindings/sound/maxim,max98088.txt
@@ -7,9 +7,17 @@ Required properties:
 - compatible: "maxim,max98088" or "maxim,max98089".
 - reg: The I2C address of the device.
 
+Optional properties:
+
+- clocks: the clock provider of MCLK, see ../clock/clock-bindings.txt section
+  "consumer" for more information.
+- clock-names: must be set to "mclk"
+
 Example:
 
 max98089: codec@10 {
 	compatible = "maxim,max98089";
 	reg = <0x10>;
+	clocks = <&clks IMX6QDL_CLK_CKO2>;
+	clock-names = "mclk";
 };
-- 
2.19.0
