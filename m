From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] fix USB card short/longname
Date: Wed, 21 Jan 2004 09:04:25 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0401210902230.5451-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


- fix buffer overflow (with "0x" prefix, component would need 17
  chars)
- rewrite shortname logic
- include product name in longname even if card doesn't have a quirk


Index: alsa-kernel/usb/usbaudio.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/usb/usbaudio.c,v
retrieving revision 1.75
diff -u -r1.75 usbaudio.c
--- alsa-kernel/usb/usbaudio.c	19 Jan 2004 19:33:45 -0000	1.75
+++ alsa-kernel/usb/usbaudio.c	21 Jan 2004 07:46:27 -0000
@@ -2738,23 +2738,21 @@
 	}

 	strcpy(card->driver, "USB-Audio");
-	sprintf(component, "USB%#04x:%#04x",
+	sprintf(component, "USB%04x:%04x",
 		dev->descriptor.idVendor, dev->descriptor.idProduct);
 	snd_component_add(card, component);

 	/* retrieve the device string as shortname */
  	if (quirk && quirk->product_name) {
-		len = strlcpy(card->shortname, quirk->product_name, sizeof(card->shortname));
+		strlcpy(card->shortname, quirk->product_name, sizeof(card->shortname));
 	} else {
-		if (dev->descriptor.iProduct)
-			len = usb_string(dev, dev->descriptor.iProduct,
-					 card->shortname, sizeof(card->shortname));
-		else
-			len = 0;
-	}
-	if (len <= 0) {
-		sprintf(card->shortname, "USB Device %#04x:%#04x",
-			dev->descriptor.idVendor, dev->descriptor.idProduct);
+		if (!dev->descriptor.iProduct ||
+		    usb_string(dev, dev->descriptor.iProduct,
+      			       card->shortname, sizeof(card->shortname)) <= 0) {
+			/* no name available from anywhere, so use ID */
+			sprintf(card->shortname, "USB Device %#04x:%#04x",
+				dev->descriptor.idVendor, dev->descriptor.idProduct);
+		}
 	}

 	/* retrieve the vendor and device strings as longname */
@@ -2766,14 +2764,12 @@
 					 card->longname, sizeof(card->longname));
 		else
 			len = 0;
+		/* we don't really care if there isn't any vendor string */
 	}
 	if (len > 0)
 		strlcat(card->longname, " ", sizeof(card->longname));

-	len = strlen(card->longname);
-
-	if (quirk && quirk->product_name)
-		strlcat(card->longname, quirk->product_name, sizeof(card->longname));
+	strlcat(card->longname, card->shortname, sizeof(card->longname));

 	len = strlcat(card->longname, " at ", sizeof(card->longname));





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
