From: Tuukka Pasanen <pasanen.tuukka@gmail.com>
Subject: Re: Rane SL-4 USB sound card
Date: Mon, 06 Jul 2015 13:15:52 +0300
Message-ID: <559A5558.4050809@gmail.com>
References: <5597A9AE.2090002@gmail.com> <55996A35.6030904@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id D139F260533
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 12:15:51 +0200 (CEST)
Received: by widjy10 with SMTP id jy10so156354211wid.1
 for <alsa-devel@alsa-project.org>; Mon, 06 Jul 2015 03:15:51 -0700 (PDT)
In-Reply-To: <55996A35.6030904@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
Thanks you for you reply. That did the trick almost. It only gives 
sysdefault with two channels and error:

[176317.418587] usb 1-5: parse_audio_format_rates_v2(): unable to 
retrieve number of sample rates (clock 5)
[176317.419156] usb 1-5: parse_audio_format_rates_v2(): unable to 
retrieve number of sample rates (clock 5)

I figured out this kind of QUIRK which seems to be working (go to test 
tomorrow more). I would go with first quirck as it's looking simpler but 
I can't add rates to it?

{
     USB_DEVICE(0x1cc5, 0x000f),
     .driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
         .ifnum = QUIRK_ANY_INTERFACE,
         .type = QUIRK_COMPOSITE,
         .data = (const struct snd_usb_audio_quirk[]) {
             {
                 .ifnum = 1,
                 .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                 .data = &(const struct audioformat) {
                     .formats = SNDRV_PCM_FMTBIT_S24_3LE,
                     .channels = 4,
                     .iface = 1,
                     .altsetting = 1,
                     .altset_idx = 1,
                     .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
                     .endpoint = 0x06,
                     .ep_attr = USB_ENDPOINT_XFER_ISOC,
                     .rates = SNDRV_PCM_RATE_48000 |
                          SNDRV_PCM_RATE_96000,
                     .rate_min = 48000,
                     .rate_max = 96000,
                     .nr_rates = 2,
                     .rate_table = (unsigned int[]) {
                         48000, 96000
                     }
                 }
             },
             {
                 .ifnum = 2,
                 .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                 .data = &(const struct audioformat) {
                     .formats = SNDRV_PCM_FMTBIT_S24_3LE,
                     .channels = 4,
                     .iface = 2,
                     .altsetting = 1,
                     .altset_idx = 1,
                     .attributes = UAC_EP_CS_ATTR_SAMPLE_RATE,
                     .endpoint = 0x82,
                     .ep_attr = USB_ENDPOINT_XFER_ISOC,
                     .rates = SNDRV_PCM_RATE_48000 |
                          SNDRV_PCM_RATE_96000,
                     .rate_min = 48000,
                     .rate_max = 96000,
                     .nr_rates = 2,
                     .rate_table = (unsigned int[]) {
                         48000, 96000
                     }
                 }
             },
             {
                 .ifnum = -1,
             }
         }
     }
},

Sincerely,
Tuukka

05.07.2015, 20:32, Clemens Ladisch kirjoitti:
> Tuukka Pasanen wrote:
>> I've been hacking to get Rane SL-4 USB audio ... to work with ALSA.
>> I have compiled kernel and tried to get USB-quirks to work with this ... it doesn't do the trick
>> If I need interface association how to do that?
> The interface association descriptor should have been provided by the firmware.
>
> Anyway, try the following quirk:
>
> {
> 	USB_DEVICE(0x1cc5, 0x000f),
> 	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
> 		.ifnum = QUIRK_ANY_INTERFACE,
> 		.type = QUIRK_COMPOSITE,
> 		.data = (const struct snd_usb_audio_quirk[]) {
> 			{
> 				.ifnum = 1,
> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> 			},
> 			{
> 				.ifnum = 2,
> 				.type = QUIRK_AUDIO_STANDARD_INTERFACE
> 			},
> 			{
> 				.ifnum = -1,
> 			}
> 		}
> 	}
> },
>
>
> Regards,
> Clemens
