From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 4/4] ALSA: line6: Drop superfluous timer helper
	function
Date: Wed,  8 May 2019 16:49:43 +0200
Message-ID: <20190508144943.8139-5-tiwai@suse.de>
References: <20190508144943.8139-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC6B4F896FD
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 16:49:44 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 326F4AF34
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 14:49:44 +0000 (UTC)
In-Reply-To: <20190508144943.8139-1-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Now all timer usages in line6 drivers are gone, we can get rid of some
helper macro and function that became superfluous.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c | 11 -----------
 sound/usb/line6/driver.h |  9 ---------
 2 files changed, 20 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b61f65bed4e4..b1c9be4bbd0f 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -195,17 +195,6 @@ static int line6_send_raw_message_async_part(struct message *msg,
 	return retval;
 }
 
-/*
-	Setup and start timer.
-*/
-void line6_start_timer(struct timer_list *timer, unsigned long msecs,
-		       void (*function)(struct timer_list *t))
-{
-	timer->function = function;
-	mod_timer(timer, jiffies + msecs_to_jiffies(msecs));
-}
-EXPORT_SYMBOL_GPL(line6_start_timer);
-
 /*
 	Asynchronously send raw message.
 */
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index 61425597eb61..0bd6a5cff539 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -68,13 +68,6 @@
 
 #define LINE6_CHANNEL_MASK 0x0f
 
-#define CHECK_STARTUP_PROGRESS(x, n)	\
-do {					\
-	if ((x) >= (n))			\
-		return;			\
-	x = (n);			\
-} while (0)
-
 extern const unsigned char line6_midi_id[3];
 
 static const int SYSEX_DATA_OFS = sizeof(line6_midi_id) + 3;
@@ -197,8 +190,6 @@ extern int line6_send_sysex_message(struct usb_line6 *line6,
 				    const char *buffer, int size);
 extern ssize_t line6_set_raw(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count);
-extern void line6_start_timer(struct timer_list *timer, unsigned long msecs,
-			      void (*function)(struct timer_list *t));
 extern int line6_version_request_async(struct usb_line6 *line6);
 extern int line6_write_data(struct usb_line6 *line6, unsigned address,
 			    void *data, unsigned datalen);
-- 
2.16.4
