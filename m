From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 1/2] ASoC: ak5386: Add regulators to
	documentation and fix sparse warning
Date: Fri, 28 Mar 2014 19:05:04 +0100
Message-ID: <1396029905-6807-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f50.google.com (mail-bk0-f50.google.com
 [209.85.214.50])
 by alsa0.perex.cz (Postfix) with ESMTP id A60D12615B9
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 19:05:12 +0100 (CET)
Received: by mail-bk0-f50.google.com with SMTP id w10so948807bkz.9
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 11:05:12 -0700 (PDT)
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

Document the newly added regulators to the DT binding document.

Also, "static const char const *x" is not identical to "static const
char * const x", which sparse now complains about. Fix it.

Signed-off-by: Daniel Mack <zonque@gmail.com>
---
 Documentation/devicetree/bindings/sound/ak5386.txt | 4 ++++
 sound/soc/codecs/ak5386.c                          | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/ak5386.txt b/Documentation/devicetree/bindings/sound/ak5386.txt
index dc3914f..ec3df3a 100644
--- a/Documentation/devicetree/bindings/sound/ak5386.txt
+++ b/Documentation/devicetree/bindings/sound/ak5386.txt
@@ -10,10 +10,14 @@ Optional properties:
 
   - reset-gpio : a GPIO spec for the reset/power down pin.
 		 If specified, it will be deasserted at probe time.
+  - va-supply : a regulator spec, providing 5.0V
+  - vd-supply : a regulator spec, providing 3.3V
 
 Example:
 
 spdif: ak5386@0 {
 	compatible = "asahi-kasei,ak5386";
 	reset-gpio = <&gpio0 23>;
+	va-supply = <&vdd_5v0_reg>;
+	vd-supply = <&vdd_3v3_reg>;
 };
diff --git a/sound/soc/codecs/ak5386.c b/sound/soc/codecs/ak5386.c
index a30be5c..8107a1c 100644
--- a/sound/soc/codecs/ak5386.c
+++ b/sound/soc/codecs/ak5386.c
@@ -19,7 +19,7 @@
 #include <sound/pcm.h>
 #include <sound/initval.h>
 
-static const char const *supply_names[] = {
+static const char * const supply_names[] = {
 	"va", "vd"
 };
 
-- 
1.8.5.3
