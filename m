From: Thomas Rabe <raven@drehmoment.org>
Subject: Re: questions about usbmidi
Date: Wed, 09 Apr 2003 18:08:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E944564.3090707@drehmoment.org>
References: <Pine.HPX.4.33n.0304091624500.23768-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0304091624500.23768-100000@studcom.urz.uni-halle.de>
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

Clemens Ladisch wrote:
> Thomas Rabe wrote:
> 
>>I try to hack a little bit on Karstens tascam-us428 alsa patch and have
>>some problems to integrate usbmidi (usbaudio works). in the patch
>>(written for alsa rc3?) this was done with:
>>[...]
> 
>>	.in_ep = 0x86,
> 
> 
> This endpoint number must not include the USB_DIR_IN flag. Make this:
> 	.in_ep = 0x06,
> 
> If this is the only endpoint in the interface, you can omit the endpoint
> number and let the driver autodetect it.

i don't really know if autodetection will work (for the lsusb see 
below). the real problem are the kernel-oopses, the last message i get: 
ports are created.

8<------------------------------------------------------
Apr  9 17:57:05 konstruktor kernel: ALSA 
../alsa-kernel/usb/usbmidi.c:782: created 2 output and 2 input ports
Apr  9 17:57:05 konstruktor kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000004
Apr  9 17:57:05 konstruktor kernel:  printing eip:
Apr  9 17:57:05 konstruktor kernel: d0861541
Apr  9 17:57:05 konstruktor kernel: *pde = 00000000
Apr  9 17:57:05 konstruktor kernel: Oops: 0002
Apr  9 17:57:05 konstruktor kernel: CPU:    0
Apr  9 17:57:05 konstruktor kernel: EIP: 
0010:[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-555711/96] 
    Not tainted
Apr  9 17:57:05 konstruktor kernel: EFLAGS: 00010246
Apr  9 17:57:05 konstruktor kernel: eax: cfc635c8   ebx: 00000001   ecx: 
00000000   edx: c2b13de4
Apr  9 17:57:05 konstruktor kernel: esi: cfc635b8   edi: c2b13e04   ebp: 
00000002   esp: c2951e48
Apr  9 17:57:05 konstruktor kernel: ds: 0018   es: 0018   ss: 0018
Apr  9 17:57:05 konstruktor kernel: Process modprobe (pid: 3506, 
stackpage=c2951000)
Apr  9 17:57:05 konstruktor kernel: Stack: c8e6bbc0 c2b13c14 cff60400 
c2b13c14 c2951e6c c2951e6a c2951e68 00000002
Apr  9 17:57:05 konstruktor kernel:        00030606 00000003 00000000 
d0861caa c2b13de4 c8e6bbc0 d086a6b8 d0861cc4
Apr  9 17:57:05 konstruktor kernel:        c2b13c14 c8e6bbc0 00000000 
d0862019 c2b13c14 d086a650 d086a680 c8e6bbc0
Apr  9 17:57:05 konstruktor kernel: Call Trace: 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-553814/96] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-518472/96] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-553788/96] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-552935/96] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-518576/96]
Apr  9 17:57:05 konstruktor kernel: 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-518528/96] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-518500/96] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-541312/96] 
[usb_find_interface_driver+305/472] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-518576/96] 
[usb_check_support+92/120]
Apr  9 17:57:05 konstruktor kernel:    [usb_check_support+53/120] 
[usb_scan_devices+50/80] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-518528/96] 
[usb_register+150/156] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-552462/96] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-518528/96]
Apr  9 17:57:05 konstruktor kernel:    [sys_init_module+1285/1448] 
[ide-cd:__insmod_ide-cd_O/lib/modules/2.4.18/kernel/drivers/ide/ide+-561056/96] 
[system_call+51/56]
Apr  9 17:57:05 konstruktor kernel:
Apr  9 17:57:05 konstruktor kernel: Code: 89 41 04 89 4e 10 89 78 04 89 
42 20 83 c6 1c 31 ff 83 3c 3e
8<---------------------------------------------------------------------------

usb desc:
8<---------------------------------------------------------------------------

usb.c: USB device 3 (vend/prod 0x1604/0x8001) is not claimed by any 
active driver.
   Length              = 18
   DescriptorType      = 01
   USB version         = 1.00
   Vendor:Product      = 1604:8001
   MaxPacketSize0      = 64
   NumConfigurations   = 1
   Device version      = 0.01
   Device Class:SubClass:Protocol = 00:00:00
     Per-interface classes
Configuration:
   bLength             =    9
   bDescriptorType     =   02
   wTotalLength        = 00b7
   bNumInterfaces      =   01
   bConfigurationValue =   01
   iConfiguration      =   00
   bmAttributes        =   40
   MaxPower            =    0mA

   Interface: 0
   Alternate Setting:  0
     bLength             =    9
     bDescriptorType     =   04
     bInterfaceNumber    =   00
     bAlternateSetting   =   00
     bNumEndpoints       =   05
     bInterface Class:SubClass:Protocol =   ff:00:00
     iInterface          =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   04 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   84 (in)
       bmAttributes        =   03 (Interrupt)
       wMaxPacketSize      = 0015
       bInterval           =   0a
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   06 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   86 (in)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   02 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
   Alternate Setting:  1
     bLength             =    9
     bDescriptorType     =   04
     bInterfaceNumber    =   00
     bAlternateSetting   =   01
     bNumEndpoints       =   08
     bInterface Class:SubClass:Protocol =   ff:00:00
     iInterface          =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   04 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   84 (in)
       bmAttributes        =   03 (Interrupt)
       wMaxPacketSize      = 0015
       bInterval           =   0a
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   06 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   86 (in)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   02 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   88 (in)
       bmAttributes        =   01 (Isochronous)
       wMaxPacketSize      = 00c8
       bInterval           =   01
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   8a (in)
       bmAttributes        =   01 (Isochronous)
       wMaxPacketSize      = 00c8
       bInterval           =   01
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   0a (out)
       bmAttributes        =   01 (Isochronous)
       wMaxPacketSize      = 00c8
       bInterval           =   01
   Alternate Setting:  2
     bLength             =    9
     bDescriptorType     =   04
     bInterfaceNumber    =   00
     bAlternateSetting   =   02
     bNumEndpoints       =   08
     bInterface Class:SubClass:Protocol =   ff:00:00
     iInterface          =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   04 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   84 (in)
       bmAttributes        =   03 (Interrupt)
       wMaxPacketSize      = 0015
       bInterval           =   0a
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   06 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   86 (in)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   02 (out)
       bmAttributes        =   02 (Bulk)
       wMaxPacketSize      = 0040
       bInterval           =   00
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   88 (in)
       bmAttributes        =   01 (Isochronous)
       wMaxPacketSize      = 012c
       bInterval           =   01
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   8a (in)
       bmAttributes        =   01 (Isochronous)
       wMaxPacketSize      = 012c
       bInterval           =   01
     Endpoint:
       bLength             =    7
       bDescriptorType     =   05
       bEndpointAddress    =   0a (out)
       bmAttributes        =   01 (Isochronous)
       wMaxPacketSize      = 012c
       bInterval           =   01
8<-----------------------------------------------------------




Greetings,

Thomas Rabe.



-- mail: raven at drehmoment dot org
-- home: http://hal9000.drehmoment.org
-- more: http://drehmoment.org



-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
