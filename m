From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: Document optional reset properties" to the asoc tree
Date: Tue, 06 Jun 2017 20:05:50 +0100
Message-ID: <E1dIJna-000796-Tu@debutante>
References: <1496313375-27892-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1496313375-27892-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: Document optional reset properties

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

>From 5f440c48c5d5a11f1892819c409e183b2056e4ba Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Thu, 1 Jun 2017 12:36:15 +0200
Subject: [PATCH] ASoC: rsnd: Document optional reset properties

Document the optional properties for describing module resets, to
support resetting these modules on R-Car Gen2 and Gen3.

Note that the audio module has resets for the Serial Sound Interfaces
only.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/renesas,rsnd.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
index 13cb21d53b8b..7246bb268bf9 100644
--- a/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
+++ b/Documentation/devicetree/bindings/sound/renesas,rsnd.txt
@@ -379,6 +379,9 @@ Optional properties:
 - clock-frequency		: for all audio_clkout0/1/2/3
 - clkout-lr-asynchronous	: boolean property. it indicates that audio_clkoutn
 				  is asynchronizes with lr-clock.
+- resets			: References to SSI resets.
+- reset-names			: List of valid reset names.
+				  "ssi-all", "ssi.X"
 
 SSI subnode properties:
 - interrupts			: Should contain SSI interrupt for PIO transfer
-- 
2.11.0
