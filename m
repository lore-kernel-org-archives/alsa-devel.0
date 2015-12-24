From: Andrzej Hajda <a.hajda@samsung.com>
Subject: Re: [PATCH] ASoC: rsnd: fix usrcnt decrementing bug
Date: Thu, 24 Dec 2015 06:56:14 +0100
Message-ID: <567B88FE.7010002@samsung.com>
References: <1450867041-729-1-git-send-email-a.hajda@samsung.com>
 <1450867041-729-4-git-send-email-a.hajda@samsung.com>
 <87y4ckg1fp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <87y4ckg1fp.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On 12/24/2015 01:04 AM, Kuninori Morimoto wrote:
> Hi Andrzej
>
>> Field usrcnt is unsigned so it cannot be lesser than zero.
>>
>> The problem has been detected using proposed semantic patch
>> scripts/coccinelle/tests/unsigned_lesser_than_zero.cocci [1].
>>
>> [1]: http://permalink.gmane.org/gmane.linux.kernel/2038576
>>
>> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
>> ---
> Thank you for your patch. good catch !
> I noticed current error case is not good for ssi.c
> Can you agree below ?
Yes, of course.

Regards
Andrzej
>
> ---------
> diff --git a/sound/soc/sh/rcar/ssi.c b/sound/soc/sh/rcar/ssi.c
> index 7db05fd..e519e30 100644
> --- a/sound/soc/sh/rcar/ssi.c
> +++ b/sound/soc/sh/rcar/ssi.c
> @@ -403,6 +403,12 @@ static int rsnd_ssi_quit(struct rsnd_mod *mod,
>  	struct rsnd_ssi *ssi = rsnd_mod_to_ssi(mod);
>  	struct device *dev = rsnd_priv_to_dev(priv);
>  
> +	if (!ssi->usrcnt) {
> +		dev_err(dev, "%s[%d] usrcnt error\n",
> +			rsnd_mod_name(mod), rsnd_mod_id(mod));
> +		return -EIO;
> +	}
> +
>  	if (rsnd_ssi_is_parent(mod, io))
>  		goto rsnd_ssi_quit_end;
>  
> @@ -422,10 +428,6 @@ rsnd_ssi_quit_end:
>  
>  	ssi->usrcnt--;
>  
> -	if (ssi->usrcnt < 0)
> -		dev_err(dev, "%s[%d] usrcnt error\n",
> -			rsnd_mod_name(mod), rsnd_mod_id(mod));
> -
>  	return 0;
>  }
>  
> ---------
>
>
> Best regards
> ---
> Kuninori Morimoto
>
>
