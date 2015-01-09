From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v9 3/4] ASoC: tda998x: add a codec to the HDMI transmitter
Date: Fri, 9 Jan 2015 17:54:59 +0000
Message-ID: <20150109175459.GN2634@sirena.org.uk>
References: <cover.1420628786.git.moinejf@free.fr>
 <23b36acc1f769418a06f3e929eba288b5911da12.1420628786.git.moinejf@free.fr>
 <54B0123C.9070800@arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yS2QJoX5Vl2MmcUM"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54B0123C.9070800-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Jackson <Andrew.Jackson-5wv7dgnIgG8@public.gmane.org>
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Dave Airlie <airlied-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--yS2QJoX5Vl2MmcUM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 09, 2015 at 05:39:08PM +0000, Andrew Jackson wrote:

> In the light of our discussions elsewhere [1], shouldn't this
> be constrained by the number of hardware channels that the TDA998x
> supports too?  That is, the maximum number of channels should
> be the lesser of sd[SAD_MX_CHAN_I] and number_of_I2S channels=20
> (or S/PDIF channels if so configured).

Yes, that's a good idea in general - we should do more of this.

--yS2QJoX5Vl2MmcUM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUsBXyAAoJECTWi3JdVIfQazgH/0plBowsIMWRwsEapQBO3mSJ
+AhpyNiWBoOpCtbEhgQVxJtL+mZ2OT+LqE1RPLOuGdjukQlOCz5q1dx1q/q+PrmB
OGnCov6TIp1k+5qW9GeHhoJgEsaSXFys45dXT9egpgMI7UuqeQswZVHK4cfD6Mpd
byU5MxgWgNzG2S6EWOr4MaHVsQNTDr0WFuo/ZjouK3FiEUj80P7A/0mPxeYfzPC6
/iiIOyvAM48Q50ppXPzDboUhyopbeszQd++M2/5tv/y+DfqA9DO44fdHxrwApB22
+UZyrcwdNeuKCvO/1Q2Le1xj6MinPTxEYC4XVekeAiylOOLTSAimPgqcnrbjiyI=
=l2kO
-----END PGP SIGNATURE-----

--yS2QJoX5Vl2MmcUM--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
