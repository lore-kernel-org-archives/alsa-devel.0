From: xiangxiao <xiaoxiang@xiaomi.com>
Subject: [PATCH] ASoC: pass snd_soc_jack_gpio to
	jack_status_check callback
Date: Sun, 16 Feb 2014 13:36:12 +0800
Message-ID: <1392528972-9440-1-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mxmail.xiaomi.com (mx1.mxmail.xiaomi.com [58.68.235.87])
 by alsa0.perex.cz (Postfix) with ESMTP id B8B6C2615FA
 for <alsa-devel@alsa-project.org>; Sun, 16 Feb 2014 06:37:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: xiaoxiang@xiaomi.com, broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

so the implementation could get the context data

Change-Id: I5542613ccf9881deb672e71d0f0c4f603ad761fd
Signed-off-by: xiangxiao <xiaoxiang@xiaomi.com>
---
 include/sound/soc.h  | 2 +-
 sound/soc/soc-jack.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 21038e0..e287462 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -613,7 +613,7 @@ struct snd_soc_jack_gpio {
 	struct snd_soc_jack *jack;
 	struct delayed_work work;
 
-	int (*jack_status_check)(void);
+	int (*jack_status_check)(struct snd_soc_jack_gpio *gpio);
 };
 
 struct snd_soc_jack {
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index b12fce6..6028af5 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -250,7 +250,7 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 		report = 0;
 
 	if (gpio->jack_status_check)
-		report = gpio->jack_status_check();
+		report = gpio->jack_status_check(gpio);
 
 	snd_soc_jack_report(jack, report, gpio->report);
 }
-- 
1.8.1.2
