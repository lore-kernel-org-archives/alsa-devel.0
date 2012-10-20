From: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Sat, 20 Oct 2012 15:03:03 +0200
Message-ID: <1350738183.25322.7.camel@didier-laptop>
References: <1350652166.5549.8.camel@didier-laptop>
 <5081539E.40705@gmail.com> <1350654327.8310.4.camel@didier-laptop>
 <50815B51.3090402@gmail.com> <1350659344.5494.11.camel@didier-laptop>
 <508195B4.2090809@gmail.com> <1350728568.5932.6.camel@didier-laptop>
 <50829DEE.7020004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 95842264F2B
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 15:03:09 +0200 (CEST)
In-Reply-To: <50829DEE.7020004@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I'm making some progress!! :)

I did not yet tried what you suggested below. But I did add that to
quirk-table.h:

#if 1
/* Reloop Play */
{
	USB_DEVICE(0x200c, 0x100b),
	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
		.vendor_name = "Reloop",
		.product_name = "Play",
		.ifnum = QUIRK_ANY_INTERFACE,
		.type = QUIRK_COMPOSITE,
		.data = &(const struct snd_usb_audio_quirk[]) {
			{
				.ifnum = 0,
				.type = QUIRK_IGNORE_INTERFACE,
			},
			{
				.ifnum = 1,
				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
				.data = &(const struct audioformat) {
					.formats = SNDRV_PCM_FMTBIT_S24_LE,
					.channels = 4,
					.iface = 1,
					.altsetting = 1,
					.altset_idx = 1,
					.attributes = 0,
					.endpoint = 0x01,
					.ep_attr = 0x05,
					.rates = SNDRV_PCM_RATE_44100 |
						 SNDRV_PCM_RATE_48000,
					.rate_min = 44100,
					.rate_max = 48000,
					.nr_rates = 2,
					.rate_table = (unsigned int[]) {
						44100, 48000
					}
				}
			},
			{
				.ifnum = -1
			}
		}
	}
},
#endif

Did some:
rmmod snd-usb-audio && make modules && cp -v
sound/usb/snd-usb*.ko /lib/modules/3.5.7-mbp83+/kernel/sound/usb/

Added this to my .asoundrc:

pcm.play {
    type plug
    slave {
        pcm "hw:1"
        format S24_LE
        channels 4
    }
}

And now I don't have strange sounds when plugin the card but silence.
And I can hear a distant "Front Center" above some noise (but no noise
in-beetween the words) when doing :

didier@didier-laptop ~ $ cat /proc/asound/card1/stream0 && aplay
-Dplay /usr/share/sounds/alsa/Front_Center.wav
Reloop Play at usb-0000:00:1a.7-1.3, full speed : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S24_LE
    Channels: 4
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 44100, 48000
Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
Little Endian, Rate 48000 Hz, Mono

I guess now is just finding the correct values for:

- .formats (which can any of the 24 bits formats)
- .maxPacketSize (not clear to me what this is)
- .ep_attr (not clear to me what a endpoint is and what are those ASYNC,
ADAPTIVE, ISOCHRONOUS attributes are nor the hex value table)

Am I right ??

Didier.

On sam., 2012-10-20 at 14:49 +0200, Daniel Mack wrote:
> On 20.10.2012 12:22, Didier 'Ptitjes' Villevalois wrote:
> > On ven., 2012-10-19 at 20:02 +0200, Daniel Mack wrote:
> > [...]
> >> Let me know of you make any progress here.
> >>
> > I diff-ed the ioreg output when the play is connected without the driver
> > (-) and with the driver (+). So I can see that it is using its
> > proprietary driver.
> > 
> > http://ptitjes.free.fr/reloop-play/play-ioreg-without-and-with-driver.diff
> 
> Hmm, that output doesn't make a whole lot of sense. Could you do the
> same thing with lsusb under Linux? Boot into Linux after the OS X driver
> downloaded the firmware for one run, and freshly connect (power cycle)
> device for the other.
> 
> > I also traced (with Apple's USB Probe tool) the USB when connecting the
> > PLAY.
> > 
> > At log level 6:
> > http://ptitjes.free.fr/reloop-play/usb-log-withdriver-l6.txt
> > 
> > At log level 7: (3.5Mo!!)
> > http://ptitjes.free.fr/reloop-play/usb-log-withdriver-l7.txt
> > 
> > I have to do the same thing when streaming some sound. But should I
> > output some easily recognizable sound ? Something like a sine or some
> > silence ?
> 
> Yes, that can help. You could for example stream a sine that is on just
> one channel, so you can debug the muxing (interleaving) on the wire. Or
> a sine at ~ -48dB, which would just leave the 8 MSB empty (to check the
> endianess).
> 
> Most probably though, the streaming mode is already supported by the
> Linux driver, and it's the recognition of the right format that fails,
> or the cards needs a different setup sequence than the generic one.
> 
> 
> Daniel
