From: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Subject: Re: [PATCH] ASoC: sun4i-codec: Distinguish sun4i from sun7i
Date: Tue, 6 Sep 2016 11:29:52 +0800
Message-ID: <CAGb2v67yFx1VxGFWQk-Z9V=BQN0kfj1YJWfqb5RCNRUwVWrjbA@mail.gmail.com>
References: <20160905192404.13871-1-dannym@scratchpost.org> <20160905192404.13871-2-dannym@scratchpost.org>
Reply-To: wens-jdAy2FN1RRM@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCMILY6JWQBBBSHQXC7AKGQEWBIPWKA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160905192404.13871-2-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 6, 2016 at 3:24 AM, Danny Milosavljevic
<dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org> wrote:
> ASoC: sun4i-codec: Distinguish sun4i from sun7i
>
> Introduce mechanism to detect sun7i and provide a different regmap, codec
> and different controls for it - different compared to sun4i Allwinner A10.
>
> The controls will be extended in a forthcoming patch - it is necessary to
> distinguish between sun4i and sun7i controls because the mic gains are in
> different registers.
>
> Renamed SUN4I_CODEC_AC_SYS_VERI to SUN7I_CODEC_AC_DAC_CAL and renamed
> SUN4I_CODEC_AC_MIC_PHONE_CAL to SUN7I_CODEC_AC_MIC_PHONE_CAL because these
> are actually not present on Allwinner A10.
>
> Handle quirks by regmap config and codec and select the correct quirks
> automatically.
>
> Signed-off-by: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>

Acked-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
