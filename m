From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] ASoC: sgtl500.txt: Document the required
	supplies
Date: Tue, 14 Oct 2014 11:11:02 -0300
Message-ID: <1413295862-2613-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0147.outbound.protection.outlook.com [207.46.100.147])
 by alsa0.perex.cz (Postfix) with ESMTP id BF7D12606B7
 for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2014 16:12:00 +0200 (CEST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sgtl5000 has two required supplies: VDDA and VDDIO and one optional supply:
VDDD, so document this properly.

Not passing VDDA and VDDIO prevents the driver to probe successfully.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 955df60..d556dcb 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -7,10 +7,20 @@ Required properties:
 
 - clocks : the clock provider of SYS_MCLK
 
+- VDDA-supply : the regulator provider of VDDA
+
+- VDDIO-supply: the regulator provider of VDDIO
+
+Optional properties:
+
+- VDDD-supply : the regulator provider of VDDD
+
 Example:
 
 codec: sgtl5000@0a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
 	clocks = <&clks 150>;
+	VDDA-supply = <&reg_3p3v>;
+	VDDIO-supply = <&reg_3p3v>;
 };
-- 
1.9.1
