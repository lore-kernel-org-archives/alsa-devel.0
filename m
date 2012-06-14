From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] USB: fix gathering of interface associations
Date: Thu, 14 Jun 2012 13:15:30 +0200
Message-ID: <4FD9C7D2.8030506@gmail.com>
References: <1339525432-22039-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050305000101090703040603"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1339525432-22039-1-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, ml_all-+8pbQKgpUcE@public.gmane.org, ivanperrone-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, sergio tabanelli <sergio.tabanelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050305000101090703040603
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.06.2012 20:23, Daniel Mack wrote:
> TEAC's UD-H01 (and probably other devices) have a gap in the interface
> number allocation of their descriptors:

I now got a report from Sergio Tabanelli who tried this patch on real
hardware, and he confirmed the fix. I added some more people to the
patch description and copied stable@ as well.

Greg, can can this go through your tree?


Daniel


> 
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          220
>     bNumInterfaces          3
>     [...]
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       [...]
>     Interface Association:
>       bLength                 8
>       bDescriptorType        11
>       bFirstInterface         2
>       bInterfaceCount         2
>       bFunctionClass          1 Audio
>       bFunctionSubClass       0
>       bFunctionProtocol      32
>       iFunction               4
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       [...]
> 
> Once a configuration is selected, usb_set_configuration() walks the
> known interfaces of a given configuration and calls find_iad() on
> each of them to set the interface association pointer the interface
> is included in.
> 
> The problem here is that the loop variable is taken for the interface
> number in the comparison logic that gathers the association. Which is
> fine as long as the descriptors are sane.
> 
> In the case above, however, the logic gets out of sync and the
> interface association fields of all interfaces beyond the interface
> number gap are wrong.
> 
> Fix this by passing the interface's bInterfaceNumber to find_iad()
> instead.
> 
> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Reported-by: bEN <ml_all-+8pbQKgpUcE@public.gmane.org>
> Reported-by: Ivan Perrone <ivanperrone-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
> ---
> 
> This patch has been tested on a virtual USB device emulated in QEMU.
> I'm still waiting for test results based on real hardware, but the bug
> is rather obvious is and the fix really simple.
> 
> Daniel

--------------050305000101090703040603
Content-Type: text/x-patch;
 name="0001-USB-fix-gathering-of-interface-associations.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-USB-fix-gathering-of-interface-associations.patch"

>From bc5818593a73dfe895b329cd5f6c95b72d641e9e Mon Sep 17 00:00:00 2001
From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Date: Sun, 10 Jun 2012 22:31:15 +0200
Subject: [PATCH] USB: fix gathering of interface associations

TEAC's UD-H01 (and probably other devices) have a gap in the interface
number allocation in their descriptors:

  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          220
    bNumInterfaces          3
    [...]
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      [...]
    Interface Association:
      bLength                 8
      bDescriptorType        11
      bFirstInterface         2
      bInterfaceCount         2
      bFunctionClass          1 Audio
      bFunctionSubClass       0
      bFunctionProtocol      32
      iFunction               4
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        2
      bAlternateSetting       0
      [...]

Once a configuration is selected on this device, usb_set_configuration()
walks the known interfaces of a given configuration and calls find_iad()
on each of them to set the interface association pointer the interface
is included in.

The problem here is that the loop varibale index is taken for the
interface number in the comparison logic that gathers the association.
Which is fine as long as the descriptors are sane.

In the case above, however, the logic gets out of sync and the
interface association fields of all interfaces beyond the interface
number gap are wrong.

Fix this by passing the interface's bInterfaceNumber to find_iad()
instead.

Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Reported-by: bEN <ml_all-+8pbQKgpUcE@public.gmane.org>
Reported-by: Ivan Perrone <ivanperrone-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Tested-by: Sergio Tabanelli <sergio.tabanelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: <stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/usb/core/message.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index b548cf1..bdd1c67 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -1838,7 +1838,6 @@ free_interfaces:
 		intfc = cp->intf_cache[i];
 		intf->altsetting = intfc->altsetting;
 		intf->num_altsetting = intfc->num_altsetting;
-		intf->intf_assoc = find_iad(dev, cp, i);
 		kref_get(&intfc->ref);
 
 		alt = usb_altnum_to_altsetting(intf, 0);
@@ -1851,6 +1850,8 @@ free_interfaces:
 		if (!alt)
 			alt = &intf->altsetting[0];
 
+		intf->intf_assoc =
+			find_iad(dev, cp, alt->desc.bInterfaceNumber);
 		intf->cur_altsetting = alt;
 		usb_enable_interface(dev, intf, true);
 		intf->dev.parent = &dev->dev;
-- 
1.7.10.2


--------------050305000101090703040603--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
