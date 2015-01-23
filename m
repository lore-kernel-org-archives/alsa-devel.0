From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 03/16] ALSA: line6: Remove unused
	line6_nop_read()
Date: Fri, 23 Jan 2015 18:13:10 +0100
Message-ID: <1422033203-23254-4-git-send-email-tiwai@suse.de>
References: <1422033203-23254-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9265E2654EA
 for <alsa-devel@alsa-project.org>; Fri, 23 Jan 2015 18:13:41 +0100 (CET)
In-Reply-To: <1422033203-23254-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

The function isn't used any longer after rewriting from sysfs to leds
class in toneport.c.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 10 ----------
 sound/usb/line6/driver.h |  2 --
 2 files changed, 12 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 2eed6fbd99c4..d6023c9a8a61 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -413,16 +413,6 @@ int line6_read_serial_number(struct usb_line6 *line6, int *serial_number)
 EXPORT_SYMBOL_GPL(line6_read_serial_number);
 
 /*
-	No operation (i.e., unsupported).
-*/
-ssize_t line6_nop_read(struct device *dev, struct device_attribute *attr,
-		       char *buf)
-{
-	return 0;
-}
-EXPORT_SYMBOL_GPL(line6_nop_read);
-
-/*
 	Card destructor.
 */
 static void line6_destruct(struct snd_card *card)
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index efd58ac3215b..a6c0b2f08ba8 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -162,8 +162,6 @@ struct usb_line6 {
 
 extern char *line6_alloc_sysex_buffer(struct usb_line6 *line6, int code1,
 				      int code2, int size);
-extern ssize_t line6_nop_read(struct device *dev,
-			      struct device_attribute *attr, char *buf);
 extern int line6_read_data(struct usb_line6 *line6, int address, void *data,
 			   size_t datalen);
 extern int line6_read_serial_number(struct usb_line6 *line6,
-- 
2.2.2
