From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl_esai doc: Add "fsl,
	vf610-esai" as compatible string
Date: Sat,  4 Oct 2014 11:43:41 -0300
Message-ID: <1412433821-10970-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f43.google.com (mail-qa0-f43.google.com
 [209.85.216.43])
 by alsa0.perex.cz (Postfix) with ESMTP id E01FB260561
 for <alsa-devel@alsa-project.org>; Sat,  4 Oct 2014 16:44:27 +0200 (CEST)
Received: by mail-qa0-f43.google.com with SMTP id s7so1994162qap.30
 for <alsa-devel@alsa-project.org>; Sat, 04 Oct 2014 07:44:26 -0700 (PDT)
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit b21cc2f5fdfe224 ("ASoC: esai: Add VF610+ compatibles support.")
the fsl_esai driver also accepts  the "fsl,vf610-esai" compatible string.

Update the documentation accordingly.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 Documentation/devicetree/bindings/sound/fsl,esai.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
index aeb8c4a..52f5b6b 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
@@ -7,7 +7,8 @@ other DSPs. It has up to six transmitters and four receivers.
 
 Required properties:
 
-  - compatible : Compatible list, must contain "fsl,imx35-esai".
+  - compatible : Compatible list, must contain "fsl,imx35-esai" or
+		 "fsl,vf610-esai"
 
   - reg : Offset and length of the register set for the device.
 
-- 
1.9.1
