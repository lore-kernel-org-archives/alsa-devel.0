From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/6] ASoC: samsung: Add Samsung Low Power Audio
 Subsystem driver
Date: Wed, 29 Jun 2016 22:57:57 +0100
Message-ID: <20160629215757.GX6247@sirena.org.uk>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-3-git-send-email-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="D+UG5SQJKkIYNVx0"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1466678715-19962-3-git-send-email-s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, inki.dae-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, Beomho Seo <beomho.seo-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--D+UG5SQJKkIYNVx0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 23, 2016 at 12:45:11PM +0200, Sylwester Nawrocki wrote:
> From: Inha Song <ideal.song-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
>=20
> This patch adds LPASS driver. The LPASS (Low Power Audio Subsystem)
> is a special subsystem that supports audio playback with low power
> consumption. This is a minimal driver which prepares resources for
> IP blocks like I2S, audio DMA and UART.
> Also system power ops are added to ensure the Audio Subsystem is
> operational after system suspend/resume cycle.

This is so trivial that I'm wondering why you even need it, it does
essentially nothing except for manage power on and off, and that isn't
synced up with the rest of the audio subsystem in any discernable way.
Previous Samsung SoCs have quite happily ignored their LPASS subsystems
in mainline.  As things stand I'm concerned that systems may get broken
if more functionality is added without the joining up with the rest of
the audio hardware via a card, there's not even the hooks which would
allow that.

--D+UG5SQJKkIYNVx0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdERhAAoJECTWi3JdVIfQfWsH/29+iYUNoubXsom5XgKcZ8bj
DSNjjNBHgRtC2hiK2wRJ44vs6TVWOrStxZW8qsMvQ3w6/Rk1v2v6orGqKF5Bgu8e
rHR64iBpaL1/UNhf0WLwyYxwJxYP6u5AYthjwDYUQWjNrBzI5jbq7Ev6cgWNhhRL
OyfKzFQKEk7U7iER/W+f1TVczEs8K2IYIlmN0SzFRJtVFo8eCeDDE+rWwKOThLZq
/BW9jelT++qzWolXR4q/XAxMxTmiP8YgrKwSm8Hn3NAMBxyKrvMgrZN+QL7K9JWV
zyMrsZ1FCsnQBSrIRsSmZj8U6HeF/1emcA0g01hXljQCC5vU/kyr84V2AAMaqiY=
=AdRV
-----END PGP SIGNATURE-----

--D+UG5SQJKkIYNVx0--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
