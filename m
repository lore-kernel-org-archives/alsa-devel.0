From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 1/4] ASoC: es8328-i2c: Add compatible for ES8388
Date: Fri, 13 Jan 2017 17:14:49 +0100
Message-ID: <20170113161452.14313-2-romain.perier@collabora.com>
References: <20170113161452.14313-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id D91AA266A12
 for <alsa-devel@alsa-project.org>; Fri, 13 Jan 2017 17:15:12 +0100 (CET)
In-Reply-To: <20170113161452.14313-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Heiko Stuebner <heiko@sntech.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, Romain Perier <romain.perier@collabora.com>
List-Id: alsa-devel@alsa-project.org

This commit adds a compatible string for everest,es8388. This is
an audio codec that is compatible with es8328.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 Documentation/devicetree/bindings/sound/es8328.txt | 2 +-
 sound/soc/codecs/es8328-i2c.c                      | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/es8328.txt b/Documentation/devicetree/bindings/sound/es8328.txt
index 30ea8a3..33fbf05 100644
--- a/Documentation/devicetree/bindings/sound/es8328.txt
+++ b/Documentation/devicetree/bindings/sound/es8328.txt
@@ -4,7 +4,7 @@ This device supports both I2C and SPI.
 
 Required properties:
 
-  - compatible : "everest,es8328"
+  - compatible  : Should be "everest,es8328" or "everest,es8388"
   - DVDD-supply : Regulator providing digital core supply voltage 1.8 - 3.6V
   - AVDD-supply : Regulator providing analog supply voltage 3.3V
   - PVDD-supply : Regulator providing digital IO supply voltage 1.8 - 3.6V
diff --git a/sound/soc/codecs/es8328-i2c.c b/sound/soc/codecs/es8328-i2c.c
index 2d05b5d..09ae67f 100644
--- a/sound/soc/codecs/es8328-i2c.c
+++ b/sound/soc/codecs/es8328-i2c.c
@@ -19,13 +19,14 @@
 #include "es8328.h"
 
 static const struct i2c_device_id es8328_id[] = {
-	{ "es8328", 0 },
+	{ "es8328", "es8388", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, es8328_id);
 
 static const struct of_device_id es8328_of_match[] = {
 	{ .compatible = "everest,es8328", },
+	{ .compatible = "everest,es8388", },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, es8328_of_match);
-- 
2.9.3
