From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas2552: Fix typos in the binding doc"
	to the asoc tree
Date: Tue, 11 Apr 2017 21:41:58 +0100
Message-ID: <E1cy2bu-0007yF-2C@debutante>
References: <1491936575-5780-2-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4BF77266DCA
 for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2017 22:42:11 +0200 (CEST)
In-Reply-To: <1491936575-5780-2-git-send-email-fabio.estevam@nxp.com>
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

   ASoC: tas2552: Fix typos in the binding doc

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

>From 7d8d2c9482474804a5c2b33ea9218d33dbcb48ba Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 11 Apr 2017 15:49:35 -0300
Subject: [PATCH] ASoC: tas2552: Fix typos in the binding doc

Fix the following typos:

"receive its reference clock" and "selected".

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/tas2552.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/tas2552.txt b/Documentation/devicetree/bindings/sound/tas2552.txt
index ea8abf08b094..2d71eb05c1d3 100644
--- a/Documentation/devicetree/bindings/sound/tas2552.txt
+++ b/Documentation/devicetree/bindings/sound/tas2552.txt
@@ -15,11 +15,11 @@ Required properties:
 Optional properties:
 	- enable-gpio - gpio pin to enable/disable the device
 
-tas2552 can receive it's reference clock via MCLK, BCLK, IVCLKIN pin or use the
+tas2552 can receive its reference clock via MCLK, BCLK, IVCLKIN pin or use the
 internal 1.8MHz. This CLKIN is used by the PLL. In addition to PLL, the PDM
 reference clock is also selectable: PLL, IVCLKIN, BCLK or MCLK.
 For system integration the dt-bindings/sound/tas2552.h header file provides
-defined values to selct and configure the PLL and PDM reference clocks.
+defined values to select and configure the PLL and PDM reference clocks.
 
 Example:
 
-- 
2.11.0
