From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fsl: Mark 'big-endian' property as
	optional" to the asoc tree
Date: Mon, 21 May 2018 16:50:29 +0100
Message-ID: <E1fKn4v-0007Ub-HV@debutante>
References: <1526778772-6676-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AA952676E3
 for <alsa-devel@alsa-project.org>; Mon, 21 May 2018 17:50:33 +0200 (CEST)
In-Reply-To: <1526778772-6676-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@tabi.org, robh+dt@kernel.org, nicoleotsuka@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fsl: Mark 'big-endian' property as optional

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9ff3036a60837b6ee0b7f70180f39ac29deb8cc2 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Sat, 19 May 2018 22:12:52 -0300
Subject: [PATCH] ASoC: fsl: Mark 'big-endian' property as optional

Currently the 'big-endian' property is listed as required, which is
not correct. i.MX SoCs do not need such property, so move it under
'Optional properties' entry instead.

Also, fsl-sai.txt incorrectly referenced 'FTM_PWM registers', so
change it to 'SAI registers', which is the intended description.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/fsl,asrc.txt  | 10 ++++++----
 Documentation/devicetree/bindings/sound/fsl,esai.txt  |  2 ++
 Documentation/devicetree/bindings/sound/fsl,spdif.txt |  2 ++
 Documentation/devicetree/bindings/sound/fsl-sai.txt   |  8 +++++---
 4 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl,asrc.txt b/Documentation/devicetree/bindings/sound/fsl,asrc.txt
index f5a14115b459..1d4d9f938689 100644
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
index cacd18bb9ba6..5b9914367610 100644
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
index 38cfa7573441..8b324f82a782 100644
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
index 740b467adf7d..dd9e59738e08 100644
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
2.17.0
