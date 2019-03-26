From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: add fsl_audmix DT binding documentation" to the asoc tree
Date: Tue, 26 Mar 2019 14:42:44 +0000 (GMT)
Message-ID: <20190326144244.33CE11121B57@debutante.sirena.org.uk>
References: <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548155654-12985-3-git-send-email-viorel.suman@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viorel Suman <viorel.suman@nxp.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Timur Tabi <timur@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <fabio.estevam@nxp.com>, "S.j. Wang" <shengjiu.wang@nxp.com>, Daniel Baluta <daniel.baluta@nxp.com>, Cosmin Samoila <cosmin.samoila@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Viorel Suman <viorel.suman@gmail.com>, dl-linux-imx <linux-imx@nxp.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: add fsl_audmix DT binding documentation

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

>From d0d9071b724123ebde89bdf6b52b86c3289abe85 Mon Sep 17 00:00:00 2001
From: Viorel Suman <viorel.suman@nxp.com>
Date: Tue, 22 Jan 2019 11:14:27 +0000
Subject: [PATCH] ASoC: add fsl_audmix DT binding documentation

Add the DT binding documentation for NXP Audio Mixer
CPU DAI driver.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/fsl,audmix.txt  | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,audmix.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,audmix.txt b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
new file mode 100644
index 000000000000..45f807ec21a5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,audmix.txt
@@ -0,0 +1,54 @@
+NXP Audio Mixer (AUDMIX).
+
+The Audio Mixer is a on-chip functional module that allows mixing of two
+audio streams into a single audio stream. Audio Mixer has two input serial
+audio interfaces. These are driven by two Synchronous Audio interface
+modules (SAI). Each input serial interface carries 8 audio channels in its
+frame in TDM manner. Mixer mixes audio samples of corresponding channels
+from two interfaces into a single sample. Before mixing, audio samples of
+two inputs can be attenuated based on configuration. The output of the
+Audio Mixer is also a serial audio interface. Like input interfaces it has
+the same TDM frame format. This output is used to drive the serial DAC TDM
+interface of audio codec and also sent to the external pins along with the
+receive path of normal audio SAI module for readback by the CPU.
+
+The output of Audio Mixer can be selected from any of the three streams
+ - serial audio input 1
+ - serial audio input 2
+ - mixed audio
+
+Mixing operation is independent of audio sample rate but the two audio
+input streams must have same audio sample rate with same number of channels
+in TDM frame to be eligible for mixing.
+
+Device driver required properties:
+=================================
+  - compatible		: Compatible list, contains "fsl,imx8qm-audmix"
+
+  - reg			: Offset and length of the register set for the device.
+
+  - clocks		: Must contain an entry for each entry in clock-names.
+
+  - clock-names		: Must include the "ipg" for register access.
+
+  - power-domains	: Must contain the phandle to AUDMIX power domain node
+
+  - dais		: Must contain a list of phandles to AUDMIX connected
+			  DAIs. The current implementation requires two phandles
+			  to SAI interfaces to be provided, the first SAI in the
+			  list being used to route the AUDMIX output.
+
+  - model		: Must contain machine driver name which will configure
+			  and instantiate the appropriate audio card.
+
+Device driver configuration example:
+======================================
+  audmix: audmix@59840000 {
+    compatible = "fsl,imx8qm-audmix";
+    reg = <0x0 0x59840000 0x0 0x10000>;
+    clocks = <&clk IMX8QXP_AUD_AUDMIX_IPG>;
+    clock-names = "ipg";
+    power-domains = <&pd_audmix>;
+    dais = <&sai4>, <&sai5>;
+    model = "imx-audmix";
+  };
-- 
2.20.1
