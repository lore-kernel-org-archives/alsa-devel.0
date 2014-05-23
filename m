From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] ASoC: max98090: Add master clock handling
Date: Fri, 23 May 2014 12:41:13 +0100
Message-ID: <20140523114113.GE12304@sirena.org.uk>
References: <1400750228-13750-1-git-send-email-tushar.behera@linaro.org>
 <1400750228-13750-2-git-send-email-tushar.behera@linaro.org>
 <20140522103039.GD12304@sirena.org.uk>
 <CAHbNUh2QHv8n7Y19qfO7BagX5AWe0i17MjDvr7yOpHf6YNGW4A@mail.gmail.com>
 <20140523111446.GA12304@sirena.org.uk>
 <CAHbNUh152xgyVxcCHiv0M6PLw8DE7KZ990WG7uRWWFBc8sPWRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fjxFa3KHLyh6LS4q"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAHbNUh152xgyVxcCHiv0M6PLw8DE7KZ990WG7uRWWFBc8sPWRQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tushar Behera <tushar.behera-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, "jerry.wong" <jerry.wong-zxKO94PEStzToO697jQleEEOCMrvLtNR@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--fjxFa3KHLyh6LS4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 23, 2014 at 05:06:27PM +0530, Tushar Behera wrote:
> On 23 May 2014 16:44, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Should be clk_prepare_enable() and similarly for the disable and you
> > should check the error codes but yes, that looks good.

> I was planning to keep clk_prepare/clk_unprepare in probe/remove.

Why - what purpose would it serve to leave the clock prepared but not
enabled?

--fjxFa3KHLyh6LS4q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTfzPWAAoJELSic+t+oim9iEAP/in4oIa0UZDAiTrzCqEakgNX
9r57NnpWbaLq4c7zYrursK2kl6SNDdgNQOHP8vebvqQsFcYe/Wvi4PfYA8tZlNZf
ISMmvvVBJcR/NkJrOy/zEK+VtsO1T14UoV2G9vPuzMYpyviSOFfUvDta2BaJR6Ig
TXvhJVtD56wNdLr8knMx1xIiQn2tEpO6N73RVWE30eIsrvTEmFxEDeWNkrbYcc36
pN2tmmOdbRBI8JSLlYTroZ6KekN4iySeZLlq4mbmdQblZzpW4mtL3y8+7Xl0EOMA
Ij2Ynh2FnXQijyGj35nnwp3lGKV3gfZyYvni48TGwRe//JP8Lj7+HUZtx9eh+mDI
vaeAhPJnCgBcHF4Rb4cjsQKjcVnt3PgWzAHsN/7BK3I65xRQZ9/cwPNLVUw53puq
o9vcR7UOwMW6UK6tpXa510RC5lVyLQ/OspXXw2XsY2rtfxwOwhaJWP0bi9O7GARb
Flwk/4/dnwoFhth2jGts/6YM4cymfN7cwPoKHO/YHknIBMt61WqaoQ3GACHzqwFf
9d+j/hIOhIDwQQKli9bbgqAUQk0qNPMnF+J1S1kBXtcby9OuJYfXf0lbTwoorESa
4t1P4oT9vquBtlqh3FW729vRdj6W7fGRnkIlyE/mTEe7mdf2P2L9DCIfr02i6d/c
h0qkN7Ba45ZXUdVFJd1X
=PcVO
-----END PGP SIGNATURE-----

--fjxFa3KHLyh6LS4q--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
