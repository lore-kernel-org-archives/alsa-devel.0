From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: [PATCH] ASoC: rt5677: fix warnings when kernel
	compiled without GPIOLIB support
Date: Thu, 16 Oct 2014 09:40:58 -0700
Message-ID: <1413477658-35049-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qc0-f201.google.com (mail-qc0-f201.google.com
 [209.85.216.201])
 by alsa0.perex.cz (Postfix) with ESMTP id 64A442605DB
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 18:41:07 +0200 (CEST)
Received: by mail-qc0-f201.google.com with SMTP id m20so300243qcx.2
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 09:41:04 -0700 (PDT)
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
index 3b63772..f6df276 100644
--- a/sound/soc/codecs/rt5677.c
+++ b/sound/soc/codecs/rt5677.c
@@ -3649,6 +3649,11 @@ static void rt5677_free_gpio(struct i2c_client *i2c)
 		dev_err(&i2c->dev, "Failed to remove GPIOs: %d\n", ret);
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
