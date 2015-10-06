From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: ad193x-spi: Fixup ad193x_spi_id table
Date: Tue, 06 Oct 2015 18:26:56 +0200
Message-ID: <5613F650.6020904@metafoo.de>
References: <1444123596.7405.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-060.synserver.de (smtp-out-137.synserver.de
 [212.40.185.137])
 by alsa0.perex.cz (Postfix) with ESMTP id 379752657D9
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 21:35:23 +0200 (CEST)
In-Reply-To: <1444123596.7405.2.camel@ingics.com>
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
Cc: Cyrille Pitchen <cyrille.pitchen@atmel.com>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 10/06/2015 11:26 AM, Axel Lin wrote:
> AD1939 is missed from the table, so add it.
> AD1936 and AD1937 are controlled by I2C interface, so remove them.
> 
> Fixes: e5224f58e3ef ("ASoC: ad193x: add support to ad1934")
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Thanks for catching that.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

> ---
>  sound/soc/codecs/ad193x-spi.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/ad193x-spi.c b/sound/soc/codecs/ad193x-spi.c
> index 364e8211..b55055a 100644
> --- a/sound/soc/codecs/ad193x-spi.c
> +++ b/sound/soc/codecs/ad193x-spi.c
> @@ -39,9 +39,8 @@ static const struct spi_device_id ad193x_spi_id[] = {
>  	{ "ad193x", AD193X },
>  	{ "ad1933", AD1933 },
>  	{ "ad1934", AD1934 },
> -	{ "ad1936", AD193X },
> -	{ "ad1937", AD193X },
>  	{ "ad1938", AD193X },
> +	{ "ad1939", AD193X },

The adau1328 is actually also support by this driver, though I had send a
patch for this a while ago, but I guess I didn't. But we can add that later
in a separate patch.

>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, ad193x_spi_id);
> 
