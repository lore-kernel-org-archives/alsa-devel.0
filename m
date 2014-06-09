From: Oder Chiou <oder_chiou@realtek.com>
Subject: Re: [PATCH 1/3] ASoC: rt5677: Convert to use
	module_i2c_driver
Date: Mon, 9 Jun 2014 02:24:19 +0000
Message-ID: <7EB0DE829A537248AF2ED30C97D1269437127B@RTITMBSV03.realtek.com.tw>
References: <1401764201.15216.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C53F261A38
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 04:24:26 +0200 (CEST)
In-Reply-To: <1401764201.15216.0.camel@phoenix>
Content-Language: zh-TW
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
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Axel Lin [mailto:axel.lin@ingics.com]
> Sent: Tuesday, June 03, 2014 10:57 AM
> To: Mark Brown
> Cc: Oder Chiou; Liam Girdwood; alsa-devel@alsa-project.org
> Subject: [PATCH 1/3] ASoC: rt5677: Convert to use module_i2c_driver
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>
> ---
>  sound/soc/codecs/rt5677.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt5677.c b/sound/soc/codecs/rt5677.c index
> 833231e..60fff7f 100644
> --- a/sound/soc/codecs/rt5677.c
> +++ b/sound/soc/codecs/rt5677.c
> @@ -3480,18 +3480,7 @@ static struct i2c_driver rt5677_i2c_driver = {
>  	.remove   = rt5677_i2c_remove,
>  	.id_table = rt5677_i2c_id,
>  };
> -
> -static int __init rt5677_modinit(void)
> -{
> -	return i2c_add_driver(&rt5677_i2c_driver);
> -}
> -module_init(rt5677_modinit);
> -
> -static void __exit rt5677_modexit(void) -{
> -	i2c_del_driver(&rt5677_i2c_driver);
> -}
> -module_exit(rt5677_modexit);
> +module_i2c_driver(rt5677_i2c_driver);
> 
>  MODULE_DESCRIPTION("ASoC RT5677 driver");  MODULE_AUTHOR("Oder
> Chiou <oder_chiou@realtek.com>");
> --
> 1.8.3.2
> 
> 

Tested-by: Oder Chiou <oder_chiou@realtek.com>

Thanks
