From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
Subject: [PATCH] MAINTAINERS: add ASoC maintainers for sound dt-bindings
Date: Sat, 17 Nov 2018 13:14:52 +0100
Message-ID: <20181117121452.6101-1-peron.clem@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "David S . Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Arnd Bergmann <arnd@arndb.de>, Shawn Guo <shawnguo@kernel.org>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
List-Id: alsa-devel@alsa-project.org

Sound dt-bindings are applied by ASoC maintainers and should be
submit to ASoC list in addition to the devicetree list.

Hence, add this information into the MAINTAINERS file.

Signed-off-by: Clément Péron <peron.clem@gmail.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0abecc528dac..62701e0135af 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13930,6 +13930,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/soc/
 F:	sound/soc/
+F:	include/dt-bindings/sound/
 F:	include/sound/soc*
 
 SOUNDWIRE SUBSYSTEM
-- 
2.19.1
