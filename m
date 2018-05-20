From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: Mark 'big-endian' property as
	optional
Date: Sat, 19 May 2018 22:12:52 -0300
Message-ID: <1526778772-6676-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f196.google.com (mail-qt0-f196.google.com
 [209.85.216.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 8ECC3267388
 for <alsa-devel@alsa-project.org>; Sun, 20 May 2018 03:13:00 +0200 (CEST)
Received: by mail-qt0-f196.google.com with SMTP id d3-v6so14972925qtp.11
 for <alsa-devel@alsa-project.org>; Sat, 19 May 2018 18:13:00 -0700 (PDT)
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@tabi.org, nicoleotsuka@gmail.com, robh+dt@kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently the 'big-endian' property is listed as required, which is
not correct. i.MX SoCs do not need such property, so move it under
'Optional properties' entry instead.

Also, fsl-sai.txt incorrectly referenced 'FTM_PWM registers', so
change it to 'SAI registers', which is the intended description.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,asrc.txt  | 10 ++++++----
 Documentation/devicetree/bindings/sound/fsl,esai.txt  |  2 ++
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  2 ++
 Documentation/devicetree/bindings/sound/fsl-sai.txt   |  8 +++++---
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index f5a1411..1d4d9f9 100644
--- a/Documentation/devicetree/bindings/sound/fsl,asrc.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
@@ -31,14 +31,16 @@ Required properties:
 			  it. This property is optional depending on the SoC
 			  design.
 
-   - big-endian		: If this property is absent, the little endian mode
-			  will be in use as default. Otherwise, the big endian
-			  mode will be in use for all the device registers.
-
    - fsl,asrc-rate	: Defines a mutual sample rate used by DPCM Back Ends.
 
    - fsl,asrc-width	: Defines a mutual sample width used by DPCM Back Ends.
 
+Optional properties:
+
+   - big-endian		: If this property is absent, the little endian mode
+			  will be in use as default. Otherwise, the big endian
+			  mode will be in use for all the device registers.
+
 Example:
 
 asrc: asrc@2034000 {
diff --git a/Documentation/devicetree/bindings/sound/fsl,esai.txt b/Documentation/devicetree/bindings/sound/fsl,esai.txt
index cacd18b..5b99143 100644
--- a/Documentation/devicetree/bindings/sound/fsl,esai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,esai.txt
@@ -42,6 +42,8 @@ Required properties:
 			  means all the settings for Receiving would be
 			  duplicated from Transmition related registers.
 
+Optional properties:
+
   - big-endian		: If this property is absent, the native endian mode
 			  will be in use as default, or the big endian mode
 			  will be in use for all the device registers.
diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.txt b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
index 38cfa75..8b324f8 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.txt
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.txt
@@ -33,6 +33,8 @@ Required properties:
 			  it. This property is optional depending on the SoC
 			  design.
 
+Optional properties:
+
    - big-endian		: If this property is absent, the native endian mode
 			  will be in use as default, or the big endian mode
 			  will be in use for all the device registers.
diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 740b467..dd9e597 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -28,9 +28,6 @@ Required properties:
 			  pinctrl-names. See ../pinctrl/pinctrl-bindings.txt
 			  for details of the property values.
 
-  - big-endian		: Boolean property, required if all the FTM_PWM
-			  registers are big-endian rather than little-endian.
-
   - lsb-first		: Configures whether the LSB or the MSB is transmitted
 			  first for the fifo data. If this property is absent,
 			  the MSB is transmitted first as default, or the LSB
@@ -48,6 +45,11 @@ Required properties:
 			  receive data by following their own bit clocks and
 			  frame sync clocks separately.
 
+Optional properties:
+
+  - big-endian		: Boolean property, required if all the SAI
+			  registers are big-endian rather than little-endian.
+
 Optional properties (for mx6ul):
 
   - fsl,sai-mclk-direction-output: This is a boolean property. If present,
-- 
2.7.4
