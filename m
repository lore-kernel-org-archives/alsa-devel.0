From: "David W." <regulars@d-dub.org.uk>
Subject: Crackly playback,
 Roland AIRA TR-8 USB audio almost works with ALSA . . .
Date: Mon, 26 Jan 2015 23:14:10 +0000
Message-ID: <54C6CA42.3040206@d-dub.org.uk>
References: <53B6FB3A.40804@d-dub.org.uk>	<53B84A0B.9060805@googlemail.com>	<53B8563A.40608@d-dub.org.uk>	<53B9A821.9060407@googlemail.com>	<53B9D21F.30801@d-dub.org.uk>	<53BA3EDD.4090105@googlemail.com>	<548F70D2.90506@d-dub.org.uk>
 <54A2FF71.9030502@d-dub.org.uk>
Reply-To: regulars@d-dub.org.uk
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from owm.eumx.net (eumx.net [91.82.101.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 6BFE42604EA
 for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2015 00:14:12 +0100 (CET)
In-Reply-To: <54A2FF71.9030502@d-dub.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear ALSA developers,

On 30/12/14 19:39, David W. wrote:
> On 15/12/14 23:37, David W. wrote:
>> On 07/07/14 07:31, Clemens Ladisch wrote:
>>>
>>> Apparently, this device needs some vendor-specific magic to enable
>>> recording.
>>>

This AIRA TR-8 USB audio device, which fails with an 'input/output
error' after ~10 seconds for 'aplay' and 'arecord', seems to require
operation in implicit feedback mode: the following patch suggested by
Daniel Mack solves the 'input/output' error for 'aplay', but the
playback is noisy and corrupted and the kernel complains of 'rogue URB
xfers' (see below).

Given this information and the quote below from lsusb etc., I am hoping
someone would be able to suggest a further patch to get playback and
recording working :-)

I can patch, compile and test recent linux kernels (whatever is in:
https://www.archlinux.org/packages/?sort=&repo=Testing&q=linux)


Here's the patch from Daniel which helped:


diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index 0d8aba5..e35575b 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -346,6 +346,15 @@ static int set_sync_ep_implicit_fb_quirk(struct
snd_usb_substream *subs,

 		alts = &iface->altsetting[1];
 		goto add_sync_ep;
+	case USB_ID(0x0582, 0x017c):
+		ep = 0x85;
+		iface = usb_ifnum_to_if(dev, 3);
+
+		if (!iface || iface->num_altsetting == 0)
+			return -EINVAL;
+
+		alts = &iface->altsetting[1];
+		goto add_sync_ep;
 	}
 	if (attr == USB_ENDPOINT_SYNC_ASYNC &&
 	    altsd->bInterfaceClass == USB_CLASS_VENDOR_SPEC &&



Here's an example of the kind of complaint that the 3.18.2-2-ARCH kernel, with the above patch
applied, reports:

Jan 12 23:18:20 dwmobile kernel: WARNING: CPU: 2 PID: 1889 at drivers/usb/core/urb.c:450
usb_submit_urb+0x265/0x5f0 [usbcore]()
Jan 12 23:18:20 dwmobile kernel: usb 2-1.1: BOGUS urb xfer, pipe 0 != type 1
Jan 12 23:18:20 dwmobile kernel: Modules linked in: snd_usb_audio snd_usbmidi_lib snd_rawmidi
snd_seq_device ctr ccm sha256_ssse3 sha256_generic d
Jan 12 23:18:20 dwmobile kernel:  snd_pcm snd_timer video mei_me battery ac snd intel_agp button
intel_gtt acpi_cpufreq shpchp mei soundcore proce
Jan 12 23:18:20 dwmobile kernel: CPU: 2 PID: 1889 Comm: aplay Not tainted 3.18.2-2-custom #1
Jan 12 23:18:20 dwmobile kernel: Hardware name: System76, Inc.                   Pangolin
Performance              /W76x/M77xCUH
Jan 12 23:18:20 dwmobile kernel:  0000000000000000 000000005911a000 ffff88022988faf8 ffffffff8154f134
Jan 12 23:18:20 dwmobile kernel:  0000000000000000 ffff88022988fb50 ffff88022988fb38 ffffffff81072bc1
Jan 12 23:18:20 dwmobile kernel:  ffff88022988fb28 ffff88022f1aba00 0000000000000020 0000000000000003
Jan 12 23:18:20 dwmobile kernel: Call Trace:
Jan 12 23:18:20 dwmobile kernel:  [<ffffffff8154f134>] dump_stack+0x4e/0x71
Jan 12 23:18:20 dwmobile kernel:  [<ffffffff81072bc1>] warn_slowpath_common+0x81/0xa0
Jan 12 23:18:20 dwmobile kernel:  [<ffffffff81072c35>] warn_slowpath_fmt+0x55/0x70
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa009b005>] ? usb_enable_endpoint+0x85/0x90 [usbcore]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa0098e75>] usb_submit_urb+0x265/0x5f0 [usbcore]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa08d2c65>] snd_usb_endpoint_start+0x125/0x350
[snd_usb_audio]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa08dac89>] start_endpoints+0xb9/0x1a0 [snd_usb_audio]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa08dcbad>] snd_usb_pcm_prepare+0x17d/0x560 [snd_usb_audio]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffff810d7af6>] ? current_fs_time+0x16/0x60
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa028627b>] snd_pcm_do_prepare+0x1b/0x30 [snd_pcm]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa0285e4f>] snd_pcm_action_single+0x2f/0x70 [snd_pcm]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa0285f06>] snd_pcm_action_nonatomic+0x76/0x80 [snd_pcm]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa0288c18>] snd_pcm_common_ioctl1+0x688/0xbc0 [snd_pcm]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa0289268>] snd_pcm_playback_ioctl1+0x118/0x280 [snd_pcm]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffffa0289404>] snd_pcm_playback_ioctl+0x34/0x40 [snd_pcm]
Jan 12 23:18:20 dwmobile kernel:  [<ffffffff811e23e0>] do_vfs_ioctl+0x2d0/0x4b0
Jan 12 23:18:20 dwmobile kernel:  [<ffffffff811cf2ac>] ? vfs_write+0x18c/0x200
Jan 12 23:18:20 dwmobile kernel:  [<ffffffff811e2641>] SyS_ioctl+0x81/0xa0
Jan 12 23:18:20 dwmobile kernel:  [<ffffffff81554ca9>] system_call_fastpath+0x12/0x17
Jan 12 23:18:20 dwmobile kernel: ---[ end trace e6531ceb4fd4f2e5 ]---
Jan 12 23:18:20 dwmobile kernel: ------------[ cut here ]------------


