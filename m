From: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Subject: Re: Re: [PATCH v9 1/2] ASoC: sun4i-codec: Distinguish
 sun4i from sun7i
Date: Wed, 31 Aug 2016 22:14:02 +0200
Message-ID: <20160831221402.670ab832@scratchpost.org>
References: <20160830054403.7878-1-dannym@scratchpost.org>
	<20160830054403.7878-2-dannym@scratchpost.org>
	<20160831174623.GA20462@lukather>
Reply-To: dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBCPKHTHNWIPBBDPVTS7AKGQEKJEDOGI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20160831174623.GA20462@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Maxime,

On Wed, 31 Aug 2016 19:46:23 +0200
Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> > -#define SUN4I_CODEC_AC_SYS_VERI			(0x38)
> > -#define SUN4I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
> > +
> > +#define SUN7I_CODEC_AC_DAC_CAL			(0x38)
> > +#define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)  
> 
> That will need at least some mention in the commit log.

Hm? It's now called like it is called in the user manual.
Also, the macro SUN4I_CODEC_AC_SYS_VERI was unused before anyway.

What should I write in the commit log?

> It would be better to add a structure assiocated to the data field of
> of_device_id. That way, you'll also be able to have any quirks without
> adding more checks (such as a different regmap config, like Chen-Yu
> suggested).

Yeah, I did that now; seems to work.

Cheers,
   Danny
