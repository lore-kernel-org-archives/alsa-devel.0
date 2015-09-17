From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 3/3] MAINTAINERS: da7219: Add entry to cover DA7219 bindings
 document
Date: Thu, 17 Sep 2015 17:01:19 +0100
Message-ID: <49c7fb102b445037d0814ebb57773d819c8d3477.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1442500784.git.Adam.Thomson.Opensource@diasemi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Jason Coughlan <jason.coughlan@diasemi.com>
List-Id: alsa-devel@alsa-project.org

This adds an entry to indicate the DA7219 bindings document (and
other Dialog codecs bindings documents) are supported.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ba7ab7..a235822 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3361,6 +3361,7 @@ M:	Support Opensource <support.opensource@diasemi.com>
 W:	http://www.dialog-semiconductor.com/products
 S:	Supported
 F:	Documentation/hwmon/da90??
+F:	Documentation/devicetree/bindings/sound/da[79]*.txt
 F:	drivers/gpio/gpio-da90??.c
 F:	drivers/hwmon/da90??-hwmon.c
 F:	drivers/iio/adc/da91??-*.c
-- 
1.9.3
