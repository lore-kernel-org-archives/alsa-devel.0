From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Make the node name generic"
	to the asoc tree
Date: Sat,  5 May 2018 02:44:01 +0100 (BST)
Message-ID: <20180505014401.C269544007C@finisterre.ee.mobilebroadband>
References: <1525461123-16686-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F31CB2675EE
 for <alsa-devel@alsa-project.org>; Sat,  5 May 2018 03:44:04 +0200 (CEST)
In-Reply-To: <1525461123-16686-1-git-send-email-festevam@gmail.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Make the node name generic

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

>From f59094e0373768a0c762ff0958879b12ad8beb82 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Fri, 4 May 2018 16:12:00 -0300
Subject: [PATCH] ASoC: sgtl5000: Make the node name generic

According to Devicetree Specification v0.2 document:

"The name of a node should be somewhat generic, reflecting the function
of the device and not its precise programming model."

Do as suggested in the binding example.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.txt b/Documentation/devicetree/bindings/sound/sgtl5000.txt
index 9a36c7e2a143..0f214457476f 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.txt
@@ -39,7 +39,7 @@ VDDIO		1.8V		2.5V		3.3V
 
 Example:
 
-codec: sgtl5000@a {
+sgtl5000: codec@a {
 	compatible = "fsl,sgtl5000";
 	reg = <0x0a>;
 	#sound-dai-cells = <0>;
-- 
2.17.0
