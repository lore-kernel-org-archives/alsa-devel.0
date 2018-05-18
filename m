From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH] ALSA: dice: add stream format parameters
 for Mytek devices
Date: Fri, 18 May 2018 11:54:01 +0900
Message-ID: <3d9fd8b0-d67e-0591-ed6d-8eec562ab58b@sakamocchi.jp>
References: <20632004.ST2tKRhYS0@melvin-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy002.phy.lolipop.jp (smtp-proxy002.phy.lolipop.jp
 [157.7.104.43]) by alsa0.perex.cz (Postfix) with ESMTP id C7C9226707F
 for <alsa-devel@alsa-project.org>; Fri, 18 May 2018 04:54:04 +0200 (CEST)
In-Reply-To: <20632004.ST2tKRhYS0@melvin-pc>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Melvin Vermeeren <mail@mel.vin>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On May 18 2018 04:00, Melvin Vermeeren wrote:
> Mytek manufactures some equipment with DICE-based firewire ports. These
> devices contain old versions of DICE firmware which lacks detailed
> stream format reporting for all sampling clock modes.
> 
> Building upon the recent work by Takashi Sakamoto, hard-coded parameters
> are added for the Stereo 192 DSD-DAC. When the device vendor and model
> match the coded parameters are copied into the stream format cache.
> 
> Signed-off-by: Melvin Vermeeren <mail@mel.vin>
> ---
>   sound/firewire/dice/Makefile     |  2 +-
>   sound/firewire/dice/dice-mytek.c | 46 ++++++++++++++++++++++++++++++++
>   sound/firewire/dice/dice.c       |  9 +++++++
>   sound/firewire/dice/dice.h       |  1 +
>   4 files changed, 57 insertions(+), 1 deletion(-)
>   create mode 100644 sound/firewire/dice/dice-mytek.c

Thanks for this patch.
Reviewed-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>

