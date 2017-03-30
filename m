From: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Subject: Re: [PATCH] ASoC: wm8903: add regulator handling
Date: Thu, 30 Mar 2017 13:42:08 -0600
Message-ID: <a236515d-b433-2dcc-a1e6-43debfb29832@wwwdotorg.org>
References: <20170320091352.4115-1-linus.walleij@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170320091352.4115-1-linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 03/20/2017 03:13 AM, Linus Walleij wrote:
> The WM8903 has four different voltage inputs: AVDD, CPVDD, DBVDD
> and DCVDD. On the Qualcomm APQ8060 Dragonboard these are all
> supplied from proper regulators and thus need activating and
> binding.
>
> This is a quick-and-dirty solution just grabbing and enabling the
> regulator supplies on probe() and disabling them on remove() and
> the errorpath. More elaborate power management is likely possible.
>
> I assume the nVidia designs using this codec have some hard-wired
> always-on power and will be happy with using the dummy regulators
> for this. But someone from the nVidia camp should probably check
> whether they can bind these to proper regulators instead.
>
> We also amend the DT binding document. A small change like this
> does not warrant a separate patch for augmenting these.

Tested-by: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Sorry for the slow response.

Tested using NVIDIA springbank/seaboard board. Just in case anyone reads 
this later and wonders how: I will point out that in the baseline 
v4.11-rc4, the LCD (or perhaps just its backlight) doesn't work on this 
HW any more, but since the GUI login prompt plays a sound, I was still 
able to validate the WM8903 change.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
