From: Martin Langer <martin-langer@gmx.de>
Subject: Re: my first usb-midi experiment ends with segmentation fault
Date: Tue, 30 Jul 2002 20:18:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020730181834.GA494@tuba.home>
References: <20020728213924.GA522@tuba.home> <3D469011.855453A7@ladisch.de> <200207301708.07066.plcl@telefonica.net> <3D46C107.2E108CEB@ladisch.de>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D46C107.2E108CEB@ladisch.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@lists.sourceforge.net, plcl@telefonica.net
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 30, 2002 at 03:09:37PM +0200, Clemens Ladisch wrote:
> Martin Langer wrote:
> > snd-usb-midi: detected Evolution Electronics L MK-249C USB MIDI keyboa
> 
> As Pedro said, subclass 1 is an AudioControl interface. There should be
> two cards, one created by snd-usb-audio, and the other one created by
> snd-usb-midi (see /proc/asound/cards). The contents of the control
> interface (if there are any controls) should be visible in the output
> of the "lsusb" command.
> 
> Your keyboard is unusual in two respects: it's an Audio Class compliant
> device (yes, this _is_ unusual for USB MIDI devices :-) , and it uses
> two endpoints, one for each direction. The combination of these two
> triggers an ugly bug in the descriptor parsing code (device_info isn't
> initialized).
> 
> Please try the following patch (the current taciturnity of the driver
> is somewhat inconvenient, so it adds some error messages as well).
> 

Thanks for all patches, but I don't found an error in the log-files. The last
line is/was always the detection, which seems to work fine (see above). I'm 
still missing a client in /proc/asound/seq/clients, so the driver never
reaches the port creation and I have no additional output from your patch.
Something else must be between usb-detection and creation of the port!

Also the entry in the /proc/asound/cards is/was all the time there, btw: I
have no hotplugtools installed, everything is manually loaded on my machine.

tuba:~# cat /proc/asound/cards 
0 [card0          ]: USB MIDI - Evolution Electronics L MK-249C Evolution
Electronics L MK-249C Evolution Elect (a4d:8e if 1 at 001/002)
                     Evolution Electronics L MK-249C Evolution Elect (a4d:8e
if 1 at 001/002)
1 [card1          ]: USB-Audio - USB Audio Driver
                     Evolution Electronics Ltd. MK-249C USB MIDI keyboard


The only strange thing I found are the unknown parts of the lsusb output
(broken descriptor?) and the impossible module reload = segfault.

martin


Bus 001 Device 002: ID 0a4d:008e  
  Language IDs: none (invalid length string descriptor bf; len=0)
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            1 Audio
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0        64
  idVendor           0x0a4d 
  idProduct          0x008e 
  bcdDevice            2.00
  iManufacturer           1 
  iProduct                2 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          101
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          3
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           0
      bInterfaceClass         1 Audio
      bInterfaceSubClass      1 Control Device
      bInterfaceProtocol      0 
      iInterface              0 
      AudioControl Interface Descriptor:
        bLength                 9
        bDescriptorType        36
        bDescriptorSubtype      1 (HEADER)
        bcdADC               1.00
        wTotalLength            9
        bInCollection           1
        baInterfaceNr( 0)       1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         1 Audio
      bInterfaceSubClass      3 Non Streaming
      bInterfaceProtocol      0 
      iInterface              0 
  unknown descriptor type: 07 24 01 00 01 41 00
  unknown descriptor type: 06 24 02 01 01 00
  unknown descriptor type: 06 24 02 02 02 00
  unknown descriptor type: 09 24 03 01 03 01 02 01 00
  unknown descriptor type: 09 24 03 02 04 01 01 01 00
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
        bRefresh                0
        bSynchAddress           0
  unknown descriptor type: 05 25 01 01 03
      Endpoint Descriptor:
        bLength                 9
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               none
        wMaxPacketSize         64
        bInterval               0
        bRefresh                0
        bSynchAddress           0
  unknown descriptor type: 05 25 01 01 01
  Language IDs: none (invalid length string descriptor bf; len=0)




-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
