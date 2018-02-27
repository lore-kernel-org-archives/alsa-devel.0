From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH] ALSA: Use scnprintf() instead of snprintf()
Date: Tue, 27 Feb 2018 11:15:59 +0900
Message-ID: <1519697759-31062-1-git-send-email-climbbb.kim@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pl0-f68.google.com (mail-pl0-f68.google.com
 [209.85.160.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CE8A267657
 for <alsa-devel@alsa-project.org>; Tue, 27 Feb 2018 03:16:18 +0100 (CET)
Received: by mail-pl0-f68.google.com with SMTP id i6so10483971plt.7
 for <alsa-devel@alsa-project.org>; Mon, 26 Feb 2018 18:16:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Jaejoong Kim <climbbb.kim@gmail.com>
List-Id: alsa-devel@alsa-project.org

The show() method should use scnprintf() not snprintf() because snprintf()
may returns a value that exceeds its second argument.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 sound/core/init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 168ae03..4a51a06 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -670,7 +670,7 @@ card_id_show_attr(struct device *dev,
 		  struct device_attribute *attr, char *buf)
 {
 	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n", card->id);
+	return scnprintf(buf, PAGE_SIZE, "%s\n", card->id);
 }
 
 static ssize_t
@@ -710,7 +710,7 @@ card_number_show_attr(struct device *dev,
 		     struct device_attribute *attr, char *buf)
 {
 	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
-	return snprintf(buf, PAGE_SIZE, "%i\n", card->number);
+	return scnprintf(buf, PAGE_SIZE, "%i\n", card->number);
 }
 
 static DEVICE_ATTR(number, S_IRUGO, card_number_show_attr, NULL);
-- 
2.7.4
