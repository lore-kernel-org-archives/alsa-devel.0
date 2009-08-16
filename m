From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: Digidesign Mbox2 - usb support
Date: Sun, 16 Aug 2009 18:27:34 +1000
Message-ID: <98ec50f0908160127k17249517x9026107d30938977@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f223.google.com (mail-ew0-f223.google.com
	[209.85.219.223])
	by alsa0.perex.cz (Postfix) with ESMTP id 4C0F524153
	for <alsa-devel@alsa-project.org>;
	Sun, 16 Aug 2009 10:27:35 +0200 (CEST)
Received: by ewy23 with SMTP id 23so2454034ewy.32
	for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2009 01:27:34 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I wrote an addition to usbquirks.h to provide support for "Digidesign
Mbox 2" but I need someone to point me in the right direction as to
which interfaces to use.  I'm not sure if the MIDI interface is a
standard device, and I'm not sure which interfaces to ignore.
I am about to compile a new alsa + kernel with my changes to
usbquirks.h to test the device.

Here is my usbquirks.h addition:

/* DIGIDESIGN MBOX 2 addition to usbquirks.h */

{
	/* Damien Zammit <damien.zammit@gmail.com>
	 * 16 August 2009
	 *
	 * Interface topology of Digidesign Mbox 2, it has 7 interfaces:
	 * 	0 - Proprietary firmware updates
	 * 	1 - Audio control device
	 * 	2 - Double endpoint IN-OUT PCM
	 * 	3 - Double endpoint OUT-IN PCM
	 * 	4 - Single endpoint IEC1937 AC3	/ PCM (selectable by altsetting)
	 * 	5 - Single endpoint PCM (supports full 24bit 48000Hz)
	 * 	6 - Triple endpoint MIDI (Interrupt + 1 IN + 1 OUT)
	 *
	 * As I am unsure which interfaces to try, I have provided _all_ the settings
	 * I can in this file to hand to the usb-audio developers.
	 * I have no idea what .altset_idx does or where to find it, so I set
it to 1 in all cases.
	 *
	 * I am currently testing with just interfaces 5 and 6 (not sure if
it will work)
	 */
	
	USB_DEVICE(0x0dba, 0x3000),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
		.vendor_name = "Digidesign",
		.product_name = "Mbox 2",
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = (const struct snd_usb_audio_quirk[]) {
			/* Proprietary firmware updater interface - ignore for now */
			{
				.ifnum = 0,
				.type = QUIRK_IGNORE_INTERFACE
			},

			/* Audio control interface - altsetting = 0 not sure what to do with this */
			{
				.ifnum = 1,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{
				.ifnum = 2,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat) {
					.format = SNDDRV_PCM_FORMAT_S24_3LE,
					.channels = 2,
					.iface = 2,
					.altsetting = 3, /* 0 is also available but has no endpoints */
					.altset_idx = 1,
					.endpoint = 0x03, /* IN or 0x83 OUT */
					.ep_attr = 0x05,
					.rates = SNDRV_PCM_RATE_CONTINUOUS,
					.rate_min = 8000,
					.rate_max = 48000
				}
			},
			{
                                .ifnum = 3,
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = & (const struct audioformat) {
                                        .format = SNDDRV_PCM_FORMAT_S24_3LE,
                                        .channels = 2,
                                        .iface = 3,
                                        .altsetting = 3, /* 0 is also
available, but has no endpoints */
                                        .altset_idx = 1,
                                        .endpoint = 0x04, /* OUT or 0x84 IN */
                                        .ep_attr = 0x05,
                                        .rates = SNDRV_PCM_RATE_CONTINUOUS,
                                        .rate_min = 8000,
                                        .rate_max = 48000
                                }
                        },
			{
                                .ifnum = 4,
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = & (const struct audioformat) {
                                        .format = <<<<< Type III -
IEC1937_AC3 (16 bit) >>>>>
                                        .channels = 2,
                                        .iface = 3,
                                        .altsetting = 6,
                                        .altset_idx = 1,
					.endpoint = 0x04,
                                        .ep_attr = 0x05,
                                        .rates = SNDRV_PCM_RATE_CONTINUOUS,
                                        .rate_min = 8000,
                                        .rate_max = 48000
                                }
                        },
			{
                                .ifnum = 5,
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = & (const struct audioformat) {
                                        .format = SNDDRV_PCM_FORMAT_S24_3LE,
                                        .channels = 2,
                                        .iface = 5,
                                        .altsetting = 3,
                                        .altset_idx = 1,
                                        .endpoint = 0x86, /* Single
endpoint only */
                                        .ep_attr = 0x0D,
                                        .rates = SNDRV_PCM_RATE_CONTINUOUS,
                                        .rate_min = 8000,
                                        .rate_max = 48000
                                }
                        },

			{

/* MIDI INTERFACE DESCRIPTION
 * Is this a standard USB MIDI device?
 * It has 2 Interface descriptors for the same altsetting...

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        6
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
          bDescriptorSubtype      1 (EP_GENERAL)
          bmAttributes         0x01
            Sampling Frequency
          bLockDelayUnits         0 Undefined
          wLockDelay              0 Undefined

    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        6
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       255 Vendor Specific Class
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               0
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0010  1x 16 bytes
        bInterval               0
*/

				.ifnum = 6,
				.type = QUIRK_MIDI_FIXED_ENDPOINT,
				.data = & (const struct snd_usb_midi_endpoint_info) {
					/* I am not certain of the "cables" flags or how
					 * to find out what they are.
					 */
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
