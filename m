From: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 2/2] Documentation: dt: bindings: sound: Add bindings for CS42L56 CODEC
Date: Mon, 5 May 2014 15:09:09 -0500
Message-ID: <1399320549-16645-2-git-send-email-brian.austin@cirrus.com>
References: <1399320549-16645-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1399320549-16645-1-git-send-email-brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, paul.handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This patch adds binding documentation for the Cirrus Logic CS42L56 Low Power Stereo I2C CODEC

Signed-off-by: Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
---
 .../devicetree/bindings/sound/cs42l56.txt          |   63 ++++++++++++++++++++
 1 file changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/cs42l56.txt

diff --git a/Documentation/devicetree/bindings/sound/cs42l56.txt b/Documentation/devicetree/bindings/sound/cs42l56.txt
new file mode 100644
index 0000000..9ae074f
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/cs42l56.txt
@@ -0,0 +1,63 @@
+CS42L52 audio CODEC
+
+Required properties:
+
+  - compatible : "cirrus,cs42l56"
+
+  - reg : the I2C address of the device for I2C
+
+  - VA-supply, VCP-supply, VLDO-supply : power supplies for the device,
+  as covered in Documentation/devicetree/bindings/regulator/regulator.txt.
+
+Optional properties:
+
+  - cirrus,gpio-nreset : GPIO controller's phandle and the number
+  of the GPIO used to reset the codec.
+
+  - cirrus,chgfreq-divisor : Values used to set the Charge Pump Frequency.
+  Allowable values of 0x00 through 0x0F. These are raw values written to the
+  register, not the actual frequency. The frequency is determined by the following.
+  Frequency = MCLK / 4 * (N+2)
+  N = chgfreq_val
+  MCLK = Where MCLK is the frequency of the mclk signal after the MCLKDIV2 circuit.
+
+  - cirrus,ain1a-ref-cfg, ain1b-ref-cfg : boolean, If present, AIN1A or AIN1B are configured
+  as a pseudo-differential input referenced to AIN1REF/AIN3A.
+
+  - cirrus,ain2a-ref-cfg, ain2b-ref-cfg : boolean, If present, AIN2A or AIN2B are configured
+  as a pseudo-differential input referenced to AIN2REF/AIN3B.
+
+  - cirrus,micbias-lvl: Set the output voltage level on the MICBIAS Pin.
+  0 = 0.5 x VA
+  1 = 0.6 x VA
+  2 = 0.7 x VA
+  3 = 0.8 x VA
+  4 = 0.83 x VA
+  5 = 0.91 x VA
+
+  - cirrus,adaptive-pwr-cfg : Configures how the power to the Headphone and Lineout
+  Amplifiers adapt to the output signal levels.
+  0 = Adapt to Volume Mode. Voltage level determined by the sum of the relevant volume settings.
+  1 = Fixed - Headphone and Line Amp supply = + or - VCP/2.
+  2 = Fixed - Headphone and Line Amp supply = + or - VCP.
+  3 = Adapted to Signal; Voltage level is dynamically determined by the output signal.
+
+  - cirrus,hpf-left-freq, hpf-right-freq : Sets the corner frequency (-3dB point) for the internal High-Pass
+  Filter.
+  0 = 1.8Hz
+  1 = 119Hz
+  2 = 236Hz
+  3 = 464Hz
+
+
+Example:
+
+codec: codec@4b {
+	compatible = "cirrus,cs42l56";
+	reg = <0x4b>;
+	gpio-reset = <&gpio 10 0>;
+	cirrus,chgfreq-divisor = <0x05>;
+	cirrus.ain1_ref_cfg;
+	cirrus,micbias-lvl = <5>;
+	VA-supply = <&reg_audio>;
+};
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
