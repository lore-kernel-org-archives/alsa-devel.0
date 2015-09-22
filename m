From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH v3 11/21] media: au0828 Use au8522_media_pads enum for pad defines
Date: Tue, 22 Sep 2015 11:19:30 -0600
Message-ID: <754f57fb0f42cc11d00ee3bbbc3df6c01d909463.1442937669.git.shuahkh@osg.samsung.com>
References: <cover.1442937669.git.shuahkh@osg.samsung.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1442937669.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1442937669.git.shuahkh@osg.samsung.com>
References: <cover.1442937669.git.shuahkh@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@osg.samsung.com, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, tiwai@suse.de, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, stefanr@s5r6.in-berlin.de, crope@iki.fi, dan.carpenter@oracle.com, tskd08@gmail.com, ruchandani.tina@gmail.com, arnd@arndb.de, chehabrafael@gmail.com, prabhakar.csengg@gmail.com, Julia.Lawall@lip6.fr, elfring@users.sourceforge.net, ricardo.ribalda@gmail.com, chris.j.arges@canonical.com, pierre-louis.bossart@linux.intel.com, gtmkramer@xs4all.nl, clemens@ladisch.de, misterpib@gmail.com, takamichiho@gmail.com, pmatilai@laiskiainen.org, damien@zamaudio.com, daniel@zonque.org, vladcatoi@gmail.com, normalperson@yhbt.net, joe@oampo.co.uk, bugzilla.frnkcg@spamgourmet.com, jussi@sonarnerd.net
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Change au0828-core to use au8522_media_pads enum defines
instead of hard-coding the pad values when it creates
media graph linking decode pads to other entities.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/usb/au0828/au0828-core.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-core.c b/drivers/media/usb/au0828/au0828-core.c
index 0378a2c..276598b 100644
--- a/drivers/media/usb/au0828/au0828-core.c
+++ b/drivers/media/usb/au0828/au0828-core.c
@@ -20,6 +20,7 @@
  */
 
 #include "au0828.h"
+#include "au8522.h"
 
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -263,11 +264,13 @@ static void au0828_create_media_graph(struct au0828_dev *dev)
 		media_entity_create_link(tuner, 0, decoder, 0,
 					 MEDIA_LNK_FL_ENABLED);
 	if (dev->vdev.entity.links)
-		media_entity_create_link(decoder, 1, &dev->vdev.entity, 0,
-				 MEDIA_LNK_FL_ENABLED);
+		media_entity_create_link(decoder, AU8522_PAD_VID_OUT,
+					 &dev->vdev.entity, 0,
+					 MEDIA_LNK_FL_ENABLED);
 	if (dev->vbi_dev.entity.links)
-		media_entity_create_link(decoder, 2, &dev->vbi_dev.entity, 0,
-				 MEDIA_LNK_FL_ENABLED);
+		media_entity_create_link(decoder, AU8522_PAD_VBI_OUT,
+					 &dev->vbi_dev.entity, 0,
+					 MEDIA_LNK_FL_ENABLED);
 #endif
 }
 
-- 
2.1.4
