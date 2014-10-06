From: Paul Handrigan <paul.handrigan@cirrus.com>
Subject: Re: [PATCH] ASoC: cs4265: Remove unused *dev field
 from struct cs4265_private
Date: Mon, 6 Oct 2014 10:23:13 -0500
Message-ID: <alpine.DEB.2.00.1410061022230.27341@phandrigan-desktop>
References: <1412608463.4950.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 by alsa0.perex.cz (Postfix) with ESMTP id EE0D2260642
 for <alsa-devel@alsa-project.org>; Mon,  6 Oct 2014 17:24:31 +0200 (CEST)
In-Reply-To: <1412608463.4950.7.camel@phoenix>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Brian Austin <brian.austin@cirrus.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org



On Mon, 6 Oct 2014, Axel Lin wrote:

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
> sound/soc/codecs/cs4265.c | 2 --
> 1 file changed, 2 deletions(-)
>
> diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
> index 4fdd47d..ce60868 100644
> --- a/sound/soc/codecs/cs4265.c
> +++ b/sound/soc/codecs/cs4265.c
> @@ -32,7 +32,6 @@
> #include "cs4265.h"
>
> struct cs4265_private {
> -	struct device *dev;
> 	struct regmap *regmap;
> 	struct gpio_desc *reset_gpio;
> 	u8 format;
> @@ -598,7 +597,6 @@ static int cs4265_i2c_probe(struct i2c_client *i2c_client,
> 			       GFP_KERNEL);
> 	if (cs4265 == NULL)
> 		return -ENOMEM;
> -	cs4265->dev = &i2c_client->dev;
>
> 	cs4265->regmap = devm_regmap_init_i2c(i2c_client, &cs4265_regmap);
> 	if (IS_ERR(cs4265->regmap)) {
> -- 
> 1.9.1
Thanks!

Signed-off-by: Paul Handrigan <paul.handrigan@cirrus.com>
