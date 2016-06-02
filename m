From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: Add ADAU7002 Stereo PDM-to-I2S/TDM Converter DT bindings" to the asoc tree
Date: Thu, 02 Jun 2016 16:50:16 +0100
Message-ID: <E1b8Usy-0004vW-Sk@finisterre>
References: <1464869982-6722-1-git-send-email-lars@metafoo.de>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1464869982-6722-1-git-send-email-lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add ADAU7002 Stereo PDM-to-I2S/TDM Converter DT bindings

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

>From 254a13811ef41932b1315f524943050e6b5ae5a1 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Date: Thu, 2 Jun 2016 14:19:41 +0200
Subject: [PATCH] ASoC: Add ADAU7002 Stereo PDM-to-I2S/TDM Converter DT
 bindings

The ADAU7002 takes a stereo PDM signal (e.g. from two digital microphones)
and converts it into a I2S/TDM PCM stream. The chip does not have a
control interface and has a single power supply that is modeled in the
devicetree.

Signed-off-by: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 .../devicetree/bindings/sound/adi,adau7002.txt        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/adi,adau7002.txt

diff --git a/Documentation/devicetree/bindings/sound/adi,adau7002.txt b/Documentation/devicetree/bindings/sound/adi,adau7002.txt
new file mode 100644
index 000000000000..f144ee1abf85
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/adi,adau7002.txt
@@ -0,0 +1,19 @@
+Analog Devices ADAU7002 Stereo PDM-to-I2S/TDM Converter
+
+Required properties:
+
+ - compatible: Must be "adi,adau7002"
+
+Optional properties:
+
+ - IOVDD-supply: Phandle and specifier for the power supply providing the IOVDD
+	supply as covered in Documentation/devicetree/bindings/regulator/regulator.txt
+
+	If this property is not present it is assumed that the supply pin is
+	hardwired to always on.
+
+Example:
+	adau7002: pdm-to-i2s {
+		compatible = "adi,adau7002";
+		IOVDD-supply = <&supply>;
+	};
-- 
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
