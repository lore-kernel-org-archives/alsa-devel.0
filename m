From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: fix warnings when kernel
	compiled without GPIOLIB support
Date: Wed, 15 Oct 2014 09:30:49 -0700
Message-ID: <1413390649-854-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f201.google.com (mail-pd0-f201.google.com
 [209.85.192.201])
 by alsa0.perex.cz (Postfix) with ESMTP id C33542605D9
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 18:30:56 +0200 (CEST)
Received: by mail-pd0-f201.google.com with SMTP id y10so271224pdj.4
 for <alsa-devel@alsa-project.org>; Wed, 15 Oct 2014 09:30:55 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Anatol Pomozov <anatol.pomozov@gmail.com>
---
 sound/soc/codecs/rt5677.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c
index d1fc9a1..2f0d19f 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3686,6 +3686,11 @@ static void rt5677_free_gpio(struct i2c_client *i2c)
 	gpiochip_remove(&rt5677->gpio_chip);
 }
 #else
+static void rt5677_gpio_config(struct rt5677_priv *rt5677, unsigned offset,
+		int value)
+{
+}
+
 static void rt5677_init_gpio(struct i2c_client *i2c)
 {
 }
-- 
2.1.0.rc2.206.gedb03e5
