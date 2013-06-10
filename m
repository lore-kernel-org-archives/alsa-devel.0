From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 2/2] Documentation: sgtl5000.txt: Add 'clocks'
	entry as a required propery
Date: Mon, 10 Jun 2013 10:24:42 -0300
Message-ID: <1370870682-10243-2-git-send-email-fabio.estevam@freescale.com>
References: <1370870682-10243-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 876272615EE
 for <alsa-devel@alsa-project.org>; Mon, 10 Jun 2013 15:26:08 +0200 (CEST)
In-Reply-To: <1370870682-10243-1-git-send-email-fabio.estevam@freescale.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org
List-Id: alsa-devel@alsa-project.org

Since commit 9e13f345 (ASoC: sgtl5000: Let the codec acquire its clock) , the 
'clocks' entry is mandatory, so update the binding doc.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 9cc4444..955df60 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -5,9 +5,12 @@ Required properties:
 
 - reg : the I2C address of the device
 
+- clocks : the clock provider of SYS_MCLK
+
 Example:
 
 codec: sgtl5000@0a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
+	clocks = <&clks 150>;
 };
-- 
1.8.1.2
