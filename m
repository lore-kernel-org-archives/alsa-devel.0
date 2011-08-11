From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: Re: [PATCH 3.1]ASoC: ad193x: add spi_hw_read,
 fix sysclk and register definition
Date: Thu, 11 Aug 2011 17:52:18 +0800
Message-ID: <CAHG8p1A_QovuTgTdkAKzzMpQXzUzpnSqSSrCom=Dx9UPpPts7Q@mail.gmail.com>
References: <CAHG8p1AJ66K8yjiEz3HXv64JB0C4OrCPbCFV+Gu5jQkvB5cibA@mail.gmail.com>
	<1313054602.16663.10.camel@finisterre.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) by alsa0.perex.cz (Postfix) with ESMTP id C75C0243CB
	for <alsa-devel@alsa-project.org>;
	Thu, 11 Aug 2011 11:52:19 +0200 (CEST)
Received: by qwf7 with SMTP id 7so1027305qwf.38
	for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2011 02:52:18 -0700 (PDT)
In-Reply-To: <1313054602.16663.10.camel@finisterre.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2011/8/11 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Thu, 2011-08-11 at 17:04 +0800, Scott Jiang wrote:
>
>> @@ -56,7 +56,7 @@ static int bf5xx_ad193x_hw_params(struct
>> snd_pcm_substream *substream,
>>
>> =A0 =A0 =A0 switch (params_rate(params)) {
>> =A0 =A0 =A0 case 48000:
>> - =A0 =A0 =A0 =A0 =A0 =A0 clk =3D 12288000;
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk =3D 24576000;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> =A0 =A0 =A0 }
>
> Whatever this is for it should be a separate change.
>
>> - =A0 =A0 reg =3D (reg & (~AD193X_DAC_WORD_LEN_MASK)) | word_len;
>> + =A0 =A0 reg =3D (reg & (~AD193X_DAC_WORD_LEN_MASK))
>> + =A0 =A0 =A0 =A0 =A0 =A0 | (word_len << AD193X_DAC_WORD_LEN_SHFT);
>> =A0 =A0 =A0 snd_soc_write(codec, AD193X_DAC_CTRL2, reg);
>>
>> =A0 =A0 =A0 reg =3D snd_soc_read(codec, AD193X_ADC_CTRL1);
>
> This needs some documentation as it's not clear what it's supposed to
> do.
>
the word_len value forgot to shift, I think it's clear.

>> +#if defined(CONFIG_SPI_MASTER)
>> + =A0 =A0 /* asoc cache layer can't support this kind of spi registers n=
ow */
>> + =A0 =A0 codec->cache_bypass =3D 1;
>> +#endif
>
> That's not what cache_bypass is for. Just mark the registers as
> volatile, or remove the cache entirely.
>
volatile usually used on the read-only registers, so I think removing
cache is better.

>> =A0#ifdef CONFIG_SPI_MASTER
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 codec->hw_write =3D do_spi_write;
>> =A0#endif
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (io_types[i].spi_read)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 codec->hw_read =3D io_type=
s[i].spi_read;
>
> So, if we've got an ifdef on the write...
>
sorry, I can't understand what you mean. I just follow i2c code above.
