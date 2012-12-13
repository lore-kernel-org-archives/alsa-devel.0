From: Damien Zammit <damien.zammit@gmail.com>
Subject: Re: sound: usb-audio: full capture/playback/spdif
 support for Digidesign Mbox 2
Date: Thu, 13 Dec 2012 17:21:55 +1100
Message-ID: <CABXa2sE_WRgCv_Ym9gD2s0bggwBghSUsJhOamSYrNhq80_F8Bw@mail.gmail.com>
References: <AANLkTi=cSDq5SEh321Zy2n2RMHWFnW2-hd-=k9mz+eEz@mail.gmail.com>
 <4CEED787.9050504@gmail.com>
 <AANLkTimjaYMaqA3fFqWKi0+8nsaqENe8oWj=hph1Hv09@mail.gmail.com>
 <s5hfwukp4k4.wl%tiwai@suse.de>
 <AANLkTi=3JSsaa=P5s31+fq75Jp0WQUKD7mu0Ft8Tq+bP@mail.gmail.com>
 <4CF517BF.4020706@ladisch.de>
 <AANLkTi=Y6tA=1CW6Yu0rpAm7=JyLLjA1A-4cL-JFaBrP@mail.gmail.com>
 <AANLkTimH8OfncsS_WPtXGgFN316YeJQMtEEfkxXmEuQ8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f51.google.com (mail-la0-f51.google.com
 [209.85.215.51])
 by alsa0.perex.cz (Postfix) with ESMTP id C6A832615EE
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2012 07:21:57 +0100 (CET)
Received: by mail-la0-f51.google.com with SMTP id e4so1413491lag.38
 for <alsa-devel@alsa-project.org>; Wed, 12 Dec 2012 22:21:57 -0800 (PST)
In-Reply-To: <AANLkTimH8OfncsS_WPtXGgFN316YeJQMtEEfkxXmEuQ8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi I thought I would post an update on this thread.
I realise it is quite old but what I have now is relevant.

/*
 * Digidesign Mbox 2
 *
 * Interface list:
 * 0    Firmware
 * 1    Control
 * 2    Playback        (Async)
 * 3    IEC958                  (Ignore)
 * 4    Record          (Sync)
 * 5    Record          (Async) (Ignore)
 * 6    MIDI
 *
 */

My previous posts may have demonstrated a lack of understanding of how
USB audio devices work, but I believe I have learnt a bit more since
last time I posted.

I have determined that there is a combination of altsettings for this
device that allows hardcoding of them and still provides duplex
support, ie, the fact that it supports multiple endpoints is
irrelevant.
If you use interfaces 2 and 4 both with #2 altsetting, hardcode the
samplerate to 48000Hz (max) and the bit depth at 24 (max) and send
some control magic to set it up, it works great!

It also requires a boot quirk to load firmware into the device from an
onboard memory chip.  I determined the control sequence to do so but
it also needs a 3 second delay while the firmware activates and I dont
have the knowledge to do a proper in-kernel delay.

In summary there are 3 parts to make this device work:
1) Boot quirk - load firmware and wait 3 seconds
2) Set up samplerate/bitrate in the device once and force S24_3BE format.
3) Select interfaces 2 and 4 both with altsetting 2, and interface 6 for midi.

I can provide working code for all three steps (except the waiting
part is dodgey).  I can't submit a proper patch.  I hope we can get
this accepted into your alsa usb driver soon because maintaining a
small quirk is time consuming for me.  I don't feel right cloning your
entire code and attaching a tiny quirk to it and releasing it on my
website for others, but so far it's the only way people have been able
to use this device in linux.  I have about 200 valid comments on my
blog post about it.

Here is the quirk part:

{
	USB_DEVICE(0x0dba, 0x3000),
	.driver_info = (unsigned long) & (const struct snd_mbox2_quirk) {
		.vendor_name = "Digidesign",
		.product_name = "Mbox 2",
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = (const struct snd_mbox2_quirk[]) {
			{
				.ifnum = 0,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{
				.ifnum = 1,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{
				.ifnum = 2,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = & (const struct audioformat) {
					.formats = SNDRV_PCM_FMTBIT_S24_3BE,
					.channels = 2,
					.iface = 2,
					.altsetting = 2,
					.altset_idx = 1,
					.attributes = 0x00,
					.endpoint = 0x03,
					.ep_attr = USB_ENDPOINT_SYNC_ASYNC,
					.maxpacksize = 0x128,
					.rates = SNDRV_PCM_RATE_48000,
					.rate_min = 48000,
					.rate_max = 48000,
					.nr_rates = 1,
					.rate_table = (unsigned int[]) {
						48000
					}
				}
			},
			{
				.ifnum = 3,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{
				.ifnum = 4,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
                               	.data = & (const struct audioformat) {
                                        .formats = SNDRV_PCM_FMTBIT_S24_3BE,
                                        .channels = 2,
                                        .iface = 4,
                                        .altsetting = 2,
                                        .altset_idx = 1,
                                        .attributes =
UAC_EP_CS_ATTR_SAMPLE_RATE,
                                        .endpoint = 0x85,
                                        .ep_attr = USB_ENDPOINT_SYNC_SYNC,
                                        .maxpacksize = 0x128,
                                        .rates = SNDRV_PCM_RATE_48000,
                                        .rate_min = 48000,
                                        .rate_max = 48000,
                                        .nr_rates = 1,
                                        .rate_table = (unsigned int[]) {
                                                48000
                                        }
                                }
			},
			{
				.ifnum = 5,
				.type = QUIRK_IGNORE_INTERFACE
			},
			{
				.ifnum = 6,
				.type = QUIRK_MIDI_MBOX2,
				.data = & (const struct snd_usb_midi_endpoint_info) {
					.out_ep =  0x02,
					.out_cables = 0x0001,
					.in_ep = 0x81,
					.in_interval = 0x01,
					.in_cables = 0x0001
				}
			},
			{
				.ifnum = -1
			}
		}
	}
},
