From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dt-bindings: add mclk support to
	cs42l51" to the asoc tree
Date: Fri, 19 Oct 2018 13:26:16 +0100 (BST)
Message-ID: <20181019122616.861841122548@debutante.sirena.org.uk>
References: <1539612216-12602-3-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id DEA64267973
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2018 14:26:17 +0200 (CEST)
In-Reply-To: <1539612216-12602-3-git-send-email-olivier.moysan@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: mark.rutland@arm.com, robh@kernel.org, alsa-devel@alsa-project.org, olivier.moysan@st.com, alexandre.torgue@st.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com, lgirdwood@gmail.com, broonie@kernel.org, mcoquelin.stm32@gmail.com, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dt-bindings: add mclk support to cs42l51

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

>From 1c5083b37deaa99e07cc3082e190a509efd2a225 Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 15 Oct 2018 16:03:34 +0200
Subject: [PATCH] ASoC: dt-bindings: add mclk support to cs42l51

Add clocks properties to cs42l51 Cirrus codec,
to support master clock provider.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/cs42l51.txt       | 17 +++++++++++++++++
 .../devicetree/bindings/trivial-devices.txt     |  1 -
 2 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l51.txt

diff --git a/Documentation/devicetree/bindings/sound/cs42l51.txt b/Documentation/devicetree/bindings/sound/cs42l51.txt
new file mode 100644
index 000000000000..4b5de33ce377
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs42l51.txt
@@ -0,0 +1,17 @@
+CS42L51 audio CODEC
+
+Optional properties:
+
+  - clocks : a list of phandles + clock-specifiers, one for each entry in
+    clock-names
+
+  - clock-names : must contain "MCLK"
+
+Example:
+
+cs42l51: cs42l51@4a {
+	compatible = "cirrus,cs42l51";
+	reg = <0x4a>;
+	clocks = <&mclk_prov>;
+	clock-names = "MCLK";
+};
diff --git a/Documentation/devicetree/bindings/trivial-devices.txt b/Documentation/devicetree/bindings/trivial-devices.txt
index 763a2808a95c..69c934aec13b 100644
--- a/Documentation/devicetree/bindings/trivial-devices.txt
+++ b/Documentation/devicetree/bindings/trivial-devices.txt
@@ -35,7 +35,6 @@ at,24c08		i2c serial eeprom  (24cxx)
 atmel,at97sc3204t	i2c trusted platform module (TPM)
 capella,cm32181		CM32181: Ambient Light Sensor
 capella,cm3232		CM3232: Ambient Light Sensor
-cirrus,cs42l51		Cirrus Logic CS42L51 audio codec
 dallas,ds1374		I2C, 32-Bit Binary Counter Watchdog RTC with Trickle Charger and Reset Input/Output
 dallas,ds1631		High-Precision Digital Thermometer
 dallas,ds1672		Dallas DS1672 Real-time Clock
-- 
2.19.0.rc2
