From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 1/8] ASoC: dt-bindings:
 sun50i-codec-analog: Add headphone amp regulator supply
Date: Fri, 23 Nov 2018 13:31:26 +0000
Message-ID: <20181123133126.GF2089@sirena.org.uk>
References: <20181122102325.29495-1-wens@csie.org>
 <20181122102325.29495-2-wens@csie.org>
 <20181122153241.lzrwhkewg5q4hy2c@flea>
Reply-To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tWc6BTYdre847SEs"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBNUC4DPQKGQE3W34SKY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20181122153241.lzrwhkewg5q4hy2c@flea>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Vasily Khoruzhick <anarsoul-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--tWc6BTYdre847SEs
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Thu, Nov 22, 2018 at 04:32:41PM +0100, Maxime Ripard wrote:
> On Thu, Nov 22, 2018 at 06:23:18PM +0800, Chen-Yu Tsai wrote:

> > +- cpvdd-supply: Regulator supply for the headphone amplifier

> I guess we should make this optional, since even if it's missing, it's
> going to create a dummy regulator. and that allows to have backward
> compatibility.

Regulators should never be marked as optional unless they can be
physically absent.  It is true that Linux has code to handle partially
defined device trees but we shouldn't rely on other OSs having similar
code and it's better practice to have board device trees be fully
specified, it means that if we need the regulator information for some
future thing it's more likely to be there and it's less likely that bugs
which do things like cause the regulator to be powered off incorrectly
will be introduced in future.
--tWc6BTYdre847SEs--
