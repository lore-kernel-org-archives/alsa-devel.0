From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Subject: Re: [alsa-devel] [PATCH v3 1/2] ALSA: pcm: add SNDRV_PCM_FORMAT_{S,
 U}20
Date: Mon, 27 Nov 2017 22:26:36 +0100
Message-ID: <8110a97f-c230-8117-2a2d-81b42766a8ec@maciej.szmigiero.name>
References: <c0667b29-661d-2b48-d5c2-75291f97d55a@maciej.szmigiero.name>
 <s5h374zmpoi.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5h374zmpoi.wl-tiwai@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Timur Tabi <timur@tabi.org>, Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

On 27.11.2017 21:28, Takashi Iwai wrote:
> On Mon, 27 Nov 2017 00:09:47 +0100,
> Maciej S. Szmigiero wrote:
>> diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
>> index 58acd00cae19..d970879944fc 100644
>> --- a/include/sound/soc-dai.h
>> +++ b/include/sound/soc-dai.h
>> @@ -102,6 +102,8 @@ struct snd_compr_stream;
>>  			       SNDRV_PCM_FMTBIT_S16_BE |\
>>  			       SNDRV_PCM_FMTBIT_S20_3LE |\
>>  			       SNDRV_PCM_FMTBIT_S20_3BE |\
>> +			       SNDRV_PCM_FMTBIT_S20_LE |\
>> +			       SNDRV_PCM_FMTBIT_S20_BE |\
>>  			       SNDRV_PCM_FMTBIT_S24_3LE |\
>>  			       SNDRV_PCM_FMTBIT_S24_3BE |\
>>                                 SNDRV_PCM_FMTBIT_S32_LE |\
> 
> Is it really safe to include them unconditionally...?

This define is used as a template of supported formats only in ASoC AC'97
CODECs.
A list of effective supported sample formats will be calculated as an
intersection of CODEC and CPU-supported formats (and DMA
controller-supported bit widths).

This means that as long as ASoC CPUs don't add these sample formats to
their list of supported formats they should not be offered as supported
by any sound card.

Also, we already have similar SNDRV_PCM_FMTBIT_S20_3 formats in this
define.

>> diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
>> index c227ccba60ae..7385024041d2 100644
>> --- a/include/uapi/sound/asound.h
>> +++ b/include/uapi/sound/asound.h
>> @@ -214,6 +214,11 @@ typedef int __bitwise snd_pcm_format_t;
>>  #define	SNDRV_PCM_FORMAT_IMA_ADPCM	((__force snd_pcm_format_t) 22)
>>  #define	SNDRV_PCM_FORMAT_MPEG		((__force snd_pcm_format_t) 23)
>>  #define	SNDRV_PCM_FORMAT_GSM		((__force snd_pcm_format_t) 24)
>> +#define	SNDRV_PCM_FORMAT_S20_LE	((__force snd_pcm_format_t) 25) /* \ 			*/
>> +#define	SNDRV_PCM_FORMAT_S20_BE	((__force snd_pcm_format_t) 26) /* | 			*/
>> +#define	SNDRV_PCM_FORMAT_U20_LE	((__force snd_pcm_format_t) 27) /* | in four bytes,	*/
>> +#define	SNDRV_PCM_FORMAT_U20_BE	((__force snd_pcm_format_t) 28) /* / LSB justified	*/
> 
> This style of comments is unusual, so I prefer rather a dumb style,
> even don't mind repeating the same text in each line.  They'll be over
> 80 chars in anyway, so ignore what checkpatch complains.

OK, will change it to the repetitive style then in a respin.

> thanks,
> 
> Takashi
> 

Thanks,
Maciej
