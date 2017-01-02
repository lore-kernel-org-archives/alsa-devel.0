From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 1/3] ASoC: tlv320aic3x: Mark the RESET
 register as volatile
Date: Mon, 2 Jan 2017 13:51:14 +0200
Message-ID: <04235176-3a8a-b16d-aceb-99c17365c895@ti.com>
References: <20161223092112.7992-1-peter.ujfalusi@ti.com>
 <20161223092112.7992-2-peter.ujfalusi@ti.com>
 <001a281f-6ae1-37ed-30a0-48cc07fa68ca@bitmer.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelnx194.ext.ti.com (lelnx194.ext.ti.com [198.47.27.80])
 by alsa0.perex.cz (Postfix) with ESMTP id D25B5266652
 for <alsa-devel@alsa-project.org>; Mon,  2 Jan 2017 12:51:00 +0100 (CET)
In-Reply-To: <001a281f-6ae1-37ed-30a0-48cc07fa68ca@bitmer.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Jarkko,

On 12/23/2016 08:27 PM, Jarkko Nikula wrote:
> Hi
> =

> On 12/23/2016 11:21 AM, Peter Ujfalusi wrote:
>> The RESET register only have one self clearing bit and it should not be
>> cached. If it is cached, when we sync the registers back to the chip we
>> will initiate a software reset as well, which is not desirable.
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>>  sound/soc/codecs/tlv320aic3x.c | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/sound/soc/codecs/tlv320aic3x.c b/sound/soc/codecs/tlv320aic=
3x.c
>> index 216f74084c6a..7b6924e19021 100644
>> --- a/sound/soc/codecs/tlv320aic3x.c
>> +++ b/sound/soc/codecs/tlv320aic3x.c
>> @@ -126,6 +126,16 @@ static const struct reg_default aic3x_reg[] =3D {
>>  	{ 108, 0x00 }, { 109, 0x00 },
>>  };
>>  =

>> +static bool aic3x_volatile_reg(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case AIC3X_RESET:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
> =

> You mentioned offline you tracked this into my commit 9fb352b18b11
> ("ASoC: tlv320aic3x: Do soft reset to codec when going to bias off
> state") but was it by bisecting or by debugging? I think I tried to
> cover it in a commit before 508b76864c18 ("ASoC: tlv320aic3x: Don't sync
> first two registers from register cache").
> =

> If you found it by debugging can it be that pop noise came because of
> 2a6fedec195b ("ASoC: tlv320aic3x: Convert to direct regmap API usage")?

Noticed this when debugging. The conversion to regmap did introduced this.

> Just thinking if there's a need to have this into stable.

Right, it might be a good idea.

> Reviewed-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
> =


-- =

P=E9ter
