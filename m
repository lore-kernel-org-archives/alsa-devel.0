From: Mark Brown <broonie@kernel.org>
Subject: Applied "bindings: sound: davinci-mcasp: Add support for optional auxclk-fs-ratio" to the asoc tree
Date: Wed, 12 Jun 2019 16:59:27 +0100 (BST)
Message-ID: <20190612155927.970D7440049@finisterre.sirena.org.uk>
References: <20190611122941.10708-2-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190611122941.10708-2-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, devicetree@vger.kernel.org, jsarha@ti.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.orgMark Brown <broonie@kernel.org>, misael.lopez@ti.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   bindings: sound: davinci-mcasp: Add support for optional auxclk-fs-ratio

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From b7e47f48f1197c24f5347327afc2a4f7f6da9ca5 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Tue, 11 Jun 2019 15:29:40 +0300
Subject: [PATCH] bindings: sound: davinci-mcasp: Add support for optional
 auxclk-fs-ratio

When McASP is bus master it's reference clock (AUXCLK) might not be a
static clock, but running at a specific FS ratio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/davinci-mcasp-audio.txt          | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index a58f79f5345c..c483dcec01f8 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -44,6 +44,9 @@ Optional properties:
   		 please refer to pinctrl-bindings.txt
 - fck_parent : Should contain a valid clock name which will be used as parent
 	       for the McASP fck
+- auxclk-fs-ratio: When McASP is bus master indicates the ratio between AUCLK
+		   and FS rate if applicable:
+		   AUCLK rate = auxclk-fs-ratio * FS rate
 
 Optional GPIO support:
 If any McASP pin need to be used as GPIO then the McASP node must have:
-- 
2.20.1
