From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: core: Fix missing card sysfs contents
Date: Wed, 19 Feb 2014 13:02:40 +0100
Message-ID: <1392811360-3309-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B97E26157F
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 13:02:41 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1260DAC95
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 12:02:41 +0000 (UTC)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

While moving the card device into struct snd_card, the reference to
the assigned card in sysfs show/store callbacks were forgotten to be
refreshed, still accessing to the no longer used drvdata.  Fix these
places to refer correctly via container_of().

Also, remove the superfluous NULL checks since it's guaranteed to be
non-NULL now.

Fixes: 8bfb181c17d2 ('ALSA: Embed card device into struct snd_card')
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/init.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 0095a530ff12..b7085eb19079 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -624,15 +624,15 @@ static ssize_t
 card_id_show_attr(struct device *dev,
 		  struct device_attribute *attr, char *buf)
 {
-	struct snd_card *card = dev_get_drvdata(dev);
-	return snprintf(buf, PAGE_SIZE, "%s\n", card ? card->id : "(null)");
+	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
+	return snprintf(buf, PAGE_SIZE, "%s\n", card->id);
 }
 
 static ssize_t
 card_id_store_attr(struct device *dev, struct device_attribute *attr,
 		   const char *buf, size_t count)
 {
-	struct snd_card *card = dev_get_drvdata(dev);
+	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
 	char buf1[sizeof(card->id)];
 	size_t copy = count > sizeof(card->id) - 1 ?
 					sizeof(card->id) - 1 : count;
@@ -664,8 +664,8 @@ static ssize_t
 card_number_show_attr(struct device *dev,
 		     struct device_attribute *attr, char *buf)
 {
-	struct snd_card *card = dev_get_drvdata(dev);
-	return snprintf(buf, PAGE_SIZE, "%i\n", card ? card->number : -1);
+	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
+	return snprintf(buf, PAGE_SIZE, "%i\n", card->number);
 }
 
 static DEVICE_ATTR(number, S_IRUGO, card_number_show_attr, NULL);
-- 
1.8.5.2
