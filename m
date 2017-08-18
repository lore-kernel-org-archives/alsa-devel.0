From: jeffy <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH v3 2/9] ASoC: rockchip: Remove obsolete dmic-delay
Date: Fri, 18 Aug 2017 22:41:44 +0800
Message-ID: <5996FCA8.9090909@rock-chips.com>
References: <20170817044417.22069-1-jeffy.chen@rock-chips.com> <20170817044417.22069-3-jeffy.chen@rock-chips.com> <20170817171152.abf3ngr6nr22jfif@sirena.org.uk> <599645E2.4020402@rock-chips.com> <20170818115223.pyfqji5jkplt6isx@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170818115223.pyfqji5jkplt6isx-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On 08/18/2017 07:52 PM, Mark Brown wrote:
> On Fri, Aug 18, 2017 at 09:41:54AM +0800, jeffy wrote:
>> On 08/18/2017 01:11 AM, Mark Brown wrote:
>>> On Thu, Aug 17, 2017 at 12:44:10PM +0800, Jeffy Chen wrote:
>
>>>> -Optional properties:
>>>> -- dmic-wakeup-delay-ms : specify delay time (ms) for DMIC ready.
>>>> -  If this option is specified, which means it's required dmic need
>>>> -  delay for DMIC to ready so that rt5514 can avoid recording before
>>>> -  DMIC send valid data
>
>>> Why would nobody ever want to use this in future?
>
>> hmmm, check again, rt5514 fixed this issue in there driver instead in:
>> a5461fd6c8f7 ASoC: rt5514: Add the DMIC initial delay to wait it ready.
>
>> so we don't need this...
>
> You don't need it on your board for new DTs but why is it not possible
> that another board might need it?
>

this property is added in:
3a6f9dce6116 ASoC: rk3399_gru_sound: fix recording pop at first attempt

to fix pop noise by performing a delay after set dmic clk.

the binding said "dmic-wakeup-delay-ms", but actually driver parses 
"dmic-delay":

+       /* Set DMIC delay */
+       ret = device_property_read_u32(&pdev->dev, "dmic-delay",
+                                       &rt5514_dmic_delay);

@@ -123,6 +125,9 @@ static int rockchip_sound_rt5514_hw_params(struct 
snd_pcm_subst
ream *substream,
                 return ret;
         }

+       /* Wait for DMIC stable */
+       msleep(rt5514_dmic_delay); <-- perform a delay after set dmic clk
+
         return 0;
  }

then realtek guys fixed this issue in the rt5514 codec driver:
a5461fd6c8f7 ASoC: rt5514: Add the DMIC initial delay to wait it ready.

+       device_property_read_u32(dev, "realtek,dmic-init-delay-ms",
+               &rt5514->pdata.dmic_init_delay);

@@ -452,6 +452,9 @@ static int rt5514_set_dmic_clk(struct 
snd_soc_dapm_widget *w,
                         RT5514_CLK_DMIC_OUT_SEL_MASK,
                         idx << RT5514_CLK_DMIC_OUT_SEL_SFT);

+       if (rt5514->pdata.dmic_init_delay)
+               msleep(rt5514->pdata.dmic_init_delay); <-- perform a 
delay after set dmic clk


so we don't need to deal with it in every boards' drivers which using 
rt5514 codec, and we are using this new property now:
ag dmic arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
620:            realtek,dmic-init-delay = <20>;   <---- oops, seems 
missing "-ms" at the end, guess due to realtek patch ends up differently 
on upstream. will send a patch to fix it later.


anyway, i think it's ok to remove that out-dated property in our driver :)




--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
