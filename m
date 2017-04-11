From: Fabio Estevam <fabio.estevam@nxp.com>
Subject: [PATCH 1/2] ASoC: tas2552: Describe the possible I2C
	addresses
Date: Tue, 11 Apr 2017 15:49:34 -0300
Message-ID: <1491936575-5780-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0089.outbound.protection.outlook.com [104.47.38.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 43D782666E1
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 20:49:47 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org

According to the TAS2552 datasheet the possible I2C addresses are:

0x40 - when ADDR pin is 0
0x41 - when ADDR pin is 1

List the possible values for better clarification.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/tas2552.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2552.txt b/Documentation/devicetree/bindings/sound/tas2552.txt
index 54c1c87..ea8abf0 100644
--- a/Documentation/devicetree/bindings/sound/tas2552.txt
+++ b/Documentation/devicetree/bindings/sound/tas2552.txt
@@ -5,7 +5,8 @@ The tas2552 serial control bus communicates through I2C protocols
 Required properties:
 	- compatible - One of:
 		"ti,tas2552" - TAS2552
-	- reg -  I2C slave address
+	- reg -  I2C slave address: it can be 0x40 if ADDR pin is 0
+				    or 0x41 if ADDR pin is 1.
 	- supply-*: Required supply regulators are:
 		"vbat"		battery voltage
 		"iovdd"		I/O Voltage
-- 
2.7.4
