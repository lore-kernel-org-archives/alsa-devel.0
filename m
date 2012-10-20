From: Daniel Mack <zonque@gmail.com>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Sat, 20 Oct 2012 17:00:43 +0200
Message-ID: <5082BC9B.3030403@gmail.com>
References: <1350652166.5549.8.camel@didier-laptop>
 <1350743061.25322.15.camel@didier-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id 84F8D264F45
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 17:00:46 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so411477bku.38
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 08:00:46 -0700 (PDT)
In-Reply-To: <1350743061.25322.15.camel@didier-laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Didier Villevalois <didier@villevalois.com>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

On 20.10.2012 16:24, Didier Villevalois wrote:
> OK this quirk works perfectly! (hooray!!!)
> 
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
> 				.type = QUIRK_AUDIO_STANDARD_MIXER,
> 			},
> 			{
> 				.ifnum = 1,
> 				.type = QUIRK_AUDIO_FIXED_ENDPOINT,
> 				.data = &(const struct audioformat) {
> 					.formats = SNDRV_PCM_FMTBIT_S24_3LE,
> 					.channels = 4,
> 					.iface = 1,
> 					.altsetting = 1,
> 					.altset_idx = 1,
> 					.attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
> 					.endpoint = 0x01,
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
> 
> Does anyone have additional comments to do before I make a patch ?

Let's ask Clemens - the quirks master - for comments :)

> Also are there some special ALSA rules or straight signed-off
> git-formated patches over the kernel tree are OK ?

That's ok. The patch should apply on top of

  git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

though.

> Thanks again for your help! I'm really happy to have a working
> device! :D

Good work! I just really wonder what that updated firmware is all about ...


Daniel
