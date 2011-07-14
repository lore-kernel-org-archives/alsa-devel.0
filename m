From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] ALSA: hda - Disable automute feature by
	default
Date: Thu, 14 Jul 2011 14:59:32 +0100
Message-ID: <1310651972.8783.258.camel@localhost>
References: <1310609271.8783.252.camel@localhost>
	<s5hzkkh5lzh.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2911061951713760274=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from shadbolt.e.decadent.org.uk (shadbolt.e.decadent.org.uk
	[88.96.1.126]) by alsa0.perex.cz (Postfix) with ESMTP id DBA5E1039F2
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Jul 2011 15:59:42 +0200 (CEST)
In-Reply-To: <s5hzkkh5lzh.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: 631963@bugs.debian.org, alsa-devel@alsa-project.org, Toni Mueller <support@oeko.net>
List-Id: alsa-devel@alsa-project.org


--===============2911061951713760274==
Content-Type: multipart/signed; micalg="pgp-sha512"; protocol="application/pgp-signature"; boundary="=-ZTFuImoJQLDUVGTIV3cC"


--=-ZTFuImoJQLDUVGTIV3cC
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2011-07-14 at 10:01 +0200, Takashi Iwai wrote:
> [I resend this again since it didn't get out due to domain problem of
>  alsa-project.org.  If you've already seen the mail, please disregard.]
>=20
> At Thu, 14 Jul 2011 03:07:51 +0100,
> Ben Hutchings wrote:
> >=20
> > The default behaviour should be the same as before this feature
> > was introduced, to avoid user confusion.
> >=20
> > Reported-by: Toni Mueller <support@oeko.net>
> > References: http://bugs.debian.org/631963
> > Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> > ---
> > The code is rather inconsistent in whether 'mode' means the behaviour o=
r
> > mechanism of automute.  I didn't touch that but you might want to
> > consider some renaming.
>=20
> Sorry, I can't take this.
>=20
> First, the fix is touching a wrong place.  There are several flags to
> control the auto-mute behavior.  spec->automute is a flag to control
> the all auto-mute feature including the headphone jack.  For the
> line-out jack, it's spec->automute_lines flag.

OK.

> Secondly, this is a fix of long-standing bug.  With this change, the
> driver finally behaves consistently in a way seen in other OS.
[...]

But why would Linux users know or care how it behaves in the other OS?

Ben.

--=20
Ben Hutchings
If the facts do not conform to your theory, they must be disposed of.

--=-ZTFuImoJQLDUVGTIV3cC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATh72Oue/yOyVhhEJAQrvfg//eVSF+jJQHCCo1qUTV+GJ/klEsQ4ANmJt
BTFvStyru6s4SWiXhUkxLBTskRmXkcPdyXeRs4ckywLXN2G6Adyxf65yErTdNAAq
v7e0L0BJurc5orK+UVoOjVsJrgsBb+gbAPLt7n73Jffb6W6rXTtx8Gg2dCj33qZf
rwxrq110t/ZOEhD5ePirhBIdpDSEIzuBBSP0pDrL0YEdjxEE8NSBvbtyAZr9CNzu
yUJpWZN1Uv+FRELXBhVYG/x8EmJdvnp9JJQFvAKbSdBMqtMepATQf1P7NTF47yMn
HCORWCVsbseoS5VXcXpEf9kcHFyowoZw/4jb0DQ6b+8YI+3wxL4LVtt3BK/9NUSB
jNMRRd2c5rHeFFk0A22YJbnjJmERqKJ7d7NnSjCgjIHDBEULbd0K257k8FJ/hoEV
zuT452/MV8xOWY7XDpodCzsKKRJPmO/G3Iim5lFBf4NDMNxKjtA29VJjlEHZtwIM
5HXXvgt8Cf7h75RpccXKcOlLQ6kvhAt/lEIM39Q72cDStLI+GH1lZP5NxosD4L8u
Uztsi53Ci3D8jhVWJsUHym67DH+LRu+tV7O3GhCKL8zeiEXVPWBzWaYMaSvKmCXz
Vyv0orkIV5PQhrtghVlNHR6jsMqOQsT9rlKfXXXEKQE+mrFYkOOw1gc42T9AyVBO
ORoBPvyfXEc=
=iFJF
-----END PGP SIGNATURE-----

--=-ZTFuImoJQLDUVGTIV3cC--

--===============2911061951713760274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2911061951713760274==--
