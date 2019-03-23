From: Aditya Pakki <pakki001@umn.edu>
Subject: Re: [PATCH] sound: rt5645: fix a NULL pointer dereference
Date: Sat, 23 Mar 2019 18:05:11 -0500
Message-ID: <aab4eea2-2d6e-1a16-5b2a-47ac5f75e642@umn.edu>
References: <20190315034833.25037-1-kjlu@umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190315034833.25037-1-kjlu@umn.edu>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Cc: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 20190315034833.25037-1-kjlu@umn.edu
List-Id: alsa-devel@alsa-project.org


On 3/14/19 10:48 PM, Kangjie Lu wrote:
> devm_kcalloc() may fail and return NULL. The fix returns ENOMEM
> in case it fails to avoid NULL pointer dereference.
>
> Signed-off-by: Kangjie Lu <kjlu@umn.edu>
> ---
>  sound/soc/codecs/rt5645.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
> index 9a0751978090..f842775dbf2c 100644
> --- a/sound/soc/codecs/rt5645.c
> +++ b/sound/soc/codecs/rt5645.c
> @@ -3419,6 +3419,9 @@ static int rt5645_probe(struct snd_soc_component *component)
>  		RT5645_HWEQ_NUM, sizeof(struct rt5645_eq_param_s),
>  		GFP_KERNEL);
>  
> +	if (!rt5645->eq_param)
> +		return -ENOMEM;
> +
>  	return 0;
>  }
>  


Friendly reminder, could someone review this patch ?
