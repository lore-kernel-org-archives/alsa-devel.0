From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 18/20] ALSA: hda - Protect user-defined arrays
	via mutex
Date: Tue, 15 Jan 2013 12:05:45 +0100
Message-ID: <1358247947-13992-19-git-send-email-tiwai@suse.de>
References: <1358247947-13992-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id D976726532E
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:50 +0100 (CET)
Received: from relay1.suse.de (unknown [195.135.220.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx2.suse.de (Postfix) with ESMTP id AC90DA523A
 for <alsa-devel@alsa-project.org>; Tue, 15 Jan 2013 12:05:48 +0100 (CET)
In-Reply-To: <1358247947-13992-1-git-send-email-tiwai@suse.de>
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

The pincfgs, init_verbs and hints set by sysfs or patch might be
changed dynamically on the fly, thus we need to protect it.
Add a simple protection via a mutex.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_codec.c      | 13 ++++++--
 sound/pci/hda/hda_codec.h      |  1 +
 sound/pci/hda/hda_hwdep.c      | 67 ++++++++++++++++++++++++++++++------------
 sound/pci/hda/patch_sigmatel.c |  5 ++++
 4 files changed, 65 insertions(+), 21 deletions(-)

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 0a531f2..b28e403 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -1086,9 +1086,16 @@ unsigned int snd_hda_codec_get_pincfg(struct hda_codec *codec, hda_nid_t nid)
 	struct hda_pincfg *pin;
 
 #ifdef CONFIG_SND_HDA_HWDEP
-	pin = look_up_pincfg(codec, &codec->user_pins, nid);
-	if (pin)
-		return pin->cfg;
+	{
+		unsigned int cfg = 0;
+		mutex_lock(&codec->user_mutex);
+		pin = look_up_pincfg(codec, &codec->user_pins, nid);
+		if (pin)
+			cfg = pin->cfg;
+		mutex_unlock(&codec->user_mutex);
+		if (cfg)
+			return cfg;
+	}
 #endif
 	pin = look_up_pincfg(codec, &codec->driver_pins, nid);
 	if (pin)
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 4c4f166..61085b3 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -845,6 +845,7 @@ struct hda_codec {
 	struct snd_array cvt_setups;	/* audio convert setups */
 
 #ifdef CONFIG_SND_HDA_HWDEP
+	struct mutex user_mutex;
 	struct snd_hwdep *hwdep;	/* assigned hwdep device */
 	struct snd_array init_verbs;	/* additional init verbs */
 	struct snd_array hints;		/* additional hints */
diff --git a/sound/pci/hda/hda_hwdep.c b/sound/pci/hda/hda_hwdep.c
index a5c9411..2dddf7f 100644
--- a/sound/pci/hda/hda_hwdep.c
+++ b/sound/pci/hda/hda_hwdep.c
@@ -148,6 +148,7 @@ int snd_hda_create_hwdep(struct hda_codec *codec)
 	hwdep->ops.ioctl_compat = hda_hwdep_ioctl_compat;
 #endif
 
+	mutex_init(&codec->user_mutex);
 	snd_array_init(&codec->init_verbs, sizeof(struct hda_verb), 32);
 	snd_array_init(&codec->hints, sizeof(struct hda_hint), 32);
 	snd_array_init(&codec->user_pins, sizeof(struct hda_pincfg), 16);
@@ -346,12 +347,14 @@ static ssize_t init_verbs_show(struct device *dev,
 	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
 	struct hda_codec *codec = hwdep->private_data;
 	int i, len = 0;
+	mutex_lock(&codec->user_mutex);
 	for (i = 0; i < codec->init_verbs.used; i++) {
 		struct hda_verb *v = snd_array_elem(&codec->init_verbs, i);
 		len += snprintf(buf + len, PAGE_SIZE - len,
 				"0x%02x 0x%03x 0x%04x\n",
 				v->nid, v->verb, v->param);
 	}
+	mutex_unlock(&codec->user_mutex);
 	return len;
 }
 
@@ -364,12 +367,16 @@ static int parse_init_verbs(struct hda_codec *codec, const char *buf)
 		return -EINVAL;
 	if (!nid || !verb)
 		return -EINVAL;
+	mutex_lock(&codec->user_mutex);
 	v = snd_array_new(&codec->init_verbs);
-	if (!v)
+	if (!v) {
+		mutex_unlock(&codec->user_mutex);
 		return -ENOMEM;
+	}
 	v->nid = nid;
 	v->verb = verb;
 	v->param = param;
+	mutex_unlock(&codec->user_mutex);
 	return 0;
 }
 
@@ -392,11 +399,13 @@ static ssize_t hints_show(struct device *dev,
 	struct snd_hwdep *hwdep = dev_get_drvdata(dev);
 	struct hda_codec *codec = hwdep->private_data;
 	int i, len = 0;
+	mutex_lock(&codec->user_mutex);
 	for (i = 0; i < codec->hints.used; i++) {
 		struct hda_hint *hint = snd_array_elem(&codec->hints, i);
 		len += snprintf(buf + len, PAGE_SIZE - len,
 				"%s = %s\n", hint->key, hint->val);
 	}
+	mutex_unlock(&codec->user_mutex);
 	return len;
 }
 
@@ -431,6 +440,7 @@ static int parse_hints(struct hda_codec *codec, const char *buf)
 {
 	char *key, *val;
 	struct hda_hint *hint;
+	int err = 0;
 
 	buf = skip_spaces(buf);
 	if (!*buf || *buf == '#' || *buf == '\n')
@@ -450,26 +460,31 @@ static int parse_hints(struct hda_codec *codec, const char *buf)
 	val = skip_spaces(val);
 	remove_trail_spaces(key);
 	remove_trail_spaces(val);
+	mutex_lock(&codec->user_mutex);
 	hint = get_hint(codec, key);
 	if (hint) {
 		/* replace */
 		kfree(hint->key);
 		hint->key = key;
 		hint->val = val;
-		return 0;
+		goto unlock;
 	}
 	/* allocate a new hint entry */
 	if (codec->hints.used >= MAX_HINTS)
 		hint = NULL;
 	else
 		hint = snd_array_new(&codec->hints);
-	if (!hint) {
-		kfree(key);
-		return -ENOMEM;
+	if (hint) {
+		hint->key = key;
+		hint->val = val;
+	} else {
+		err = -ENOMEM;
 	}
-	hint->key = key;
-	hint->val = val;
-	return 0;
+ unlock:
+	mutex_unlock(&codec->user_mutex);
+	if (err)
+		kfree(key);
+	return err;
 }
 
 static ssize_t hints_store(struct device *dev,
@@ -489,11 +504,13 @@ static ssize_t pin_configs_show(struct hda_codec *codec,
 				char *buf)
 {
 	int i, len = 0;
+	mutex_lock(&codec->user_mutex);
 	for (i = 0; i < list->used; i++) {
 		struct hda_pincfg *pin = snd_array_elem(list, i);
 		len += sprintf(buf + len, "0x%02x 0x%08x\n",
 			       pin->nid, pin->cfg);
 	}
+	mutex_unlock(&codec->user_mutex);
 	return len;
 }
 
@@ -528,13 +545,16 @@ static ssize_t driver_pin_configs_show(struct device *dev,
 
 static int parse_user_pin_configs(struct hda_codec *codec, const char *buf)
 {
-	int nid, cfg;
+	int nid, cfg, err;
 
 	if (sscanf(buf, "%i %i", &nid, &cfg) != 2)
 		return -EINVAL;
 	if (!nid)
 		return -EINVAL;
-	return snd_hda_add_pincfg(codec, &codec->user_pins, nid, cfg);
+	mutex_lock(&codec->user_mutex);
+	err = snd_hda_add_pincfg(codec, &codec->user_pins, nid, cfg);
+	mutex_unlock(&codec->user_mutex);
+	return err;
 }
 
 static ssize_t user_pin_configs_store(struct device *dev,
@@ -600,16 +620,27 @@ EXPORT_SYMBOL_HDA(snd_hda_get_hint);
 
 int snd_hda_get_bool_hint(struct hda_codec *codec, const char *key)
 {
-	const char *p = snd_hda_get_hint(codec, key);
+	const char *p;
+	int ret;
+
+	mutex_lock(&codec->user_mutex);
+	p = snd_hda_get_hint(codec, key);
 	if (!p || !*p)
-		return -ENOENT;
-	switch (toupper(*p)) {
-	case 'T': /* true */
-	case 'Y': /* yes */
-	case '1':
-		return 1;
+		ret = -ENOENT;
+	else {
+		switch (toupper(*p)) {
+		case 'T': /* true */
+		case 'Y': /* yes */
+		case '1':
+			ret = 1;
+			break;
+		default:
+			ret = 0;
+			break;
+		}
 	}
-	return 0;
+	mutex_unlock(&codec->user_mutex);
+	return ret;
 }
 EXPORT_SYMBOL_HDA(snd_hda_get_bool_hint);
 
diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index a86547c..d3a81f1 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -4298,15 +4298,20 @@ static void stac_toggle_power_map(struct hda_codec *codec, hda_nid_t nid,
 static inline int get_int_hint(struct hda_codec *codec, const char *key,
 			       int *valp)
 {
+#ifdef CONFIG_SND_HDA_RECONFIG
 	const char *p;
+	mutex_lock(&codec->user_mutex);
 	p = snd_hda_get_hint(codec, key);
 	if (p) {
 		unsigned long val;
 		if (!strict_strtoul(p, 0, &val)) {
 			*valp = val;
+			mutex_unlock(&codec->user_mutex);
 			return 1;
 		}
 	}
+	mutex_unlock(&codec->user_mutex);
+#endif
 	return 0;
 }
 
-- 
1.8.1
