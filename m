From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] remove snd_ prefix from module options
Date: Tue, 18 Feb 2003 18:12:34 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0302181809180.11247-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


This removes the (hopefully) last remains of the snd_ prefix.


Index: alsa-driver/pci/azt3328.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/azt3328.c,v
retrieving revision 1.4
diff -u -r1.4 azt3328.c
--- alsa-driver/pci/azt3328.c	31 Jan 2003 15:24:33 -0000	1.4
+++ alsa-driver/pci/azt3328.c	18 Feb 2003 17:03:34 -0000
@@ -1598,7 +1598,7 @@

 #ifndef MODULE

-/* format is: snd-azf3328=snd_enable,snd_index,snd_id */
+/* format is: snd-azf3328=enable,index,id */

 static int __init alsa_card_azf3328_setup(char *str)
 {
Index: alsa-kernel/drivers/mtpav.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/drivers/mtpav.c,v
retrieving revision 1.22
diff -u -r1.22 mtpav.c
--- alsa-kernel/drivers/mtpav.c	13 Feb 2003 09:14:16 -0000	1.22
+++ alsa-kernel/drivers/mtpav.c	18 Feb 2003 17:03:55 -0000
@@ -802,7 +802,7 @@

 #ifndef MODULE

-/* format is: snd-mtpav=snd_enable,index,id,
+/* format is: snd-mtpav=enable,index,id,
 			port,irq,hwports */

 static int __init alsa_card_mtpav_setup(char *str)
Index: alsa-kernel/include/initval.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/initval.h,v
retrieving revision 1.9
diff -u -r1.9 initval.h
--- alsa-kernel/include/initval.h	6 Jan 2003 09:45:16 -0000	1.9
+++ alsa-kernel/include/initval.h	18 Feb 2003 17:03:55 -0000
@@ -67,7 +67,7 @@
 #define SNDRV_BOOLEAN_TRUE_DESC	"allows:{{0,Disabled},{1,Enabled}},default:1,dialog:check"
 #define SNDRV_BOOLEAN_FALSE_DESC "allows:{{0,Disabled},{1,Enabled}},default:0,dialog:check"

-#define SNDRV_ENABLED		"enable:(snd_enable)"
+#define SNDRV_ENABLED		"enable:(enable)"

 #define SNDRV_INDEX_DESC	SNDRV_ENABLED ",allows:{{0,7}},unique,skill:required,dialog:list"
 #define SNDRV_ID_DESC		SNDRV_ENABLED ",unique"
Index: alsa-kernel/isa/dt019x.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/dt019x.c,v
retrieving revision 1.4
diff -u -r1.4 dt019x.c
--- alsa-kernel/isa/dt019x.c	21 Oct 2002 18:28:21 -0000	1.4
+++ alsa-kernel/isa/dt019x.c	18 Feb 2003 17:03:55 -0000
@@ -379,7 +379,7 @@

 #ifndef MODULE

-/* format is: snd-dt019x=enable,index,id,snd_isapnp,
+/* format is: snd-dt019x=enable,index,id,
 			  port,mpu_port,fm_port,
 			  irq,mpu_irq,dma8,dma8_size */

Index: alsa-kernel/isa/sgalaxy.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/sgalaxy.c,v
retrieving revision 1.14
diff -u -r1.14 sgalaxy.c
--- alsa-kernel/isa/sgalaxy.c	31 Jan 2003 15:19:45 -0000	1.14
+++ alsa-kernel/isa/sgalaxy.c	18 Feb 2003 17:03:55 -0000
@@ -44,7 +44,7 @@

 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;	/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;	/* ID for this card */
-static int snd_enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
+static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
 static long sbport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x220,0x240 */
 static long wssport[SNDRV_CARDS] = SNDRV_DEFAULT_PORT;	/* 0x530,0xe80,0xf40,0x604 */
 static int irq[SNDRV_CARDS] = SNDRV_DEFAULT_IRQ;	/* 7,9,10,11 */
@@ -300,7 +300,7 @@
 {
 	int dev, cards;

-	for (dev = cards = 0; dev < SNDRV_CARDS && snd_enable[dev]; dev++) {
+	for (dev = cards = 0; dev < SNDRV_CARDS && enable[dev]; dev++) {
 		if (snd_sgalaxy_probe(dev) >= 0)
 			cards++;
 	}
@@ -327,7 +327,7 @@

 #ifndef MODULE

-/* format is: snd-sgalaxy=snd_enable,index,id,
+/* format is: snd-sgalaxy=enable,index,id,
 			  sbport,wssport,
 			  irq,dma1 */

@@ -337,7 +337,7 @@

 	if (nr_dev >= SNDRV_CARDS)
 		return 0;
-	(void)(get_option(&str,&snd_enable[nr_dev]) == 2 &&
+	(void)(get_option(&str,&enable[nr_dev]) == 2 &&
 	       get_option(&str,&index[nr_dev]) == 2 &&
 	       get_id(&str,&id[nr_dev]) == 2 &&
 	       get_option(&str,(int *)&sbport[nr_dev]) == 2 &&
Index: alsa-kernel/isa/sb/es968.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/isa/sb/es968.c,v
retrieving revision 1.12
diff -u -r1.12 es968.c
--- alsa-kernel/isa/sb/es968.c	21 Oct 2002 18:28:22 -0000	1.12
+++ alsa-kernel/isa/sb/es968.c	18 Feb 2003 17:03:55 -0000
@@ -277,7 +277,7 @@
 #ifndef MODULE

 /* format is: snd-es968=enable,index,id,
-			port,irq,snd_dma1 */
+			port,irq,dma1 */

 static int __init alsa_card_es968_setup(char *str)
 {
Index: alsa-lib/src/control/cards.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/cards.c,v
retrieving revision 1.26
diff -u -r1.26 cards.c
--- alsa-lib/src/control/cards.c	12 Mar 2002 20:14:33 -0000	1.26
+++ alsa-lib/src/control/cards.c	18 Feb 2003 17:04:17 -0000
@@ -97,7 +97,7 @@
  * \return zero if success, otherwise a negative error code
  *
  * The accepted format is an integer value in ASCII representation
- * or the card identifier (snd_id parameter for sound-card drivers).
+ * or the card identifier (the id parameter for sound-card drivers).
  */
 int snd_card_get_index(const char *string)
 {




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
