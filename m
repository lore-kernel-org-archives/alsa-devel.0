From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l52: Report correct chip id and
	revision
Date: Fri, 4 Apr 2014 12:00:45 -0500
Message-ID: <alpine.DEB.2.02.1404041128380.3451@heelrod>
References: <1396616889.13903.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0053.outbound.protection.outlook.com [157.56.110.53])
 by alsa0.perex.cz (Postfix) with ESMTP id BD03E2657F3
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 19:06:30 +0200 (CEST)
In-Reply-To: <1396616889.13903.2.camel@phoenix>
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

On Fri, 4 Apr 2014, Axel Lin wrote:

>
> 	ret = regmap_read(cs42l52->regmap, CS42L52_CHIP, &reg);
> -	devid = reg & CS42L52_CHIP_ID_MASK;
> +	devid = (reg & CS42L52_CHIP_ID_MASK) >> 3;

What you added does the same thing as what was already there.
The CHIP_ID is E0.

> 	if (devid != CS42L52_CHIP_ID) {
> 		ret = -ENODEV;
> 		dev_err(&i2c_client->dev,
> @@ -1259,7 +1259,7 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
> 	}
>
> 	dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision: %02X\n",
> -			reg & 0xFF);
> +			reg & CS42L52_CHIP_REV_MASK);

This works
>
> 	/* Set Platform Data */
> 	if (cs42l52->pdata.mica_diff_cfg)
> -#define CS42L52_CHIP_ID				0xE0
> -#define CS42L52_CHIP_ID_MASK			0xF8
> +#define CS42L52_CHIP_ID				0x1C
> +#define CS42L52_CHIP_ID_MASK			(0x1F << 3)
> #define CS42L52_CHIP_REV_A0			0x00
> #define CS42L52_CHIP_REV_A1			0x01
> #define CS42L52_CHIP_REV_B0			0x02
> -#define CS42L52_CHIP_REV_MASK			0x03
> +#define CS42L52_CHIP_REV_B1			0x03

If you used this it would be cool, but your not so I don't see the need 
for it.

So if you want to add the code to actually display the REV_ID I would ack 
that, but I dont see anything that this patch actually fixes.

-Brian
