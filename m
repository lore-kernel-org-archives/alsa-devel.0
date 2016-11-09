From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: cs42l42: Add devicetree bindings for CS42L42" to the asoc tree
Date: Wed, 09 Nov 2016 14:59:52 +0000
Message-ID: <E1c4ULw-0002hY-Ke@finisterre>
References: <139006a2-bc5f-4a49-8269-89c1adc3acf0@EX4.ad.cirrus.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <139006a2-bc5f-4a49-8269-89c1adc3acf0-k7YZYYsDncjfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: James Schulman <james.schulman-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs42l42: Add devicetree bindings for CS42L42

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

>From da16c55793539a8c83c81240984915ce6d0140fe Mon Sep 17 00:00:00 2001
From: James Schulman <james.schulman-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Date: Mon, 7 Nov 2016 14:38:38 -0600
Subject: [PATCH] ASoC: cs42l42: Add devicetree bindings for CS42L42

Add devicetree bindings documentation file for Cirrus
Logic CS42L42 codec.

Signed-off-by: James Schulman <james.schulman-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/cs42l42.txt          | 110 +++++++++++++++++++++
 1 file changed, 110 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l42.txt

diff --git a/Documentation/devicetree/bindings/sound/cs42l42.txt b/Documentation/devicetree/bindings/sound/cs42l42.txt
new file mode 100644
index 000000000000..9a2c5e2423d5
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs42l42.txt
@@ -0,0 +1,110 @@
+CS42L42 audio CODEC
+
+Required properties:
+
+  - compatible : "cirrus,cs42l42"
+
+  - reg : the I2C address of the device for I2C.
+
+  - VP-supply, VCP-supply, VD_FILT-supply, VL-supply, VA-supply :
+  power supplies for the device, as covered in
+  Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Optional properties:
+
+  - reset-gpios : a GPIO spec for the reset pin. If specified, it will be
+  deasserted before communication to the codec starts.
+
+  - interrupt-parent : Specifies the phandle of the interrupt controller to
+  which the IRQs from CS42L42 are delivered to.
+
+  - interrupts : IRQ line info CS42L42.
+  (See Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+  for further information relating to interrupt properties)
+
+  - cirrus,ts-inv : Boolean property. For jacks that invert the tip sense
+  polarity. Normal jacks will short tip sense pin to HS1 when headphones are
+  plugged in and leave tip sense floating when not plugged in. Inverting jacks
+  short tip sense when unplugged and float when plugged in.
+
+  0 = (Default) Non-inverted
+  1 = Inverted
+
+  - cirrus,ts-dbnc-rise : Debounce the rising edge of TIP_SENSE_PLUG. With no
+  debounce, the tip sense pin might be noisy on a plug event.
+
+  0 - 0ms,
+  1 - 125ms,
+  2 - 250ms,
+  3 - 500ms,
+  4 - 750ms,
+  5 - (Default) 1s,
+  6 - 1.25s,
+  7 - 1.5s,
+
+  - cirrus,ts-dbnc-fall : Debounce the falling edge of TIP_SENSE_UNPLUG.
+  With no debounce, the tip sense pin might be noisy on an unplug event.
+
+  0 - 0ms,
+  1 - 125ms,
+  2 - 250ms,
+  3 - 500ms,
+  4 - 750ms,
+  5 - (Default) 1s,
+  6 - 1.25s,
+  7 - 1.5s,
+
+  - cirrus,btn-det-init-dbnce : This sets how long the driver sleeps after
+  enabling button detection interrupts. After auto-detection and before
+  servicing button interrupts, the HS bias needs time to settle. If you
+  don't wait, there is possibility for erroneous button interrupt.
+
+  0ms - 200ms,
+  Default = 100ms
+
+  - cirrus,btn-det-event-dbnce : This sets how long the driver delays after
+  receiving a button press interrupt. With level detect interrupts, you want
+  to wait a small amount of time to make sure the button press is making a
+  clean connection with the bias resistors.
+
+  0ms - 20ms,
+  Default = 10ms
+
+  - cirrus,bias-lvls : For a level-detect headset button scheme, each button
+  will bias the mic pin to a certain voltage. To determine which button was
+  pressed, the driver will compare this biased voltage to sequential,
+  decreasing voltages and will stop when a comparator is tripped,
+  indicating a comparator voltage < bias voltage. This value represents a
+  percentage of the internally generated HS bias voltage. For different
+  hardware setups, a designer might want to tweak this. This is an array of
+  descending values for the comparator voltage.
+
+  Array of 4 values
+  Each 0-63
+  < x1 x2 x3 x4 >
+  Default = < 15 8 4 1>
+
+
+Example:
+
+cs42l42: cs42l42@48 {
+	compatible = "cirrus,cs42l42";
+	reg = <0x48>;
+	VA-supply = <&dummy_vreg>;
+	VP-supply = <&dummy_vreg>;
+	VCP-supply = <&dummy_vreg>;
+	VD_FILT-supply = <&dummy_vreg>;
+	VL-supply = <&dummy_vreg>;
+
+	reset-gpios = <&axi_gpio_0 1 0>;
+	interrupt-parent = <&gpio0>;
+	interrupts = <55 8>
+
+	cirrus,ts-inv = <0x00>;
+	cirrus,ts-dbnc-rise = <0x05>;
+	cirrus,ts-dbnc-fall = <0x00>;
+	cirrus,btn-det-init-dbnce = <100>;
+	cirrus,btn-det-event-dbnce = <10>;
+	cirrus,bias-lvls = <0x0F 0x08 0x04 0x01>;
+	cirrus,hs-bias-ramp-rate = <0x02>;
+};
\ No newline at end of file
-- 
2.10.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
