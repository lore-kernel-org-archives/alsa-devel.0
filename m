From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: Re: [PATCH 2/3] ASoC: da7218: Use common error
 handling code in da7218_of_to_pdata()
Date: Fri, 24 Nov 2017 12:03:32 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337014C1B11E5@SW-EX-MBX01.diasemi.com>
References: <07c631e4-e2df-7ae2-ea31-9430c89dc8e3@users.sourceforge.net>
 <32a4c9e8-2030-c4e8-eb54-9ce6712ef0cd@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta5.messagelabs.com (mail1.bemta5.messagelabs.com
 [195.245.231.141])
 by alsa0.perex.cz (Postfix) with ESMTP id 7EC17266E3A
 for <alsa-devel@alsa-project.org>; Fri, 24 Nov 2017 13:03:34 +0100 (CET)
In-Reply-To: <32a4c9e8-2030-c4e8-eb54-9ce6712ef0cd@users.sourceforge.net>
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

On 23 November 2017 20:06, SF Markus Elfring wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 23 Nov 2017 20:48:05 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> in an if branch of this function.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Hmm. Doesn't really gain an awful lot this. Would understand if there were
multiple return paths, but in that case I'd have implemented something like
this anyway. Also your patch description isn't really correct. You're re-using
code from the sunny day scenario to handle an exception.

> ---
>  sound/soc/codecs/da7218.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
> index 25ab7443d803..93a0cb741751 100644
> --- a/sound/soc/codecs/da7218.c
> +++ b/sound/soc/codecs/da7218.c
> @@ -2524,10 +2524,9 @@ static struct da7218_pdata *da7218_of_to_pdata(struct
> snd_soc_codec *codec)
> 
>  		hpldet_pdata = devm_kzalloc(codec->dev, sizeof(*hpldet_pdata),
>  					    GFP_KERNEL);
> -		if (!hpldet_pdata) {
> -			of_node_put(hpldet_np);
> -			return pdata;
> -		}
> +		if (!hpldet_pdata)
> +			goto put_node;
> +
>  		pdata->hpldet_pdata = hpldet_pdata;
> 
>  		if (of_property_read_u32(hpldet_np, "dlg,jack-rate-us",
> @@ -2561,6 +2560,7 @@ static struct da7218_pdata *da7218_of_to_pdata(struct
> snd_soc_codec *codec)
>  		if (of_property_read_bool(hpldet_np, "dlg,discharge"))
>  			hpldet_pdata->discharge = true;
> 
> +put_node:
>  		of_node_put(hpldet_np);
>  	}
> 
> --
> 2.15.0
