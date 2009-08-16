From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: Digidesign Mbox2 - usb support
Date: Mon, 17 Aug 2009 02:44:59 +1000
Message-ID: <98ec50f0908160944v654fbe0fj8753027060aa368c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 0565124151
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Aug 2009 18:45:00 +0200 (CEST)
Received: by ewy23 with SMTP id 23so2597546ewy.32
	for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2009 09:44:59 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel mailing list <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Using the following patch to usbquirks.h, I was able to get MIDI in
and out working on the Digidesign Mbox2!!
The capture/playback PCMs are also configured with alsa, but the
status on these are "closed".
I am guessing I need to snoop the commands on interface 1 (control
device) to enable them.
Also, there is some "magic" needed to initialise the device which I
have captured.
It seems that the device needs to be loaded with altsettings = 0 on
interfaces 1-5 first,
then some setup codes are transmitted, and finally the following
altsettings are used.

dczammit@flop:/proc/asound$ ls
card0  cards  devices  hwdep  M2  modules  pcm  seq  timers  version

dczammit@flop:/proc/asound$ cat cards
 0 [M2             ]: USB-Audio - Mbox 2
                      Digidesign Mbox 2 at usb-0000:00:1d.1-1, full speed

dczammit@flop:/proc/asound$ cat devices
  0: [ 0]   : control
  1:        : sequencer
  8: [ 0- 0]: raw midi
 16: [ 0- 0]: digital audio playback
 24: [ 0- 0]: digital audio capture
 33:        : timer

dczammit@flop:/proc/asound$ cat pcm
00-00: USB Audio : USB Audio : playback 1 : capture 1

