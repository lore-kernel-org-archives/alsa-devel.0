From: Giuliano Pochini <pochini@shiny.it>
Subject: [PATCH] echoaudio cleanup
Date: Sun, 13 Feb 2005 21:46:12 +0100
Message-ID: <20050213214612.5eddf224.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


- Trivial cleanup: move some duplicated defines into echoaudio.h



Signed-off-by: Giuliano Pochini <pochini@shiny.it>

diff -du alsa-driver_orig/pci/echoaudio/darla20.c alsa-driver/pci/echoaudio/darla20.c
--- alsa-driver_orig/pci/echoaudio/darla20.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/darla20.c	Sun Feb 13 21:08:00 2005
@@ -35,17 +35,6 @@
 #define BX_DIGITAL_IN	10	/* 0 */
 #define BX_NUM		10
 
-/* Number of channels */
-#define NUM_PIPES	PX_NUM
-#define NUM_PIPES_OUT	(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN	(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT	(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN	(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
 
 #include <sound/driver.h>
 #include <linux/delay.h>
diff -du alsa-driver_orig/pci/echoaudio/darla24.c alsa-driver/pci/echoaudio/darla24.c
--- alsa-driver_orig/pci/echoaudio/darla24.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/darla24.c	Sun Feb 13 21:08:00 2005
@@ -39,17 +39,6 @@
 #define BX_DIGITAL_IN	10	/* 0 */
 #define BX_NUM		10
 
-/* Number of channels */
-#define NUM_PIPES	PX_NUM
-#define NUM_PIPES_OUT	(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN	(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT	(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN	(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
 
 #include <sound/driver.h>
 #include <linux/delay.h>
diff -du alsa-driver_orig/pci/echoaudio/echoaudio.h alsa-driver/pci/echoaudio/echoaudio.h
--- alsa-driver_orig/pci/echoaudio/echoaudio.h	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/echoaudio.h	Sun Feb 13 21:08:00 2005
@@ -288,6 +288,17 @@
 #define PIPE_STATE_STARTED	2	// Pipe has been started
 #define PIPE_STATE_PENDING	3	// Pipe has pending start
 
+/* Number of channels */
+#define NUM_PIPES		PX_NUM
+#define NUM_PIPES_OUT		(PX_ANALOG_IN - PX_ANALOG_OUT)
+#define NUM_PIPES_IN		(PX_NUM - PX_ANALOG_IN)
+#define NUM_BUSSES_OUT		(BX_ANALOG_IN - BX_ANALOG_OUT)
+#define NUM_BUSSES_IN		(BX_NUM - BX_ANALOG_IN)
+#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
+#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
+#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
+#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
+
 
 /* Debug initialization */
 #if (CONFIG_SND_DEBUG)
diff -du alsa-driver_orig/pci/echoaudio/gina20.c alsa-driver/pci/echoaudio/gina20.c
--- alsa-driver_orig/pci/echoaudio/gina20.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/gina20.c	Sun Feb 13 21:08:00 2005
@@ -39,17 +39,6 @@
 #define BX_DIGITAL_IN	12	/* 2 */
 #define BX_NUM		14
 
-/* Number of channels */
-#define NUM_PIPES	PX_NUM
-#define NUM_PIPES_OUT	(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN	(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT	(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN	(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
 
 #include <sound/driver.h>
 #include <linux/delay.h>
diff -du alsa-driver_orig/pci/echoaudio/gina24.c alsa-driver/pci/echoaudio/gina24.c
--- alsa-driver_orig/pci/echoaudio/gina24.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/gina24.c	Sun Feb 13 21:08:00 2005
@@ -46,18 +46,6 @@
 #define BX_NUM		26
 
 
-/* Number of channels */
-#define NUM_PIPES	PX_NUM
-#define NUM_PIPES_OUT	(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN	(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT	(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN	(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
-
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff -du alsa-driver_orig/pci/echoaudio/gina3g.c alsa-driver/pci/echoaudio/gina3g.c
--- alsa-driver_orig/pci/echoaudio/gina3g.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/gina3g.c	Sun Feb 13 21:08:00 2005
@@ -48,18 +48,6 @@
 #define BX_NUM		24
 
 
-/* Number of channels */
-#define NUM_PIPES		PX_NUM
-#define NUM_PIPES_OUT		(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN		(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT		(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN		(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
-
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff -du alsa-driver_orig/pci/echoaudio/indigo.c alsa-driver/pci/echoaudio/indigo.c
--- alsa-driver_orig/pci/echoaudio/indigo.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/indigo.c	Sun Feb 13 21:08:00 2005
@@ -38,18 +38,6 @@
 #define BX_NUM		2
 
 
-/* Number of channels */
-#define NUM_PIPES		PX_NUM
-#define NUM_PIPES_OUT		(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN		(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT		(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN		(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
-
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff -du alsa-driver_orig/pci/echoaudio/indigodj.c alsa-driver/pci/echoaudio/indigodj.c
--- alsa-driver_orig/pci/echoaudio/indigodj.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/indigodj.c	Sun Feb 13 21:08:00 2005
@@ -38,18 +38,6 @@
 #define BX_NUM		4
 
 
