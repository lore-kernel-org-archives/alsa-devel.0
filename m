From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3 2/2] ASoC: fsl ssi doc: Remove unused
	properties
Date: Mon, 29 Sep 2014 23:25:30 -0300
Message-ID: <1412043930-15243-2-git-send-email-festevam@gmail.com>
References: <1412043930-15243-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yh0-f46.google.com (mail-yh0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A8CE2606B4
 for <alsa-devel@alsa-project.org>; Tue, 30 Sep 2014 04:26:52 +0200 (CEST)
Received: by mail-yh0-f46.google.com with SMTP id f73so2183811yha.5
 for <alsa-devel@alsa-project.org>; Mon, 29 Sep 2014 19:26:51 -0700 (PDT)
In-Reply-To: <1412043930-15243-1-git-send-email-festevam@gmail.com>
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
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Li.Xiubo@freescale.com, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

The fsl_ssi driver only checks for the ac97 mode property, so remove the unused
ones.

Suggested-by: Nicolin Chen <nicoleotsuka@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Timur Tabi <timur@tabi.org>
---
Changes since v2:
- Added Timur's Ack and CC the alsa-list
Changes since v1:
- Newly introduced in this series

 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 3aa4a8f..5b76be4 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -58,13 +58,7 @@ Optional properties:
 		    Documentation/devicetree/bindings/dma/dma.txt.
 - dma-names:	    Two dmas have to be defined, "tx" and "rx", if fsl,imx-fiq
 		    is not defined.
-- fsl,mode:         The operating mode for the SSI interface.
-                    "i2s-slave" - I2S mode, SSI is clock slave
-                    "i2s-master" - I2S mode, SSI is clock master
-                    "lj-slave" - left-justified mode, SSI is clock slave
-                    "lj-master" - l.j. mode, SSI is clock master
-                    "rj-slave" - right-justified mode, SSI is clock slave
-                    "rj-master" - r.j., SSI is clock master
+- fsl,mode:         The operating mode for the AC97 interface only.
                     "ac97-slave" - AC97 mode, SSI is clock slave
                     "ac97-master" - AC97 mode, SSI is clock master
 
-- 
1.9.1
