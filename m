From: xiangxiao <xiaoxiang@xiaomi.com>
Subject: [PATCH] ASoC: delay the initial jack detect by
	debounce_time
Date: Sun, 23 Feb 2014 14:44:52 +0800
Message-ID: <1393137892-21007-1-git-send-email-xiaoxiang@xiaomi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.mxmail.xiaomi.com (mx1.mxmail.xiaomi.com [58.68.235.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 80532261A18
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 07:45:00 +0100 (CET)
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

so the hardware could get time to initialize and debounce

Change-Id: Iebeffa9bac6c4012ee8f9645771c13b28fe5ae80
Signed-off-by: xiangxiao <xiaoxiang@xiaomi.com>
---
 sound/soc/soc-jack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-jack.c b/sound/soc/soc-jack.c
index 23d43da..b12fce6 100644
--- a/sound/soc/soc-jack.c
+++ b/sound/soc/soc-jack.c
@@ -342,7 +342,8 @@ int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 		gpio_export(gpios[i].gpio, false);
 
 		/* Update initial jack status */
-		snd_soc_jack_gpio_detect(&gpios[i]);
+		schedule_delayed_work(&gpios[i].work,
+				      msecs_to_jiffies(gpios[i].debounce_time));
 	}
 
 	return 0;
-- 
1.8.1.2