dczammit@flop:/proc/asound$ cat timers
G0: system timer : 1000.000us (10000000 ticks)
G1: RTC timer : 976.562us (100000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE

dczammit@flop:/proc/asound/M2$ ls
id  midi0  pcm0c  pcm0p  stream0  usbbus  usbid

dczammit@flop:/proc/asound/M2$ cat midi0
Mbox 2

Output 0
  Tx bytes     : 212
Input 0
  Rx bytes     : 314

dczammit@flop:/proc/asound/M2$ cat stream0
Digidesign Mbox 2 at usb-0000:00:1d.1-1, full speed : USB Audio

Playback:
  Status: Stop
  Interface 3
    Altset 3
    Format: 0x20
    Channels: 2
    Endpoint: 4 OUT (ASYNC)
    Rates: 8000 - 48000 (continuous)

Capture:
  Status: Stop
  Interface 5
    Altset 3
    Format: 0x20
    Channels: 2
    Endpoint: 6 IN (SYNC)
    Rates: 8000 - 48000 (continuous)

dczammit@flop:/proc/asound/seq$  aplay -Ddefault:CARD=M2 -f S16_LE
~/Desktop/tunes/dzjam.wav
Playing WAVE '/home/dczammit/Desktop/tunes/dzjam.wav' : Signed 16 bit
Little Endian, Rate 44100 Hz, Stereo
Segmentation fault


Please find the quirk below and the magic init codes.

##################################
{
	USB_DEVICE(0x0dba, 0x3000),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
		.vendor_name = "Digidesign",
		.product_name = "Mbox 2",
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = (const struct snd_usb_audio_quirk[]) {
			{
				.ifnum = 0,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{ /* Audio control interface - sets the sampling rate? - no idea
how this works
                             Possibly also enables the
capture/playback using a command? */
				.ifnum = 1,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{
				.ifnum = 2,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{
                                .ifnum = 3,
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = & (const struct audioformat) {
                                        .format = SNDRV_PCM_FORMAT_S24_3LE,
                                        .channels = 2,
                                        .iface = 3,
                                        .altsetting = 3, /* 0 is also
available, but has no endpoints */
                                        .altset_idx = 1,
                                        .endpoint = 0x04, /* OUT or
0x84 IN (attr 1) */
                                        .ep_attr = 0x05,
                                        .rates = SNDRV_PCM_RATE_CONTINUOUS,
                                        .rate_min = 8000,
                                        .rate_max = 48000
                                }
                        },
			{
                                .ifnum = 4,
                        	.type = QUIRK_IGNORE_INTERFACE
			},
			{
                                .ifnum = 5,
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = & (const struct audioformat) {
                                        .format = SNDRV_PCM_FORMAT_S24_3LE,
                                        .channels = 2,
                                        .iface = 5,
                                        .altsetting = 3,
                                        .altset_idx = 1,
                                        .endpoint = 0x86, /* IN */
                                        .ep_attr = 0x0D,
                                        .rates = SNDRV_PCM_RATE_CONTINUOUS,
                                        .rate_min = 8000,
                                        .rate_max = 48000
                                }
                        },
			{
				.ifnum = 6,
				.type = QUIRK_MIDI_FIXED_ENDPOINT,
				.data = & (const struct snd_usb_midi_endpoint_info) {
					.out_ep = 2,
					.out_interval = 0x00,
					.in_ep = 2,
					.in_interval = 0x00,
					.out_cables = 0x0001,
					.in_cables = 0x0001
				}

			},
			{
				.ifnum = -1
			}
		}
	}
},
##################################

Audio driver magic:

[0 ms] UsbSnoop compiled on Jan 18 2003 22:41:32 loading
[0 ms] UsbSnoop - DriverEntry(baca2c40) : Windows NT WDM version 1.32
[101 ms] UsbSnoop - AddDevice(baca2f50) : DriverObject 83499768, pdo 83338c10
[102 ms] UsbSnoop - MyDispatchPNP(baca2ee0) : IRP_MJ_PNP
(IRP_MN_QUERY_INTERFACE)
[102 ms] UsbSnoop - MyDispatchPNP(baca2ee0) : IRP_MJ_PNP (0x00000018)
[127 ms] UsbSnoop - MyDispatchPNP(baca2ee0) : IRP_MJ_PNP
(IRP_MN_QUERY_RESOURCE_REQUIREMENTS)
[127 ms] UsbSnoop - MyDispatchPNP(baca2ee0) : IRP_MJ_PNP
(IRP_MN_FILTER_RESOURCE_REQUIREMENTS)
[128 ms] UsbSnoop - MyDispatchPNP(baca2ee0) : IRP_MJ_PNP (IRP_MN_START_DEVICE)
[128 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=832c7530, IRQL=0
[128 ms]  >>>  URB 1 going down  >>>
-- URB_FUNCTION_GET_DESCRIPTOR_FROM_DEVICE:
  TransferBufferLength = 00000012
  TransferBuffer       = bacef95c
  TransferBufferMDL    = 00000000
  Index                = 00000001
  DescriptorType       = 00000001 (USB_DEVICE_DESCRIPTOR_TYPE)
  LanguageId           = 00000000
[128 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=832c7530, Context=832ff2e8, IRQL=0
[128 ms]  <<<  URB 1 coming back  <<<
-- URB_FUNCTION_GET_DESCRIPTOR_FROM_DEVICE:
  TransferBufferLength = 00000012
  TransferBuffer       = bacef95c
  TransferBufferMDL    = 00000000
    00000000: 12 01 00 01 00 00 00 08 ba 0d 00 30 38 01 01 02
    00000010: 00 01
  Index                = 00000001
  DescriptorType       = 00000001 (USB_DEVICE_DESCRIPTOR_TYPE)
  LanguageId           = 00000000
[128 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=832c7530, IRQL=0
[128 ms]  >>>  URB 2 going down  >>>
-- URB_FUNCTION_GET_DESCRIPTOR_FROM_DEVICE:
  TransferBufferLength = 00000009
  TransferBuffer       = bacef9d0
  TransferBufferMDL    = 00000000
  Index                = 00000001
  DescriptorType       = 00000002 (USB_CONFIGURATION_DESCRIPTOR_TYPE)
  LanguageId           = 00000000
[128 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=832c7530, Context=833e2438, IRQL=0
[128 ms]  <<<  URB 2 coming back  <<<
-- URB_FUNCTION_GET_DESCRIPTOR_FROM_DEVICE:
  TransferBufferLength = 00000009
  TransferBuffer       = bacef9d0
  TransferBufferMDL    = 00000000
    00000000: 09 02 58 02 05 01 00 80 fa
  Index                = 00000001
  DescriptorType       = 00000002 (USB_CONFIGURATION_DESCRIPTOR_TYPE)
  LanguageId           = 00000000
[128 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=832c7530, IRQL=0
[128 ms]  >>>  URB 3 going down  >>>
-- URB_FUNCTION_GET_DESCRIPTOR_FROM_DEVICE:
  TransferBufferLength = 00000258
  TransferBuffer       = 83369540
  TransferBufferMDL    = 00000000
  Index                = 00000001
  DescriptorType       = 00000002 (USB_CONFIGURATION_DESCRIPTOR_TYPE)
  LanguageId           = 00000000
[128 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=832c7530, Context=83455a90, IRQL=0
[128 ms]  <<<  URB 3 coming back  <<<
-- URB_FUNCTION_GET_DESCRIPTOR_FROM_DEVICE:
  TransferBufferLength = 00000258
  TransferBuffer       = 83369540
  TransferBufferMDL    = 00000000
    00000000: 09 02 58 02 05 01 00 80 fa 09 04 01 00 00 01 01
    00000010: 00 02 0c 24 01 00 01 60 00 04 02 03 04 05 0c 24
    00000020: 02 05 01 01 00 02 03 00 00 00 09 24 03 06 01 06
    00000030: 00 05 00 0c 24 02 07 01 01 00 02 03 00 00 00 09
    00000040: 24 03 08 01 06 00 07 00 0c 24 02 01 01 06 00 02
    00000050: 03 00 00 00 09 24 03 02 01 01 00 01 00 0c 24 02
    00000060: 03 01 06 00 02 03 00 00 00 09 24 03 04 01 01 00
    00000070: 03 00 09 04 02 00 00 01 02 00 00 09 04 02 02 02
    00000080: 01 02 00 00 07 24 01 05 01 01 00 0e 24 02 01 02
    00000090: 03 18 00 40 1f 00 80 bb 00 09 05 03 05 28 01 01
    000000a0: 00 83 07 25 01 00 00 00 00 09 05 83 01 03 00 01
    000000b0: 02 00 09 04 02 03 02 01 02 00 00 07 24 01 05 01
    000000c0: 01 00 0e 24 02 01 02 03 18 00 40 1f 00 80 bb 00
    000000d0: 09 05 03 05 28 01 01 00 83 07 25 01 00 00 00 00
    000000e0: 09 05 83 01 03 00 01 02 00 09 04 03 00 00 01 02
    000000f0: 00 00 09 04 03 02 02 01 02 00 00 07 24 01 07 01
    00000100: 01 00 0e 24 02 01 02 03 18 00 40 1f 00 80 bb 00
    00000110: 09 05 04 05 28 01 01 00 84 07 25 01 00 00 00 00
    00000120: 09 05 84 01 03 00 01 02 00 09 04 03 03 02 01 02
    00000130: 00 00 07 24 01 07 01 01 00 0e 24 02 01 02 03 18
    00000140: 00 40 1f 00 80 bb 00 09 05 04 05 28 01 01 00 84
    00000150: 07 25 01 00 00 00 00 09 05 84 01 03 00 01 02 00
    00000160: 09 04 03 06 01 01 02 00 00 07 24 01 07 01 01 20
    00000170: 0e 24 02 03 02 02 10 00 40 1f 00 80 bb 00 09 05
    00000180: 04 0d c0 00 01 00 00 07 25 01 01 00 00 00 09 04
    00000190: 04 00 00 01 02 00 00 09 04 04 02 01 01 02 00 00
    000001a0: 07 24 01 02 01 01 00 0e 24 02 01 02 03 18 00 40
    000001b0: 1f 00 80 bb 00 09 05 85 05 28 01 01 00 00 07 25
    000001c0: 01 00 00 00 00 09 04 04 03 01 01 02 00 00 07 24
    000001d0: 01 02 01 01 00 0e 24 02 01 02 03 18 00 40 1f 00
    000001e0: 80 bb 00 09 05 85 0d 28 01 01 00 00 07 25 01 01
    000001f0: 00 00 00 09 04 05 00 00 01 02 00 00 09 04 05 02
    00000200: 01 01 02 00 00 07 24 01 04 01 01 00 0e 24 02 01
    00000210: 02 03 18 00 40 1f 00 80 bb 00 09 05 86 05 28 01
    00000220: 01 00 00 07 25 01 00 00 00 00 09 04 05 03 01 01
    00000230: 02 00 00 07 24 01 04 01 01 00 0e 24 02 01 02 03
    00000240: 18 00 40 1f 00 80 bb 00 09 05 86 0d 28 01 01 00
    00000250: 00 07 25 01 01 00 00 00
  Index                = 00000001
  DescriptorType       = 00000002 (USB_CONFIGURATION_DESCRIPTOR_TYPE)
  LanguageId           = 00000000
[128 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=832c7530, IRQL=0
[128 ms]  >>>  URB 4 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[133 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=832c7530, Context=833573c0, IRQL=2
[133 ms]  <<<  URB 4 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 83623978
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[433 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=83436508, IRQL=0
[433 ms]  >>>  URB 5 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[437 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=83436508, Context=83429560, IRQL=2
[437 ms]  <<<  URB 5 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 834a08e8
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[733 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=83436508, IRQL=0
[733 ms]  >>>  URB 6 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[738 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=83436508, Context=83625f08, IRQL=2
[738 ms]  <<<  URB 6 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 834a08e8
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[1034 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=834a1398, IRQL=0
[1034 ms]  >>>  URB 7 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[1038 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=834a1398, Context=832ff2e8, IRQL=2
[1038 ms]  <<<  URB 7 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 834a08e8
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[1334 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[1334 ms]  >>>  URB 8 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[1339 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=833573c0, IRQL=2
[1339 ms]  <<<  URB 8 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 83621768
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[1635 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[1635 ms]  >>>  URB 9 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[1639 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=832ff2e8, IRQL=2
[1639 ms]  <<<  URB 9 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 83621768
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[1935 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[1935 ms]  >>>  URB 10 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[1940 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=833573c0, IRQL=2
[1940 ms]  <<<  URB 10 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 83621768
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[2236 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[2236 ms]  >>>  URB 11 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[2240 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=832ff2e8, IRQL=2
[2240 ms]  <<<  URB 11 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 83621768
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[2536 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[2536 ms]  >>>  URB 12 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[2541 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=833573c0, IRQL=2
[2541 ms]  <<<  URB 12 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 83621768
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[2837 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[2837 ms]  >>>  URB 13 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[2841 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=832ff2e8, IRQL=2
[2841 ms]  <<<  URB 13 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 83621768
    00000000: 01
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[3137 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[3137 ms]  >>>  URB 14 going down  >>>
-- URB_FUNCTION_VENDOR_DEVICE:
  TransferFlags          = 00000001 (USBD_TRANSFER_DIRECTION_IN,
~USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000012
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 00000000
  UrbLink                 = 00000000
  RequestTypeReservedBits = 00000000
  Request                 = 00000085
  Value                   = 00000001
  Index                   = 00000000
[3142 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=833573c0, IRQL=2
[3142 ms]  <<<  URB 14 coming back  <<<
-- URB_FUNCTION_CONTROL_TRANSFER:
  PipeHandle           = 83323ac0
  TransferFlags        = 0000000b (USBD_TRANSFER_DIRECTION_IN,
USBD_SHORT_TRANSFER_OK)
  TransferBufferLength = 00000001
  TransferBuffer       = bacef8e7
  TransferBufferMDL    = 83621768
    00000000: 02
  UrbLink              = 00000000
  SetupPacket          =
    00000000: c0 85 01 00 00 00 12 00
[3142 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[3142 ms]  >>>  URB 15 going down  >>>
-- URB_FUNCTION_SELECT_CONFIGURATION:
  ConfigurationDescriptor = 0x83369540 (configure)
  ConfigurationDescriptor : bLength             = 9
  ConfigurationDescriptor : bDescriptorType     = 0x00000002
  ConfigurationDescriptor : wTotalLength        = 0x00000258
  ConfigurationDescriptor : bNumInterfaces      = 0x00000005
  ConfigurationDescriptor : bConfigurationValue = 0x00000001
  ConfigurationDescriptor : iConfiguration      = 0x00000000
  ConfigurationDescriptor : bmAttributes        = 0x00000080
  ConfigurationDescriptor : MaxPower            = 0x000000fa
  ConfigurationHandle     = 0x00000000
  Interface[0]: Length            = 16
  Interface[0]: InterfaceNumber   = 1
  Interface[0]: AlternateSetting  = 0
  Interface[1]: Length            = 16
  Interface[1]: InterfaceNumber   = 2
  Interface[1]: AlternateSetting  = 0
  Interface[2]: Length            = 16
  Interface[2]: InterfaceNumber   = 3
  Interface[2]: AlternateSetting  = 0
  Interface[3]: Length            = 16
  Interface[3]: InterfaceNumber   = 4
  Interface[3]: AlternateSetting  = 0
  Interface[4]: Length            = 16
  Interface[4]: InterfaceNumber   = 5
  Interface[4]: AlternateSetting  = 0
[3142 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=83429560, IRQL=0
[3142 ms]  <<<  URB 15 coming back  <<<
-- URB_FUNCTION_SELECT_CONFIGURATION:
  ConfigurationDescriptor = 0x83369540 (configure)
  ConfigurationDescriptor : bLength             = 9
  ConfigurationDescriptor : bDescriptorType     = 0x00000002
  ConfigurationDescriptor : wTotalLength        = 0x00000258
  ConfigurationDescriptor : bNumInterfaces      = 0x00000005
  ConfigurationDescriptor : bConfigurationValue = 0x00000001
  ConfigurationDescriptor : iConfiguration      = 0x00000000
  ConfigurationDescriptor : bmAttributes        = 0x00000080
  ConfigurationDescriptor : MaxPower            = 0x000000fa
  ConfigurationHandle     = 0x835a8978
  Interface[0]: Length            = 16
  Interface[0]: InterfaceNumber   = 1
  Interface[0]: AlternateSetting  = 0
  Interface[0]: Class             = 0x00000001
  Interface[0]: SubClass          = 0x00000001
  Interface[0]: Protocol          = 0x00000000
  Interface[0]: InterfaceHandle   = 0x8336b868
  Interface[0]: NumberOfPipes     = 0
  Interface[1]: Length            = 16
  Interface[1]: InterfaceNumber   = 2
  Interface[1]: AlternateSetting  = 0
  Interface[1]: Class             = 0x00000000
  Interface[1]: SubClass          = 0x00000000
  Interface[1]: Protocol          = 0x00000000
  Interface[1]: InterfaceHandle   = 0x00000000
  Interface[1]: NumberOfPipes     = 0
  Interface[2]: Length            = 16
  Interface[2]: InterfaceNumber   = 3
  Interface[2]: AlternateSetting  = 0
  Interface[2]: Class             = 0x00000000
  Interface[2]: SubClass          = 0x00000000
  Interface[2]: Protocol          = 0x00000000
  Interface[2]: InterfaceHandle   = 0x00000000
  Interface[2]: NumberOfPipes     = 0
  Interface[3]: Length            = 16
  Interface[3]: InterfaceNumber   = 4
  Interface[3]: AlternateSetting  = 0
  Interface[3]: Class             = 0x00000000
  Interface[3]: SubClass          = 0x00000000
  Interface[3]: Protocol          = 0x00000000
  Interface[3]: InterfaceHandle   = 0x00000000
  Interface[3]: NumberOfPipes     = 0
  Interface[4]: Length            = 16
  Interface[4]: InterfaceNumber   = 5
  Interface[4]: AlternateSetting  = 0
  Interface[4]: Class             = 0x00000000
  Interface[4]: SubClass          = 0x00000000
  Interface[4]: Protocol          = 0x00000000
  Interface[4]: InterfaceHandle   = 0x00000000
  Interface[4]: NumberOfPipes     = 0
[3142 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[3142 ms]  >>>  URB 16 going down  >>>
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 56
  Interface: InterfaceNumber   = 2
  Interface: AlternateSetting  = 0
  Interface: Class             = 0x00000000
  Interface: SubClass          = 0x00000000
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 00000000
  Interface: NumberOfPipes     = 0
[3145 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=832f0090, IRQL=0
[3145 ms]  <<<  URB 16 coming back  <<<
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 16
  Interface: InterfaceNumber   = 2
  Interface: AlternateSetting  = 0
  Interface: Class             = 0x00000001
  Interface: SubClass          = 0x00000002
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 83621580
  Interface: NumberOfPipes     = 0
[3145 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[3145 ms]  >>>  URB 17 going down  >>>
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 56
  Interface: InterfaceNumber   = 2
  Interface: AlternateSetting  = 3
  Interface: Class             = 0x00000000
  Interface: SubClass          = 0x00000000
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 00000000
  Interface: NumberOfPipes     = 0
[3187 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=83539d80, IRQL=0
[3187 ms]  <<<  URB 17 coming back  <<<
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 56
  Interface: InterfaceNumber   = 2
  Interface: AlternateSetting  = 3
  Interface: Class             = 0x00000001
  Interface: SubClass          = 0x00000002
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 833b9d68
  Interface: NumberOfPipes     = 2
  Interface: Pipes[0] : MaximumPacketSize = 0x00000128
  Interface: Pipes[0] : EndpointAddress   = 0x00000003
  Interface: Pipes[0] : Interval          = 0x00000001
  Interface: Pipes[0] : PipeType          = 0x00000001 (UsbdPipeTypeIsochronous)
  Interface: Pipes[0] : PipeHandle        = 0x833b9d84
  Interface: Pipes[0] : MaxTransferSize   = 0x00000000
  Interface: Pipes[0] : PipeFlags         = 0x00000000
  Interface: Pipes[1] : MaximumPacketSize = 0x00000003
  Interface: Pipes[1] : EndpointAddress   = 0x00000083
  Interface: Pipes[1] : Interval          = 0x00000001
  Interface: Pipes[1] : PipeType          = 0x00000001 (UsbdPipeTypeIsochronous)
  Interface: Pipes[1] : PipeHandle        = 0x833b9da4
  Interface: Pipes[1] : MaxTransferSize   = 0x00000000
  Interface: Pipes[1] : PipeFlags         = 0x00000000
[3187 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[3187 ms]  >>>  URB 18 going down  >>>
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 76
  Interface: InterfaceNumber   = 4
  Interface: AlternateSetting  = 0
  Interface: Class             = 0x00000000
  Interface: SubClass          = 0x00000000
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 00000000
  Interface: NumberOfPipes     = 0
[3190 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=835fced8, IRQL=0
[3190 ms]  <<<  URB 18 coming back  <<<
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 16
  Interface: InterfaceNumber   = 4
  Interface: AlternateSetting  = 0
  Interface: Class             = 0x00000001
  Interface: SubClass          = 0x00000002
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 83621580
  Interface: NumberOfPipes     = 0
[3190 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[3190 ms]  >>>  URB 19 going down  >>>
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 76
  Interface: InterfaceNumber   = 4
  Interface: AlternateSetting  = 3
  Interface: Class             = 0x00000000
  Interface: SubClass          = 0x00000000
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 00000000
  Interface: NumberOfPipes     = 0
[3207 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=832f0090, IRQL=0
[3207 ms]  <<<  URB 19 coming back  <<<
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 36
  Interface: InterfaceNumber   = 4
  Interface: AlternateSetting  = 3
  Interface: Class             = 0x00000001
  Interface: SubClass          = 0x00000002
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 834a36c8
  Interface: NumberOfPipes     = 1
  Interface: Pipes[0] : MaximumPacketSize = 0x00000128
  Interface: Pipes[0] : EndpointAddress   = 0x00000085
  Interface: Pipes[0] : Interval          = 0x00000001
  Interface: Pipes[0] : PipeType          = 0x00000001 (UsbdPipeTypeIsochronous)
  Interface: Pipes[0] : PipeHandle        = 0x834a36e4
  Interface: Pipes[0] : MaxTransferSize   = 0x00000000
  Interface: Pipes[0] : PipeFlags         = 0x00000000
[3207 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[3207 ms]  >>>  URB 20 going down  >>>
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 76
  Interface: InterfaceNumber   = 5
  Interface: AlternateSetting  = 0
  Interface: Class             = 0x00000000
  Interface: SubClass          = 0x00000000
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 00000000
  Interface: NumberOfPipes     = 0
[3210 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=83539d80, IRQL=0
[3210 ms]  <<<  URB 20 coming back  <<<
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 16
  Interface: InterfaceNumber   = 5
  Interface: AlternateSetting  = 0
  Interface: Class             = 0x00000001
  Interface: SubClass          = 0x00000002
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 83621580
  Interface: NumberOfPipes     = 0
[3210 ms] UsbSnoop - MyDispatchInternalIOCTL(baca1e80) : fdo=83338c10,
Irp=8348a7c0, IRQL=0
[3210 ms]  >>>  URB 21 going down  >>>
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 76
  Interface: InterfaceNumber   = 5
  Interface: AlternateSetting  = 3
  Interface: Class             = 0x00000000
  Interface: SubClass          = 0x00000000
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 00000000
  Interface: NumberOfPipes     = 0
[3227 ms] UsbSnoop - MyInternalIOCTLCompletion(baca1db0) :
fido=00000000, Irp=8348a7c0, Context=835fced8, IRQL=0
[3227 ms]  <<<  URB 21 coming back  <<<
-- URB_FUNCTION_SELECT_INTERFACE:
  ConfigurationHandle     = 0x835a8978
  Interface: Length            = 36
  Interface: InterfaceNumber   = 5
  Interface: AlternateSetting  = 3
  Interface: Class             = 0x00000001
  Interface: SubClass          = 0x00000002
  Interface: Protocol          = 0x00000000
  Interface: InterfaceHandle   = 83631b58
  Interface: NumberOfPipes     = 1
  Interface: Pipes[0] : MaximumPacketSize = 0x00000128
  Interface: Pipes[0] : EndpointAddress   = 0x00000086
  Interface: Pipes[0] : Interval          = 0x00000001
  Interface: Pipes[0] : PipeType          = 0x00000001 (UsbdPipeTypeIsochronous)
  Interface: Pipes[0] : PipeHandle        = 0x83631b74
  Interface: Pipes[0] : MaxTransferSize   = 0x00000000
  Interface: Pipes[0] : PipeFlags         = 0x00000000
[3228 ms] UsbSnoop - MyDispatchPNP(baca2ee0) : IRP_MJ_PNP
(IRP_MN_QUERY_CAPABILITIES)
[3228 ms] UsbSnoop - MyDispatchPNP(baca2ee0) : IRP_MJ_PNP
(IRP_MN_QUERY_PNP_DEVICE_STATE)
[3228 ms] UsbSnoop - MyDispatchPNP(baca2ee0) : IRP_MJ_PNP
(IRP_MN_QUERY_DEVICE_RELATIONS)
[3288 ms] UsbSnoop - MyDispatchPNP(baca2ee0) : IRP_MJ_PNP
(IRP_MN_QUERY_DEVICE_RELATIONS)


Audio driver "magic" successful response:

usb_get_driver_np returned -61
1 get descriptor returned 18, bytes: 12 01 00 01 00 00 00 08 ba 0d 00
30 38 01 01 02 00 01 "...........08....."
2 get descriptor returned 9, bytes: 09 02 86 02 07 01 00 80 fa "........."
3 get descriptor returned 600, bytes: 09 02 86 02 07 01 00 80 fa 09 04
00 00 00 fe 01 00 00 07 21 05 ff ff 08 00 09 04 01 00 00 01 01 00 02
0c 24 01 00 01 60 00 04 02 03 04 05 0c 24 02 05 01 01 00 02 03 00 00
00 09 24 03 06 01 06 00 05 00 0c 24 02 07 01 01 00 02 03 00 00 00 09
24 03 08 01 06 00 07 00 0c 24 02 01 01 06 00 02 03 00 00 00 09 24 03
02 01 01 00 01 00 0c 24 02 03 01 06 00 02 03 00 00 00 09 24 03 04 01
01 00 03 00 09 04 02 00 00 01 02 00 00 09 04 02 02 02 01 02 00 00 07
24 01 05 01 01 00 0e 24 02 01 02 03 18 00 40 1f 00 80 bb 00 09 05 03
05 28 01 01 00 83 07 25 01 00 00 00 00 09 05 83 01 03 00 01 02 00 09
04 02 03 02 01 02 00 00 07 24 01 05 01 01 00 0e 24 02 01 02 03 18 00
40 1f 00 80 bb 00 09 05 03 05 28 01 01 00 83 07 25 01 00 00 00 00 09
05 83 01 03 00 01 02 00 09 04 03 00 00 01 02 00 00 09 04 03 02 02 01
02 00 00 07 24 01 07 01 01 00 0e 24 02 01 02 03 18 00 40 1f 00 80 bb
00 09 05 04 05 28 01 01 00 84 07 25 01 00 00 00 00 09 05 84 01 03 00
01 02 00 09 04 03 03 02 01 02 00 00 07 24 01 07 01 01 00 0e 24 02 01
02 03 18 00 40 1f 00 80 bb 00 09 05 04 05 28 01 01 00 84 07 25 01 00
00 00 00 09 05 84 01 03 00 01 02 00 09 04 03 06 01 01 02 00 00 07 24
01 07 01 01 20 0e 24 02 03 02 02 10 00 40 1f 00 80 bb 00 09 05 04 0d
c0 00 01 00 00 07 25 01 01 00 00 00 09 04 04 00 00 01 02 00 00 09 04
04 02 01 01 02 00 00 07 24 01 02 01 01 00 0e 24 02 01 02 03 18 00 40
1f 00 80 bb 00 09 05 85 05 28 01 01 00 00 07 25 01 00 00 00 00 09 04
04 03 01 01 02 00 00 07 24 01 02 01 01 00 0e 24 02 01 02 03 18 00 40
1f 00 80 bb 00 09 05 85 0d 28 01 01 00 00 07 25 01 01 00 00 00 09 04
05 00 00 01 02 00 00 09 04 05 02 01 01 02 00 00 07 24 01 04 01 01 00
0e 24 02 01 02 03 18 00 40 1f 00 80 bb 00 09 05 86 05 28 01 01 00 00
07 25 01 00 00 00 00 09 04 05 03 01 01 02 00 00 07 24 01 04 01 01 00
0e 24 02 01 02 03 18 00 40 1f 00 80 bb 00
"...................!...............$...`.......$...........$........$...........$........$...........$........$...........$..........................$......$......@.........(.....%........................$......$......@.........(.....%.................................$......$......@.........(.....%........................$......$......@.........(.....%........................$....
.$......@...............%........................$......$......@.........(.....%...............$......$......@.........(.....%........................$......$......@.........(.....%...............$......$......@....."
4 control msg returned 1, bytes: 01 "."
5 control msg returned 1, bytes: 01 "."
6 control msg returned 1, bytes: 01 "."
7 control msg returned 1, bytes: 01 "."
8 control msg returned 1, bytes: 01 "."
9 control msg returned 1, bytes: 01 "."
10 control msg returned 1, bytes: 01 "."
11 control msg returned 1, bytes: 01 "."
12 control msg returned 1, bytes: 01 "."
13 control msg returned 1, bytes: 01 "."
14 control msg returned 1, bytes: 02 "."
15 set configuration returned 0
15 set alternate setting returned 0
16 set alternate setting returned 0
17 set alternate setting returned -22
18 set alternate setting returned 0
19 set alternate setting returned -22
20 set alternate setting returned 0
21 set alternate setting returned -22

I need help! How can I enable the capture/playback?
