From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 2/3] sound: usb: line6: Replace mdelay with
	msleep in line6_write_data
Date: Sun, 18 Mar 2018 22:51:59 +0800
Message-ID: <1521384719-23423-1-git-send-email-baijiaju1990@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f68.google.com (mail-pg0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id C2601266FFE
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 15:52:00 +0100 (CET)
Received: by mail-pg0-f68.google.com with SMTP id m24so244146pgv.8
 for <alsa-devel@alsa-project.org>; Sun, 18 Mar 2018 07:52:00 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, Jia-Ju Bai <baijiaju1990@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

line6_write_data() is never called in atomic context.

The call chains ending up at line6_write_data() are:
[1] line6_write_data() <- toneport_setup() <- toneport_init() 
	<- line6_probe()
[2] line6_write_data() <- toneport_setup() <- toneport_reset_resume()

line6_probe() is called in toneport_probe(), pod_probe(), podhd_probe() 
and variax_probe(), which are set as ".probe" in usb_driver structure.
toneport_reset_resume() is set as ".reset_resume" in usb_driver structure.
These functions are not called in atomic context.

Despite never getting called from atomic context, line6_write_data()
calls mdelay for busy wait.
That is not necessary and can be replaced with msleep to 
avoid busy waiting.

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 sound/usb/line6/driver.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 0ff5a7d..29acd86 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -426,7 +426,7 @@ int line6_write_data(struct usb_line6 *line6, unsigned address, void *data,
 	}
 
 	for (count = 0; count < LINE6_READ_WRITE_MAX_RETRIES; count++) {
-		mdelay(LINE6_READ_WRITE_STATUS_DELAY);
+		msleep(LINE6_READ_WRITE_STATUS_DELAY);
 
 		ret = usb_control_msg(usbdev, usb_rcvctrlpipe(usbdev, 0),
 				      0x67,
-- 
1.9.1
