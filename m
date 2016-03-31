From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas571x: new chip added into TAS571x
	binding" to the asoc tree
Date: Thu, 31 Mar 2016 10:33:34 -0700
Message-ID: <E1algTO-0004CK-2t@finisterre>
References: <1459237178-12920-5-git-send-email-petr@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BB95266700
 for <alsa-devel@alsa-project.org>; Thu, 31 Mar 2016 19:33:39 +0200 (CEST)
In-Reply-To: <1459237178-12920-5-git-send-email-petr@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas571x: new chip added into TAS571x binding

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From a42121b7a1d80a0eaac9ed1442760bf4e65f5352 Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <petr@barix.com>
Date: Thu, 31 Mar 2016 18:41:27 +0200
Subject: [PATCH] ASoC: tas571x: new chip added into TAS571x binding

This adds the TAS5721 into the TAS571x binding.

Signed-off-by: Petr Kulhavy <petr@barix.com>
Reviewed-by: Kevin Cernekee <cernekee@chromium.org>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/tas571x.txt | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas571x.txt b/Documentation/devicetree/bindings/sound/tas571x.txt
index 0ac31d8d5ac4..b4959f10b74b 100644
--- a/Documentation/devicetree/bindings/sound/tas571x.txt
+++ b/Documentation/devicetree/bindings/sound/tas571x.txt
@@ -1,4 +1,4 @@
-Texas Instruments TAS5711/TAS5717/TAS5719 stereo power amplifiers
+Texas Instruments TAS5711/TAS5717/TAS5719/TAS5721 stereo power amplifiers
 
 The codec is controlled through an I2C interface.  It also has two other
 signals that can be wired up to GPIOs: reset (strongly recommended), and
@@ -6,7 +6,11 @@ powerdown (optional).
 
 Required properties:
 
-- compatible: "ti,tas5711", "ti,tas5717", or "ti,tas5719"
+- compatible: should be one of the following:
+  - "ti,tas5711",
+  - "ti,tas5717",
+  - "ti,tas5719",
+  - "ti,tas5721"
 - reg: The I2C address of the device
 - #sound-dai-cells: must be equal to 0
 
@@ -25,6 +29,8 @@ Optional properties:
 - PVDD_B-supply: regulator phandle for the PVDD_B supply (5711)
 - PVDD_C-supply: regulator phandle for the PVDD_C supply (5711)
 - PVDD_D-supply: regulator phandle for the PVDD_D supply (5711)
+- DRVDD-supply: regulator phandle for the DRVDD supply (5721)
+- PVDD-supply: regulator phandle for the PVDD supply (5721)
 
 Example:
 
-- 
2.8.0.rc3
