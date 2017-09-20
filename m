From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add device tree binding doc for volume limits" to the asoc tree
Date: Wed, 20 Sep 2017 18:13:55 +0100
Message-ID: <E1duiZP-00033S-5n@debutante>
References: <20170904154154.4395-8-ckeepax@opensource.cirrus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170904154154.4395-8-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>broonie@kernel.org, lee.jones@linaro.org, mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, robh+dt@kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add device tree binding doc for volume limits

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

>From 0340afe74d43e9c82bc0f5904d8f5b99d0fc3ab0 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Mon, 4 Sep 2017 16:41:54 +0100
Subject: [PATCH] ASoC: arizona: Add device tree binding doc for volume limits

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/wlf,arizona.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/wlf,arizona.txt b/Documentation/devicetree/bindings/sound/wlf,arizona.txt
index 4e67224488d8..e172c62dc2df 100644
--- a/Documentation/devicetree/bindings/sound/wlf,arizona.txt
+++ b/Documentation/devicetree/bindings/sound/wlf,arizona.txt
@@ -47,3 +47,7 @@ Optional properties:
     See the datasheet for values.
     The second cell is ignored for codecs that do not have OUT6 (wm5102, wm8997,
     wm8998, wm1814)
+
+  - wlf,out-volume-limit : The volume limit value that should be applied to each
+    output channel. See the datasheet for exact values. Channels are specified
+    in the order OUT1L, OUT1R, OUT2L, OUT2R, etc.
-- 
2.14.1
