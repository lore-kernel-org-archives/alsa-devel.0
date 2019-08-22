From: Yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] ASoC: sun4i-i2s: Use PTR_ERR_OR_ZERO in
 sun4i_i2s_init_regmap_fields()
Date: Thu, 22 Aug 2019 22:34:37 +0800
Message-ID: <5b15becf-b79b-ae5d-91e2-6521ded50946@huawei.com>
References: <20190822065252.74028-1-yuehaibing@huawei.com>
 <20190822141826.is6nizjpdgvhd7ra@flea>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190822141826.is6nizjpdgvhd7ra@flea>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Maxime Ripard <mripard@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 2019/8/22 22:18, Maxime Ripard wrote:
> Hi,
> 
> On Thu, Aug 22, 2019 at 06:52:52AM +0000, YueHaibing wrote:
>> Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
>>
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  sound/soc/sunxi/sun4i-i2s.c | 5 +----
>>  1 file changed, 1 insertion(+), 4 deletions(-)
>>
>> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
>> index 9e691baee1e8..2071c54265f3 100644
>> --- a/sound/soc/sunxi/sun4i-i2s.c
>> +++ b/sound/soc/sunxi/sun4i-i2s.c
>> @@ -1095,10 +1095,7 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
>>  	i2s->field_fmt_sr =
>>  			devm_regmap_field_alloc(dev, i2s->regmap,
>>  						i2s->variant->field_fmt_sr);
>> -	if (IS_ERR(i2s->field_fmt_sr))
>> -		return PTR_ERR(i2s->field_fmt_sr);
>> -
>> -	return 0;
>> +	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);
> 
> I'm not really convinced that this more readable or more maintainable
> though. Is there a reason for this other than we can do it?

No special reason, just suggested by scripts/coccinelle/api/ptr_ret.cocci

> 
> Maxie
> 
> --
> Maxime Ripard, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com
> 