-/* Number of channels */
-#define NUM_PIPES		PX_NUM
-#define NUM_PIPES_OUT		(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN		(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT		(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN		(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
-
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff -du alsa-driver_orig/pci/echoaudio/indigoio.c alsa-driver/pci/echoaudio/indigoio.c
--- alsa-driver_orig/pci/echoaudio/indigoio.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/indigoio.c	Sun Feb 13 21:08:00 2005
@@ -39,18 +39,6 @@
 #define BX_NUM		4
 
 
-/* Number of channels */
-#define NUM_PIPES		PX_NUM
-#define NUM_PIPES_OUT		(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN		(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT		(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN		(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
-
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff -du alsa-driver_orig/pci/echoaudio/layla20.c alsa-driver/pci/echoaudio/layla20.c
--- alsa-driver_orig/pci/echoaudio/layla20.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/layla20.c	Sun Feb 13 21:23:44 2005
@@ -44,17 +44,6 @@
 #define BX_DIGITAL_IN	20	/*  2 */
 #define BX_NUM		22
 
-/* Number of channels */
-#define NUM_PIPES	PX_NUM
-#define NUM_PIPES_OUT	(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN	(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT	(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN	(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
 
 #include <sound/driver.h>
 #include <linux/delay.h>
diff -du alsa-driver_orig/pci/echoaudio/layla24.c alsa-driver/pci/echoaudio/layla24.c
--- alsa-driver_orig/pci/echoaudio/layla24.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/layla24.c	Sun Feb 13 21:08:00 2005
@@ -46,17 +46,6 @@
 #define BX_DIGITAL_IN	24	/* 8 */
 #define BX_NUM		32
 
-/* Number of channels */
-#define NUM_PIPES	PX_NUM
-#define NUM_PIPES_OUT	(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN	(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT	(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN	(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
 
 #include <sound/driver.h>
 #include <linux/delay.h>
diff -du alsa-driver_orig/pci/echoaudio/layla3g.c alsa-driver/pci/echoaudio/layla3g.c
--- alsa-driver_orig/pci/echoaudio/layla3g.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/layla3g.c	Sun Feb 13 21:08:00 2005
@@ -47,18 +47,6 @@
 #define BX_NUM		32
 
 
-/* Number of channels */
-#define NUM_PIPES		PX_NUM
-#define NUM_PIPES_OUT		(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN		(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT		(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN		(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
-
 #include <sound/driver.h>
 #include <linux/delay.h>
 #include <linux/init.h>
diff -du alsa-driver_orig/pci/echoaudio/mia.c alsa-driver/pci/echoaudio/mia.c
--- alsa-driver_orig/pci/echoaudio/mia.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/mia.c	Sun Feb 13 21:08:00 2005
@@ -44,17 +44,6 @@
 #define BX_DIGITAL_IN	6	/* 2 */
 #define BX_NUM		8
 
-/* Number of channels */
-#define NUM_PIPES	PX_NUM
-#define NUM_PIPES_OUT	(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN	(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT	(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN	(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
 
 #include <sound/driver.h>
 #include <linux/delay.h>
diff -du alsa-driver_orig/pci/echoaudio/mona.c alsa-driver/pci/echoaudio/mona.c
--- alsa-driver_orig/pci/echoaudio/mona.c	Sun Feb 13 21:17:04 2005
+++ alsa-driver/pci/echoaudio/mona.c	Sun Feb 13 21:08:00 2005
@@ -43,17 +43,6 @@
 #define BX_DIGITAL_IN	18	/* 8 */
 #define BX_NUM		26
 
-/* Number of channels */
-#define NUM_PIPES	PX_NUM
-#define NUM_PIPES_OUT	(PX_ANALOG_IN - PX_ANALOG_OUT)
-#define NUM_PIPES_IN	(PX_NUM - PX_ANALOG_IN)
-#define NUM_BUSSES_OUT	(BX_ANALOG_IN - BX_ANALOG_OUT)
-#define NUM_BUSSES_IN	(BX_NUM - BX_ANALOG_IN)
-#define NUM_ANALOG_BUSSES_OUT	(BX_DIGITAL_OUT - BX_ANALOG_OUT)
-#define NUM_ANALOG_BUSSES_IN	(BX_DIGITAL_IN - BX_ANALOG_IN)
-#define NUM_DIGITAL_BUSSES_OUT	(NUM_BUSSES_OUT - NUM_ANALOG_BUSSES_OUT)
-#define NUM_DIGITAL_BUSSES_IN	(NUM_BUSSES_IN - NUM_ANALOG_BUSSES_IN)
-
 
 #include <sound/driver.h>
 #include <linux/delay.h>




--
Giuliano.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
