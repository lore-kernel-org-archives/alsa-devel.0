From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] ALSA: line6: fixup of line6_start_timer argument type
Date: Tue,  3 Feb 2015 02:38:56 -0500
Message-ID: <1422949136-9349-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Chris Rorvick <chris@rorvick.com>, Stefan Hajnoczi <stefanha@gmail.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

line6_start_timer passes an unsigned int as argument to be used in mod_timer
which is then used by mod_timer as unsigned long, this just fixes up the 
argument type. This change helps make static code checkers happy.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

The change of argument type was checked against all call-sites - in all cases
it is passing in a constant (either VARIAX_STARTUP_DELAY1 or POD_STARTUP_DELAY)
which should be fine with the argument type change.

Patch was compile tested for x86_64_defconfig + CONFIG_SOUND=y,
CONFIG_SND_USB_POD=m (implies CONFIG_SND_USB_LINE6=y)

Patch is against 3.0.19-rc6 (localversion = -next-20150202)

 sound/usb/line6/driver.c |    2 +-
 sound/usb/line6/driver.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index 3cf12cc..e2a2603 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -162,7 +162,7 @@ static int line6_send_raw_message_async_part(struct message *msg,
 /*
 	Setup and start timer.
 */
-void line6_start_timer(struct timer_list *timer, unsigned int msecs,
+void line6_start_timer(struct timer_list *timer, unsigned long msecs,
 		       void (*function)(unsigned long), unsigned long data)
 {
 	setup_timer(timer, function, data);
diff --git a/sound/usb/line6/driver.h b/sound/usb/line6/driver.h
index fa877a3..2276b78 100644
--- a/sound/usb/line6/driver.h
+++ b/sound/usb/line6/driver.h
@@ -159,7 +159,7 @@ extern int line6_send_sysex_message(struct usb_line6 *line6,
 				    const char *buffer, int size);
 extern ssize_t line6_set_raw(struct device *dev, struct device_attribute *attr,
 			     const char *buf, size_t count);
-extern void line6_start_timer(struct timer_list *timer, unsigned int msecs,
+extern void line6_start_timer(struct timer_list *timer, unsigned long msecs,
 			      void (*function)(unsigned long),
 			      unsigned long data);
 extern int line6_version_request_async(struct usb_line6 *line6);
-- 
1.7.10.4
