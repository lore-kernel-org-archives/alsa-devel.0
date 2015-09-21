From: Jon Cormier <jcormier@criticallink.com>
Subject: Re: [alsa-devel] [PATCH RFC 1/7] ASoC: tlv320aic26: Add device tree binding
Date: Mon, 21 Sep 2015 09:01:47 -0400
Message-ID: <CADL8D3aUwA-DiSiVUh3u1nLhohDmxJoFCk38r4kMuvL1o1J3Ww@mail.gmail.com>
References: <1442607076-26681-1-git-send-email-jcormier@criticallink.com>
 <1442607076-26681-2-git-send-email-jcormier@criticallink.com> <55FFC204.9000903@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55FFC204.9000903@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Bob Duke <bduke@criticallink.com>, Mark Brown <broonie@linaro.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Jyri Sarha <jsarha@ti.com>, Mike Williamson <michael.williamson@criticallink.com>, Greg Gluszek <greg.gluszek@criticallink.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Sep 21, 2015 at 4:38 AM, Peter Ujfalusi <peter.ujfalusi@ti.com>=
 wrote:
> On 09/18/2015 11:11 PM, Cormier, Jonathan wrote:
>
>> diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv32=
0aic26.c
>> index 620ab9ea1ef0..91fdd96648bd 100644
>> --- a/sound/soc/codecs/tlv320aic26.c
>> +++ b/sound/soc/codecs/tlv320aic26.c
>> @@ -370,10 +370,20 @@ static int aic26_spi_remove(struct spi_device =
*spi)
>>       return 0;
>>  }
>>
>> +#if defined(CONFIG_OF)
>
> You don't need the #ifdef here
>
>> +static const struct of_device_id tlv320aic26_of_match[] =3D {
>> +     { .compatible =3D "ti,tlv320aic26", },
>> +     {},
>> +};
>> +#endif
>> +
>>  static struct spi_driver aic26_spi =3D {
>>       .driver =3D {
>>               .name =3D "tlv320aic26-codec",
>>               .owner =3D THIS_MODULE,
>> +#if defined(CONFIG_OF)
>
> neither here.
>
>> +             .of_match_table =3D of_match_ptr(tlv320aic26_of_match)=
,
>> +#endif
>>       },
>>       .probe =3D aic26_spi_probe,
>>       .remove =3D aic26_spi_remove,
>>
>
>
> --
> P=C3=A9ter

Ok thanks.

--=20
Jonathan Cormier
CriticalLink
