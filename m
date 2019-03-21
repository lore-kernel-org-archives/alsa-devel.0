From: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] arm64: dts: allwinner: a64: Rename
 hpvcc-supply to cpvdd-supply
Date: Thu, 21 Mar 2019 10:01:19 +0100
Message-ID: <20190321090119.5h7migh5wkn6yswx@flea>
References: <20190213070457.26049-1-wens@csie.org>
 <20190213070457.26049-3-wens@csie.org>
Reply-To: maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n64t5b7k22uirwh2"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBY5FZXSAKGQEMEDLX7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20190213070457.26049-3-wens-jdAy2FN1RRM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--n64t5b7k22uirwh2
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline

On Wed, Feb 13, 2019 at 03:04:57PM +0800, Chen-Yu Tsai wrote:
> The A64 datasheet lists the supply rail for the headphone amp's charge
> pump as "CPVDD". cpvdd-supply is the name of the property for this power
> rail specified in the device tree bindings. "HPVCC" was the name used in
> the A33 datasheet for the same function.
>
> Rename the supply so it matches the datasheet and bindings.
>
> Fixes: c56689e6f2fb ("arm64: dts: allwinner: a64: bananapi-m64: Enable audio codec")
> Fixes: 6de8e717848f ("arm64: dts: allwinner: a64: enable sound on Pinebook")
> Fixes: 498c21f233ed ("arm64: dts: allwinner: a64: enable sound on Pine64 and SoPine")
> Signed-off-by: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>

Acked-by: Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
--n64t5b7k22uirwh2--
