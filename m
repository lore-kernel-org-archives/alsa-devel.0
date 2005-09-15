From: Nicolas Pitre <nico@cam.org>
Subject: [PATCH] remove redundent assignment to the ac97 device structure
Date: Wed, 14 Sep 2005 22:06:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509142157071.31877@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Don't use dev.platform_data to store a reference to the containing 
ac97_t structure.  Such assignment is redundent since we can deduce the 
ac97_t structure location from the contained device structure.  This 
sets platform_data free for other purposes.

Signed-off-by: Nicolas Pitre <nico@cam.org>

Index: linux-2.6/sound/pci/ac97/ac97_codec.c
===================================================================
--- linux-2.6.orig/sound/pci/ac97/ac97_codec.c
+++ linux-2.6/sound/pci/ac97/ac97_codec.c
@@ -1828,7 +1828,6 @@
 
 	ac97->dev.bus = &ac97_bus_type;
 	ac97->dev.parent = ac97->bus->card->dev;
-	ac97->dev.platform_data = ac97;
 	ac97->dev.release = ac97_device_release;
 	snprintf(ac97->dev.bus_id, BUS_ID_SIZE, "card%d-%d", ac97->bus->card->number, ac97->num);
 	if ((err = device_register(&ac97->dev)) < 0) {
Index: linux-2.6/include/sound/ac97_codec.h
===================================================================
--- linux-2.6.orig/include/sound/ac97_codec.h
+++ linux-2.6/include/sound/ac97_codec.h
@@ -527,6 +527,8 @@
 	struct device dev;
 };
 
+#define to_ac97_t(d) container_of(d, struct _snd_ac97, dev)
+
 /* conditions */
 static inline int ac97_is_audio(ac97_t * ac97)
 {


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
