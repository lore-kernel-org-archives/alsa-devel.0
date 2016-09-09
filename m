From: Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Subject: RE: [PATCH] ASoC: da7219: make sure the valid event when startup
Date: Fri, 9 Sep 2016 14:17:47 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A03370142A25083@SW-EX-MBX01.diasemi.com>
References: <1473429695-12604-1-git-send-email-zhengxing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <1473429695-12604-1-git-send-email-zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, "linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Adam Thomson <Adam.Thomson.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>
Cc: "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "hychao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <hychao-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Support Opensource <Support.Opensource-WBD+wuPFNBhBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, "heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org" <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <smbarber-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "cychiang-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <cychiang-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 09 September 2016 15:02, Xing Zheng wrote:

> We need to ensure the master bias and jack detection to be enabled
> before reporting event at the da7219_aad_irq_thread. Otherwise, we
> may acquire the incorrect the unplug event when the DUT startup
> with a plugged headphone.

For this device, the master bias is enabled by default at power on and should
also be enabled in the move to bias_level STANDBY. This I believe should all
happen before the machine code calls the 'da7219_aad_jack_det()' function, and
you should certainly not see any IRQs until after you've made that call and
enabled accessory detection in the device.

I'm not really sure how this fixes anything.

> 
> Signed-off-by: Xing Zheng <zhengxing-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
>  sound/soc/codecs/da7219-aad.c | 7 +++++++
>  sound/soc/codecs/da7219-aad.h | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/sound/soc/codecs/da7219-aad.c b/sound/soc/codecs/da7219-aad.c
> index 4e369a1..cef17c0d 100644
> --- a/sound/soc/codecs/da7219-aad.c
> +++ b/sound/soc/codecs/da7219-aad.c
> @@ -38,6 +38,7 @@ void da7219_aad_jack_det(struct snd_soc_codec *codec,
> struct snd_soc_jack *jack)
> 
>  	da7219->aad->jack = jack;
>  	da7219->aad->jack_inserted = false;
> +	da7219->aad->accdet_en = false;
> 
>  	/* Send an initial empty report */
>  	snd_soc_jack_report(jack, 0, DA7219_AAD_REPORT_ALL_MASK);
> @@ -46,6 +47,8 @@ void da7219_aad_jack_det(struct snd_soc_codec *codec,
> struct snd_soc_jack *jack)
>  	snd_soc_update_bits(codec, DA7219_ACCDET_CONFIG_1,
>  			    DA7219_ACCDET_EN_MASK,
>  			    (jack ? DA7219_ACCDET_EN_MASK : 0));
> +
> +	da7219->aad->accdet_en = true;
>  }
>  EXPORT_SYMBOL_GPL(da7219_aad_jack_det);
> 
> @@ -293,6 +296,10 @@ static irqreturn_t da7219_aad_irq_thread(int irq, void
> *data)
>  	u8 statusa;
>  	int i, report = 0, mask = 0;
> 
> +	/* Ensure the master bias to be enabled */
> +	if (!da7219_aad->accdet_en)
> +		return IRQ_NONE;
> +
>  	/* Read current IRQ events */
>  	regmap_bulk_read(da7219->regmap, DA7219_ACCDET_IRQ_EVENT_A,
>  			 events, DA7219_AAD_IRQ_REG_MAX);
> diff --git a/sound/soc/codecs/da7219-aad.h b/sound/soc/codecs/da7219-aad.h
> index 4fccf67..5641965 100644
> --- a/sound/soc/codecs/da7219-aad.h
> +++ b/sound/soc/codecs/da7219-aad.h
> @@ -200,6 +200,7 @@ struct da7219_aad_priv {
> 
>  	struct snd_soc_jack *jack;
>  	bool jack_inserted;
> +	bool accdet_en;
>  };
> 
>  /* AAD control */
> --
> 1.9.1
>
