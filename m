From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 02/10] ALSA: hwdep: Take private_data as
	drvdata for sysfs
Date: Wed, 26 Feb 2014 07:47:24 +0100
Message-ID: <1393397252-11690-3-git-send-email-tiwai@suse.de>
References: <1393397252-11690-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1D0DC265357
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 07:47:38 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id E4F6F75021
 for <alsa-devel@alsa-project.org>; Wed, 26 Feb 2014 06:47:37 +0000 (UTC)
In-Reply-To: <1393397252-11690-1-git-send-email-tiwai@suse.de>
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

For referring to a different object from sysfs ops, take hwdep
private_data as stored via dev_set_drvdata() at creating the device
object.  In that way, the same sysfs ops can be used by different
device types.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/hwdep.c        |  2 ++
 sound/pci/hda/hda_hwdep.c | 45 +++++++++++++++------------------------------
 2 files changed, 17 insertions(+), 30 deletions(-)

diff --git a/sound/core/hwdep.c b/sound/core/hwdep.c
index 99f7e8515ba1..825cd2847940 100644
--- a/sound/core/hwdep.c
+++ b/sound/core/hwdep.c
@@ -441,6 +441,8 @@ static int snd_hwdep_dev_register(struct snd_device *device)
 		struct device *d = snd_get_device(SNDRV_DEVICE_TYPE_HWDEP,
 						  hwdep->card, hwdep->device);
 		if (d) {
+			if (hwdep->private_data)
+				dev_set_drvdata(d, hwdep->private_data);
 			err = sysfs_create_groups(&d->kobj, hwdep->groups);
 			if (err < 0)
 				dev_warn(card->dev,
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index 53eef6a01589..0fada0f8cfe8 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -163,8 +163,7 @@ static ssize_t power_on_acct_show(struct device *dev,
 				  struct device_attribute *attr,
 				  char *buf)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	snd_hda_update_power_acct(codec);
 	return sprintf(buf, "%u\n", jiffies_to_msecs(codec->power_on_acct));
 }
@@ -173,8 +172,7 @@ static ssize_t power_off_acct_show(struct device *dev,
 				   struct device_attribute *attr,
 				   char *buf)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	snd_hda_update_power_acct(codec);
 	return sprintf(buf, "%u\n", jiffies_to_msecs(codec->power_off_acct));
 }
@@ -251,8 +249,7 @@ static ssize_t type##_show(struct device *dev,			\
 			   struct device_attribute *attr,	\
 			   char *buf)				\
 {								\
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);		\
-	struct hda_codec *codec = hwdep->private_data;		\
+	struct hda_codec *codec = dev_get_drvdata(dev);		\
 	return sprintf(buf, "0x%x\n", codec->type);		\
 }
 
@@ -261,8 +258,7 @@ static ssize_t type##_show(struct device *dev,			\
 			     struct device_attribute *attr,	\
 					char *buf)		\
 {								\
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);		\
-	struct hda_codec *codec = hwdep->private_data;		\
+	struct hda_codec *codec = dev_get_drvdata(dev);		\
 	return sprintf(buf, "%s\n",				\
 		       codec->type ? codec->type : "");		\
 }
@@ -281,8 +277,7 @@ static ssize_t type##_store(struct device *dev,			\
 			    struct device_attribute *attr,	\
 			    const char *buf, size_t count)	\
 {								\
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);		\
-	struct hda_codec *codec = hwdep->private_data;		\
+	struct hda_codec *codec = dev_get_drvdata(dev);		\
 	unsigned long val;					\
 	int err = kstrtoul(buf, 0, &val);			\
 	if (err < 0)						\
@@ -296,8 +291,7 @@ static ssize_t type##_store(struct device *dev,			\
 			    struct device_attribute *attr,	\
 			    const char *buf, size_t count)	\
 {								\
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);		\
-	struct hda_codec *codec = hwdep->private_data;		\
+	struct hda_codec *codec = dev_get_drvdata(dev);		\
 	char *s = kstrndup_noeol(buf, 64);			\
 	if (!s)							\
 		return -ENOMEM;					\
@@ -318,8 +312,7 @@ static ssize_t type##_store(struct device *dev,			\
 			    struct device_attribute *attr,	\
 			    const char *buf, size_t count)	\
 {								\
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);		\
-	struct hda_codec *codec = hwdep->private_data;		\
+	struct hda_codec *codec = dev_get_drvdata(dev);		\
 	int err = 0;						\
 	if (*buf)						\
 		err = type##_codec(codec);			\
@@ -333,8 +326,7 @@ static ssize_t init_verbs_show(struct device *dev,
 			       struct device_attribute *attr,
 			       char *buf)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	int i, len = 0;
 	mutex_lock(&codec->user_mutex);
 	for (i = 0; i < codec->init_verbs.used; i++) {
@@ -373,8 +365,7 @@ static ssize_t init_verbs_store(struct device *dev,
 				struct device_attribute *attr,
 				const char *buf, size_t count)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	int err = parse_init_verbs(codec, buf);
 	if (err < 0)
 		return err;
@@ -385,8 +376,7 @@ static ssize_t hints_show(struct device *dev,
 			  struct device_attribute *attr,
 			  char *buf)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	int i, len = 0;
 	mutex_lock(&codec->user_mutex);
 	for (i = 0; i < codec->hints.used; i++) {
@@ -480,8 +470,7 @@ static ssize_t hints_store(struct device *dev,
 			   struct device_attribute *attr,
 			   const char *buf, size_t count)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	int err = parse_hints(codec, buf);
 	if (err < 0)
 		return err;
@@ -507,8 +496,7 @@ static ssize_t init_pin_configs_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	return pin_configs_show(codec, &codec->init_pins, buf);
 }
 
@@ -516,8 +504,7 @@ static ssize_t user_pin_configs_show(struct device *dev,
 				     struct device_attribute *attr,
 				     char *buf)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	return pin_configs_show(codec, &codec->user_pins, buf);
 }
 
@@ -525,8 +512,7 @@ static ssize_t driver_pin_configs_show(struct device *dev,
 				       struct device_attribute *attr,
 				       char *buf)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	return pin_configs_show(codec, &codec->driver_pins, buf);
 }
 
@@ -550,8 +536,7 @@ static ssize_t user_pin_configs_store(struct device *dev,
 				      struct device_attribute *attr,
 				      const char *buf, size_t count)
 {
-	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
-	struct hda_codec *codec = hwdep->private_data;
+	struct hda_codec *codec = dev_get_drvdata(dev);
 	int err = parse_user_pin_configs(codec, buf);
 	if (err < 0)
 		return err;
-- 
1.9.0
