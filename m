From: MARUBAYASHI Takamichi <exarias@ps.ksky.ne.jp>
Subject: Patch for snd-serialmidi
Date: Thu, 24 Oct 2002 21:26:14 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021024212614.25e04ccd.exarias@ps.ksky.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello,

A module parameter doesn't chenge from 'snd_sdev' to 'sdev' in the snd-serialmidi.
And, this parameter isn't registered with MODULE_PARM.

--- drivers/serialmidi.c.orig	2002-10-22 23:25:55.000000000 +0900
+++ drivers/serialmidi.c	2002-10-23 23:23:32.000000000 +0900
@@ -52,20 +52,23 @@
 static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX;		/* Index 0-MAX */
 static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR;		/* ID for this card */
 static int enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE;	/* Enable this card */
-static char *snd_sdev[SNDRV_CARDS] = {"/dev/ttyS0", [1 ... (SNDRV_CARDS - 1)] = ""}; /* serial device */
+static char *sdev[SNDRV_CARDS] = {"/dev/ttyS0", [1 ... (SNDRV_CARDS - 1)] = ""}; /* serial device */
 static int speed[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 38400}; /* 9600,19200,38400,57600,115200 */
 static int adaptor[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = SERIAL_ADAPTOR_SOUNDCANVAS};
 static int outs[SNDRV_CARDS] = {[0 ... (SNDRV_CARDS - 1)] = 1};     /* 1 to 16 */
 
 MODULE_PARM(index, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(index, "Index value for MPU-401 device.");
+MODULE_PARM_DESC(index, "Index value for serial device.");
 MODULE_PARM_SYNTAX(index, SNDRV_INDEX_DESC);
 MODULE_PARM(id, "1-" __MODULE_STRING(SNDRV_CARDS) "s");
-MODULE_PARM_DESC(id, "ID string for MPU-401 device.");
+MODULE_PARM_DESC(id, "ID string for serial device.");
 MODULE_PARM_SYNTAX(id, SNDRV_ID_DESC);
 MODULE_PARM(enable, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
-MODULE_PARM_DESC(enable, "Enable MPU-401 device.");
+MODULE_PARM_DESC(enable, "Enable serial device.");
 MODULE_PARM_SYNTAX(enable, SNDRV_ENABLE_DESC);
+MODULE_PARM(sdev, "1-" __MODULE_STRING(SNDRV_CARDS) "s");
+MODULE_PARM_DESC(sdev, "Device file string for serial device.");
+MODULE_PARM_SYNTAX(sdev, SNDRV_ID_DESC);
 MODULE_PARM(speed, "1-" __MODULE_STRING(SNDRV_CARDS) "i");
 MODULE_PARM_DESC(speed, "Speed in bauds.");
 MODULE_PARM_SYNTAX(speed, SNDRV_ENABLED ",allows:{9600,19200,38400,57600,115200},dialog:list");
@@ -493,7 +496,7 @@
 	strcpy(card->shortname, card->driver);
 
 	if ((err = snd_serialmidi_create(card,
-					 snd_sdev[dev],
+					 sdev[dev],
 					 speed[dev],
 					 adaptor[dev],
 					 outs[dev],
@@ -502,7 +505,7 @@
 		return err;
 	}
 
-	sprintf(card->longname, "%s at %s", card->shortname, snd_sdev[dev]);
+	sprintf(card->longname, "%s at %s", card->shortname, sdev[dev]);
 	if ((err = snd_card_register(card)) < 0) {
 		snd_card_free(card);
 		return err;
@@ -544,7 +547,7 @@
 #ifndef MODULE
 
 /* format is: snd-serialmidi=enable,index,id,
-			     snd_sdev,speed,adaptor,outs */
+			     sdev,speed,adaptor,outs */
 
 static int __init alsa_card_serialmidi_setup(char *str)
 {
@@ -555,7 +558,7 @@
 	(void)(get_option(&str,&enable[nr_dev]) == 2 &&
 	       get_option(&str,&index[nr_dev]) == 2 &&
 	       get_id(&str,&id[nr_dev]) == 2 &&
-	       get_id(&str,&snd_sdev[nr_dev]) == 2 &&
+	       get_id(&str,&sdev[nr_dev]) == 2 &&
 	       get_option(&str,&speed[nr_dev]) == 2 &&
 	       get_option(&str,&adaptor[nr_dev]) == 2 &&
 	       get_option(&str,&outs[nr_dev]) == 2);


-------------------------------------------------------
This sf.net email is sponsored by: Influence the future 
of Java(TM) technology. Join the Java Community 
Process(SM) (JCP(SM)) program now. 
http://ad.doubleclick.net/clk;4729346;7592162;s?http://www.sun.com/javavote
