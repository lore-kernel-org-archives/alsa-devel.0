From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Subject: Re: [PATCH 4/4] sound: jz4740: Enable codec clock during dai_probe
Date: Mon, 26 Jan 2015 11:30:56 +0000
Message-ID: <54C62570.5050600@imgtec.com>
References: <1422267511-6649-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1422267511-6649-5-git-send-email-Zubair.Kakakhel@imgtec.com> <54C61980.9030205@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <54C61980.9030205@metafoo.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, tiwai@suse.de, perex@perex.cz
Cc: broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


On 26/01/15 10:40, Lars-Peter Clausen wrote:
> On 01/26/2015 11:18 AM, Zubair Lutfullah Kakakhel wrote:
>> As we are moving away from platform to DT, we cant rely on the board
>> file to do this now. So enable it here.
>=20
> I don't understand this changelog. The board file never did this. The=
 driver enables the clock in the startup() callback.

My bad.

I couldn't get the ci20 audio to work without this change.

I double checked. The clock is indeed enabled.

But the rate needs to be set for the ci20.

clk_set_rate(i2s->clk_i2s, 12000000);

Where should I put it? I couldn=92t trace how the rate is set for the j=
z4740..

ZubairLK

>=20
>>
>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com=
>
>> ---
>>   sound/soc/jz4740/jz4740-i2s.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740=
-i2s.c
>> index 3c309fc..a7e4a7b 100644
>> --- a/sound/soc/jz4740/jz4740-i2s.c
>> +++ b/sound/soc/jz4740/jz4740-i2s.c
>> @@ -376,6 +376,10 @@ static int jz4740_i2s_dai_probe(struct snd_soc_=
dai *dai)
>>           JZ_AIC_CONF_I2S |
>>           JZ_AIC_CONF_INTERNAL_CODEC;
>>
>> +    /* enable codec sysclk */
>> +    clk_set_rate(i2s->clk_i2s, 12000000);
>> +    clk_prepare_enable(i2s->clk_i2s);
>> +
>>       jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, JZ_AIC_CONF_RESET);
>>       jz4740_i2s_write(i2s, JZ_REG_AIC_CONF, conf);
>>
>>
>=20
