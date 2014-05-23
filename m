From: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Add master clock handling
Date: Fri, 23 May 2014 11:05:17 +0530
Message-ID: <CAHbNUh2QHv8n7Y19qfO7BagX5AWe0i17MjDvr7yOpHf6YNGW4A@mail.gmail.com>
References: <1400750228-13750-1-git-send-email-tushar.behera@linaro.org>
	<1400750228-13750-2-git-send-email-tushar.behera@linaro.org>
	<20140522103039.GD12304@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140522103039.GD12304-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "jerry.wong" <jerry.wong-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 22 May 2014 16:00, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, May 22, 2014 at 02:47:07PM +0530, Tushar Behera wrote:
>
>> +     max98090->mclk = devm_clk_get(codec->dev, "mclk");
>> +     if (!IS_ERR(max98090->mclk))
>> +             clk_prepare_enable(max98090->mclk);
>> +
>
> Ths doesn't handle deferred probe, we need to at least return an error
> if we get -EPROBE_DEFER.
>

Ok.

> It'd also be better to move the enabling to set_bias_level() if possible
> (I don't know if the clock is needed for register access) though less
> essential.

I tested with moving clk_enable/clk_disable calls to set_bias_level():
SND_SOC_BIAS_PREPARE. That works well for me. Does it look okay?

@@ -1801,6 +1801,25 @@ static int max98090_set_bias_level(struct
snd_soc_codec *codec,
                break;

        case SND_SOC_BIAS_PREPARE:
+               /*
+                * SND_SOC_BIAS_PREPARE is called while preparing for a
+                * transition to ON or away from ON. If current bias_level
+                * is SND_SOC_BIAS_ON, then it is preparing for a transition
+                * away from ON. Disable the clock in that case, otherwise
+                * enable it.
+                */
+               if (!IS_ERR(max98090->mclk)) {
+                       if (codec->dapm.bias_level == SND_SOC_BIAS_ON)
+                               clk_disable(max98090->mclk);
+                       else
+                               clk_enable(max98090->mclk);
+               }
                break;

-- 
Tushar Behera
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
