From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: sgtl5000: Place optional properties in
	the correct section
Date: Tue, 31 May 2016 17:41:50 -0300
Message-ID: <1464727310-10034-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f195.google.com (mail-yw0-f195.google.com
 [209.85.161.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 3838D2651D1
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 22:42:01 +0200 (CEST)
Received: by mail-yw0-f195.google.com with SMTP id j74so20553979ywg.1
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 13:42:01 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, jean-michel.hautbois@vodalys.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

'micbias-resistor-k-ohms' and 'micbias-voltage-m-volts' are optional
properties, so move them below the 'Optional properties' line.

While at it, fix a typo in 'mentioned'.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 0e5e4eb..5666da7 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -7,6 +7,14 @@ Required properties:
 
 - clocks : the clock provider of SYS_MCLK
 
+- VDDA-supply : the regulator provider of VDDA
+
+- VDDIO-supply: the regulator provider of VDDIO
+
+Optional properties:
+
+- VDDD-supply : the regulator provider of VDDD
+
 - micbias-resistor-k-ohms : the bias resistor to be used in kOmhs
 	The resistor can take values of 2k, 4k or 8k.
 	If set to 0 it will be off.
@@ -15,17 +23,9 @@ Required properties:
 
 - micbias-voltage-m-volts : the bias voltage to be used in mVolts
 	The voltage can take values from 1.25V to 3V by 250mV steps
-	If this node is not mentionned or the value is unknown, then
+	If this node is not mentioned or the value is unknown, then
 	the value is set to 1.25V.
 
-- VDDA-supply : the regulator provider of VDDA
-
-- VDDIO-supply: the regulator provider of VDDIO
-
-Optional properties:
-
-- VDDD-supply : the regulator provider of VDDD
-
 Example:
 
 codec: sgtl5000@0a {
-- 
1.9.1
