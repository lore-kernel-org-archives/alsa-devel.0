From: Chris Rankin <rankincj@yahoo.com>
Subject: [PATCH] snd-sscape.o and snd-pnp.o
Date: Sun, 18 May 2003 22:26:26 +0100 (BST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200305182126.h4ILQQku010611@wittsend.radionet>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

I have managed to enable the SoundScape driver on my machine. It wasn't too difficult,
once I worked out why it was refusing to find the sound card on the ISA-PnP bus. The
PnP compatibility module appears to implement the new API on an as-needed basis,
and so I have added suuport for the PNP_DRIVER_RES_DO_NOT_CHANGE flag. I
hope that I have understood this flag correctly. The idea is that it's better to load the
firmware once at boot-time and then keep the device active.

Cheers,
Chris

Index: isa/sscape.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/isa/sscape.c,v
retrieving revision 1.15
diff -u -r1.15 sscape.c
--- isa/sscape.c	15 May 2003 15:02:56 -0000	1.15
+++ isa/sscape.c	18 May 2003 21:12:01 -0000
@@ -1431,7 +1431,7 @@
 }
 
 static struct pnp_card_driver sscape_pnpc_driver = {
-	.flags = PNP_DRIVER_RES_DISABLE,
+	.flags = PNP_DRIVER_RES_DO_NOT_CHANGE,
 	.name = "sscape",
 	.id_table = sscape_pnpids,
 	.probe = sscape_pnp_detect,
Index: support/pnp/pnp.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/support/pnp/pnp.c,v
retrieving revision 1.9
diff -u -r1.9 pnp.c
--- support/pnp/pnp.c	9 May 2003 14:06:51 -0000	1.9
+++ support/pnp/pnp.c	18 May 2003 21:12:30 -0000
@@ -111,7 +111,7 @@
 	if (c >= 'A' && c <= 'F')
 		return (c - 'A') + 10;
 	if (c >= 'a' && c <= 'f')
-		return (c = 'a') + 10;
+		return (c - 'a') + 10;
 	return 0x0f;
 }
 
@@ -145,7 +145,9 @@
 	if (parse_id(id, &vendor, &function) < 0)
 		return NULL;
 	dev = (struct pnp_dev *)isapnp_find_dev((struct isapnp_card *)clink->card, vendor, function, (struct isapnp_dev *)from);
-	if (dev->p.active)
+	if ( (dev != NULL) &&
+	     (dev->p.active) &&
+	     !(clink->driver->flags & PNP_DRIVER_RES_DO_NOT_CHANGE) )
 		return NULL;
 	return dev;
 }
@@ -204,6 +206,10 @@
 			}
 		} while (card != NULL);
 	}
+
+	if (ninst != NULL)
+		kfree(ninst);
+ 
 	return res;
 }
 
@@ -218,8 +224,9 @@
 		if (inst->link.driver == drv) {
 			list_del(p);
 			drv->remove(&inst->link);
-			for (i = 0; i < PNP_MAX_DEVICES && inst->devs[i]; i++)
-				pnp_release_card_device(inst->devs[i]);
+			if ( !(drv->flags & PNP_DRIVER_RES_DO_NOT_CHANGE) )
+				for (i = 0; i < PNP_MAX_DEVICES && inst->devs[i]; i++)
+					pnp_release_card_device(inst->devs[i]);
 			kfree(inst);
 		}
 	}


-------------------------------------------------------
This SF.net email is sponsored by: If flattening out C++ or Java
code to make your application fit in a relational database is painful, 
don't do it! Check out ObjectStore. Now part of Progress Software.
http://www.objectstore.net/sourceforge
