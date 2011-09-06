From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Blackfin: bf5xx-ad193x: Fix codec
 device name
Date: Tue, 06 Sep 2011 10:16:27 +0200
Message-ID: <4E65D6DB.7030805@metafoo.de>
References: <1315223397-18627-1-git-send-email-lars@metafoo.de>
	<CAHG8p1B9Oshc6GgJn8UyERczGB2E0B=6nB6UsPX5Pis_CxUdmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 9A4541038BB
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 10:17:07 +0200 (CEST)
In-Reply-To: <CAHG8p1B9Oshc6GgJn8UyERczGB2E0B=6nB6UsPX5Pis_CxUdmg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Scott Jiang <scott.jiang.linux@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, stable@kernel.org, device-drivers-devel@blackfin.uclinux.org, uclinux-dist-devel@blackfin.uclinux.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On 09/06/2011 04:35 AM, Scott Jiang wrote:
> 2011/9/5 Lars-Peter Clausen <lars@metafoo.de>:
>> Fix the codec_name field of the dai_link to match the actual device name
>> of the codec. Otherwise the card won't be instantiated.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: stable@kernel.org
>> ---
>>  sound/soc/blackfin/bf5xx-ad193x.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/sound/soc/blackfin/bf5xx-ad193x.c b/sound/soc/blackfin/bf5xx-ad193x.c
>> index a118a0f..5956584 100644
>> --- a/sound/soc/blackfin/bf5xx-ad193x.c
>> +++ b/sound/soc/blackfin/bf5xx-ad193x.c
>> @@ -103,7 +103,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai[] = {
>>                .cpu_dai_name = "bfin-tdm.0",
>>                .codec_dai_name ="ad193x-hifi",
>>                .platform_name = "bfin-tdm-pcm-audio",
>> -               .codec_name = "ad193x.5",
>> +               .codec_name = "spi0.5",
>>                .ops = &bf5xx_ad193x_ops,
>>        },
>>        {
>> @@ -112,7 +112,7 @@ static struct snd_soc_dai_link bf5xx_ad193x_dai[] = {
>>                .cpu_dai_name = "bfin-tdm.1",
>>                .codec_dai_name ="ad193x-hifi",
>>                .platform_name = "bfin-tdm-pcm-audio",
>> -               .codec_name = "ad193x.5",
>> +               .codec_name = "spi0.5",
>>                .ops = &bf5xx_ad193x_ops,
>>        },
>>  };
>> --
>> 1.7.2.5
> 
> Lars, I have to tell you ad193x supports i2c and spi.
> 
> #if defined(CONFIG_SND_SOC_AD193X_SPI)
>                 .codec_name = "spi0.5",
> #elif defined(CONFIG_SND_SOC_AD193X_I2C)
>                 .codec_name = "ad193x.0-0004",
> #endif
> 
> It is better to modify machine driver to platform driver and pass in
> control type.
> 
> Scott

Yes, though I would prefer using platform_device_id for this since whether it
is I2C or SPI depends on the codec model.

- Lars
