From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: Added device tree binding for max98373 amplifier" to the asoc tree
Date: Thu, 04 Jan 2018 17:42:44 +0000
Message-ID: <E1eX9XQ-00064d-QS@debutante>
References: <1515004704-22182-1-git-send-email-ryans.lee@maximintegrated.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1515004704-22182-1-git-send-email-ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ryan.lee.maxim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Added device tree binding for max98373 amplifier

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

>From bab4a10f0dc745b3c07acb8fa5fbc4337e140f58 Mon Sep 17 00:00:00 2001
From: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Date: Wed, 3 Jan 2018 10:38:24 -0800
Subject: [PATCH] ASoC: Added device tree binding for max98373 amplifier

Signed-off-by: Ryan Lee <ryans.lee-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/max98373.txt         | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/max98373.txt

diff --git a/Documentation/devicetree/bindings/sound/max98373.txt b/Documentation/devicetree/bindings/sound/max98373.txt
new file mode 100644
index 000000000000..456cb1c59353
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/max98373.txt
@@ -0,0 +1,40 @@
+Maxim Integrated MAX98373 Speaker Amplifier
+
+This device supports I2C.
+
+Required properties:
+
+ - compatible : "maxim,max98373"
+
+ - reg : the I2C address of the device.
+
+Optional properties:
+
+  - maxim,vmon-slot-no : slot number used to send voltage information
+                   or in inteleave mode this will be used as
+                   interleave slot.
+                   slot range : 0 ~ 15,  Default : 0
+
+  - maxim,imon-slot-no : slot number used to send current information
+                   slot range : 0 ~ 15,  Default : 0
+
+  - maxim,spkfb-slot-no : slot number used to send speaker feedback information
+                   slot range : 0 ~ 15,  Default : 0
+
+  - maxim,interleave-mode : For cases where a single combined channel
+		   for the I/V sense data is not sufficient, the device can also be configured
+		   to share a single data output channel on alternating frames.
+		   In this configuration, the current and voltage data will be frame interleaved
+		   on a single output channel.
+                   Boolean, define to enable the interleave mode, Default : false
+
+Example:
+
+codec: max98373@31 {
+   compatible = "maxim,max98373";
+   reg = <0x31>;
+   maxim,vmon-slot-no = <0>;
+   maxim,imon-slot-no = <1>;
+   maxim,spkfb-slot-no = <2>;
+   maxim,interleave-mode;
+};
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
