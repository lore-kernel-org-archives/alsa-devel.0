From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: update cs42l51 bindings" to the asoc tree
Date: Thu,  4 Apr 2019 20:58:31 +0700 (+07)
Message-ID: <20190404135831.D3441441D3C@finisterre.ee.mobilebroadband>
References: <1554297817-14154-2-git-send-email-olivier.moysan@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554297817-14154-2-git-send-email-olivier.moysan@st.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com, benjamin.gaignard@st.com, apatard@mandriva.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: update cs42l51 bindings

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

>From 26bde6ad6d59b2e1347995de6198205ef6138b52 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Wed, 3 Apr 2019 15:23:31 +0200
Subject: [PATCH] ASoC: dt-bindings: update cs42l51 bindings

Add compatible, reg, regulator, and reset
to Cirrus CS42L51 audio codec bindings.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/cs42l51.txt        | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/cs42l51.txt b/Documentation/devicetree/bindings/sound/cs42l51.txt
index 4b5de33ce377..acbd68ddd2cb 100644
--- a/Documentation/devicetree/bindings/sound/cs42l51.txt
+++ b/Documentation/devicetree/bindings/sound/cs42l51.txt
@@ -1,6 +1,17 @@
 CS42L51 audio CODEC
 
+Required properties:
+
+  - compatible : "cirrus,cs42l51"
+
+  - reg : the I2C address of the device for I2C.
+
 Optional properties:
+  - VL-supply, VD-supply, VA-supply, VAHP-supply: power supplies for the device,
+    as covered in Documentation/devicetree/bindings/regulator/regulator.txt.
+
+  - reset-gpios : GPIO specification for the reset pin. If specified, it will be
+    deasserted before starting the communication with the codec.
 
   - clocks : a list of phandles + clock-specifiers, one for each entry in
     clock-names
@@ -14,4 +25,9 @@ cs42l51: cs42l51@4a {
 	reg = <0x4a>;
 	clocks = <&mclk_prov>;
 	clock-names = "MCLK";
+	VL-supply = <&reg_audio>;
+	VD-supply = <&reg_audio>;
+	VA-supply = <&reg_audio>;
+	VAHP-supply = <&reg_audio>;
+	reset-gpios = <&gpiog 9 GPIO_ACTIVE_LOW>;
 };
-- 
2.20.1
