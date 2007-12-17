From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: [PATCH] alsa-lib: Broken SNDRV_PCM_IOCTL_TTSTAMP entry
Date: Sun, 16 Dec 2007 21:49:04 -0500
Message-ID: <4765E3A0.4080008@embeddedalley.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080507040209030706020108"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp104.biz.mail.re2.yahoo.com (smtp104.biz.mail.re2.yahoo.com
	[206.190.52.173]) by alsa0.perex.cz (Postfix) with SMTP id 771332454E
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 03:49:45 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080507040209030706020108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 Fixed a IOCTL entry that was broken with a recent update to alsa-driver.
---
Signed-off-by: Matthew Ranostay <mranostay@embeddedalley.com>

--------------080507040209030706020108
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="tstamp_ioctl_fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tstamp_ioctl_fix.patch"

diff -r 0b2df0817fb6 include/sound/asound.h
--- a/include/sound/asound.h	Fri Dec 14 15:19:03 2007 +0100
+++ b/include/sound/asound.h	Sun Dec 16 19:38:55 2007 -0700
@@ -463,7 +463,7 @@ enum {
 enum {
 	SNDRV_PCM_IOCTL_PVERSION = _IOR('A', 0x00, int),
 	SNDRV_PCM_IOCTL_INFO = _IOR('A', 0x01, struct sndrv_pcm_info),
-	SNDRV_PCM_IOCTL_TSTAMP = _IOW('A', 0x02, int),
+	SNDRV_PCM_IOCTL_TTSTAMP = _IOW('A', 0x03, int),
 	SNDRV_PCM_IOCTL_HW_REFINE = _IOWR('A', 0x10, struct sndrv_pcm_hw_params),
 	SNDRV_PCM_IOCTL_HW_PARAMS = _IOWR('A', 0x11, struct sndrv_pcm_hw_params),
 	SNDRV_PCM_IOCTL_HW_FREE = _IO('A', 0x12),
diff -r 0b2df0817fb6 src/pcm/pcm_hw.c
--- a/src/pcm/pcm_hw.c	Fri Dec 14 15:19:03 2007 +0100
+++ b/src/pcm/pcm_hw.c	Sun Dec 16 19:38:55 2007 -0700
@@ -978,9 +978,9 @@ int snd_pcm_hw_open_fd(snd_pcm_t **pcmp,
 
 	if (SNDRV_PROTOCOL_VERSION(2, 0, 5) <= ver) {
 		int on = 1;
-		if (ioctl(fd, SNDRV_PCM_IOCTL_TSTAMP, &on) < 0) {
+		if (ioctl(fd, SNDRV_PCM_IOCTL_TTSTAMP, &on) < 0) {
 			ret = -errno;
-			SNDMSG("TSTAMP failed\n");
+			SNDMSG("TTSTAMP failed\n");
 			return ret;
 		}			
 	}

--------------080507040209030706020108
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------080507040209030706020108--
