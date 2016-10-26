From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 02/12] ASoC: dapm: Implement stereo mixer
 control support
Date: Wed, 26 Oct 2016 17:57:53 +0100
Message-ID: <20161026165753.GC25322@sirena.org.uk>
References: <20161003110804.28235-1-wens@csie.org>
 <20161003110804.28235-3-wens@csie.org>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NU0Ex4SbNnrxsi6C"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBWOBYPAAKGQE4GR2HJI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20161003110804.28235-3-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--NU0Ex4SbNnrxsi6C
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Mon, Oct 03, 2016 at 07:07:54PM +0800, Chen-Yu Tsai wrote:

> While DAPM is mono or single channel, its controls can be shared between
> widgets, such as sharing one stereo mixer control between the left and
> right channel widgets.

> This patch introduces support for such shared mixer controls.

Based on this changelog I'm really not sure what the intended semantic
of this change is which makes it difficult to review.  What are you
expecting these controls to look like and how are you expecting them to
work?

> -static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i)
> +static void dapm_set_mixer_path_status(struct snd_soc_dapm_path *p, int i,
> +				       int nth_path)

It looks like the goal is to attach more than one path to a single
control somehow?
--NU0Ex4SbNnrxsi6C--
