From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/2] ALSA: hda - Create AFG sysfs node at last
Date: Wed,  8 Apr 2015 16:44:58 +0200
Message-ID: <1428504299-19763-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B244265375
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 16:45:01 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id ED739AD8A
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 14:45:00 +0000 (UTC)
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

... so that user-space can know that the whole nodes have been
created.  Unfortunately, this can't be implemented easily in race-free
way, so it's a kind of compromise.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_sysfs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/hda/hdac_sysfs.c b/sound/hda/hdac_sysfs.c
index b358d5157802..18aea43d230d 100644
--- a/sound/hda/hdac_sysfs.c
+++ b/sound/hda/hdac_sysfs.c
@@ -313,12 +313,12 @@ static void widget_tree_free(struct hdac_device *codec)
 
 	if (!tree)
 		return;
+	free_widget_node(tree->afg, &widget_afg_group);
 	if (tree->nodes) {
 		for (p = tree->nodes; *p; p++)
 			free_widget_node(*p, &widget_node_group);
 		kfree(tree->nodes);
 	}
-	free_widget_node(tree->afg, &widget_afg_group);
 	if (tree->root)
 		kobject_put(tree->root);
 	kfree(tree);
@@ -362,13 +362,6 @@ static int widget_tree_create(struct hdac_device *codec)
 	if (!tree->root)
 		return -ENOMEM;
 
-	if (codec->afg) {
-		err = add_widget_node(tree->root, codec->afg,
-				      &widget_afg_group, &tree->afg);
-		if (err < 0)
-			return err;
-	}
-
 	tree->nodes = kcalloc(codec->num_nodes + 1, sizeof(*tree->nodes),
 			      GFP_KERNEL);
 	if (!tree->nodes)
@@ -381,6 +374,13 @@ static int widget_tree_create(struct hdac_device *codec)
 			return err;
 	}
 
+	if (codec->afg) {
+		err = add_widget_node(tree->root, codec->afg,
+				      &widget_afg_group, &tree->afg);
+		if (err < 0)
+			return err;
+	}
+
 	kobject_uevent(tree->root, KOBJ_CHANGE);
 	return 0;
 }
-- 
2.3.4
