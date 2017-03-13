From: Paul Handrigan <paul.handrigan@cirrus.com>
Subject: Re: [PATCH] ASoC: cs35l35: Fix display revision id
Date: Mon, 13 Mar 2017 09:32:14 -0500
Message-ID: <fc476ebc-9f8d-40c6-bdc1-f77ad08e16c2@EX3.ad.cirrus.com>
References: <20170311125707.14309-1-axel.lin@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 667E3266BDA
 for <alsa-devel@alsa-project.org>; Mon, 13 Mar 2017 15:32:14 +0100 (CET)
In-Reply-To: <20170311125707.14309-1-axel.lin@ingics.com>
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



On Sat, 11 Mar 2017, Axel Lin wrote:

> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/cs35l35.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
> index 260ed42..9c82e5e 100644
> --- a/sound/soc/codecs/cs35l35.c
> +++ b/sound/soc/codecs/cs35l35.c
> @@ -1468,7 +1468,7 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
>  
>  	dev_info(&i2c_client->dev,
>  		 "Cirrus Logic CS35L35 (%x), Revision: %02X\n", devid,
> -		ret & 0xFF);
> +		reg & 0xFF);
>  
>  	/* Set the INT Masks for critical errors */
>  	regmap_write(cs35l35->regmap, CS35L35_INT_MASK_1,

Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com> 
 
