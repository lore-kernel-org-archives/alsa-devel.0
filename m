From: Daniel Mack <daniel@zonque.org>
Subject: Re: [Alsa-user] snd-usb-caiaq (NI Maschine Mikro)
 device not recognised by alsa
Date: Tue, 22 Sep 2015 13:17:54 +0200
Message-ID: <560138E2.3020300@zonque.org>
References: <CAGPstWvoprjRHN2+xZe5w+=pPkOqcqQdR4t7bYY_MgXwKbPD4A@mail.gmail.com>
 <55EC7191.8020107@googlemail.com>
 <CAGPstWtnvg=mE54JGaU8y0gTU8BwxkzMqnOFXW-VSVmtQtkJmQ@mail.gmail.com>
 <560039B6.2000204@zonque.org>
 <CAGPstWuWNbYpveL56Tznr3TMVGVqprrfAT-F7bGbc5e3nJkCSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id D2FBA261AE4
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2015 13:17:55 +0200 (CEST)
In-Reply-To: <CAGPstWuWNbYpveL56Tznr3TMVGVqprrfAT-F7bGbc5e3nJkCSg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sypwex@gmail.com
Cc: alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org, Clemens Ladisch <cladisch@googlemail.com>
List-Id: alsa-devel@alsa-project.org

On 09/21/2015 10:10 PM, sypwex wrote:
> Thanks for the reply!
> 
>> What does 'lsusb -v' show when you plug in the device?
> the exactly `lsusb -v` out is here http://pastebin.com/raw.php?i=trmwPjGF
> 
> information only about 17cc:1110 (`sudo lsusb -D /dev/bus/usb/001/010`):
> 
> Device: ID 17cc:1110 Native Instruments
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 (Defined at Interface level)
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x17cc Native Instruments
>   idProduct          0x1110
>   bcdDevice            0.37
>   iManufacturer           1 Native Instruments
>   iProduct                2 Maschine Mikro
>   iSerial                 6 677AC139
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength           57
>     bNumInterfaces          2
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              450mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0 No Subclass
>       bInterfaceProtocol      0 None
>       iInterface              4 Maschine Mikro HID

Yes, this device only offers HID and DFU (for firmware updates), so
you'll have to parse the HID data it produces. Use the hidraw interface
to get to the uncached information. Whether you can use an existing tool
to do that depends on what you want to achieve with this device.

In either case, there is no hardware MIDI port on this device, so the
firmware doesn't offer that as class compliant interface. NI's own
software stack might offer that, but that's a pure virtual MIDI device then.


HTH,
Daniel
