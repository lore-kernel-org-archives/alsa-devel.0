From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [patch] ASoC: dapm: using freed pointer in dapm_kcontrol_add_widget()
Date: Wed, 31 Jul 2013 11:02:45 +0200
Message-ID: <51F8D2B5.7060504@metafoo.de>
References: <20130731085244.GB8210@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20130731085244.GB8210@elgon.mountain>
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, "olof@lixom.net" <olof@lixom.net>
List-Id: alsa-devel@alsa-project.org

On 07/31/2013 10:52 AM, Dan Carpenter wrote:
> There is a typo here so we end up using the old freed pointer instead of
> the newly allocated one.  (If the "n" is zero then the code works,
> obviously).
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks.

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Olof, can you check whether this fixes the crash you see?

> ---
> Only needed in linux-next
>
> diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
> index 9abb3b2..d74c356 100644
> --- a/sound/soc/soc-dapm.c
> +++ b/sound/soc/soc-dapm.c
> @@ -225,13 +225,13 @@ static int dapm_kcontrol_add_widget(struct snd_kcontrol *kcontrol,
>
>   	new_data = krealloc(data, sizeof(*data) + sizeof(widget) * n,
>   		GFP_KERNEL);
> -	if (!data)
> +	if (!new_data)
>   		return -ENOMEM;
>
> -	data->wlist.widgets[n - 1] = widget;
> -	data->wlist.num_widgets = n;
> +	new_data->wlist.widgets[n - 1] = widget;
> +	new_data->wlist.num_widgets = n;
>
> -	kcontrol->private_data = data;
> +	kcontrol->private_data = new_data;
>
>   	return 0;
>   }
>

