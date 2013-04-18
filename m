From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] sgtl5000.txt: Include supplies as required
	properties
Date: Wed, 17 Apr 2013 21:10:39 -0300
Message-ID: <1366243839-16908-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f53.google.com (mail-yh0-f53.google.com
 [209.85.213.53])
 by alsa0.perex.cz (Postfix) with ESMTP id AEF7F2625D3
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 02:10:50 +0200 (CEST)
Received: by mail-yh0-f53.google.com with SMTP id t59so354759yho.12
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 17:10:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, rob.herring@calxeda.com, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

sgtl5000 driver cannot probe succesfully if VDDA and VDDIO regulators are not
provided.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 .../devicetree/bindings/sound/sgtl5000.txt         |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 9cc4444..520eb98 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -5,9 +5,15 @@ Required properties:
 
 - reg : the I2C address of the device
 
+- VDDA-supply: regulator that provides VDDA voltage
+
+- VDDIO-supply: regulator that provides VDDIO voltage
+
 Example:
 
 codec: sgtl5000@0a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
+	VDDA-supply = <&reg_2p5v>;
+	VDDIO-supply = <&reg_3p3v>;
 };
-- 
1.7.9.5
