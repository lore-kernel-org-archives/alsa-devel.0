From: Daniel Mack <zonque@gmail.com>
Subject: Re: snd-usb-audio probe problem (Teac UD-H01)
Date: Sun, 10 Jun 2012 22:26:11 +0200
Message-ID: <4FD502E3.40704@gmail.com>
References: <4F774ABE.6070905@circa.be> <4F795F55.2040208@ladisch.de>
	<4F819F7A.4020707@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020505060306090203020404"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f51.google.com (mail-ee0-f51.google.com [74.125.83.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 0565924817
	for <alsa-devel@alsa-project.org>;
	Sun, 10 Jun 2012 22:26:24 +0200 (CEST)
Received: by eekc1 with SMTP id c1so1493057eek.38
	for <alsa-devel@alsa-project.org>; Sun, 10 Jun 2012 13:26:24 -0700 (PDT)
In-Reply-To: <4F819F7A.4020707@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: bEN <ml_all@circa.be>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020505060306090203020404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 08.04.2012 16:23, Daniel Mack wrote:
> On 02.04.2012 10:12, Clemens Ladisch wrote:
>> bEN wrote:
>>> the new USB DAC from Teac seems detected as 'Human Interface Device'
>>> instead of 'Audio'.
>>
>> It has both HID and audio interfaces.
>>
>>> Despite the fact it is based on a standard USB Audio
>>> class v2 controller (Tenor 8802).
>>
>> Which doesn't prevent Teac from writing buggy firmware.
>>
>>> $ dmesg
>>> usb 2-4: new high speed USB device using ehci_hcd and address 3
>>> usb 2-4: config 1 has an invalid interface number: 3 but max is 2
>>> usb 2-4: config 1 has no interface number 1
>>
>> This violates the USB spec.  But I guess it shouldn't prevent the driver
>> from attaching to the device.
> 
> Right, that's just a warning.
> 
>>> Audio class v2 interfaces need an interface association
>>
>> This looks like a bug in the driver; there certainly is such
>> an descriptor.  Daniel?
> 
> The USB audio driver actually just uses functions from the USB driver
> core to access the interface association. However, the USB core didn't
> assign it during its probe, which is most probably a result of the
> broken descriptor set.

And it turned out it is.

Ben, can you try the patch below, please? It's a pretty obvious flaw in
the USB core system which is triggered by buggy descriptors.


Daniel


--------------020505060306090203020404
Content-Type: text/x-patch;
 name="intf-assoc-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="intf-assoc-fix.patch"

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index b548cf1..8eb1a1e 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1838,7 +1838,6 @@ free_interfaces:
 		intfc = cp->intf_cache[i];
 		intf->altsetting = intfc->altsetting;
 		intf->num_altsetting = intfc->num_altsetting;
-		intf->intf_assoc = find_iad(dev, cp, i);
 		kref_get(&intfc->ref);
 
 		alt = usb_altnum_to_altsetting(intf, 0);
@@ -1851,6 +1850,9 @@ free_interfaces:
 		if (!alt)
 			alt = &intf->altsetting[0];
 
+		intf->intf_assoc =
+			find_iad(dev, cp, alt->desc.bInterfaceNumber);
+
 		intf->cur_altsetting = alt;
 		usb_enable_interface(dev, intf, true);
 		intf->dev.parent = &dev->dev;

--------------020505060306090203020404
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------020505060306090203020404--
