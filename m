From: Markus Pargmann <mpa@pengutronix.de>
Subject: [PATCH 2/2] ASoC: codec doc,
	tlv320aic3x: Add tlv320aic32x4 as compatible
Date: Sat, 11 Jan 2014 14:48:31 +0100
Message-ID: <1389448111-17064-3-git-send-email-mpa@pengutronix.de>
References: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 393872617BB
 for <alsa-devel@alsa-project.org>; Sat, 11 Jan 2014 14:49:10 +0100 (CET)
In-Reply-To: <1389448111-17064-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Markus Pargmann <mpa@pengutronix.de>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel@pengutronix.de
List-Id: alsa-devel@alsa-project.org

Add tlv320aic32x4 to the compatible list in the binding documentation.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 Documentation/devicetree/bindings/sound/tlv320aic3x.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index 5e6040c..9d8ea14 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -6,6 +6,7 @@ Required properties:
 
 - compatible - "string" - One of:
     "ti,tlv320aic3x" - Generic TLV320AIC3x device
+    "ti,tlv320aic32x4" - TLV320AIC32x4
     "ti,tlv320aic33" - TLV320AIC33
     "ti,tlv320aic3007" - TLV320AIC3007
     "ti,tlv320aic3106" - TLV320AIC3106
-- 
1.8.5.2
