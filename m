From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] Update user-space access from sscape driver
Date: Sat, 4 Dec 2004 18:14:42 +0000 (GMT)
Message-ID: <200412041814.iB4IEhUM021640@wittsend.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Chris Rankin <rankincj@yahoo.com>

Hi,

I see that the copy_to/from_user() functions have been updated across Linux 2.4 and 2.6, and that verify_read/write() has been replaced by access_ok(). I have patched the SoundScape driver accordingly.

Cheers,
Chris

Index: alsa-kernel/isa/sscape.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/sscape.c,v
retrieving revision 1.18
diff -u -u -r1.18 sscape.c
--- alsa-kernel/isa/sscape.c	30 Nov 2004 14:37:33 -0000	1.18
+++ alsa-kernel/isa/sscape.c	4 Dec 2004 18:07:26 -0000
@@ -487,7 +487,7 @@
 		 * the userspace pointer ...
 		 */
 		len = min(size, dma.bytes);
-		__copy_from_user(dma.area, data, len);
+		len -= __copy_from_user(dma.area, data, len);
 		data += len;
 		size -= len;
 
@@ -571,9 +571,9 @@
 		if (data < 0) {
 			snd_printk(KERN_ERR "sscape: timeout reading firmware version\n");
 			ret = -EAGAIN;
-		} else {
-			if (__copy_to_user(&bb->version, &data, sizeof(bb->version)))
-				ret = -EFAULT;
+		}
+		else if (__copy_to_user(&bb->version, &data, sizeof(bb->version))) {
+			ret = -EFAULT;
 		}
 	}
 
@@ -592,7 +592,7 @@
 {
 	unsigned long flags;
 	char __user *code;
-	int err, ret;
+	int err;
 
 	/*
 	 * We are going to have to copy this data into a special
@@ -602,12 +602,11 @@
 	 * NOTE: This buffer is 64K long! That's WAY too big to
 	 *       copy into a stack-temporary anyway.
 	 */
-	if (get_user(code, &mc->code))
+	if ( get_user(code, &mc->code) ||
+	     !access_ok(VERIFY_READ, code, SSCAPE_MICROCODE_SIZE) )
 		return -EFAULT;
-	if ((err = verify_area(VERIFY_READ, code, SSCAPE_MICROCODE_SIZE)) != 0)
-		return err;
 
-	if ((ret = upload_dma_data(sscape, code, SSCAPE_MICROCODE_SIZE)) == 0) {
+	if ((err = upload_dma_data(sscape, code, SSCAPE_MICROCODE_SIZE)) == 0) {
 		snd_printk(KERN_INFO "sscape: MIDI firmware loaded\n");
 	}
 
@@ -617,7 +616,7 @@
 
 	initialise_mpu401(sscape->mpu);
 
-	return ret;
+	return err;
 }
 
 /*
@@ -674,14 +673,14 @@
 			 * DMA-able buffer before we can upload it. We shall therefore
 			 * just check that the data pointer is valid for now ...
 			 */
-			if ((err = verify_area(VERIFY_READ, bb->code, sizeof(bb->code))) != 0)
-				return err;
+			if ( !access_ok(VERIFY_READ, bb->code, sizeof(bb->code)) )
+				return -EFAULT;
 
 			/*
 			 * Now check that we can write the firmware version number too...
 			 */
-			if ((err = verify_area(VERIFY_WRITE, &bb->version, sizeof(bb->version))) != 0)
-				return err;
+			if ( !access_ok(VERIFY_WRITE, &bb->version, sizeof(bb->version)) )
+				return -EFAULT;
 
 			err = sscape_upload_bootblock(sscape, bb);
 		}


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
