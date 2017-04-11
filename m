From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas2552: Describe the possible I2C
	addresses" to the asoc tree
Date: Tue, 11 Apr 2017 21:42:01 +0100
Message-ID: <E1cy2bx-0007z4-2w@debutante>
References: <1491936575-5780-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id DD3A126684C
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 22:42:10 +0200 (CEST)
In-Reply-To: <1491936575-5780-1-git-send-email-fabio.estevam@nxp.com>
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
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, dmurphy@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas2552: Describe the possible I2C addresses

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

>From ddea87ea79927ba0b94e697a505f90fe06c29f84 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 11 Apr 2017 15:49:34 -0300
Subject: [PATCH] ASoC: tas2552: Describe the possible I2C addresses

According to the TAS2552 datasheet the possible I2C addresses are:

0x40 - when ADDR pin is 0
0x41 - when ADDR pin is 1

List the possible values for better clarification.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/tas2552.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2552.txt b/Documentation/devicetree/bindings/sound/tas2552.txt
index 54c1c87c4ad8..ea8abf08b094 100644
--- a/Documentation/devicetree/bindings/sound/tas2552.txt
+++ b/Documentation/devicetree/bindings/sound/tas2552.txt
@@ -5,7 +5,8 @@ The tas2552 serial control bus communicates through I2C protocols
 Required properties:
 	- compatible - One of:
 		"ti,tas2552" - TAS2552
-	- reg -  I2C slave address
+	- reg -  I2C slave address: it can be 0x40 if ADDR pin is 0
+				    or 0x41 if ADDR pin is 1.
 	- supply-*: Required supply regulators are:
 		"vbat"		battery voltage
 		"iovdd"		I/O Voltage
-- 
2.11.0
