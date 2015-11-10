From: Shuah Khan <shuahkh@osg.samsung.com>
Subject: [PATCH MC Next Gen v3 5/6] media: Fix compile warning when CONFIG_MEDIA_CONTROLLER_DVB is disabled
Date: Tue, 10 Nov 2015 13:40:48 -0700
Message-ID: <534f63cf35f10ef11fa2eeb7c3d5fdb525b3d465.1447184001.git.shuahkh@osg.samsung.com>
References: <cover.1447183999.git.shuahkh@osg.samsung.com>
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <cover.1447183999.git.shuahkh@osg.samsung.com>
In-Reply-To: <cover.1447183999.git.shuahkh@osg.samsung.com>
References: <cover.1447183999.git.shuahkh@osg.samsung.com>
Sender: linux-media-owner@vger.kernel.org
To: mchehab@osg.samsung.com, tiwai@suse.de, perex@perex.cz, chehabrafael@gmail.com, hans.verkuil@cisco.com, prabhakar.csengg@gmail.com, chris.j.arges@canonical.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-media@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fix the following compile warning when CONFIG_MEDIA_CONTROLLER_DVB
is disabled:

drivers/media/dvb-core/dvb_frontend.c: In function 'dvb_frontend_open':
drivers/media/dvb-core/dvb_frontend.c:2526:1: warning: label 'err2'
defined but not used [-Wunused-label] err2:

Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
---
 drivers/media/dvb-core/dvb_frontend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/dvb-core/dvb_frontend.c b/drivers/media/dvb-core/dvb_frontend.c
index 6a759f5..9e7ee83 100644
--- a/drivers/media/dvb-core/dvb_frontend.c
+++ b/drivers/media/dvb-core/dvb_frontend.c
@@ -2522,8 +2522,8 @@ err3:
 #ifdef CONFIG_MEDIA_CONTROLLER_DVB
 	if (fe->dvb->mdev && fe->dvb->mdev->disable_source)
 		fe->dvb->mdev->disable_source(dvbdev->entity);
-#endif
 err2:
+#endif
 	dvb_generic_release(inode, file);
 err1:
 	if (dvbdev->users == -1 && fe->ops.ts_bus_ctrl)
-- 
2.5.0