> diff --git a/sound/firewire/dice/Makefile b/sound/firewire/dice/Makefile
> index 7b7997a5754c..37062a233f6a 100644
> --- a/sound/firewire/dice/Makefile
> +++ b/sound/firewire/dice/Makefile
> @@ -1,4 +1,4 @@
>   snd-dice-objs := dice-transaction.o dice-stream.o dice-proc.o dice-midi.o \
>   		 dice-pcm.o dice-hwdep.o dice.o dice-tcelectronic.o \
> -		 dice-alesis.o dice-extension.o
> +		 dice-alesis.o dice-extension.o dice-mytek.o
>   obj-$(CONFIG_SND_DICE) += snd-dice.o
> diff --git a/sound/firewire/dice/dice-mytek.c b/sound/firewire/dice/dice-mytek.c
> new file mode 100644
> index 000000000000..eb7d5492d10b
> --- /dev/null
> +++ b/sound/firewire/dice/dice-mytek.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * dice-mytek.c - a part of driver for DICE based devices
> + *
> + * Copyright (c) 2018 Melvin Vermeeren
> + */
> +
> +#include "dice.h"
> +
> +struct dice_mytek_spec {
> +	unsigned int tx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
> +	unsigned int rx_pcm_chs[MAX_STREAMS][SND_DICE_RATE_MODE_COUNT];
> +};
> +
> +static const struct dice_mytek_spec stereo_192_dsd_dac = {
> +	/* AES, TOSLINK, SPDIF, ADAT inputs on device */
> +	.tx_pcm_chs = {{8, 8, 8}, {0, 0, 0} },
> +	/* PCM 44.1-192, native DSD64/DSD128 to device */
> +	.rx_pcm_chs = {{4, 4, 4}, {0, 0, 0} }
> +};
> +
> +/*
> + * Mytek has a few other firewire-capable devices, though newer models appear
> + * to lack the port more often than not. As I don't have access to any of them
> + * they are missing here. An example is the Mytek 8x192 ADDA, which is DICE.
> + */
> +
> +int snd_dice_detect_mytek_formats(struct snd_dice *dice)
> +{
> +	int i;
> +	const struct dice_mytek_spec *dev;
> +
> +	dev = &stereo_192_dsd_dac;
> +
> +	memcpy(dice->tx_pcm_chs, dev->tx_pcm_chs,
> +	       MAX_STREAMS * SND_DICE_RATE_MODE_COUNT * sizeof(unsigned int));
> +	memcpy(dice->rx_pcm_chs, dev->rx_pcm_chs,
> +	       MAX_STREAMS * SND_DICE_RATE_MODE_COUNT * sizeof(unsigned int));
> +
> +	for (i = 0; i < MAX_STREAMS; ++i) {
> +		dice->tx_midi_ports[i] = 0;
> +		dice->rx_midi_ports[i] = 0;
> +	}
> +
> +	return 0;
> +}
> diff --git a/sound/firewire/dice/dice.c b/sound/firewire/dice/dice.c
> index 40f7a32e4893..beeef62581ba 100644
> --- a/sound/firewire/dice/dice.c
> +++ b/sound/firewire/dice/dice.c
> @@ -17,6 +17,7 @@ MODULE_LICENSE("GPL v2");
>   #define OUI_TCELECTRONIC	0x000166
>   #define OUI_ALESIS		0x000595
>   #define OUI_MAUDIO		0x000d6c
> +#define OUI_MYTEK		0x001ee8
>   
>   #define DICE_CATEGORY_ID	0x04
>   #define WEISS_CATEGORY_ID	0x00
> @@ -365,6 +366,14 @@ static const struct ieee1394_device_id dice_id_table[] = {
>   		.model_id	= MODEL_ALESIS_IO_BOTH,
>   		.driver_data = (kernel_ulong_t)snd_dice_detect_alesis_formats,
>   	},
> +	/* Mytek Stereo 192 DSD-DAC. */
> +	{
> +		.match_flags	= IEEE1394_MATCH_VENDOR_ID |
> +				  IEEE1394_MATCH_MODEL_ID,
> +		.vendor_id	= OUI_MYTEK,
> +		.model_id	= 0x000002,
> +		.driver_data = (kernel_ulong_t)snd_dice_detect_mytek_formats,
> +	},
>   	{
>   		.match_flags = IEEE1394_MATCH_VERSION,
>   		.version     = DICE_INTERFACE,
> diff --git a/sound/firewire/dice/dice.h b/sound/firewire/dice/dice.h
> index 505b79fea6d9..83353a3559e8 100644
> --- a/sound/firewire/dice/dice.h
> +++ b/sound/firewire/dice/dice.h
> @@ -226,5 +226,6 @@ int snd_dice_create_midi(struct snd_dice *dice);
>   int snd_dice_detect_tcelectronic_formats(struct snd_dice *dice);
>   int snd_dice_detect_alesis_formats(struct snd_dice *dice);
>   int snd_dice_detect_extension_formats(struct snd_dice *dice);
> +int snd_dice_detect_mytek_formats(struct snd_dice *dice);
>   
>   #endif

 From me, some supplements. In Mytek website, we can get firmwares for
some models with interfaces for IEEE 1394 bus.

* Professional:   https://mytekdigital.com/professional/support/
   * Stereo192-DSD-DAC: 
https://mytekdigital.com/support_docs/Mytek_Stereo192DSD%20DAC_firmware.zip
   * 8x192ADDA DIO FW: 
https://mytekdigital.com/download_library/DioFWDiceMini3001.bin
* HiFi:   https://mytekdigital.com/hifi/support/
   * Manhattan DAC (Original model): 
https://mytekdigital.com/support_docs/Mytek_ManhattanDAC_firmware_v1.1.1.zip
   * Stereo192-DSD-DAC: 
https://mytekdigital.com/support_docs/Mytek_Stereo192DSD%20DAC_firmware.zip

When executing strings(1) to these firmwares, we can see below line:

For Stereo192-DSD-DAC:
```
* Mytek Stereo192DA on DICE Mini (TCD2210)               *
```

For original Manhattan DAC:
```
* Mytek Stereo192DA on DICE Mini (TCD2210)               *
```
(I note that the line includes different name.)

For 8x192ADDA DIO FW:
```
* Mytek 8x192ADDA DioFW on DICE Mini (TCD2210)     *
```

It's reasonable that we judge TCD2210 (a.k.a. Dice mini) ASIC used for
Mytek models. Old firmwares were not released for this ASIC, thus your
patch comment is not proper. The reason for this patch is that this
model doesn't support extended protocol, which I've addressed at a
commit commit 58579c056c1c ('ALSA: dice: use extended protocol to detect
available stream formats').

Furthermore, for 8x192ADDA DIO FW, the firmware includes below
line:

```
* EAP is supported.                                      *
```

I believe ALSA Dice driver can detect stream formats correctly for
this model. Thus, the rest of piece may be for original Manhattan DAC.

I note that all of Dice based devices utilizes Embedded Configurable
Operating System(eCos)[1], and these firmwares are designed for eCos.
IMHO, the firmwares can be parsed by format of eCos but I have never
attempted it,

 From my curious, can you drive your model with DSD samples? If so, what
kind of software do you use?

[1] http://ecos.sourceware.org/


Regards

Takashi Sakamoto
