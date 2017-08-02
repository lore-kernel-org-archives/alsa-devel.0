From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "ASoC: Add bindings for DMIC codec driver" to the asoc tree
Date: Wed, 02 Aug 2017 18:30:20 +0100
Message-ID: <E1dcxTQ-0003pQ-53@debutante>
References: <1500972494-10696-2-git-send-email-arnaud.pouliquen@st.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1500972494-10696-2-git-send-email-arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.orgbroonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.orgalsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add bindings for DMIC codec driver

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

>From 5863e57c22b0e201a88679cd534f95f4338e7769 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Date: Tue, 25 Jul 2017 10:48:13 +0200
Subject: [PATCH] ASoC: Add bindings for DMIC codec driver

This patch adds documentation of device tree bindings for audio DMIC codec.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 Documentation/devicetree/bindings/sound/dmic.txt | 12 ++++++++++++
 1 file changed, 12 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/dmic.txt

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
new file mode 100644
index 000000000000..a0c58f2a162a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -0,0 +1,12 @@
+Device-Tree bindings for Digital microphone (DMIC) codec
+
+This device support generic PDM digital microphone.
+
+Required properties:
+	- compatible: should be "dmic-codec".
+
+Example node:
+
+	dmic_codec: dmic@0 {
+		compatible = "dmic-codec";
+	};
-- 
2.13.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
