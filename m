From: Ben Zhang <benzh@chromium.org>
Subject: [PATCH 1/3] ASoC: rt5677: Include gpio driver header
Date: Fri,  3 Oct 2014 14:37:24 -0700
Message-ID: <1412372246-10489-1-git-send-email-benzh@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Ben Zhang <benzh@chromium.org>
List-Id: alsa-devel@alsa-project.org

The header file is needed because struct gpio_chip is
placed in struct rt5677_priv.

Signed-off-by: Ben Zhang <benzh@chromium.org>
---
 sound/soc/codecs/rt5677.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5677.h b/sound/soc/codecs/rt5677.h
index d4eb6d5..99fd023 100644
--- a/sound/soc/codecs/rt5677.h
+++ b/sound/soc/codecs/rt5677.h
@@ -13,6 +13,7 @@
 #define __RT5677_H__
 
 #include <sound/rt5677.h>
+#include <linux/gpio/driver.h>
 
 /* Info */
 #define RT5677_RESET				0x00
-- 
2.1.0.rc2.206.gedb03e5
