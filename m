From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: doc: simple-card: Add pin-switches property" to the asoc tree
Date: Thu, 25 Apr 2019 20:24:33 +0100 (BST)
Message-ID: <20190425192433.19363441D3D@finisterre.ee.mobilebroadband>
References: <20190420104553.5071-1-paul@crapouillou.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190420104553.5071-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>, od@zcrc.me, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: doc: simple-card: Add pin-switches property

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From 6b903f9bdd98093a2c1ea79df07e86decfda3b04 Mon Sep 17 00:00:00 2001
From: Paul Cercueil <paul@crapouillou.net>
Date: Sat, 20 Apr 2019 12:45:51 +0200
Subject: [PATCH] ASoC: doc: simple-card: Add pin-switches property

The simple-audio-card,pin-switches property can contain the list of
widget names for which pin switches must be created.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/simple-card.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/simple-card.txt b/Documentation/devicetree/bindings/sound/simple-card.txt
index 4629c8f8a6b6..79954cd6e37b 100644
--- a/Documentation/devicetree/bindings/sound/simple-card.txt
+++ b/Documentation/devicetree/bindings/sound/simple-card.txt
@@ -24,6 +24,8 @@ Optional properties:
 					  a microphone is attached.
 - simple-audio-card,aux-devs		: List of phandles pointing to auxiliary devices, such
 					  as amplifiers, to be added to the sound card.
+- simple-audio-card,pin-switches	: List of strings containing the widget names for
+					  which pin switches must be created.
 
 Optional subnodes:
 
-- 
2.20.1
