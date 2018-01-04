From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: simple-card: Pass 'reg' property in the
	examples
Date: Thu,  4 Jan 2018 15:24:57 -0200
Message-ID: <1515086697-25900-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f195.google.com (mail-qk0-f195.google.com
 [209.85.220.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 07C26267900
 for <alsa-devel@alsa-project.org>; Thu,  4 Jan 2018 18:25:03 +0100 (CET)
Received: by mail-qk0-f195.google.com with SMTP id x7so2806394qkb.0
 for <alsa-devel@alsa-project.org>; Thu, 04 Jan 2018 09:25:03 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Since unit addresses are passed to simple-audio-card,dai-link a
corresponding 'reg' property is needed, otherwise dtc complains
(when building with W=1) in case someone copies the bindings example
into a real dts file:

Warning (unit_address_vs_reg): Node /sound-digital/simple-audio-card,dai-link@0 has a unit name, but no reg property

Improve the example by passing the correct 'reg' properties.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 166f229..17c13e7 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -140,6 +140,7 @@ sound {
 	simple-audio-card,name = "Cubox Audio";
 
 	simple-audio-card,dai-link@0 {		/* I2S - HDMI */
+		reg = <0>;
 		format = "i2s";
 		cpu {
 			sound-dai = <&audio1 0>;
@@ -150,6 +151,7 @@ sound {
 	};
 
 	simple-audio-card,dai-link@1 {		/* S/PDIF - HDMI */
+		reg = <1>;
 		cpu {
 			sound-dai = <&audio1 1>;
 		};
@@ -159,6 +161,7 @@ sound {
 	};
 
 	simple-audio-card,dai-link@2 {		/* S/PDIF - S/PDIF */
+		reg = <2>;
 		cpu {
 			sound-dai = <&audio1 1>;
 		};
-- 
2.7.4
