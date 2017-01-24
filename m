From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 7/7] dmasound_core: Adjust six function calls together with a
 variable assignment
Date: Tue, 24 Jan 2017 11:27:19 +0100
Message-ID: <43a0c4d3-d054-4be2-eab7-7ee37b62fca6@users.sourceforge.net>
References: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f2404d64-27c8-4afa-b893-fc72601c0136@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, Jaroslav Kysela <perex@perex.cz>, Martin Koegler <martin.koegler@chello.at>, Takashi Iwai <tiwai@suse.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 24 Jan 2017 10:34:47 +0100

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/oss/dmasound/dmasound_core.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/sound/oss/dmasound/dmasound_core.c b/sound/oss/dmasound/dmasound_core.c
index 2bdd1d619a7f..a20bf3b94329 100644
--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -576,7 +576,9 @@ static ssize_t sq_write(struct file *file, const char __user *src, size_t uLeft,
 	*/
 
 	if (write_sq.locked == 0) {
-		if ((uWritten = sq_setup(&write_sq)) < 0) return uWritten ;
+		uWritten = sq_setup(&write_sq);
+		if (uWritten < 0)
+			return uWritten;
 		uWritten = 0 ;
 	}
 
@@ -675,7 +677,8 @@ static unsigned int sq_poll(struct file *file, struct poll_table_struct *wait)
 	int retVal;
 	
 	if (write_sq.locked == 0) {
-		if ((retVal = sq_setup(&write_sq)) < 0)
+		retVal = sq_setup(&write_sq);
+		if (retVal < 0)
 			return retVal;
 		return 0;
 	}
@@ -736,7 +739,8 @@ static int sq_open2(struct sound_queue *sq, struct file *file, fmode_t mode,
 		   can't be changed at the moment - but _could_ be perhaps
 		   in the setfragments ioctl.
 		*/
-		if (( rc = sq_allocate_buffers(sq, numbufs, bufsize))) {
+		rc = sq_allocate_buffers(sq, numbufs, bufsize);
+		if (rc) {
 #if 0 /* blocking open() */
 			sq_wake_up(sq, file, mode);
 #else
@@ -1407,12 +1411,14 @@ int dmasound_init(void)
 	/* Set up sound queue, /dev/audio and /dev/dsp. */
 
 	/* Set default settings. */
-	if ((res = sq_init()) < 0)
-		return res ;
+	res = sq_init();
+	if (res < 0)
+		return res;
 
 	/* Set up /dev/sndstat. */
-	if ((res = state_init()) < 0)
-		return res ;
+	res = state_init();
+	if (res < 0)
+		return res;
 
 	/* Set up /dev/mixer. */
 	mixer_init();
@@ -1485,7 +1491,8 @@ static int dmasound_setup(char *str)
 			numWriteBufs = ints[1];
 		/* fall through */
 	case 1:
-		if ((size = ints[2]) < 256) /* check for small buffer specs */
+		size = ints[2];
+		if (size < 256) /* check for small buffer specs */
 			size <<= 10 ;
                 if (size < MIN_BUFSIZE || size > MAX_BUFSIZE)
                         printk("dmasound_setup: invalid write buffer size, using default = %d\n", writeBufSize);
-- 
2.11.0
