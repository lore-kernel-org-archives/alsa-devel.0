From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: tas2552: Improve DT binding document
	example
Date: Mon, 13 Mar 2017 16:56:03 -0300
Message-ID: <1489434963-2843-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f195.google.com (mail-qt0-f195.google.com
 [209.85.216.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 38AC7266B13
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 20:56:30 +0100 (CET)
Received: by mail-qt0-f195.google.com with SMTP id r5so7628371qtb.2
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 12:56:30 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, robh+dt@kernel.org, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Improve DT binding document example by providing the mandatory
regulator properties.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/tas2552.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tas2552.txt b/Documentation/devicetree/bindings/sound/tas2552.txt
index c49992c..075df91 100644
--- a/Documentation/devicetree/bindings/sound/tas2552.txt
+++ b/Documentation/devicetree/bindings/sound/tas2552.txt
@@ -25,6 +25,9 @@ Example:
 tas2552: tas2552@41 {
 	compatible = "ti,tas2552";
 	reg = <0x41>;
+	vbat-supply = <&reg_vbat>;
+	iovdd-supply = <&reg_iovdd>;
+	avdd-supply = <&reg_avdd>;
 	enable-gpio = <&gpio4 2 GPIO_ACTIVE_HIGH>;
 };
 
-- 
2.7.4
