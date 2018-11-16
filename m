From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add documentation for pcm3060 property
	out-single-ended" to the asoc tree
Date: Fri, 16 Nov 2018 00:39:24 +0000 (GMT)
Message-ID: <20181116003925.01EC6440078@finisterre.ee.mobilebroadband>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id F311E267AFC
 for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2018 01:39:31 +0100 (CET)
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
To: Kirill Marinushkin <kmarinushkin@birdec.tech>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add documentation for pcm3060 property out-single-ended

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

>From fd7de6370cb62b147185834d60069568a21acacd Mon Sep 17 00:00:00 2001
From: Kirill Marinushkin <kmarinushkin@birdec.tech>
Date: Thu, 15 Nov 2018 08:12:53 +0100
Subject: [PATCH] ASoC: Add documentation for pcm3060 property out-single-ended

Output of pcm3060 codec may be configured as single-ended or differential

Signed-off-by: Kirill Marinushkin <kmarinushkin@birdec.tech>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/pcm3060.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/pcm3060.txt b/Documentation/devicetree/bindings/sound/pcm3060.txt
index 90fcb8523099..97de66932d44 100644
--- a/Documentation/devicetree/bindings/sound/pcm3060.txt
+++ b/Documentation/devicetree/bindings/sound/pcm3060.txt
@@ -9,9 +9,15 @@ Required properties:
 - reg : the I2C address of the device for I2C, the chip select
         number for SPI.
 
+Optional properties:
+
+- ti,out-single-ended: "true" if output is single-ended;
+                       "false" or not specified if output is differential.
+
 Examples:
 
 	pcm3060: pcm3060@46 {
 		 compatible = "ti,pcm3060";
 		 reg = <0x46>;
+		 ti,out-single-ended = "true";
 	};
-- 
2.19.1
