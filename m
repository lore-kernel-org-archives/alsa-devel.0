From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH MC Next Gen 11/20] media: au0828 fix au0828_create_media_graph() entity checks
Date: Fri,  2 Oct 2015 16:07:23 -0600
Message-ID: <243a0fc15048a2d81c5b893a788ec11801b58f98.1443822799.git.shuahkh@osg.samsung.com>
References: <cover.1443822799.git.shuahkh@osg.samsung.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1443822799.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1443822799.git.shuahkh@osg.samsung.com>
References: <cover.1443822799.git.shuahkh@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@osg.samsung.com, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, tiwai@suse.de, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, dan.carpenter@oracle.com, tskd08@gmail.com, arnd@arndb.de, ruchandani.tina@gmail.com, corbet@lwn.net, k.kozlowski@samsung.com, chehabrafael@gmail.com, prabhakar.csengg@gmail.com, elfring@users.sourceforge.net, Julia.Lawall@lip6.fr, p.zabel@pengutronix.de, ricardo.ribalda@gmail.com, labbott@fedoraproject.org, chris.j.arges@canonical.com, pierre-louis.bossart@linux.intel.com, johan@oljud.se, wsa@the-dreams.de, jcragg@gmail.com, clemens@ladisch.de, daniel@zonque.org, gtmkramer@xs4all.nl, misterpib@gmail.com, takamichiho@gmail.com, pmatilai@laiskiainen.org, vladcatoi@gmail.com, damien@zamaudio.com, normalperson@yhbt.net, joe@oampo.co.uk, jussi@sonarnerd.netca
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

au0828_create_media_graph() doesn't do any checks to determine,
if vbi_dev, vdev, and input entities have been registered prior
to creating pad links. Checking graph_obj.mdev field works as
the graph_obj.mdev field gets initialized in the entity register
interface. Fix it to check graph_obj.mdev field before creating
pad links.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/usb/au0828/au0828-core.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index b04c2a5..4fd7db8 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -287,20 +287,28 @@ static int au0828_create_media_graph(struct au0828_dev *dev)
 		if (ret)
 			return ret;
 	}
-	ret = media_create_pad_link(decoder, AU8522_PAD_VID_OUT,
-				    &dev->vdev.entity, 0,
-			 	    MEDIA_LNK_FL_ENABLED);
-	if (ret)
-		return ret;
-	ret = media_create_pad_link(decoder, AU8522_PAD_VBI_OUT,
-				    &dev->vbi_dev.entity, 0,
-				    MEDIA_LNK_FL_ENABLED);
-	if (ret)
-		return ret;
+
+	if (dev->vdev.entity.graph_obj.mdev) {
+		ret = media_create_pad_link(decoder, AU8522_PAD_VID_OUT,
+					    &dev->vdev.entity, 0,
+					    MEDIA_LNK_FL_ENABLED);
+		if (ret)
+			return ret;
+	}
+	if (dev->vbi_dev.entity.graph_obj.mdev) {
+		ret = media_create_pad_link(decoder, AU8522_PAD_VBI_OUT,
+					    &dev->vbi_dev.entity, 0,
+					    MEDIA_LNK_FL_ENABLED);
+		if (ret)
+			return ret;
+	}
 
 	for (i = 0; i < AU0828_MAX_INPUT; i++) {
 		struct media_entity *ent = &dev->input_ent[i];
 
+		if (!ent->graph_obj.mdev)
+			continue;
+
 		if (AUVI_INPUT(i).type == AU0828_VMUX_UNDEFINED)
 			break;
 
-- 
2.1.4
