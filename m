From: Sampo Savolainen <v2@iki.fi>
Subject: M-Audio USB Quattro on 2.6.x
Date: Mon, 16 Feb 2004 18:50:50 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1076950250.683.38.camel@puppeli>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-/F3GYBnihDVU3ZwH3CC8"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-usb-devel <linux-usb-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-/F3GYBnihDVU3ZwH3CC8
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hello to both alsa-devel and linux-usb-devel,


As most of you who have seen the words "USB Quattro" and "2.6.x"
together know, these two don't mix well. I have been investigating this
issue for some time and here are a few conclusions:

 1. The Quattro's alternate settings (usb jargon) are wrong
    (not-in-spec), and kernel doesn't accept the device.
 2. M-Audio says that it has done nothing wrong and haven't issued
    firmware updates (which as far as I know, are not possible on
    the Quattro).
 3. USB-IF says that M-Audio are violating the specs, but they can't
    force them to correct these issues because the USB logo is not
    on the device (that requires licensing and compliance). Only the
    USB trident is on the box, and that doesn't apply.

USB-IF has said, that these kinds of misinterpretations of the spec are
normal, and most operating systems just work around them. This isn't
'the right way to do it', but at the moment it seems like the only way
to do it.

To remedy this situation I've been working on a patch to the usb core.
The patch is attached as a part of this mail. This patch is not finished
yet, it has an unloading issue! This is why I'm writing this mail to you
all.

This patch is for Linux 2.6.2, it patches drivers/usb/core/config.c
(cd linux-2.6.2; patch -p0 < ../whereisit?/usbconfig.patch)

The changes I've made are commented, but here's a short list:
(All changes are for the code that configures new USB devices)

- Instead of counting how many alternate settings each interface has, it
  sets the number of alternate settings to (largest found altsetting)+1.
- Thus all the alternate settings are saved at the corresponding cell of
  the interface->altsetting pointer. If an altsetting is missing, that
  cell will be left blank.
- After parsing each alternate setting, instead of reporting an error
  for unset altsettings, the code truncates the list. If the list
  was modified, a new pointer will be allocated and the old one will be
  freed.

With this patch, I've got my Quattro working.
The problem is this:
If snd_usb_audio finds the soundcard, the card works well, until it is
removed. The kernel will see the device disconnect, but after that you
cannot reconnect the device. Nothing comes in the logs from connecting
the cable. Also, removing the snd_usb_audio module will result in the
command hanging. Not even 'kill -KILL [pid]' as root will kill the
process.

If snd_usb_audio isn't loaded, the soundcard can be reconnected again
and again and again without any problems-

I can think of a few things that could go wrong
 - I've missed something that the USB drivers do with the descriptor
   afterwards, especially when the descirptor is given to the
   approriate registered driver. Some checks aren't done because all
   devices should have all alternate settings?... 
 - The snd_usb_audio driver does something wild when all alternative
   settings aren't set.
 - Not much testing has been done on snd_usb_audio on 2.[56].x because
   the Quattro hasn't worked at all.

Could someone with more experience in this area help me?


 Thank you,
   Sampo Savolainen


--=-/F3GYBnihDVU3ZwH3CC8
Content-Disposition: attachment; filename=usbconfig.patch
Content-Type: text/x-patch; name=usbconfig.patch; charset=
Content-Transfer-Encoding: 7bit

--- ../ko/linux-2.6.2/drivers/usb/core/config.c	2004-02-04 05:43:06.000000000 +0200
+++ drivers/usb/core/config.c	2004-02-16 16:36:15.000000000 +0200
@@ -202,8 +202,9 @@
 int usb_parse_configuration(struct usb_host_config *config, char *buffer, int size)
 {
 	int nintf, nintf_orig;
-	int i, j;
+	int i, j, k; // added k, v2 18:52 2004-02-15
 	struct usb_interface *interface;
+	struct usb_host_interface *altsetbuf; // added, v2 12:17 2004-02-16
 	char *buffer2;
 	int size2;
 	struct usb_descriptor_header *header;
@@ -265,8 +266,20 @@
 				    i, nintf_orig);
 				return -EINVAL;
 			}
-			if (i < nintf)
-				++config->interface[i]->num_altsetting;
+			if (i < nintf) {
+				// modified, v2 18:19 2004-02-15
+				// instead of increasing the number of altsettings by one per alternate setting
+				// found, set the number to largest found altsetting plus one
+				// Example:
+				// d->bAlternateSetting = 0,1,3
+				// config->interface[i]->num_altsetting = 4
+
+				if (config->interface[i]->num_altsetting < d->bAlternateSetting+1)
+					config->interface[i]->num_altsetting = d->bAlternateSetting+1;
+				
+				// old code
+				//++config->interface[i]->num_altsetting;
+			}
 
 		} else if ((header->bDescriptorType == USB_DT_DEVICE ||
 		    header->bDescriptorType == USB_DT_CONFIG) && j) {
@@ -340,12 +353,40 @@
 	/* Check for missing altsettings */
 	for (i = 0; i < nintf; ++i) {
 		interface = config->interface[i];
+		size2 = interface->num_altsetting;
 		for (j = 0; j < interface->num_altsetting; ++j) {
 			if (!interface->altsetting[j].desc.bLength) {
+				// new code, v2 18:54 2004-02-15
+				// move interfaces at j+1..interface->num_altsetting one left and 
+				// decrease interface->num_altsetting by one
+				
+				warn("missing altsetting %d for interface %d, moving alternate settings left", j, i);
+				--interface->num_altsetting;
+				for (k=j; k<interface->num_altsetting; ++k)
+					interface->altsetting[k] = interface->altsetting[k+1];
+				--j;
+				
+				/* old code
 				warn("missing altsetting %d for interface %d", j, i);
 				return -EINVAL;
+				*/
 			}
 		}
+		if (size2 != interface->num_altsetting) {
+			// new code, v2 12:34 2004-02-16
+			// allocate new interface->altsetting with the truncated size and free
+			// the old buffer
+			len = sizeof(*interface->altsetting) * interface->num_altsetting;
+			
+			altsetbuf = interface->altsetting;
+			interface->altsetting = kmalloc(len, GFP_KERNEL);
+			memcpy(interface->altsetting,altsetbuf,len);
+
+			kfree(altsetbuf);
+			
+			warn("truncated alternate settings on interface %d from %d to %d",
+			     i,size2,interface->num_altsetting);
+		}
 	}
 
 	return size;
@@ -484,3 +525,4 @@
 	return result;
 }
 
+

--=-/F3GYBnihDVU3ZwH3CC8--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
