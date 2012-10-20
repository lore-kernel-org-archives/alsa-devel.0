From: Daniel Mack <zonque@gmail.com>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Sat, 20 Oct 2012 15:06:54 +0200
Message-ID: <5082A1EE.4020000@gmail.com>
References: <1350652166.5549.8.camel@didier-laptop> <5081539E.40705@gmail.com>
 <1350654327.8310.4.camel@didier-laptop> <50815B51.3090402@gmail.com>
 <1350659344.5494.11.camel@didier-laptop> <508195B4.2090809@gmail.com>
 <1350728568.5932.6.camel@didier-laptop> <50829DEE.7020004@gmail.com>
 <1350738183.25322.7.camel@didier-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 3836D264F2B
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 15:06:57 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so399930bku.38
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 06:06:56 -0700 (PDT)
In-Reply-To: <1350738183.25322.7.camel@didier-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 20.10.2012 15:03, Didier 'Ptitjes' Villevalois wrote:
> I'm making some progress!! :)

Very good.

> I did not yet tried what you suggested below. But I did add that to
> quirk-table.h:
> 
> #if 1
> /* Reloop Play */
> {
> 	USB_DEVICE(0x200c, 0x100b),
> 	.bInterfaceClass = USB_CLASS_PER_INTERFACE,
> 	.driver_info = (unsigned long) &(const struct snd_usb_audio_quirk) {
> 		.vendor_name = "Reloop",
> 		.product_name = "Play",
> 		.ifnum = QUIRK_ANY_INTERFACE,
> 		.type = QUIRK_COMPOSITE,
> 		.data = &(const struct snd_usb_audio_quirk[]) {
> 			{
> 				.ifnum = 0,
> 				.type = QUIRK_IGNORE_INTERFACE,
> 			},
> 			{
> 				.ifnum = 1,
> 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
> 				.data = &(const struct audioformat) {
> 					.formats = SNDRV_PCM_FMTBIT_S24_LE,
> 					.channels = 4,
> 					.iface = 1,
> 					.altsetting = 1,
> 					.altset_idx = 1,
> 					.attributes = 0,
> 					.endpoint = 0x01,
> 					.ep_attr = 0x05,
> 					.rates = SNDRV_PCM_RATE_44100 |
> 						 SNDRV_PCM_RATE_48000,
> 					.rate_min = 44100,
> 					.rate_max = 48000,
> 					.nr_rates = 2,
> 					.rate_table = (unsigned int[]) {
> 						44100, 48000
> 					}
> 				}
> 			},
> 			{
> 				.ifnum = -1
> 			}
> 		}
> 	}
> },
> #endif
> 
> Did some:
> rmmod snd-usb-audio && make modules && cp -v
> sound/usb/snd-usb*.ko /lib/modules/3.5.7-mbp83+/kernel/sound/usb/
> 
> Added this to my .asoundrc:
> 
> pcm.play {
>     type plug
>     slave {
>         pcm "hw:1"
>         format S24_LE
>         channels 4
>     }
> }
> 
> And now I don't have strange sounds when plugin the card but silence.
> And I can hear a distant "Front Center" above some noise (but no noise
> in-beetween the words) when doing :

Ok, but you still need the firmware I guess? Or does this even work
after you plugged in the device under Linux?

> didier@didier-laptop ~ $ cat /proc/asound/card1/stream0 && aplay
> -Dplay /usr/share/sounds/alsa/Front_Center.wav
> Reloop Play at usb-0000:00:1a.7-1.3, full speed : USB Audio
> 
> Playback:
>   Status: Stop
>   Interface 1
>     Altset 1
>     Format: S24_LE
>     Channels: 4
>     Endpoint: 1 OUT (ADAPTIVE)
>     Rates: 44100, 48000
> Playing WAVE '/usr/share/sounds/alsa/Front_Center.wav' : Signed 16 bit
> Little Endian, Rate 48000 Hz, Mono
> 
> I guess now is just finding the correct values for:
> 
> - .formats (which can any of the 24 bits formats)
> - .maxPacketSize (not clear to me what this is)
> - .ep_attr (not clear to me what a endpoint is and what are those ASYNC,
> ADAPTIVE, ISOCHRONOUS attributes are nor the hex value table)
> 
> Am I right ??

Possibly yes. You can try and blindly guess them, or really dive into
the logs and try to understand the reason.


Daniel
