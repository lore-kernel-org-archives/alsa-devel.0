From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] ASoC: sun4i-i2s: Show detailed error when
 DAI configuration callbacks fail
Date: Thu, 14 Dec 2017 09:12:11 +0100
Message-ID: <20171214081211.ow6q5cgwew2buwfj@flea.lan>
References: <20171214072928.6613-1-wens@csie.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f656jwpyda5fjvbp"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBZXEZDIQKGQEFXPZCHA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20171214072928.6613-1-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Code Kipper <codekipper-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--f656jwpyda5fjvbp
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Thu, Dec 14, 2017 at 03:29:28PM +0800, Chen-Yu Tsai wrote:
> When any of the DAI hardware configuration callbacks (.hw_param,
> .set_fmt, .set_sysclk) fails, there is no explanation about why it
> failed. This is particularly confusing for .hw_param, which covers
> many parameters of the DAI. Telling the users what parameter isn't
> supported, and what the requested value was goes a long way for
> developers trying to combine sun4i-i2s with external codecs.
> 
> This patch adds dev_err calls explaining what isn't supported or
> failed, and what the value was. sun4i_i2s_set_clk_rate()'s first
> parameter was changed to a struct snd_soc_dai *dai, so we can
> get the underlying device.
> 
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--f656jwpyda5fjvbp--
