From: Eldad Zack <eldad@fogrefinery.com>
Subject: [PATCHv2 09/10] ALSA: usb-audio: show err in
	set_sample_rate_v2 debug
Date: Wed,  3 Apr 2013 23:18:57 +0200
Message-ID: <1365023938-1461-10-git-send-email-eldad@fogrefinery.com>
References: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f54.google.com (mail-bk0-f54.google.com
 [209.85.214.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 52073265D0E
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2013 23:19:36 +0200 (CEST)
Received: by mail-bk0-f54.google.com with SMTP id q16so1127251bkw.27
 for <alsa-devel@alsa-project.org>; Wed, 03 Apr 2013 14:19:35 -0700 (PDT)
In-Reply-To: <1365023938-1461-1-git-send-email-eldad@fogrefinery.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, Daniel Mack <zonque@gmail.com>, Torstein Hegge <hegge@resisty.net>
Cc: alsa-devel@alsa-project.org, Eldad Zack <eldad@fogrefinery.com>
List-Id: alsa-devel@alsa-project.org

Show the error code returned from the USB subsystem in
the debug messages.

Signed-off-by: Eldad Zack <eldad@fogrefinery.com>
---
 sound/usb/clock.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/usb/clock.c b/sound/usb/clock.c
index e59d359..a694e1c 100644
--- a/sound/usb/clock.c
+++ b/sound/usb/clock.c
@@ -331,8 +331,8 @@ static int get_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 			      snd_usb_ctrl_intf(chip) | (clock << 8),
 			      &data, sizeof(data));
 	if (err < 0) {
-		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2)\n",
-			   dev->devnum, iface, altsetting);
+		snd_printk(KERN_WARNING "%d:%d:%d: cannot get freq (v2): err %d\n",
+			   dev->devnum, iface, altsetting, err);
 		return 0;
 	}
 
@@ -360,8 +360,8 @@ static int set_sample_rate_v2(struct snd_usb_audio *chip, int iface,
 				   UAC2_CS_CONTROL_SAM_FREQ << 8,
 				   snd_usb_ctrl_intf(chip) | (clock << 8),
 				   &data, sizeof(data))) < 0) {
-		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2)\n",
-			   dev->devnum, iface, fmt->altsetting, rate);
+		snd_printk(KERN_ERR "%d:%d:%d: cannot set freq %d (v2): err %d\n",
+			   dev->devnum, iface, fmt->altsetting, rate, err);
 		return err;
 	}
 
-- 
1.8.1.5
