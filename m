From: Thierry Vignaud <tvignaud@mandrakesoft.com>
Subject: [PATCHES] bogus includes cleaning
Date: Mon, 04 Nov 2002 09:30:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m2y989rb2v.fsf@vador.mandrakesoft.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--=-=-=

against 2.4.45, not cvs.

linux/config.h is *not* needed for these ones:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=snd_not_needed.diff

linux/config.h is *not* needed for these ones
--- ./sound/oss/ad1816.c.not_needed	2002-11-03 16:45:04.000000000 -0500
+++ ./sound/oss/ad1816.c	2002-11-03 16:45:15.000000000 -0500
@@ -32,7 +32,6 @@
  *	Arnaldo Carvalho de Melo: get rid of check_region	2001/10/07
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/isapnp.h>
--- ./sound/oss/wavfront.c.not_needed	2002-11-03 16:45:04.000000000 -0500
+++ ./sound/oss/wavfront.c	2002-11-03 16:45:18.000000000 -0500
@@ -78,7 +78,6 @@
 #include <linux/ioport.h>    
 #include <linux/spinlock.h>
 #include <linux/interrupt.h>
-#include <linux/config.h>
 
 #include <linux/delay.h>
 
--- ./sound/pci/rme9652/hammerfall_mem.c.not_needed	2002-11-03 16:45:04.000000000 -0500
+++ ./sound/pci/rme9652/hammerfall_mem.c	2002-11-03 16:45:21.000000000 -0500
@@ -34,7 +34,6 @@
     
 */
 
-#include <linux/config.h>
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/pci.h>
--- ./sound/sparc/amd7930.c.not_needed	2002-11-03 16:45:04.000000000 -0500
+++ ./sound/sparc/amd7930.c	2002-11-03 16:45:25.000000000 -0500
@@ -29,7 +29,6 @@
  * --- End of notes from Thoamas's original driver ---
  */
 
-#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>

--=-=-=


seq_timer.h is included more than once in sound/core/seq/seq_prioq.c:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=snd_seq.diff

seq_timer.h is included more than once.
--- sound/core/seq/seq_prioq.c.inclu	2002-11-03 16:36:00.000000000 -0500
+++ sound/core/seq/seq_prioq.c	2002-11-03 16:36:40.000000000 -0500
@@ -25,7 +25,6 @@
 #include <sound/core.h>
 #include "seq_timer.h"
 #include "seq_prioq.h"
-#include "seq_timer.h"
 
 
 /* Implementation is a simple linked list for now...

--=-=-=


sound/oss/i810_audio.c needs linux/init.h  for CONFIG_PM:

--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment; filename=snd_need.diff

linux/init.h is needed for CONFIG_P
--- sound/oss/i810_audio.c.tv	2002-11-03 16:30:21.000000000 -0500
+++ sound/oss/i810_audio.c	2002-11-03 16:30:23.000000000 -0500
@@ -78,6 +78,7 @@
 #include <linux/slab.h>
 #include <linux/soundcard.h>
 #include <linux/pci.h>
+#include <linux/config.h>
 #include <asm/io.h>
 #include <asm/dma.h>
 #include <linux/init.h>

--=-=-=--



-------------------------------------------------------
This SF.net email is sponsored by: ApacheCon, November 18-21 in
Las Vegas (supported by COMDEX), the only Apache event to be
fully supported by the ASF. http://www.apachecon.com
