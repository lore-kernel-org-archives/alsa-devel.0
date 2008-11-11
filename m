From: Jaroslav Kysela <perex@perex.cz>
Subject: RFC: add possibility to change text identification
	string
Date: Tue, 11 Nov 2008 17:00:41 +0100 (CET)
Message-ID: <Pine.LNX.4.61.0811111657261.13649@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E7D8243C7
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 17:00:42 +0100 (CET)
Received: from server.perex.cz (server.perex.cz [172.16.0.20])
	by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	54689129AF4
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 17:00:42 +0100 (CET)
Received: from tm8103.perex-int.cz (localhost [127.0.0.1])
	by server.perex.cz (Perex's E-mail Delivery System) with ESMTP id
	3D6068434F
	for <alsa-devel@alsa-project.org>; Tue, 11 Nov 2008 17:00:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all,

	based on discussion today, I prepared a patch to handle udev-style 
card renaming. Comments are welcome.

					Jaroslav

>From b0dca2c114f465a11f1595854090a85f58870b35 Mon Sep 17 00:00:00 2001
From: Jaroslav Kysela <perex@perex.cz>
Date: Tue, 11 Nov 2008 16:51:02 +0100
Subject: [PATCH] ALSA: add /sys/class/sound/card#/id (r/w) and card#/number (r/o) files

For udev, we need a way to rename soundcard names. The soundcard numbers
(indexes) are hardwired but we have a text identification which can be
changed at run-time. The ALSA user space tools already allow using of
this text identification.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 sound/core/init.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 65 insertions(+), 1 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index b47ff8b..1426abd 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -533,6 +533,64 @@ static void choose_default_id(struct snd_card *card)
 	}
 }
 
+#ifndef CONFIG_SYSFS_DEPRECATED
+static ssize_t
+card_id_show_attr(struct device *dev,
+		  struct device_attribute *attr, char *buf)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	return snprintf(buf, PAGE_SIZE, "%s\n", card ? card->id : "(null)");
+}
+
+static ssize_t
+card_id_store_attr(struct device *dev, struct device_attribute *attr,
+		   const char *buf, size_t count)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	char buf1[sizeof(card->id)];
+	size_t copy = count > sizeof(card->id) - 1 ?
+					sizeof(card->id) - 1 : count;
+	size_t idx;
+	int c;
+
+	for (idx = 0; idx < copy; idx++) {
+		c = buf[idx];
+		if (!isalnum(c) && c != '_' && c != '-')
+			return -EINVAL;
+	}
+	memcpy(buf1, buf, copy);
+	buf1[copy] = '\0';
+	mutex_lock(&snd_card_mutex);
+	if (!snd_info_check_reserved_words(buf1)) {
+	     __exist:
+		mutex_unlock(&snd_card_mutex);
+		return -EEXIST;
+	}
+	for (idx = 0; idx < snd_ecards_limit; idx++) {
+		if (snd_cards[idx] && !strcmp(snd_cards[idx]->id, buf1))
+			goto __exist;
+	}
+	strcpy(card->id, buf1);
+	mutex_unlock(&snd_card_mutex);
+
+	return count;
+}
+
+static struct device_attribute card_id_attrs =
+	__ATTR(id, S_IRUGO | S_IWUSR, card_id_show_attr, card_id_store_attr);
+
+static ssize_t
+card_number_show_attr(struct device *dev,
+		     struct device_attribute *attr, char *buf)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	return snprintf(buf, PAGE_SIZE, "%i\n", card ? card->number : -1);
+}
+
+static struct device_attribute card_number_attrs =
+	__ATTR(number, S_IRUGO, card_number_show_attr, NULL);
+#endif /* CONFIG_SYSFS_DEPRECATED */
+
 /**
  *  snd_card_register - register the soundcard
  *  @card: soundcard structure
@@ -553,7 +611,7 @@ int snd_card_register(struct snd_card *card)
 #ifndef CONFIG_SYSFS_DEPRECATED
 	if (!card->card_dev) {
 		card->card_dev = device_create(sound_class, card->dev,
-					       MKDEV(0, 0), NULL,
+					       MKDEV(0, 0), card,
 					       "card%i", card->number);
 		if (IS_ERR(card->card_dev))
 			card->card_dev = NULL;
@@ -576,6 +634,12 @@ int snd_card_register(struct snd_card *card)
 	if (snd_mixer_oss_notify_callback)
 		snd_mixer_oss_notify_callback(card, SND_MIXER_OSS_NOTIFY_REGISTER);
 #endif
+#ifndef CONFIG_SYSFS_DEPRECATED
+	if (card->card_dev) {
+		device_create_file(card->card_dev, &card_id_attrs);
+		device_create_file(card->card_dev, &card_number_attrs);
+	}
+#endif
 	return 0;
 }
 
-- 
1.6.0.1.217.gb4928


-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
