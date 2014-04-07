From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH] ASoC: da732x: Print correct major id
Date: Mon, 7 Apr 2014 09:54:59 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03377CDC09F6@SW-EX-MBX01.diasemi.com>
References: <1396526192.12814.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.146])
 by alsa0.perex.cz (Postfix) with ESMTP id D91E52610A8
 for <alsa-devel@alsa-project.org>; Mon,  7 Apr 2014 11:55:01 +0200 (CEST)
In-Reply-To: <1396526192.12814.1.camel@phoenix>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 3, 2014 at 12:57:32PM +0000, Axel Lin wrote:

> DA732X_ID_MAJOR_MASK is 0xF0, so the major id is
> (reg & DA732X_ID_MAJOR_MASK) >> 4.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/da732x.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/da732x.c b/sound/soc/codecs/da732x.c
> index 7d168ec..48f3fef 100644
> --- a/sound/soc/codecs/da732x.c
> +++ b/sound/soc/codecs/da732x.c
> @@ -1571,7 +1571,8 @@ static int da732x_i2c_probe(struct i2c_client *i2c,
>  	}
> 
>  	dev_info(&i2c->dev, "Revision: %d.%d\n",
> -		 (reg & DA732X_ID_MAJOR_MASK), (reg &
> DA732X_ID_MINOR_MASK));
> +		 (reg & DA732X_ID_MAJOR_MASK) >> 4,
> +		 (reg & DA732X_ID_MINOR_MASK));
> 
>  	ret = snd_soc_register_codec(&i2c->dev, &soc_codec_dev_da732x,
>  				     da732x_dai, ARRAY_SIZE(da732x_dai));
> --
> 1.8.3.2
> 

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
