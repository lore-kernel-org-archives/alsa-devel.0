From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH] ASoC: sun4i-codec: use consistent names for
 PA controls
Date: Tue, 27 Oct 2015 19:27:06 +0100
Message-ID: <20151027182706.GE6114@lukather>
References: <1445688712-31951-1-git-send-email-ats@offog.org>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpbVkmxF4tDyP/Kb"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB64DX6YQKGQEW24YFTA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1445688712-31951-1-git-send-email-ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <http://groups.google.com/group/linux-sunxi/subscribe>
To: Adam Sampson <ats-G+91BasbrijYtjvyW6yDsg@public.gmane.org>
Cc: lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--IpbVkmxF4tDyP/Kb
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

Hi,

On Sat, Oct 24, 2015 at 01:11:52PM +0100, Adam Sampson wrote:
> The power amplifier for the headphone output is called "the PA" and "the
> headphone amplifier" in Allwinner's documentation for the A10 and A20.
> sun4i-codec calls it "PA" in some places and "Pre-Amplifier" (which
> isn't really accurate) in others, leading to user-visible controls with
> different names referring to the same device.
> 
> When this driver implements audio input, it'll also need to expose
> controls for the line and mic input preamps, so just referring to "the
> Pre-Amplifier" will be ambiguous.
> 
> Change it to use "PA" consistently for the power amplifier.

Just to avoid any ambiguity in the future, could you call that Power
Amp(lifier?) instead?

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
--IpbVkmxF4tDyP/Kb--
