From: Eric Dantan Rzewnicki <eric@zhevny.com>
Subject: Re: [linux-audio-user] novation remote 25 usb midi controller
Date: Fri, 01 Aug 2003 20:40:52 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F2B0894.76B80218@zhevny.com>
References: <Pine.HPX.4.33n.0308010917360.22186-100000@studcom.urz.uni-halle.de>
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
To: linux-audio-user@music.columbia.edu
Cc: alsa user <alsa-user@lists.sourceforge.net>, alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> > Eric Dantan Rzewnicki wrote:
> > T:  Bus=01 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  3 Spd=12  MxCh= 0
> > D:  Ver= 1.00 Cls=00(>ifc ) Sub=00 Prot=00 MxPS= 8 #Cfgs=  1
> > P:  Vendor=1235 ProdID=4661 Rev= 1.01
> > S:  Manufacturer=Novation EMS
> > S:  Product=ReMOTE25 V1.0
> > C:* #Ifs= 1 Cfg#= 1 Atr=20 MxPwr=250mA
> > I:  If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=00 Prot=00 Driver=(none)
> 
> Class ff is "vendor-specific", so it's not 100% compatible with the
> USB Audio Specification.
> 
> Please post the output of "lsusb -v".
> 
> Regards,
> Clemens

box1:~# lsusb -v

Bus 001 Device 001: ID 0000:0000  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            9 Hub
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x0000 
  idProduct          0x0000 
  bcdDevice            0.00
  iManufacturer           0 
  iProduct                2 USB UHCI-alt Root Hub
  iSerial                 1 6400
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           25
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x40
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           1
      bInterfaceClass         9 Hub
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize          8
        bInterval             255
  Language IDs: (length=4)
     0000 (null)((null))


Bus 001 Device 004: ID 1235:4661  
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0 Interface
  bDeviceSubClass         0 
  bDeviceProtocol         0 
  bMaxPacketSize0         8
  idVendor           0x1235 
  idProduct          0x4661 
  bcdDevice            1.01
  iManufacturer           1 Novation EMS     
  iProduct                2 ReMOTE25 V1.0
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x20
      Remote Wakeup
    MaxPower              250mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
        wMaxPacketSize         32
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               none
       wMaxPacketSize         32
        bInterval               1
  Language IDs: (length=4)
     0409 English(US)


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
