From: egel@scoutnet.nl
Subject: How to get alsa 0.9.3 working with 2.4 kernels on Alpha; part 2t
Date: Fri, 23 May 2003 11:35:45 GMT
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <200305231135.h4NBZjM03144@explorer.scouting.nl>
Return-path: <alsa-user-admin@lists.sourceforge.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: alsa-user@lists.sourceforge.net
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I got Alsa 0.9.3c finally build an loaded with kernel 2.4.20 with 
only " #include <asm/pgtable.h> " in highmem.h 

#include <linux/sched.h>
#include <linux/mm.h>
added to acore/memory_wrapper.c

#include <linux/slab.h>
added to misc.c , opl4_lib.c and opl4_proc.c

and this patch:
----------------------------------------------

diff -Naur alsa-driver-0.9.3a/alsa-kernel/isa/sb/emu8000_patch.c alsa-driver-0.
9.3a-linux2420/alsa-kernel/isa/sb/emu8000_patch.c
--- alsa-driver-0.9.3a/alsa-kernel/isa/sb/emu8000_patch.c	2002-08-12 03:43:
46.000000000 -0500
+++ alsa-driver-0.9.3a-linux2420/alsa-kernel/isa/sb/emu8000_patch.
c	2003-05-18 15:50:53.000000000 -0500
@@ -233,7 +233,7 @@
 		/* we may take too long time in this loop.
 		 * so give controls back to kernel if needed.
 		 */
-		if (need_resched()) {
+		if (ALSA_NEED_RESCHED()) {
 			if (current->state != TASK_RUNNING)
 				set_current_state(TASK_RUNNING);
 			schedule();
diff -Naur alsa-driver-0.9.3a/alsa-kernel/isa/sb/emu8000_pcm.c alsa-driver-0.9.
3a-linux2420/alsa-kernel/isa/sb/emu8000_pcm.c
--- alsa-driver-0.9.3a/alsa-kernel/isa/sb/emu8000_pcm.c	2003-02-10 05:53:49.
000000000 -0600
+++ alsa-driver-0.9.3a-linux2420/alsa-kernel/isa/sb/emu8000_pcm.c	2003-05-18 
15:50:53.000000000 -0500
@@ -424,7 +424,7 @@
  */
 #define CHECK_SCHEDULER() \
 do { \
-	if (need_resched()) {\
+	if (ALSA_NEED_RESCHED()) {\
 		if (current->state != TASK_RUNNING)\
 			set_current_state(TASK_RUNNING);\
 		schedule();\
diff -Naur alsa-driver-0.9.3a/include/adriver.h alsa-driver-0.9.
3a-linux2420/include/adriver.h
--- alsa-driver-0.9.3a/include/adriver.h	2003-04-27 09:49:58.000000000 -0500
+++ alsa-driver-0.9.3a-linux2420/include/adriver.h	2003-05-18 15:50:53.
000000000 -0500
@@ -105,7 +105,9 @@
 #endif
 
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 3)
-#define need_resched() (current->need_resched)
+#define ALSA_NEED_RESCHED() (current->need_resched)
+#else
+#define ALSA_NEED_RESCHED() (need_resched())
 #endif
 #if LINUX_VERSION_CODE < KERNEL_VERSION(2, 5, 4)
 #include <linux/fs.h>
diff -Naur alsa-driver-0.9.3a/pci/vx222/vx222_ops.c alsa-driver-0.9.
3a-linux2420/pci/vx222/vx222_ops.c
--- alsa-driver-0.9.3a/pci/vx222/vx222_ops.c	2003-03-21 11:41:57.000000000 
-0600
+++ alsa-driver-0.9.3a-linux2420/pci/vx222/vx222_ops.c	2003-05-18 15:50:53.
000000000 -0500
@@ -376,7 +376,7 @@
 		if (put_xilinx_data(chip, port, 8, data) < 0)
 			return -EINVAL;
 		/* don't take too much time in this loop... */
-		if (need_resched()) {
+		if (ALSA_NEED_RESCHED()) {
 			if (current->state != TASK_RUNNING)
 				set_current_state(TASK_RUNNING);
 			schedule();

----------------------------------------------

Thanks to Kelledin and the Axp-list@redhat.com

but i'm stil getting this error when using alsaplayer:

ALSA lib pcm_hw.c:324:(snd_pcm_hw_hw_params) SNDRV_PCM_IOCTL_HW_PARAMS failed: 
Cannot allocate memory
Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 32
CHANNELS: 2
RATE: 44100
PERIOD_TIME: (23219 23220)
PERIOD_SIZE: 1024
PERIOD_BYTES: 4096
PERIODS: 8
BUFFER_TIME: (185759 185760)
BUFFER_SIZE: 8192
BUFFER_BYTES: 32768
TICK_TIME: 976
failed to configure output device...trying OSS
error setting sample_rate
failed to configure output device...trying OSS

And sfxload gives this error:

pci_map_single failed:could not allocate dma page tables

I'm using a 164SX ALPHA with Debian Woody and trying to use a emu10k1

What is the way to solve these problems ? 

Met Vriendelijke Zwerversgroeten
 
Wouter Rademaker

Snel-post:    egel@scoutnet.nl

    \ / \ /
    >O< >O<
  *{_}   {_}*



------------------------------------------
This message was sent by Scoutnet Webmail.
http://www.scoutnet.nl                    




-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
