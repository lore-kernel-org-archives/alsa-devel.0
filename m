From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Place optional properties in
	the correct section" to the asoc tree
Date: Thu, 02 Jun 2016 11:18:35 +0100
Message-ID: <E1b8Phz-0001bb-Fy@finisterre>
References: <1464727310-10034-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 318302666BE
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 12:18:49 +0200 (CEST)
In-Reply-To: <1464727310-10034-1-git-send-email-festevam@gmail.com>
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
Cc: jean-michel.hautbois@vodalys.com, alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Place optional properties in the correct section

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

>From 10ff08029d9880e4bf70de0535f34ce239af7a9a Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Tue, 31 May 2016 17:41:50 -0300
Subject: [PATCH] ASoC: sgtl5000: Place optional properties in the correct
 section

'micbias-resistor-k-ohms' and 'micbias-voltage-m-volts' are optional
properties, so move them below the 'Optional properties' line.

While at it, fix a typo in 'mentioned'.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 0e5e4eb3ef1b..5666da7b8605 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -7,6 +7,14 @@ Required properties:
 
 - clocks : the clock provider of SYS_MCLK
 
+- VDDA-supply : the regulator provider of VDDA
+
+- VDDIO-supply: the regulator provider of VDDIO
+
+Optional properties:
+
+- VDDD-supply : the regulator provider of VDDD
+
 - micbias-resistor-k-ohms : the bias resistor to be used in kOmhs
 	The resistor can take values of 2k, 4k or 8k.
 	If set to 0 it will be off.
@@ -15,17 +23,9 @@ Required properties:
 
 - micbias-voltage-m-volts : the bias voltage to be used in mVolts
 	The voltage can take values from 1.25V to 3V by 250mV steps
-	If this node is not mentionned or the value is unknown, then
+	If this node is not mentioned or the value is unknown, then
 	the value is set to 1.25V.
 
-- VDDA-supply : the regulator provider of VDDA
-
-- VDDIO-supply: the regulator provider of VDDIO
-
-Optional properties:
-
-- VDDD-supply : the regulator provider of VDDD
-
 Example:
 
 codec: sgtl5000@0a {
-- 
2.8.1
