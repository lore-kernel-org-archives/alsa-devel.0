From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH] ALSA: hda: Fix race between creating and refreshing sysfs entries
Date: Fri, 10 May 2019 14:21:41 +0200
Message-ID: <20190510122141.8802-1-amadeuszx.slawinski@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

hda_widget_sysfs_reinit() can free underlying codec->widgets structure
on which widget_tree_create() operates. Add locking to prevent such
issues from happening.

Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=110382
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 include/sound/hdaudio.h   |  1 +
 sound/hda/hdac_sysfs.c    | 22 +++++++++++++++++++---
 sound/pci/hda/hda_codec.c |  2 ++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 45f944d57982..85835d0c33cc 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -81,6 +81,7 @@ struct hdac_device {
 	atomic_t in_pm;		/* suspend/resume being performed */
 
 	/* sysfs */
+	struct mutex widget_lock;
 	struct hdac_widget_tree *widgets;
 
 	/* regmap */
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index fb2aa344981e..5352e5db814c 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -399,21 +399,28 @@ int hda_widget_sysfs_init(struct hdac_device *codec)
 {
 	int err;
 
-	if (codec->widgets)
+	mutex_lock(&codec->widget_lock);
+	if (codec->widgets) {
+		mutex_unlock(&codec->widget_lock);
 		return 0; /* already created */
+	}
 
 	err = widget_tree_create(codec);
 	if (err < 0) {
 		widget_tree_free(codec);
+		mutex_unlock(&codec->widget_lock);
 		return err;
 	}
 
+	mutex_unlock(&codec->widget_lock);
 	return 0;
 }
 
 void hda_widget_sysfs_exit(struct hdac_device *codec)
 {
+	mutex_lock(&codec->widget_lock);
 	widget_tree_free(codec);
+	mutex_unlock(&codec->widget_lock);
 }
 
 int hda_widget_sysfs_reinit(struct hdac_device *codec,
@@ -424,16 +431,23 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
 	hda_nid_t nid;
 	int i;
 
-	if (!codec->widgets)
+	mutex_lock(&codec->widget_lock);
+
+	if (!codec->widgets) {
+		mutex_unlock(&codec->widget_lock);
 		return hda_widget_sysfs_init(codec);
+	}
 
 	tree = kmemdup(codec->widgets, sizeof(*tree), GFP_KERNEL);
-	if (!tree)
+	if (!tree) {
+		mutex_unlock(&codec->widget_lock);
 		return -ENOMEM;
+	}
 
 	tree->nodes = kcalloc(num_nodes + 1, sizeof(*tree->nodes), GFP_KERNEL);
 	if (!tree->nodes) {
 		kfree(tree);
+		mutex_unlock(&codec->widget_lock);
 		return -ENOMEM;
 	}
 
@@ -460,5 +474,7 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
 	codec->widgets = tree;
 
 	kobject_uevent(tree->root, KOBJ_CHANGE);
+
+	mutex_unlock(&codec->widget_lock);
 	return 0;
 }
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 701a69d856f5..a5746df5c94b 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -870,6 +870,8 @@ static int snd_hda_codec_device_init(struct hda_bus *bus, struct snd_card *card,
 	if (!codec)
 		return -ENOMEM;
 
+	mutex_init(&codec->widget_lock);
+
 	sprintf(name, "hdaudioC%dD%d", card->number, codec_addr);
 	err = snd_hdac_device_init(&codec->core, &bus->core, name, codec_addr);
 	if (err < 0) {
-- 
2.17.1
