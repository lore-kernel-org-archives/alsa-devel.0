From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] sgtl5000.txt: Explain the required and
	optional power supplies
Date: Mon, 13 May 2013 12:39:20 -0300
Message-ID: <1368459567-26780-2-git-send-email-fabio.estevam@freescale.com>
References: <1368459567-26780-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 1BB1B2616F4
 for <alsa-devel@alsa-project.org>; Mon, 13 May 2013 17:40:01 +0200 (CEST)
In-Reply-To: <1368459567-26780-1-git-send-email-fabio.estevam@freescale.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, matt@genesi-usa.com, alsa-devel@alsa-project.org, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org

sgtl5000 has two power supplies that are mandatory: VDDA and VDDIO.

VDDD is an optional supply and can be left unconnected and in this case an 
internal regulator is used.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 .../devicetree/bindings/sound/sgtl5000.txt         |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 9cc4444..3537a7d 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -5,9 +5,19 @@ Required properties:
 
 - reg : the I2C address of the device
 
+- VDDA-supply: the regulator for VDDA supply
+
+- VDDIO-supply: the regulator for VDDIO supply
+
+Optional properties:
+
+- VDDD-supply: the regulator for VDDD supply
+
 Example:
 
 codec: sgtl5000@0a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
+	VDDA-supply = <&vdda_reg>;
+	VDDIO-supply = <&vddio_reg>;
 };
-- 
1.7.9.5
