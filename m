From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH v3 4/4] ASoC: simple-card: Add DT
 documentation for multi-DAI links
Date: Wed, 19 Mar 2014 19:21:57 +0000
Message-ID: <20140319192157.GW11706@sirena.org.uk>
References: <cover.1394883134.git.moinejf@free.fr>
 <d054780a0edf4b2338a52e48bff9144e19aa614f.1394883134.git.moinejf@free.fr>
 <20140317164339.GR11706@sirena.org.uk>
 <20140318091728.1d2240ca@armhf>
 <53296CB7.1000909@ti.com>
 <5329E749.6070900@metafoo.de>
 <5329ECC2.7040803@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sctg3NRPI3j1J0DR"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5329ECC2.7040803-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>
Cc: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Xiubo Li <Li.Xiubo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--sctg3NRPI3j1J0DR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 19, 2014 at 09:15:14PM +0200, Jyri Sarha wrote:
> On 03/19/2014 08:51 PM, Lars-Peter Clausen wrote:

> >When does this make sense? Either the bitclock is inverted for all of
> >them or for none.

> Definition of clock signal and it's inversion varies between chip
> manufacturers and sometimes it may not be possible to get all the dai
> drivers to work identically in this respect. Because of this in some cases
> there may be a need to set the inversion bit only at one end of the link.

No, Linux has a definition of all the clock modes which applies to all
devices regardless of what the manufacturer documents in their
datasheet.

--sctg3NRPI3j1J0DR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKe5SAAoJELSic+t+oim9iCUP/1r3+A9s/XhXpLnEoxAoYjzx
jILm8CNuiPSIAQ+cv+NxbjQ4qXpM5ruRitl/jcUZBjSZ+QALhLrJbYdo/emRya+o
FYNjSsuUhqe2WhT6W2+OOjph9bN4pTRMGxvC8OG/BiIk6P6PLFcGoXM/EZRUTmHl
ZBaj3lMvSLitz0rW6DNK1R4/IxhwzFq4mraG4H04Um6EYoyRoWvsvyY9XutSGo/g
Lp9jL//MNZ1ntLmYOOzazbIlZNIaiZMIJG0CklIKcFUggk8T7ia6BKgs/TySBghc
qfjpIhnVbQ8BOG2VLH3E3jnEoCdEv8fwDR0Dj5hZiuKPrvfKmN1FynIkPfwqhNrK
jOcB7VK2KQdFXP0rd+Ng/H4dYA7lEGfHnGyytuRbr+xioXJ0Q2arwo+y3Af+/cGX
ITyB4yLnyuMObX5qkHWjyT6Z1GU96wiYjT2iAlxNaT39cp9fmLrn1vD4DiMLB+qB
aGaGhGID1IAXM85DXgb14mdBG4AHWmVNSs9oQgQ2L47SbPgcT8jqdYNTeyFAQyWe
JNlbYaGKf3GqyWeCT0f2LLdiOPToztXPosHMs0dGhQ7SSox0+E2uICRN2VqQXTqN
VTvfJOmlknOiGqlps2XzctJ7iVtmfCzZ9+XUr7kUdtl1/2LbCu9PTFhlNBLX9oyf
dZa0qJGoC2QYCrPEsMSX
=ITy2
-----END PGP SIGNATURE-----

--sctg3NRPI3j1J0DR--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
