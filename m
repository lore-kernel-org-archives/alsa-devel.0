From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] ALSA: line6: use msecs_to_jiffies for conversion
Date: Tue,  3 Feb 2015 02:38:39 -0500
Message-ID: <1422949119-9306-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chris Rorvick <chris@rorvick.com>, Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

This is only an API consolidation and should make things more readable
it replaces var * HZ / 1000 by msecs_to_jiffies(var).


Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Converting milliseconds to jiffies by val * HZ / 1000 is technically
not wrong but msecs_to_jiffies(val) is the cleaner solution and handles
all corner cases correctly. This is a minor API cleanup only.

Patch was only compile tested for x86_64_defconfig + CONFIG_SOUND=y,
CONFIG_SND_USB_POD=m (implies CONFIG_SND_USB_LINE6=y)

Patch is against 3.0.19-rc6 (localversion = -next-20150202)

 sound/usb/line6/driver.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 2328ec9..3cf12cc 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -166,7 +166,7 @@ void line6_start_timer(struct timer_list *timer, unsigned int msecs,
 		       void (*function)(unsigned long), unsigned long data)
 {
 	setup_timer(timer, function, data);
-	mod_timer(timer, jiffies + msecs * HZ / 1000);
+	mod_timer(timer, jiffies + msecs_to_jiffies(msecs));
 }
 EXPORT_SYMBOL_GPL(line6_start_timer);
 
-- 
1.7.10.4
