From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH] ASoC: fsl: fix the binding of imx-sgtl5000
Date: Fri, 11 May 2012 22:44:23 +0800
Message-ID: <1336747463-24237-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E0ED210413A
	for <alsa-devel@alsa-project.org>;
	Fri, 11 May 2012 16:44:28 +0200 (CEST)
Received: by dajt11 with SMTP id t11so4236144daj.38
	for <alsa-devel@alsa-project.org>; Fri, 11 May 2012 07:44:27 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Richard Zhao <richard.zhao@freescale.com>, linux-arm-kernel@lists.infradead.org, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

The sgtl5000 data sheet does not particularly mention that the Mic Bias
will internally supplies to MIC_IN, so fix the example in imx-sgtl5000
binding document to have a better reflection of the actual circuit.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/sound/imx-audio-sgtl5000.txt          |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
index d09b4e3..e4acdd8 100644
--- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
@@ -41,8 +41,8 @@ sound {
 	ssi-controller = <&ssi1>;
 	audio-codec = <&sgtl5000>;
 	audio-routing =
+		"MIC_IN", "Mic Jack",
 		"Mic Jack", "Mic Bias",
-		"MIC_IN", "Mic Bias",
 		"Headphone Jack", "HP_OUT";
 	mux-int-port = <1>;
 	mux-ext-port = <3>;
-- 
1.7.5.4
