From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] ASoC: max98090 not need to return fail if fail to request
 hpdet irq.
Date: Wed, 30 Jul 2014 09:29:27 +0300
Message-ID: <53D890C7.4080201@linux.intel.com>
References: <1406685010-25108-1-git-send-email-xjq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406685010-25108-1-git-send-email-xjq@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jianqun <xjq@rock-chips.com>, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, tbleung@chromium.org, dgreid@chromium.org, kevin.strasser@intel.com, swarren@nvidia.com, ralph.birt@maximintegrated.com
Cc: heiko@sntech.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On 07/30/2014 04:50 AM, jianqun wrote:
> From: xujianqun <xjq@rock-chips.com>
>
> Since hardware may not MUST to use IRQ pin of max98090 as jack detect, the
> driver can work well without it, can report jack trigger to CPU by a GPIO.
>
> But here driver will register fail caused by failed to request irq.
>
> Signed-off-by: xujianqun <xjq@rock-chips.com>
> ---
>   sound/soc/codecs/max98090.c |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index 566919c..bc124ff 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2515,6 +2515,8 @@ static int max98090_probe(struct snd_soc_codec *codec)
>   
>   	max98090_add_widgets(codec);
>   
> +	return 0;
> +
>   err_access:
>   	return ret;
>   }
I would say it's better to call request_threaded_irq() conditionally 
when max98090->irq is valid in the same max98090_probe(). Also code 
should return instantly in case of request_threaded_irq() fails for 
valid irq.

Now code is still printing needless error message in case max98090->irq 
is invalid or not specified and continue probing in case 
request_threaded_irq() fails for valid irq.

-- 
Jarkko
