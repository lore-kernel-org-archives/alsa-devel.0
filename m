From: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/8] ARM: at91: sama5d3: enable sound support
Date: Fri, 18 Apr 2014 22:35:02 +0200
Message-ID: <53518C76.2020005@atmel.com>
References: <1395049541-28128-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1395049541-28128-1-git-send-email-voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bo Shen <voice.shen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>, Boris BREZILLON <b.brezillon-ZNYIgs0QAGpBDgjK7y7TUQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jean-Christophe Plagniol-Villard <plagnioj-sclMFOaUSTBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 17/03/2014 10:45, Bo Shen :
> This patch add sound support on sama5d3xek board.
> 
> This patch series based on the following patch set:
>   clk: at91: better support for the PCKs
>   http://comments.gmane.org/gmane.linux.kernel/1664477
> 
> 
> Bo Shen (5):
>   ARM: at91: sama5d3: add DMA property for SSC devices
>   ARM: at91: sama5d3: disable sound by default
>   ARM: at91: sama5d3: correct the sound compatible string
>   ARM: at91: sama5d3: add the missing property
>   ARM: at91: sama5d3: clock for ssc from rk pin
> 
> Boris BREZILLON (3):
>   ASoC: atmel: support CCF based clks
>   ASoC: atmel: document clock properties of the wm8904 driver
>   ARM: at91/dt: add clock properties to the wm8904 codec node

Hi Voice and Boris,

For this series I am a little bit puzzled: should I take the ASoC part
of it? I see no acknowledgement from Mark and I also read some messages
still discussing about CCF and wm8904 afterwards.

So, I take the 5 patches by Voice Shen and tell me what is the proper
sequence with this wm8904 work.

I will be happy to stack more patches about this topic during the 3.16
development phase.


Otherwise, the 5 patches by Voice go into at91-3.16-dt branch.

Thanks, bye.


>  .../devicetree/bindings/sound/atmel-wm8904.txt     |  2 ++
>  arch/arm/boot/dts/sama5d3.dtsi                     |  6 ++++++
>  arch/arm/boot/dts/sama5d3xmb.dtsi                  | 11 +++++++++-
>  sound/soc/atmel/atmel_wm8904.c                     | 25 +++++++++++-----------
>  4 files changed, 31 insertions(+), 13 deletions(-)
> 


-- 
Nicolas Ferre
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
