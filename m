From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] Use "safe" Linux min() macro in Linux 2.2, 2.4
Date: Mon, 7 Oct 2002 00:00:33 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210062300.g96N0XjD001410@wittsend.radionet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: perex@perex.cz
List-Id: alsa-devel@alsa-project.org

Hi,

I have modified the SoundScape (proto-)driver to use the typesafe Linux min() macro, defining
the macro if it hasn't been declared already. (This is compatibility for Linux 2.2.) In fact, it turns
out that both min() and ARRAY_SIZE() are declared in include/linux/kernel.h and so I suppose
that both these macros are candidates for putting in adriver.h instead.

Cheers,
Chris

Index: alsa-driver/isa/sscape.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/isa/sscape.c,v
retrieving revision 1.6
diff -u -u -r1.6 sscape.c
--- alsa-driver/isa/sscape.c	4 Oct 2002 12:45:16 -0000	1.6
+++ alsa-driver/isa/sscape.c	6 Oct 2002 22:55:41 -0000
@@ -72,6 +72,18 @@
 #  define ARRAY_SIZE(a)  (sizeof(a) / sizeof(a[0]))
 #endif
 
+#ifndef min
+	/*
+	 * This macro copied from the include/linux/kernel.h file
+	 * for compatibility with earlier kernels.
+	 */
+#  define min(x,y) ({ \
+	const typeof(x) _x = (x); \
+	const typeof(y) _y = (y); \
+	(void) (&_x == &_y); \
+	_x < _y ? _x : _y; })
+#endif
+
 #define MPU401_IO(i)     ((i) + 0)
 #define MIDI_DATA_IO(i)  ((i) + 0)
 #define MIDI_CTRL_IO(i)  ((i) + 1)
@@ -435,8 +447,8 @@
  * Upload a byte-stream into the SoundScape using DMA channel A.
  */
 static int upload_dma_data(struct soundscape *s,
-			   const unsigned char *data, unsigned long size,
-			   unsigned long dmasize)
+                           const unsigned char *data, unsigned long size,
+                           unsigned long dmasize)
 {
 	unsigned long flags;
 	struct dmabuf dma;
@@ -471,7 +483,7 @@
 	while (size != 0) {
 		unsigned long len;
 
-		len = size < dma.size ? size : dma.size;
+		len = min(size, dma.size);
 
 		/*
 		 * Remember that the data that we want to DMA
@@ -517,7 +529,7 @@
 		ret = -EAGAIN;
 	}
 
-      _release_dma:
+	_release_dma:
 	/*
 	 * NOTE!!! We are NOT holding any spinlocks at this point !!!
 	 */


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
