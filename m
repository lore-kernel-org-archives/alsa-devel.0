From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 2/2] ASoC: ak4104: Add regulator to
	documentation
Date: Fri, 28 Mar 2014 19:05:05 +0100
Message-ID: <1396029905-6807-2-git-send-email-zonque@gmail.com>
References: <1396029905-6807-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f52.google.com (mail-bk0-f52.google.com
 [209.85.214.52])
 by alsa0.perex.cz (Postfix) with ESMTP id C9EFD265510
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 19:05:13 +0100 (CET)
Received: by mail-bk0-f52.google.com with SMTP id my13so955412bkb.39
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 11:05:13 -0700 (PDT)
In-Reply-To: <1396029905-6807-1-git-send-email-zonque@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Add the 3v3 supply to Documentation/devicetree/bindings/sound/ak4104.txt.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/sound/ak4104.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/ak4104.txt b/Documentation/devicetree/bindings/sound/ak4104.txt
index b902ee3..deca5e1 100644
--- a/Documentation/devicetree/bindings/sound/ak4104.txt
+++ b/Documentation/devicetree/bindings/sound/ak4104.txt
@@ -8,6 +8,8 @@ Required properties:
 
   - reg : The chip select number on the SPI bus
 
+  - vdd-supply : A regulator node, providing 2.7V - 3.6V
+
 Optional properties:
 
   - reset-gpio : a GPIO spec for the reset pin. If specified, it will be
@@ -19,4 +21,5 @@ spdif: ak4104@0 {
 	compatible = "asahi-kasei,ak4104";
 	reg = <0>;
 	spi-max-frequency = <5000000>;
+	vdd-supply = <&vdd_3v3_reg>;
 };
-- 
1.8.5.3
