From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 2/3] ASoC: rename some sun7i-only registers
Date: Sun, 18 Sep 2016 22:17:47 +0200
Message-ID: <20160918201747.GL17518@lukather>
References: <20160915163630.18026-1-dannym@scratchpost.org>
 <20160915163630.18026-3-dannym@scratchpost.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FnOKg9Ah4tDwTfQS"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBB3HM7O7AKGQEQS4MVUQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160915163630.18026-3-dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Danny Milosavljevic <dannym-bxPqe3T81XXwRsdMLXbzog@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--FnOKg9Ah4tDwTfQS
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Sep 15, 2016 at 06:36:29PM +0200, Danny Milosavljevic wrote:
> ASoC: sun4i-codec: Some of the registers are sun7i-only.

That line is useless, you already have the commit title.

> 
> Therefore rename "SUN4I_CODEC_SYS_VERI" to "SUN7I_CODEC_AC_DAC_CAL" and
> rename "SUN4I_CODEC_AC_MIC_PHONE_CAL" to "SUN7I_CODEC_AC_MIC_PHONE_CAL".

And removing it, you could make a real sentence, like:

Some of the registers defined in the driver are only usable on the
A20. Rename these registers.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--FnOKg9Ah4tDwTfQS--
