From: LCID Fire <lcid-fire@gmx.net>
Subject: Re: Questions on usb audio development
Date: Mon, 21 May 2007 22:51:33 +0200
Message-ID: <46520655.7000402@gmx.net>
References: <46506D9D.4000701@gmx.net>	<75b66ecd0705201225w5e6a7e28t7a61f000cd5e2352@mail.gmail.com>
	<s5hk5v2p4az.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 827032441E
	for <alsa-devel@alsa-project.org>;
	Mon, 21 May 2007 22:51:36 +0200 (CEST)
In-Reply-To: <s5hk5v2p4az.wl%tiwai@suse.de>
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

Takashi Iwai wrote:
> The major difference between the normal PCI and USB audio drivers is
> that USB audio has no traditional DMA like most PCI devices have.
> Thus the driver has to sets up URB pakets.  usb-audio driver creates
> an intermediate ring-buffer that is used for the communication from/to
> user-space, and URBs are made from this buffer.

Basicly the reoccuring interface pattern I'm facing is:

bLength                 9
bDescriptorType         4
bInterfaceNumber        5
bAlternateSetting       1
bNumEndpoints           1
bInterfaceClass       255 Vendor Specific Class
bInterfaceSubClass      2
bInterfaceProtocol      0
iInterface              6 LineIn2
Class specific interface descriptor for class 255 is unsupported
Class specific interface descriptor for class 255 is unsupported
	Endpoint Descriptor:
		bLength                 9
		bDescriptorType         5
		bEndpointAddress     0x84  EP 4 IN
		bmAttributes            9
			Transfer Type            Isochronous
			Synch Type               Adaptive
			Usage Type               Data
		wMaxPacketSize     0x00b8  1x 184 bytes
		bInterval               1
		bRefresh                0
		bSynchAddress           0


Which is - if you ask me a normal audio token - hidden as a vendor
specific interface. So what do you think, are these 2 descriptors just
the audio format info or have they really embedded some specific info
for the class? Question is whether to wire that with FIXED_ENDPOINT or
STANDARD_INTERFACE?

The others are:
bLength                 9
bDescriptorType         4
bInterfaceNumber        0
bAlternateSetting       0
bNumEndpoints           0
bInterfaceClass       255 Vendor Specific Class
bInterfaceSubClass      1
bInterfaceProtocol      0
iInterface             15 Line 1
Class specific interface descriptor for class 255 is unsupported
Class specific interface descriptor for class 255 is unsupported
Class specific interface descriptor for class 255 is unsupported
Class specific interface descriptor for class 255 is unsupported
Class specific interface descriptor for class 255 is unsupported
Class specific interface descriptor for class 255 is unsupported

Which again does not seem to be more than the sync node of an audio
device (especially as it seems like they did not even change the subclass).

Well and I just for a start tried to write a quirks sections for these
nodes like:

{
	USB_DEVICE(0x13e5, 0x0001),
	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk)
	{
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,		
		.data = & (const struct snd_usb_audio_quirk[])
		{
			{
				.ifnum = 0,
				.altsetting = 0,
				.type = QUIRK_AUDIO_STANDARD_INTERFACE
			},
			{
				.ifnum = 0,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat)
				{
					.format = SNDRV_PCM_FORMAT_S16_LE,
					.channels = 2,
					.iface = 0,
					.altsetting = 1,
					.altset_idx = 1,
					.attributes = 0,
					.endpoint = 0x01,
					.ep_attr = 0x09,
					.rates = SNDRV_PCM_RATE_CONTINUOUS,
					.rate_min = 44100,
					.rate_max = 44100,
				}
			},
			{
				.ifnum = 2,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat)
				{
					.format = SNDRV_PCM_FORMAT_S16_LE,
					.channels = 2,
					.iface = 2,
					.altsetting = 1,
					.altset_idx = 1,
					.attributes = 0,
					.endpoint = 0x82,
					.ep_attr = 0x09,
					.rates = SNDRV_PCM_RATE_CONTINUOUS,
					.rate_min = 44100,
					.rate_max = 44100,
				}
				
			},
			{
				.ifnum = 3,
				.altsetting = 0,
				.type = QUIRK_AUDIO_STANDARD_INTERFACE
			},
			{
				.ifnum = 4,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat)
				{
					.format = SNDRV_PCM_FORMAT_S16_LE,
					.channels = 2,
					.iface = 4,
					.altsetting = 1,
					.altset_idx = 1,
					.attributes = 0,
					.endpoint = 0x04,
					.ep_attr = 0x09,
					.rates = SNDRV_PCM_RATE_CONTINUOUS,
					.rate_min = 44100,
					.rate_max = 44100,
				}
			},
			{
				.ifnum = 5,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat)
				{
					.format = SNDRV_PCM_FORMAT_S16_LE,
					.channels = 2,
					.iface = 5,
					.altsetting = 1,
					.altset_idx = 1,
					.attributes = 0,
					.endpoint = 0x84,
					.ep_attr = 0x09,
					.rates = SNDRV_PCM_RATE_CONTINUOUS,
					.rate_min = 44100,
					.rate_max = 44100,
				}
			},
			{
				.ifnum = 6,
				.altsetting = 0,
				.type = QUIRK_AUDIO_STANDARD_INTERFACE
			},
			{
				.ifnum = 7,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat)
				{
					.format = SNDRV_PCM_FORMAT_S16_LE,
					.channels = 2,
					.iface = 7,
					.altsetting = 1,
					.altset_idx = 1,
					.attributes = 0,
					.endpoint = 0x85,
					.ep_attr = 0x09,
					.rates = SNDRV_PCM_RATE_CONTINUOUS,
					.rate_min = 44100,
					.rate_max = 44100,
				}
			},
			{
				.ifnum = -1
			}
		}
	}
},

So could anyone please tell me whether I'm totally lost on a wrong track?
