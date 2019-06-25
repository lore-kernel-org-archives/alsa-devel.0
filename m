From: Evan Green <evgreen@chromium.org>
Subject: [PATCH] ALSA: hda: Use correct start/count for sysfs
	init
Date: Tue, 25 Jun 2019 14:54:18 -0700
Message-ID: <20190625215418.17548-1-evgreen@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 35BCFF8071F
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 23:54:36 +0200 (CEST)
Received: by mail-pg1-x541.google.com with SMTP id z19so88277pgl.12
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2019 14:54:36 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: alsa-devel@alsa-project.org

The normal flow through the widget sysfs codepath is that
snd_hdac_refresh_widgets() is called once without the sysfs bool set
to set up codec->num_nodes and friends, then another time with the
bool set to actually allocate all the sysfs widgets. However, during
the first time allocation, hda_widget_sysfs_reinit() ignores the new
num_nodes passed in via parameter and just calls hda_widget_sysfs_init(),
using whatever was in codec->num_nodes before the update. This is not
correct in cases where num_nodes changes. Here's an example:

Sometime earlier:
snd_hdac_refresh_widgets(hdac, false)
  sets codec->num_nodes to 2, widgets is still not allocated

Now:
snd_hdac_refresh_widgets(hdac, true)
  hda_widget_sysfs_reinit(num_nodes=7)
    hda_widget_sysfs_init()
      widget_tree_create()
        alloc(codec->num_nodes) // this is still 2
  codec->num_nodes = 7

Pass num_nodes and start_nid down into widget_tree_create() so that
the right number of nodes are allocated in all cases.

Signed-off-by: Evan Green <evgreen@chromium.org>
---

 sound/hda/hdac_device.c |  2 +-
 sound/hda/hdac_sysfs.c  | 14 ++++++++------
 sound/hda/local.h       |  3 ++-
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/hda/hdac_device.c b/sound/hda/hdac_device.c
index 6907dbefd08c..5e74acf45c81 100644
--- a/sound/hda/hdac_device.c
+++ b/sound/hda/hdac_device.c
@@ -144,7 +144,7 @@ int snd_hdac_device_register(struct hdac_device *codec)
 	if (err < 0)
 		return err;
 	mutex_lock(&codec->widget_lock);
-	err = hda_widget_sysfs_init(codec);
+	err = hda_widget_sysfs_init(codec, codec->start_nid, codec->num_nodes);
 	mutex_unlock(&codec->widget_lock);
 	if (err < 0) {
 		device_del(&codec->dev);
diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index 909d5ef1179c..1c4b98929d9c 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -358,7 +358,8 @@ static int add_widget_node(struct kobject *parent, hda_nid_t nid,
 	return 0;
 }
 
-static int widget_tree_create(struct hdac_device *codec)
+static int widget_tree_create(struct hdac_device *codec,
+			      hda_nid_t start_nid, int num_nodes)
 {
 	struct hdac_widget_tree *tree;
 	int i, err;
@@ -372,12 +373,12 @@ static int widget_tree_create(struct hdac_device *codec)
 	if (!tree->root)
 		return -ENOMEM;
 
-	tree->nodes = kcalloc(codec->num_nodes + 1, sizeof(*tree->nodes),
+	tree->nodes = kcalloc(num_nodes + 1, sizeof(*tree->nodes),
 			      GFP_KERNEL);
 	if (!tree->nodes)
 		return -ENOMEM;
 
-	for (i = 0, nid = codec->start_nid; i < codec->num_nodes; i++, nid++) {
+	for (i = 0, nid = start_nid; i < num_nodes; i++, nid++) {
 		err = add_widget_node(tree->root, nid, &widget_node_group,
 				      &tree->nodes[i]);
 		if (err < 0)
@@ -396,14 +397,15 @@ static int widget_tree_create(struct hdac_device *codec)
 }
 
 /* call with codec->widget_lock held */
-int hda_widget_sysfs_init(struct hdac_device *codec)
+int hda_widget_sysfs_init(struct hdac_device *codec,
+			  hda_nid_t start_nid, int num_nodes)
 {
 	int err;
 
 	if (codec->widgets)
 		return 0; /* already created */
 
-	err = widget_tree_create(codec);
+	err = widget_tree_create(codec, start_nid, num_nodes);
 	if (err < 0) {
 		widget_tree_free(codec);
 		return err;
@@ -428,7 +430,7 @@ int hda_widget_sysfs_reinit(struct hdac_device *codec,
 	int i;
 
 	if (!codec->widgets)
-		return hda_widget_sysfs_init(codec);
+		return hda_widget_sysfs_init(codec, start_nid, num_nodes);
 
 	tree = kmemdup(codec->widgets, sizeof(*tree), GFP_KERNEL);
 	if (!tree)
diff --git a/sound/hda/local.h b/sound/hda/local.h
index 877631e39373..8936120ab4d9 100644
--- a/sound/hda/local.h
+++ b/sound/hda/local.h
@@ -28,7 +28,8 @@ static inline unsigned int get_wcaps_channels(u32 wcaps)
 }
 
 extern const struct attribute_group *hdac_dev_attr_groups[];
-int hda_widget_sysfs_init(struct hdac_device *codec);
+int hda_widget_sysfs_init(struct hdac_device *codec,
+			  hda_nid_t start_nid, int num_nodes);
 int hda_widget_sysfs_reinit(struct hdac_device *codec, hda_nid_t start_nid,
 			    int num_nodes);
 void hda_widget_sysfs_exit(struct hdac_device *codec);
-- 
2.20.1
