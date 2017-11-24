From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 1/3] ASoC: da7218: Delete two error
 messages for a failed memory allocation in da7218_of_to_pdata()
Date: Fri, 24 Nov 2017 11:44:52 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1B11AC@SW-EX-MBX01.diasemi.com>
References: <07c631e4-e2df-7ae2-ea31-9430c89dc8e3@users.sourceforge.net>
 <d6ca1c55-1bb9-7ec2-de4a-63b994567d59@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.143])
 by alsa0.perex.cz (Postfix) with ESMTP id C275C266E3A
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 12:44:54 +0100 (CET)
In-Reply-To: <d6ca1c55-1bb9-7ec2-de4a-63b994567d59@users.sourceforge.net>
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
To: SF Markus Elfring <elfring@users.sourceforge.net>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support
 Opensource <Support.Opensource@diasemi.com>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, Jaroslav Kysela <perex@perex.cz>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
Cc: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 23 November 2017 20:05, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 23 Nov 2017 20:42:20 +0100
> 
> Omit extra messages for a memory allocation failure in this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>

> ---
>  sound/soc/codecs/da7218.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
> index 56564ce90cb6..25ab7443d803 100644
> --- a/sound/soc/codecs/da7218.c
> +++ b/sound/soc/codecs/da7218.c
> @@ -2455,10 +2455,8 @@ static struct da7218_pdata *da7218_of_to_pdata(struct
> snd_soc_codec *codec)
>  	u32 of_val32;
> 
>  	pdata = devm_kzalloc(codec->dev, sizeof(*pdata), GFP_KERNEL);
> -	if (!pdata) {
> -		dev_warn(codec->dev, "Failed to allocate memory for pdata\n");
> +	if (!pdata)
>  		return NULL;
> -	}
> 
>  	if (of_property_read_u32(np, "dlg,micbias1-lvl-millivolt", &of_val32) >= 0)
>  		pdata->micbias1_lvl = da7218_of_micbias_lvl(codec, of_val32);
> @@ -2527,8 +2525,6 @@ static struct da7218_pdata *da7218_of_to_pdata(struct
> snd_soc_codec *codec)
>  		hpldet_pdata = devm_kzalloc(codec->dev, sizeof(*hpldet_pdata),
>  					    GFP_KERNEL);
>  		if (!hpldet_pdata) {
> -			dev_warn(codec->dev,
> -				 "Failed to allocate memory for hpldet pdata\n");
>  			of_node_put(hpldet_np);
>  			return pdata;
>  		}
> --
> 2.15.0
