From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Document dismod optional property" to the asoc tree
Date: Wed, 28 Nov 2018 12:57:27 +0000 (GMT)
Message-ID: <20181128125727.B3238440078@finisterre.ee.mobilebroadband>
References: <20181116134141.17396-4-peter.ujfalusi@ti.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116134141.17396-4-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jsarha@ti.com, robh+dt@kernel.org, misael.lopez@ti.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Document dismod optional property

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

>From a3641b30c19b93b1298028a7210b55145e70056c Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 16 Nov 2018 15:41:40 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Document dismod optional property

The dismod property can be used to specify the drive on level of inactive
TX slots.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/davinci-mcasp-audio.txt        | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index 46bc9829c71a..b279b6072bd5 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -30,6 +30,11 @@ Optional properties:
 - ti,hwmods : Must be "mcasp<n>", n is controller instance starting 0
 - tx-num-evt : FIFO levels.
 - rx-num-evt : FIFO levels.
+- dismod : Specify the drive on TX pin during inactive slots
+	0 : 3-state
+	2 : logic low
+	3 : logic high
+	Defaults to 'logic low' when the property is not present
 - sram-size-playback : size of sram to be allocated during playback
 - sram-size-capture  : size of sram to be allocated during capture
 - interrupts : Interrupt numbers for McASP
-- 
2.19.1
