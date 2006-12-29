From: Andre Coetzee <andre_4you@yahoo.co.uk>
Subject: USB MIDI Support for Roland EXR Series
Date: Fri, 29 Dec 2006 15:56:56 +0000 (GMT)
Message-ID: <20061229155656.22507.qmail@web27909.mail.ukl.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi

I recently acquired a Roland EXR 5s usb midi keyboard.

I'm keen to use the ALSA usb midi driver on my 2.6
kernel Gentoo Linux system using current ALSA modules.

For some time now I have seen that support for the EXR
is shaded gray on ALSA's supported hardware list. Not
sure what this means, but I'm guessing there is
partial support?

I can see the device with lsusb -v:

Bus 001 Device 002: ID 0582:0060 Roland Corp. 
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         0 
  bDeviceProtocol       255 
  bMaxPacketSize0         8
  idVendor           0x0582 Roland Corp.
  idProduct          0x0060 
  bcdDevice            1.00
  iManufacturer           1 Roland
  iProduct                2 EXR
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          149
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xc0
      Self Powered
    MaxPower                0mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      3 
      bInterfaceProtocol      0 
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x01  EP 1 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1

I have the snd-usb-audio module loaded:
lsmod | grep usb
snd_usb_audio          48384  0 
snd_usb_lib            10432  1 snd_usb_audio
snd_pcm                47332  3
snd_usb_audio,snd_pcm_oss,snd_cmipci
snd_hwdep               5956  2
snd_usb_audio,snd_opl3_lib
snd_rawmidi            14272  3
snd_usb_lib,snd_seq_midi,snd_mpu401_uart
snd                    31368  14
snd_usb_audio,snd_usb_lib,snd_pcm_oss,snd_mixer_oss,snd_seq_oss,snd_seq,snd_cmipci,snd_pcm,snd_opl3_lib,snd_timer,snd_hwdep,snd_mpu401_uart,snd_rawmidi,snd_seq_device
usb_storage            55936  0 
usbhid                 31936  0 
usbcore                80548  9
snd_usb_audio,snd_usb_lib,sl811_hcd,ohci_hcd,uhci_hcd,usb_storage,usbhid,ehci_hcd

But ALSA doesn't seem to recognize the device:

cat /proc/asound/cards 
 0 [CMI8738        ]: CMI8738 - C-Media PCI CMI8738
                      C-Media PCI CMI8738 (model 37)
at 0x9800, irq 10

amidi -l
Dir Device    Name
IO  hw:0,0    MPU-401 MIDI 0-0

(hw:0,0 is the onboard gameport MPU401)


I saw a comment in the kernel's usbquirks.h:

   /* TODO: add Roland EXR support */

But if support is incomplete, I'd like to learn how
can I help to accelerate this process? (I'm not a
programmer, but I have access to the hardware and am
willing to do some testing on my system).

When replying, please CC me, as I am not subscribed to
the list.

Season's greetings and thanks for a great sound
system.

Andre

Send instant messages to your online friends http://uk.messenger.yahoo.com 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
