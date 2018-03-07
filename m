From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: dt-bindings: wm8524: Remove unit address
Date: Wed,  7 Mar 2018 00:24:13 -0300
Message-ID: <1520393053-24132-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 9644D267196
 for <alsa-devel@alsa-project.org>; Wed,  7 Mar 2018 04:24:25 +0100 (CET)
Received: by mail-qt0-f196.google.com with SMTP id t6so999888qtn.9
 for <alsa-devel@alsa-project.org>; Tue, 06 Mar 2018 19:24:25 -0800 (PST)
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
Cc: alsa-devel@alsa-project.org, robh+dt@kernel.org, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

WM8524 does not use I2C nor SPI, hence no 'reg' property is used,
so remove the unit address from the bindings example to conform.

This avoids users getting dtc warnings when they copy the
binding example to a real dts file.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
 Documentation/devicetree/bindings/sound/wm8524.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/wm8524.txt b/Documentation/devicetree/bindings/sound/wm8524.txt
index 20c6200..0f05535 100644
--- a/Documentation/devicetree/bindings/sound/wm8524.txt
+++ b/Documentation/devicetree/bindings/sound/wm8524.txt
@@ -10,7 +10,7 @@ Required properties:
 
 Example:
 
-codec: wm8524@0 {
+codec: wm8524 {
 	compatible = "wlf,wm8524";
 	wlf,mute-gpios = <&gpio1 8 GPIO_ACTIVE_LOW>;
 };
-- 
2.7.4
