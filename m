From: Didier 'Ptitjes' Villevalois <ptitjes@free.fr>
Subject: Re: usb-audio: Reloop Play support (TI TUSB3200AC)
Date: Sat, 20 Oct 2012 16:30:58 +0200
Message-ID: <1350743458.25322.16.camel@didier-laptop>
References: <1350652166.5549.8.camel@didier-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
 by alsa0.perex.cz (Postfix) with ESMTP id 57EF8264F45
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 16:31:04 +0200 (CEST)
In-Reply-To: <1350652166.5549.8.camel@didier-laptop>
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
Cc: Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

OK this quirk works perfectly! (hooray!!!)

/* Reloop Play */
{
        USB_DEVICE(0x200c, 0x100b),
        .bInterfaceClass = USB_CLASS_PER_INTERFACE,
        .driver_info = (unsigned long) &(const struct
snd_usb_audio_quirk) {
                .vendor_name = "Reloop",
                .product_name = "Play",
                .ifnum = QUIRK_ANY_INTERFACE,
                .type = QUIRK_COMPOSITE,
                .data = &(const struct snd_usb_audio_quirk[]) {
                        {
                                .ifnum = 0,
                                .type = QUIRK_AUDIO_STANDARD_MIXER,
                        },
                        {
                                .ifnum = 1,
                                .type = QUIRK_AUDIO_FIXED_ENDPOINT,
                                .data = &(const struct audioformat) {
                                        .formats =
SNDRV_PCM_FMTBIT_S24_3LE,
                                        .channels = 4,
                                        .iface = 1,
                                        .altsetting = 1,
                                        .altset_idx = 1,
                                        .attributes =
UAC_EP_CS_ATTR_SAMPLE_RATE,
                                        .endpoint = 0x01,
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

Does anyone have additional comments to do before I make a patch ?
Also are there some special ALSA rules or straight signed-off
git-formated patches over the kernel tree are OK ?

Thanks again for your help! I'm really happy to have a working
device! :D

Didier.
