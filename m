From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
        <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH v2] ALSA: hda: Fix race between creating and refreshing sysfs entries
Date: Mon, 13 May 2019 11:18:01 +0200
Message-ID: <20190513091801.985-1-amadeuszx.slawinski@linux.intel.com>
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

Changes since v1:
 - Moved mutexes around the callers
 - Added comments noting that functions should be called with mutex held

---
 include/sound/hdaudio.h | 1 +
 sound/hda/hdac_device.c | 7 +++++++
 sound/hda/hdac_sysfs.c  | 3 +++
 3 files changed, 11 insertions(+)

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
diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 95b073ee4b32..4769f4c03e14 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -55,6 +55,7 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
 	codec->bus = bus;
 	codec->addr = addr;
 	codec->type = HDA_DEV_CORE;
+	mutex_init(&codec->widget_lock);
 	pm_runtime_set_active(&codec->dev);
 	pm_runtime_get_noresume(&codec->dev);
 	atomic_set(&codec->in_pm, 0);
@@ -141,7 +142,9 @@ int snd_hdac_device_register(struct hdac_device *codec)
 	err = device_add(&codec->dev);
 	if (err < 0)
 		return err;
+	mutex_lock(&codec->widget_lock);
 	err = hda_widget_sysfs_init(codec);
+	mutex_unlock(&codec->widget_lock);
 	if (err < 0) {
 		device_del(&codec->dev);
 		return err;
@@ -158,7 +161,9 @@ EXPORT_SYMBOL_GPL(snd_hdac_device_register);
 void snd_hdac_device_unregister(struct hdac_device *codec)
 {
 	if (device_is_registered(&codec->dev)) {
+		mutex_lock(&codec->widget_lock);
 		hda_widget_sysfs_exit(codec);
+		mutex_unlock(&codec->widget_lock);
 		device_del(&codec->dev);
 		snd_hdac_bus_remove_device(codec->bus, codec);
 	}
@@ -404,7 +409,9 @@ int snd_hdac_refresh_widgets(struct hdac_device *codec, bool sysfs)
 	}
 
 	if (sysfs) {
+		mutex_lock(&codec->widget_lock);
 		err = hda_widget_sysfs_reinit(codec, start_nid, nums);
+		mutex_unlock(&codec->widget_lock);
 		if (err < 0)
 			return err;
 	}
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index fb2aa344981e..909d5ef1179c 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -395,6 +395,7 @@ static int widget_tree_create(struct hdac_device *codec)
 	return 0;
 }
 
+/* call with codec->widget_lock held */
 int hda_widget_sysfs_init(struct hdac_device *codec)
 {
 	int err;
@@ -411,11 +412,13 @@ int hda_widget_sysfs_init(struct hdac_device *codec)
 	return 0;
 }
 
+/* call with codec->widget_lock held */
 void hda_widget_sysfs_exit(struct hdac_device *codec)
 {
 	widget_tree_free(codec);
 }
 
+/* call with codec->widget_lock held */
 int hda_widget_sysfs_reinit(struct hdac_device *codec,
 			    hda_nid_t start_nid, int num_nodes)
 {
-- 
2.17.1
