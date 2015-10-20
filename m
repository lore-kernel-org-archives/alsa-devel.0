From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH MC Next Gen v2 1/3] sound/usb: Fix media_stream_delete() to remove intf devnode
Date: Tue, 20 Oct 2015 17:25:14 -0600
Message-ID: <192c21ec5392e122c22caeca2b19f50fea4440b0.1445380851.git.shuahkh@osg.samsung.com>
References: <cover.1445380851.git.shuahkh@osg.samsung.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1445380851.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1445380851.git.shuahkh@osg.samsung.com>
References: <cover.1445380851.git.shuahkh@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@osg.samsung.com, tiwai@suse.de, perex@perex.cz, chehabrafael@gmail.com, hans.verkuil@cisco.com, prabhakar.csengg@gmail.com, chris.j.arges@canonical.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

media_stream_delete() doesn't remove intf_devnode. Fix it to
call media_devnode_remove() to remove the intf_devnode.

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 sound/usb/media.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/media.c b/sound/usb/media.c
index 9b455ad..0cbfee6 100644
--- a/sound/usb/media.c
+++ b/sound/usb/media.c
@@ -173,6 +173,7 @@ void media_stream_delete(struct snd_usb_substream *subs)
 		mdev = media_device_find_devres(&subs->dev->dev);
 		if (mdev) {
 			media_entity_remove_links(&mctl->media_entity);
+			media_devnode_remove(mctl->intf_devnode);
 			media_device_unregister_entity(&mctl->media_entity);
 			media_entity_cleanup(&mctl->media_entity);
 		}
-- 
2.1.4
