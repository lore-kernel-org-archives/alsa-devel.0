From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH] USB: fix gathering of interface associations
Date: Tue, 12 Jun 2012 20:23:52 +0200
Message-ID: <1339525432-22039-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
	by alsa0.perex.cz (Postfix) with ESMTP id 7D42324749
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Jun 2012 20:24:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-usb@vger.kernel.org
Cc: alsa-devel@alsa-project.org, ivanperrone@hotmail.com, sarah.a.sharp@linux.intel.com, gregkh@linuxfoundation.org, ml_all@circa.be, Daniel Mack <zonque@gmail.com>, stern@rowland.harvard.edu
List-Id: alsa-devel@alsa-project.org

TEAC's UD-H01 (and probably other devices) have a gap in the interface
number allocation of their descriptors:

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

Once a configuration is selected, usb_set_configuration() walks the
known interfaces of a given configuration and calls find_iad() on
each of them to set the interface association pointer the interface
is included in.

The problem here is that the loop variable is taken for the interface
number in the comparison logic that gathers the association. Which is
fine as long as the descriptors are sane.

In the case above, however, the logic gets out of sync and the
interface association fields of all interfaces beyond the interface
number gap are wrong.

Fix this by passing the interface's bInterfaceNumber to find_iad()
instead.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Reported-by: bEN <ml_all@circa.be>
Reported-by: Ivan Perrone <ivanperrone@hotmail.com>
---

This patch has been tested on a virtual USB device emulated in QEMU.
I'm still waiting for test results based on real hardware, but the bug
is rather obvious is and the fix really simple.

Daniel

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
