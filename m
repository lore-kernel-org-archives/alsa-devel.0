From: Grant Grundler <grundler@chromium.org>
Subject: [PATCH] ASoC: max98373: usleep_range() needs include/delay.h
Date: Thu,  6 Sep 2018 17:27:28 -0700
Message-ID: <20180907002728.112770-1-grundler@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Ryan Lee <ryans.lee@maximintegrated.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Grant Grundler <grundler@chromium.org>
List-Id: alsa-devel@alsa-project.org

Commit ca917f9fe1a0fab added use of usleep_range() but not
the corresponding "include <linux/delay.h>". The result is
with Chrome OS won't build because warnings are forced
to be errors:
mnt/host/source/src/third_party/kernel/v4.4/sound/soc/codecs/max98373.c:734:2: error: implicit declaration of function 'usleep_range' [-Werror,-Wimplicit-function-declaration]
        usleep_range(10000, 11000);
        ^

Including delay.h "fixes" this.

Signed-off-by: Grant Grundler <grundler@chromium.org>
---
 sound/soc/codecs/max98373.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index 92b7125ea169..1f97b2f7c851 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2017, Maxim Integrated
 
 #include <linux/acpi.h>
+#include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
-- 
2.19.0.rc2.392.g5ba43deb5a-goog
