From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v9 10/10] ASoC: fsl: Update fsl-ssi binding doc
Date: Thu, 20 Jun 2013 15:20:29 +0200
Message-ID: <1371734429-6081-11-git-send-email-mpa@pengutronix.de>
References: <1371734429-6081-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1371734429-6081-1-git-send-email-mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Timur Tabi <timur-N01EOCouUvQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Update the fsl-ssi bindings. DMA is no required property anymore and
uses the generic DMA bindings. imx-fiq is a new alternative to DMA

Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Tested-by: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---

Notes:
    Changes in v9:
     - Remove space before tab
    
    Changes in v4:
     - Add a comment about hardware bugs for imx-pcm-fiq
    
    Changes in v3:
     - In previous versions, I removed fsl,playback-dma and capture-dma. But they
       are still in use by fsl_dma.c, so I added them again.

 Documentation/devicetree/bindings/sound/fsl,ssi.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,ssi.txt b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
index 5ff76c9..cae80d2 100644
--- a/Documentation/devicetree/bindings/sound/fsl,ssi.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,ssi.txt
@@ -43,10 +43,20 @@ Required properties:
                     together.  This would still allow different sample sizes,
                     but not different sample rates.
 
+Note that either dmas, dma-names or fsl,imx-fiq are required.
+
 Optional properties:
 - codec-handle:     Phandle to a 'codec' node that defines an audio
                     codec connected to this SSI.  This node is typically
                     a child of an I2C or other control node.
+- dmas:		    Generic dma devicetree binding as described in
+		    Documentation/devicetree/bindings/dma/dma.txt.
+- dma-names:	    Two dmas have to be defined, "tx" and "rx", if fsl,imx-fiq
+		    is not defined.
+- fsl,imx-fiq:	    Bool property. Use imx-pcm-fiq instead of imx-pcm-dma.
+		    Only necessary for some boards with incompatible
+		    codec. imx-pcm-fiq will manually filter some data from
+		    the codec. It is a workaround for a hardware bug.
 
 Child 'codec' node required properties:
 - compatible:       Compatible list, contains the name of the codec
-- 
1.8.2.1