>>
>> amidi -l
>>
>> Dir Device    Name
>> IO  hw:0,0,0  USB X-Session MIDI 1
>> I   hw:0,0,1  USB X-Session MIDI 2
>> IO  hw:2,0,0  TR-8 MIDI 1  # this device
>> IO  hw:2,0,1  TR-8 MIDI 2  # this device
>>
>>
>> ./alsacap -d hw:2,0
>>
>> *** Exploring configuration space of device 'hw:1,0' for playback ***
>> 4 channels
>> Sampling rate 96000 Hz
>> Sample formats: S32_LE
>> Significant bits: 32
>>
>>
>> Bus 002 Device 005: ID 0582:017c Roland Corp.
>> Device Descriptor:
>>   bLength                18
>>   bDescriptorType         1
>>   bcdUSB               2.00
>>   bDeviceClass          255 Vendor Specific Class
>>   bDeviceSubClass         0
>>   bDeviceProtocol       255
>>   bMaxPacketSize0        64
>>   idVendor           0x0582 Roland Corp.
>>   idProduct          0x017c
>>   bcdDevice            1.00
>>   iManufacturer           1 Roland
>>   iProduct                2 TR-8
>>   iSerial                 0
>>   bNumConfigurations      1
>>   Configuration Descriptor:
>>     bLength                 9
>>     bDescriptorType         2
>>     wTotalLength          176
>>     bNumInterfaces          4
>>     bConfigurationValue     1
>>     iConfiguration          0
>>     bmAttributes         0xc0
>>       Self Powered
>>     MaxPower                0mA
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        0
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass       255 Vendor Specific Class
>>       bInterfaceSubClass    255 Vendor Specific Subclass
>>       bInterfaceProtocol      0
>>       iInterface              0
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass       255 Vendor Specific Class
>>       bInterfaceSubClass      2
>>       bInterfaceProtocol      2
>>       iInterface              0
>> # <06 24 F1 02 <inputs> <outputs>> from patch comment by Clemens Ladisch
>>       ** UNRECOGNIZED:  06 24 f1 01 00 00
>>     # Audio OUT 4 channels?
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        1
>>       bAlternateSetting       1
>>       bNumEndpoints           1
>>       bInterfaceClass       255 Vendor Specific Class
>>       bInterfaceSubClass      2
>>       bInterfaceProtocol      2
>>       iInterface              0
>>       # seen in other Roland devices
>>       # http://ubuntuforums.org/archive/index.php/t-1905531.html
>>       ** UNRECOGNIZED:  07 24 01 01 00 01 00
>>       ** UNRECOGNIZED:  0b 24 02 01 04 04 18 01 00 77 01
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x0d  EP 13 OUT
>>         bmAttributes            5
>>           Transfer Type            Isochronous   # audio
>>           Synch Type               Asynchronous
>>           Usage Type               Data
>> 	# 4x 24-bit 96kHz == 56 bytes per 4 channels (or 32-bit?)
>>         wMaxPacketSize     0x00e0  1x 224 bytes
>>         bInterval               1
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        2
>>       bAlternateSetting       0
>>       bNumEndpoints           0
>>       bInterfaceClass       255 Vendor Specific Class
>>       bInterfaceSubClass      2
>>       bInterfaceProtocol      1
>>       iInterface              0
>>     # Audio IN: 14 channels?
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        2
>>       bAlternateSetting       1
>>       bNumEndpoints           1
>>       bInterfaceClass       255 Vendor Specific Class
>>       bInterfaceSubClass      2
>>       bInterfaceProtocol      1
>>       iInterface              0
>>       ** UNRECOGNIZED:  07 24 01 07 00 01 00
>>       ** UNRECOGNIZED:  0b 24 02 01 0e 04 18 01 00 77 01
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x8e  EP 14 IN
>>         bmAttributes           37
>>           Transfer Type            Isochronous
>>           Synch Type               Asynchronous
>>           Usage Type               Implicit feedback Data
>>         # 14 channels x 56 bytes per transfer 96kHz, 24-bit?
>>         wMaxPacketSize     0x0310  1x 784 bytes
>>         bInterval               1
>>     # MIDI?
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        3
>>       bAlternateSetting       0
>>       bNumEndpoints           2
>>       bInterfaceClass       255 Vendor Specific Class
>>       bInterfaceSubClass      3
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       # <06 24 F1 02 <inputs> <outputs>> 2 in 2 out
>>       ** UNRECOGNIZED:  06 24 f1 02 02 02
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x03  EP 3 OUT
>>         bmAttributes            2
>>           Transfer Type            Bulk
>>           Synch Type               None
>>           Usage Type               Data
>>         wMaxPacketSize     0x0200  1x 512 bytes
>>         bInterval               1
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x84  EP 4 IN
>>         bmAttributes            2
>>           Transfer Type            Bulk
>>           Synch Type               None
>>           Usage Type               Data
>>         wMaxPacketSize     0x0200  1x 512 bytes
>>         bInterval               0
>>     # MIDI: same endpoints needs Bulk AND Interrupt packet types?
>>     Interface Descriptor:
>>       bLength                 9
>>       bDescriptorType         4
>>       bInterfaceNumber        3
>>       bAlternateSetting       1
>>       bNumEndpoints           2
>>       bInterfaceClass       255 Vendor Specific Class
>>       bInterfaceSubClass      3
>>       bInterfaceProtocol      0
>>       iInterface              0
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x03  EP 3 OUT
>>         bmAttributes            3
>>           Transfer Type            Interrupt
>>           Synch Type               None
>>           Usage Type               Data
>>         wMaxPacketSize     0x0200  1x 512 bytes
>>         bInterval               1
>>       Endpoint Descriptor:
>>         bLength                 7
>>         bDescriptorType         5
>>         bEndpointAddress     0x85  EP 5 IN
>>         bmAttributes            3
>>           Transfer Type            Interrupt
>>           Synch Type               None
>>           Usage Type               Data
>>         wMaxPacketSize     0x0200  1x 512 bytes
>>         bInterval               1
>> Device Qualifier (for other device speed):
>>   bLength                10
>>   bDescriptorType         6
>>   bcdUSB               2.00
>>   bDeviceClass          255 Vendor Specific Class
>>   bDeviceSubClass         0
>>   bDeviceProtocol       255
>>   bMaxPacketSize0        64
>>   bNumConfigurations      1
>> can't get debug descriptor: Resource temporarily unavailable
>> Device Status:     0x0001
>>   Self Powered
>>
>>
>>
>> A summary of some USB packets during idle, start playback, stop
>> playback, start recording, stop recording. Playback and record was
>> probably only using a pair of stereo channels IIRC (maybe even one mono
>> channel). I could do the same with all channels if that would be of any use.
>>
>>
>> - at all times, polling seems to be 'Bulk or Interrupt Transfer' to
>> Device Object FFFFFA800BBF1C00h (00000094) with I/O Request Packet
>> FFFFFA800B97B830h
>>
>>
>> - start playback: 'Select Interface', 'Ifc 1 / Alt 1' and 'Ifc 2 / Alt
>> 1', Device Object: FFFFFA800BBF1C00h,  I/O Request Packet: FFFFFA800778E780h
>>
>> 1x 'Create' using I/O Request Packet: FFFFFA800C7A2480h to Device
>> Objects: FFFFFA800C060C20h (00000095) and FFFFFA800BE30600h (00000096)
>>
>>
>> - during playback: lots of 'Isoch Transfer' to FFFFFA800BBF1C00h with
>> nine different I/O Request Packets
>>
>>
>> - stop playback: 'Select Interface', 'Ifc 1 / Alt 0' and 'Ifc 1 / Alt
>> 0', Device Object: FFFFFA800BBF1C00h;   I/O Request Packet:
>> FFFFFA8007552810h
>>
>> 1x 'Close' using I/O Request Packet: FFFFFA800C7A2480h to Device
>> Objects: FFFFFA800C060C20h and FFFFFA800BE30600h; some 'Cleanups' that
>> return 'Invalid Device Request'
>>
>>
>> - start recording: 'Select Interface', 'Ifc 1 / Alt 1' and 'Ifc 2 / Alt
>> 1', Device Object: FFFFFA800BBF1C00h,  I/O Request Packet: FFFFFA800778E780h
>>
>> 5x 'Create' using I/O Request Packet: FFFFFA800C0E9C60h to Device
>> Objects: FFFFFA800C060C20h and FFFFFA800BE30600h
>> 2x 'Create' using I/O Request Packet: FFFFFA800C60A010h to Device
>> Objects: FFFFFA800C060C20h and FFFFFA800BE30600h
>> 1x 'Create' using I/O Request Packet: FFFFFA800754F010h to Device
>> Objects: FFFFFA800C060C20h and FFFFFA800BE30600h
>> 2x 'Close' using I/O Request Packet: FFFFFA800C0E9C60h to Device
>> Objects: FFFFFA800C060C20h and FFFFFA800BE30600h
>>
>>
>> - during recording: lots of 'Isoch Transfer' to FFFFFA800BBF1C00h with
>> nine different I/O Request Packets
>>
>>
>> - stop recording: 'Select Interface', 'Ifc 1 / Alt 0' and 'Ifc 1 / Alt
>> 0', Device Object: FFFFFA800BBF1C00h;   I/O Request Packet:
>> FFFFFA8007552810h
>>
>> 4x 'Close' using I/O Request Packet: FFFFFA8007543C60h to Device
>> Objects: FFFFFA800C060C20h and FFFFFA800BE30600h
>>
>>
