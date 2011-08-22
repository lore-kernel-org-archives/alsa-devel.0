From: Kristian Amlie <kristian@amlie.name>
Subject: Re: How to add a new MIDI device to the usbaudio driver
Date: Mon, 22 Aug 2011 13:40:12 +0200
Message-ID: <4E52401C.8030605@amlie.name>
References: <4E5234F0.8000502@amlie.name>
	<CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oproxy6-pub.bluehost.com (oproxy6-pub.bluehost.com
	[67.222.54.6]) by alsa0.perex.cz (Postfix) with SMTP id 2B2581038AF
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 13:41:28 +0200 (CEST)
In-Reply-To: <CACTFLAMA08qqaNALA1dksxVN_yAwXnONxXadeuUb1Owkz6VwsA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 08/22/11 12:54, Daniel Mack wrote:
> On Mon, Aug 22, 2011 at 12:52 PM, Kristian Amlie <kristian@amlie.name> wrote:
>> I have just received a new MIDI instrument (Starr Labs Z7S) which is not
>> recognized by the kernel, and I'd like to add support for it. I'm hoping
>> that it uses a standard MIDI interface and it's just a matter of adding
>> the correct entry in the table of devices.
>>
>> I have tried to add an entry to sound/usb/usbquirks.h
>> (sound/usb/quirks-table.h in later kernels), but so far I haven't
>> succeeded. Is there any documentation for how to do this, and which
>> options to use? Google hasn't really turned up anything...
> 
> The USB descriptors should give us a hint. Can you send your "lsusb
> -v" output, please?

Sure! Here is the lsusb -v output for the device:

-------
Bus 003 Device 010: ID 0403:b8d8 Future Technology Devices
International, Ltd
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass            0 (Defined at Interface level)
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x0403 Future Technology Devices International, Ltd
  idProduct          0xb8d8
  bcdDevice            6.00
  iManufacturer           1 STARR LABS
  iProduct                2 Starr Labs MIDI USB device
  iSerial                 3 FTPW490R
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength           32
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              500mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass    255 Vendor Specific Subclass
      bInterfaceProtocol    255 Vendor Specific Protocol
      iInterface              2 Starr Labs MIDI USB device
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
Device Status:     0x0000
  (Bus Powered)
-------

-- 
Kristian
