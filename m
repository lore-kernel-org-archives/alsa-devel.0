From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: Re: [PATCH v2] ASoC: cs42xx8: Check return value of
 regmap_read and report correct chipid value
Date: Fri, 4 Apr 2014 11:32:31 +0800
Message-ID: <20140404033230.GA1406@MrMyself>
References: <1396580675.9690.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 by alsa0.perex.cz (Postfix) with ESMTP id 4147D265718
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 05:33:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1396580675.9690.0.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>
Cc: alsa-devel@alsa-project.org, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 04, 2014 at 11:04:35AM +0800, Axel Lin wrote:
> Fix checking return value of regmap_read().
> Also fix reporting the chip_id value. CS42XX8_CHIPID_CHIP_ID_MASK is 0xF0,
> so the chip_id value is (val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4).
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> Acked-by: Paul Handrigan <paul.handrigan@cirrus.com>
> Acked-by: Brian Austin <brian.austin@cirrus.com>

Acked-by: Nicolin Chen <Guangyu.Chen@freescale.com>

Not sure if it's needed since both Brian and Paul acked.

Thanks for this fix,
Nicolin

> ---
>  sound/soc/codecs/cs42xx8.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/codecs/cs42xx8.c b/sound/soc/codecs/cs42xx8.c
> index 082299a..8502032 100644
> --- a/sound/soc/codecs/cs42xx8.c
> +++ b/sound/soc/codecs/cs42xx8.c
> @@ -495,17 +495,16 @@ int cs42xx8_probe(struct device *dev, struct regmap *regmap)
>  	regcache_cache_bypass(cs42xx8->regmap, true);
>  
>  	/* Validate the chip ID */
> -	regmap_read(cs42xx8->regmap, CS42XX8_CHIPID, &val);
> -	if (val < 0) {
> -		dev_err(dev, "failed to get device ID: %x", val);
> -		ret = -EINVAL;
> +	ret = regmap_read(cs42xx8->regmap, CS42XX8_CHIPID, &val);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to get device ID, ret = %d", ret);
>  		goto err_enable;
>  	}
>  
>  	/* The top four bits of the chip ID should be 0000 */
> -	if ((val & CS42XX8_CHIPID_CHIP_ID_MASK) != 0x00) {
> +	if (((val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4) != 0x00) {
>  		dev_err(dev, "unmatched chip ID: %d\n",
> -				val & CS42XX8_CHIPID_CHIP_ID_MASK);
> +			(val & CS42XX8_CHIPID_CHIP_ID_MASK) >> 4);
>  		ret = -EINVAL;
>  		goto err_enable;
>  	}
> -- 
> 1.8.3.2
> 
> 
> 
> 
> 
