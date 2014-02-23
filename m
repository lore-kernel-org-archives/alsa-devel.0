From: xiangxiao <xiaoxiang@xiaomi.com>
Subject: [PATCH] ASoC: add data field into snd_soc_jack_gpio
Date: Sun, 23 Feb 2014 14:40:44 +0800
Message-ID: <1393137644-20955-1-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mxmail.xiaomi.com (mx1.mxmail.xiaomi.com [58.68.235.87])
 by alsa0.perex.cz (Postfix) with ESMTP id B79AE261A18
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 07:40:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, xiaoxiang@xiaomi.com
List-Id: alsa-devel@alsa-project.org

so callback could get the context data as needed

Change-Id: I5542613ccf9881deb672e71d0f0c4f603ad761fd
Signed-off-by: xiangxiao <xiaoxiang@xiaomi.com>
---
 include/sound/soc.h  | 3 ++-
 sound/soc/soc-jack.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 21038e0..a789a29 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -613,7 +613,8 @@ struct snd_soc_jack_gpio {
 	struct snd_soc_jack *jack;
 	struct delayed_work work;
 
-	int (*jack_status_check)(void);
+	void *data;
+	int (*jack_status_check)(void *data);
 };
 
 struct snd_soc_jack {
diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index b12fce6..b903f82 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -250,7 +250,7 @@ static void snd_soc_jack_gpio_detect(struct snd_soc_jack_gpio *gpio)
 		report = 0;
 
 	if (gpio->jack_status_check)
-		report = gpio->jack_status_check();
+		report = gpio->jack_status_check(gpio->data);
 
 	snd_soc_jack_report(jack, report, gpio->report);
 }
-- 
1.8.1.2
