From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Document GPIO support"
	to the asoc tree
Date: Mon,  7 Jan 2019 12:24:58 +0000 (GMT)
Message-ID: <20190107122458.B0BA21127490@debutante.sirena.org.uk>
References: <20190103140552.29809-3-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 7FC71267B7D
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 13:24:59 +0100 (CET)
In-Reply-To: <20190103140552.29809-3-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lgirdwood@gmail.com, jsarha@ti.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, broonie@kernel.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Document GPIO support

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

>From 4664b94c98b4f9fdd3845da41d5c65288e59c66c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Thu, 3 Jan 2019 16:05:51 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Document GPIO support

McASP pins can be used as GPIO, add optional section to enable GPIO support
for McASP.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/davinci-mcasp-audio.txt      | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index b279b6072bd5..a58f79f5345c 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -45,6 +45,23 @@ Optional properties:
 - fck_parent : Should contain a valid clock name which will be used as parent
 	       for the McASP fck
 
+Optional GPIO support:
+If any McASP pin need to be used as GPIO then the McASP node must have:
+...
+  gpio-controller
+  #gpio-cells = <2>;
+...
+
+When requesting a GPIO, the first parameter is the PIN index in McASP_P*
+registers.
+For example to request the AXR2 pin of mcasp8:
+function-gpios = <&mcasp8 2 0>;
+
+Or to request the ACLKR pin of mcasp8:
+function-gpios = <&mcasp8 29 0>;
+
+For generic gpio information, please refer to bindings/gpio/gpio.txt
+
 Example:
 
 mcasp0: mcasp0@1d00000 {
-- 
2.20.1
