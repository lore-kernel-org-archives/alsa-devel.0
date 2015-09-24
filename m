From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v2 4/4] MAINTAINERS: da7219: Add entry to cover DA7219 bindings
 document
Date: Thu, 24 Sep 2015 18:19:56 +0100
Message-ID: <e9d38f861751ad892ce295362982a94491c545be.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1443113192.git.Adam.Thomson.Opensource@diasemi.com>
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
index 274f854..fba06a5 100644
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
