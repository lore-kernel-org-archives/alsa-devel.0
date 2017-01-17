From: Romain Perier <romain.perier@collabora.com>
Subject: [PATCH 1/2] SoC: es8328-i2c: Add compatible for ES8323
Date: Tue, 17 Jan 2017 10:12:09 +0100
Message-ID: <20170117091210.6837-2-romain.perier@collabora.com>
References: <20170117091210.6837-1-romain.perier@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 by alsa0.perex.cz (Postfix) with ESMTP id 39B98266718
 for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2017 10:12:24 +0100 (CET)
In-Reply-To: <20170117091210.6837-1-romain.perier@collabora.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Heiko Stuebner <heiko@sntech.de>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Kumar Gala <galak@codeaurora.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: Romain Perier <romain.perier@collabora.com>, linux-rockchip@lists.infradead.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This commit adds a compatible string for everest,es8323. This is an
audio codec that is compatible with es8328 and can be found for example
on the Firefly-RK3288 board.

Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 Documentation/devicetree/bindings/sound/es8328.txt | 5 ++++-
 sound/soc/codecs/es8328-i2c.c                      | 2 ++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/es8328.txt b/Documentation/devicetree/bindings/sound/es8328.txt
index 33fbf05..86b6d6e 100644
--- a/Documentation/devicetree/bindings/sound/es8328.txt
+++ b/Documentation/devicetree/bindings/sound/es8328.txt
@@ -4,7 +4,10 @@ This device supports both I2C and SPI.
 
 Required properties:
 
-  - compatible  : Should be "everest,es8328" or "everest,es8388"
+  - compatible  : Should be one of the following:
+	- "everest,es8323"
+	- "everest,es8328"
+	- "everest,es8388"
   - DVDD-supply : Regulator providing digital core supply voltage 1.8 - 3.6V
   - AVDD-supply : Regulator providing analog supply voltage 3.3V
   - PVDD-supply : Regulator providing digital IO supply voltage 1.8 - 3.6V
diff --git a/sound/soc/codecs/es8328-i2c.c b/sound/soc/codecs/es8328-i2c.c
index 318ab28..be3f03c 100644
--- a/sound/soc/codecs/es8328-i2c.c
+++ b/sound/soc/codecs/es8328-i2c.c
@@ -19,6 +19,7 @@
 #include "es8328.h"
 
 static const struct i2c_device_id es8328_id[] = {
+	{ "es8323", 0 },
 	{ "es8328", 0 },
 	{ "es8388", 0 },
 	{ }
@@ -26,6 +27,7 @@ static const struct i2c_device_id es8328_id[] = {
 MODULE_DEVICE_TABLE(i2c, es8328_id);
 
 static const struct of_device_id es8328_of_match[] = {
+	{ .compatible = "everest,es8323", },
 	{ .compatible = "everest,es8328", },
 	{ .compatible = "everest,es8388", },
 	{ }
-- 
2.9.3
