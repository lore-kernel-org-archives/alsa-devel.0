From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2] ASoC: fsl-sai: using 'lsb-first' property instead of
 'big-endian-data'.
Date: Fri, 29 Aug 2014 20:11:41 +0100
Message-ID: <20140829191141.GA29327@sirena.org.uk>
References: <20140829110601.GB21473@leverpostej>
 <20140829115943.GV29327@sirena.org.uk>
 <20140829164010.GA5520@Asurada>
 <20140829172601.GC18555@leverpostej>
 <20140829174019.GA5536@Asurada>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lYjFa3qL1bvncypl"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140829174019.GA5536@Asurada>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--lYjFa3qL1bvncypl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 29, 2014 at 10:40:20AM -0700, Nicolin Chen wrote:

> Agreed, it's better to be described in the commit comments as well.

> And regarding the compatibility with the old DT, I personally prefer
> it to be added in the change for safety but if this case is allowable
> which I'm not so sure about it, I'm fairly okay with the rename.

If you're happy I can easily add a note, but keeping the old property
would remove all doubt :)  I'll wait for either an ack or a respin.

--lYjFa3qL1bvncypl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUANBqAAoJELSic+t+oim9FD0P/jUvsFBwEyAN2jvYezhNgr5+
VXho1bgvY7e1FBmlXmw4pLMCmNpx1SVV9SByQuwCvqN1UeaMhtt5jdLEIZj8JWD0
5ok8hqBBc787ZqFdfUpouYiwiQ+Bm7C1vYjiXSMtnUQL7IzHhkS5JONYSbnGCsGb
f8vBVMjilZYiUm8VEuqCsFtD+9xfMBTsAXpQ8WVHxsFz4SRTZ+FfySEefmiOjKYi
CfMSnYG+l+sD1X11RLbZwaHqmNau27yoyUkkbtcc/m51TAeU6IAOhwpaaYjvVbzk
0Wfjmd0akLmCSOAhhBdH0jtoWx58+UeXUnsWYSjnjtm2FCc6eGZapSS0M0m4JVSY
01MvQn9sGGeRA9lHOrR9HO32wVVZFduX+vsGzdHEbW+E3ik2PqyNEY5EQn+6UPBp
D1EgNjZAeMuLnrdeHghYUQCwm0bI+UvAR27fTy7a1ZfU65CYAKzTWw/P/fGjXs1M
QP0b8jgZZuZj2JTCMx+ZPXY/uW4obpUB31FxZmaV5Byir3HbGmaxQrpUiUQhSNPO
ULeA9OU1E7ByEqBWzo2wEIVwUVZy96AB/ZHL3SmShlTB0msjdwxlJbKLy/dZv6sv
hLWMdx47bZZ+hktzkwZod53wCoviYrfKN9e0dT8V23xOBS5i38AaccfywnBK4Iv1
z/aGJ1+5aXEvOKnzXR2X
=fPhD
-----END PGP SIGNATURE-----

--lYjFa3qL1bvncypl--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
