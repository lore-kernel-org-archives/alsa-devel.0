From: John Lin <john.lin@realtek.com>
Subject: Re: [PATCH] ASoC: rt5645: Add dmi "Google Reks" for
	chrome
Date: Thu, 1 Oct 2015 08:23:33 +0000
Message-ID: <14AE6189BDA733429BF8455FEEF63298010F69C3@RTITMBSV02.realtek.com.tw>
References: <1442831899-15339-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 65D7C26042B
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 10:23:45 +0200 (CEST)
In-Reply-To: <1442831899-15339-1-git-send-email-john.lin@realtek.com>
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
To: "broonie@kernel.org" <broonie@kernel.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Flove <flove@realtek.com>, "Keith.Tzeng@quantatw.com" <Keith.Tzeng@quantatw.com>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: John Lin
> Sent: Monday, September 21, 2015 6:38 PM
> To: broonie@kernel.org; lgirdwood@gmail.com
> Cc: alsa-devel@alsa-project.org; Bard Liao; Flove; Oder Chiou;
> Keith.Tzeng@quantatw.com; John Lin
> Subject: [PATCH] ASoC: rt5645: Add dmi "Google Reks" for chrome
> 
> Signed-off-by: John Lin <john.lin@realtek.com>
> ---
>  sound/soc/codecs/rt5645.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index b0d96b6..84c5261 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3212,6 +3212,13 @@ static const struct dmi_system_id
> dmi_platform_intel_braswell[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "Ultima"),
>  		},
>  	},
> +	{
> +		.ident = "Google Reks",
> +		.callback = strago_quirk_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_NAME, "Reks"),
> +		},
> +	},
>  	{ }
>  };
> 
> --
> 1.8.1.1.439.g50a6b54

Hi Mark,
Could you help to review this patch?
Is there any problem on this patch?
If yes, please kindly tell us. We will modify it according to your opinion, thanks.
