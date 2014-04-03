From: Paul Handrigan <paul.handrigan@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42xx8: Check return value of
 regmap_read and report correct chipid value
Date: Thu, 3 Apr 2014 11:48:57 -0500
Message-ID: <alpine.DEB.2.00.1404031147350.2043@phandrigan-desktop>
References: <1396511616.30532.2.camel@phoenix>
 <20140403153314.GB32327@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0091.outbound.protection.outlook.com [157.56.110.91])
 by alsa0.perex.cz (Postfix) with ESMTP id 63DBD2656B9
 for <alsa-devel@alsa-project.org>; Thu,  3 Apr 2014 18:49:03 +0200 (CEST)
In-Reply-To: <20140403153314.GB32327@MrMyself>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <Guangyu.Chen@freescale.com>
Cc: alsa-devel@alsa-project.org, Axel Lin <axel.lin@ingics.com>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Acked-by: Paul Handrigan <paul.handrigan@cirrus.com>

On Thu, 3 Apr 2014, Nicolin Chen wrote:

> On Thu, Apr 03, 2014 at 03:53:36PM +0800, Axel Lin wrote:
>> Fix checking return value of regmap_read().
>> Also fix reporting the chip_id value. CS42XX8_CHIPID_CHIP_ID_MASK is 0xF0,
>> so the chip_id value is (val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4).
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>  sound/soc/codecs/cs42xx8.c | 9 ++++-----
>>  1 file changed, 4 insertions(+), 5 deletions(-)
>>
>> diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
>> index 082299a..b1606cf 100644
>> --- a/sound/soc/codecs/cs42xx8.c
>> +++ b/sound/soc/codecs/cs42xx8.c
>> @@ -495,17 +495,16 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
>>  	regcache_cache_bypass(cs42xx8->regmap, true);
>>
>>  	/* Validate the chip ID */
>> -	regmap_read(cs42xx8->regmap, CS42XX8_CHIPID, &val);
>> -	if (val < 0) {
>> +	ret = regmap_read(cs42xx8->regmap, CS42XX8_CHIPID, &val);
>> +	if (ret < 0) {
>>  		dev_err(dev, "failed to get device ID: %x", val);
>
> %d and ret would be better here since val won't be useful in this case.
>
> Thank you for the fix.
> Nicolin Chen
>
>> -		ret = -EINVAL;
>>  		goto err_enable;
>>  	}
>>
>>  	/* The top four bits of the chip ID should be 0000 */
>> -	if ((val & CS42XX8_CHIPID_CHIP_ID_MASK) != 0x00) {
>> +	if (((val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4) != 0x00) {
>>  		dev_err(dev, "unmatched chip ID: %d\n",
>> -				val & CS42XX8_CHIPID_CHIP_ID_MASK);
>> +			(val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4);
>>  		ret = -EINVAL;
>>  		goto err_enable;
>>  	}
>> --
>> 1.8.3.2
>>
>>
>>
>>
>>
>
>
