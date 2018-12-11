From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 4/4] MAINTAINERS: Add Amlogic sound drivers entry
Date: Tue, 11 Dec 2018 14:47:13 +0100
Message-ID: <20181211134713.4908-5-jbrunet@baylibre.com>
References: <20181211134713.4908-1-jbrunet@baylibre.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181211134713.4908-1-jbrunet@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Add sound/soc/meson drivers entry for Amlogic audio drivers.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7fe120fc25fa..e8e79713a790 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1310,6 +1310,13 @@ F:	drivers/pinctrl/meson/
 F:	drivers/mmc/host/meson*
 N:	meson
 
+ARM/Amlogic Meson SoC Sound Drivers
+M:	Jerome Brunet <jbrunet@baylibre.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/meson/
+F:	Documentation/devicetree/bindings/sound/amlogic*
+
 ARM/Annapurna Labs ALPINE ARCHITECTURE
 M:	Tsahee Zidenberg <tsahee@annapurnalabs.com>
 M:	Antoine Tenart <antoine.tenart@bootlin.com>
-- 
2.19.2
