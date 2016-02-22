From: Mark Brown <broonie@kernel.org>
Subject: Applied "regmap: Add explict native endian flag to DT
	bindings" to the asoc tree
Date: Mon, 22 Feb 2016 12:15:31 +0900
Message-ID: <E1aXgyB-0005vi-D0@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5189526595B
 for <alsa-devel@alsa-project.org>; Mon, 22 Feb 2016 04:15:43 +0100 (CET)
In-Reply-To: 
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   regmap: Add explict native endian flag to DT bindings

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

>From a06c488da0b0c1eebf710017675f00b9d5f9cf42 Mon Sep 17 00:00:00 2001
From: Mark Brown <broonie@kernel.org>
Date: Tue, 26 Jan 2016 17:59:30 +0000
Subject: [PATCH] regmap: Add explict native endian flag to DT bindings

Currently the binding document says that if no endianness is configured
we use native endian but this is not in fact true for all binding types
and we do have some devices that really want native endianness such as
Broadcom MIPS SoCs where switching the endianness of the CPU also
switches the endianness of external IPs.

Provide an explicit option for this.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regmap/regmap.txt | 11 +++++++----
 drivers/base/regmap/regmap.c                        |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/regmap/regmap.txt b/Documentation/devicetree/bindings/regmap/regmap.txt
index b494f8b..e98a9652 100644
--- a/Documentation/devicetree/bindings/regmap/regmap.txt
+++ b/Documentation/devicetree/bindings/regmap/regmap.txt
@@ -5,15 +5,18 @@ Index     Device     Endianness properties
 ---------------------------------------------------
 1         BE         'big-endian'
 2         LE         'little-endian'
+3	  Native     'native-endian'
 
 For one device driver, which will run in different scenarios above
 on different SoCs using the devicetree, we need one way to simplify
 this.
 
-Required properties:
-- {big,little}-endian: these are boolean properties, if absent
-  meaning that the CPU and the Device are in the same endianness mode,
-  these properties are for register values and all the buffers only.
+Optional properties:
+- {big,little,native}-endian: these are boolean properties, if absent
+  then the implementation will choose a default based on the device
+  being controlled.  These properties are for register values and all
+  the buffers only.  Native endian means that the CPU and device have
+  the same endianness.
 
 Examples:
 Scenario 1 : CPU in LE mode & device in LE mode.
diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ee54e84..3432634 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -557,6 +557,8 @@ enum regmap_endian regmap_get_val_endian(struct device *dev,
 			endian = REGMAP_ENDIAN_BIG;
 		else if (of_property_read_bool(np, "little-endian"))
 			endian = REGMAP_ENDIAN_LITTLE;
+		else if (of_property_read_bool(np, "native-endian"))
+			endian = REGMAP_ENDIAN_NATIVE;
 
 		/* If the endianness was specified in DT, use that */
 		if (endian != REGMAP_ENDIAN_DEFAULT)
-- 
2.7.0
