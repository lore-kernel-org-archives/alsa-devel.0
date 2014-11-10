From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 1/3] ASoC: twl4030: don't report EBUSY if no change
 requested.
Date: Mon, 10 Nov 2014 11:45:18 +1100
Message-ID: <20141110114518.715dcd4e@notabene.brown>
References: <20141108002637.6561.19002.stgit@notabene.brown>
	<20141108003803.6561.42934.stgit@notabene.brown>
	<20141108092242.GB2722@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Ry163USoKLJGigS4hoDEhBo"; protocol="application/pgp-signature"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141108092242.GB2722-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

--Sig_/Ry163USoKLJGigS4hoDEhBo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Sat, 8 Nov 2014 09:22:42 +0000 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> On Sat, Nov 08, 2014 at 11:38:03AM +1100, NeilBrown wrote:
>=20
> > +	int val =3D ucontrol->value.integer.value[0];
> > +
> > +	if (!!(twl4030_read(codec, TWL4030_REG_CODEC_MODE)
> > +	       & TWL4030_OPTION_1) =3D=3D !!val)
> > +		/* No change */
> > +		return 0;
>=20
> We shouldn't be accepting attempts to set out of range values so there
> should be no need for the !! on val (which confused me when I was
> reading this).

True, the '!!' on val isn't necessary.

I took the opportunity to look around a bit more and discovered there was a
snd_soc_get_enum_double, which I really should use in preference to
twl4030_read.

So here is the new version.  Can it be taken out of the email, or should I
resend stand-alone?

Thanks,
NeilBrown


From: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Date: Wed, 2 Oct 2013 14:45:52 +1000
Subject: [PATCH] ASoC: twl4030: don't report EBUSY if no change requested.

"mode" must not be changed when active.
However if a request is received to set the mode to what it currently
is, that is also rejected when active, which causes confusing
error messages.

So check first and if no change is actually requested, don't report
an error.

Signed-off-by: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index b6b0cb399599..613b61cee081 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -957,6 +957,16 @@ static int snd_soc_put_twl4030_opmode_enum_double(stru=
ct snd_kcontrol *kcontrol,
 {
 	struct snd_soc_codec *codec =3D snd_soc_kcontrol_codec(kcontrol);
 	struct twl4030_priv *twl4030 =3D snd_soc_codec_get_drvdata(codec);
+	struct snd_ctl_elem_value currentval;
+	int ret;
+
+	ret =3D snd_soc_get_enum_double(kcontrol, &currentval);
+	if (ret)
+		return ret;
+	if (ucontrol->value.enumerated.item[0] =3D=3D
+	    currentval.value.enumerated.item[0])
+		/* No change */
+		return 0;
=20
 	if (twl4030->configured) {
 		dev_err(codec->dev,

--Sig_/Ry163USoKLJGigS4hoDEhBo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIVAwUBVGAKnjnsnt1WYoG5AQINZQ//VDIecdqCM5IduFfNuGehnhN0g6yQQpYD
/OVxUHOlUjbqCMkW+ny+aK+X4qlDkGXruWe3v27fC0o7TCw4t8T3iNwmEAHrM1Fy
BLigMrwTI0+MotekbSfLa/3VkGOYN41Crcu7Z5ghtGKQJS9u/VnbE4YsSh1ZWLyQ
e5rs/1GO6ea18aIYIyYw3wvZp4JYYaMSHB4AZXoLjc205fLJs9lo5KROAk4gMApn
XT/P+0L+ne2yqV++OEQGY1TVayZftFCEDPJq0uiVM0lNrT2SX/LydRMXDo5Venze
eYg6XCXfono7521fLi2w61ACy/bm8hkrTDUG544o/hDR8tD0hs0JkO+6Zgx5kNYD
qq8b//9tEHxc5V+/cAsVjltUlxp8pMn1LBitqcgP7rSzSDLeFIhy56d4M2rY1nuh
d3xtpjATJXbiuUv02CF90ZwckntpROA8yseK/wr46LLgsCW8sePgSoMYYZ5NVBli
rns7DKwo8TitdzyHVFjg6e0OZBpp6x0hyzlbpHElTG1501hKzCvCkr0xlaC/TCwx
POW41A9tc9Jx5qMDn8ZwOhdrewTA6cJ+ikuoUMalBwDpHteE1CRUqdmpgNm5d5/1
cgqqJ01yQNLvk30pKLjmKr+mo0VimjpO2Qh6pZMKVJnRW1QB9nH86xyGiYDjO7H6
zqcImho01ik=
=0Zzo
-----END PGP SIGNATURE-----

--Sig_/Ry163USoKLJGigS4hoDEhBo--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
