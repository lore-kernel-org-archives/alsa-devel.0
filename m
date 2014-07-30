From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: max98090 add irq valid check
Date: Wed, 30 Jul 2014 17:21:42 +0300
Message-ID: <53D8FF76.7090707@linux.intel.com>
References: <1406685010-25108-1-git-send-email-xjq@rock-chips.com> <1406710457-6195-1-git-send-email-xjq@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1406710457-6195-1-git-send-email-xjq@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jianqun <xjq@rock-chips.com>, broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, tbleung@chromium.org, dgreid@chromium.org, kevin.strasser@intel.com, swarren@nvidia.com, ralph.birt@maximintegrated.com
Cc: alsa-devel@alsa-project.org, heiko@sntech.de, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Hi

On 07/30/2014 11:54 AM, jianqun wrote:
> From: Jianqun <xjq@rock-chips.com>
>
> Since IRQ pin from max98090 may NC, the irq number will be zero, that is
> invalid for request_threaded_irq, so just add irq valid check there.
>
> Since hardware may not MUST to use IRQ pin of max98090 as jack detect, the
> driver can work well without it, can report jack trigger to CPU by a GPIO.
>
> But here driver will register fail caused by failed to request irq.
>
> Signed-off-by: Jianqun <xjq@rock-chips.com>
> ---
>   sound/soc/codecs/max98090.c |   14 ++++++++------
>   1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
> index 566919c..9dc0e8c 100644
> --- a/sound/soc/codecs/max98090.c
> +++ b/sound/soc/codecs/max98090.c
> @@ -2478,12 +2478,14 @@ static int max98090_probe(struct snd_soc_codec *codec)
>   	/* Register for interrupts */
>   	dev_dbg(codec->dev, "irq = %d\n", max98090->irq);
>   
> -	ret = request_threaded_irq(max98090->irq, NULL,
> -		max98090_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -		"max98090_interrupt", codec);
> -	if (ret < 0) {
> -		dev_err(codec->dev, "request_irq failed: %d\n",
> -			ret);
> +	if (max98090->irq) {
> +		ret = request_threaded_irq(max98090->irq, NULL,
> +			max98090_interrupt, IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +			"max98090_interrupt", codec);
> +		if (ret < 0) {
> +			dev_err(codec->dev, "request_irq failed: %d\n",
> +				ret);
> +		}
>   	}
>   
Remember to add also "return ret;" at the end of if () {} in case 
request_threaded_irq() fails since code should not continue probing now 
after adding a test for valid irq.

Should the if (max98090->irq) test be >0? I'm not sure is there 
possibility that can i2c->irq actually pass both -1 and 0 depending how 
struct i2c_board_info etc are initialized?

I forgot that I have a fix changing request_threaded_irq() to 
devm_request_threaded_irq() so you should redo your patch on top of 
for-next branch of 
git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git.

-- 
Jarkko
