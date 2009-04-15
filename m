From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: hda-intel channels hibernate bug
Date: Wed, 15 Apr 2009 18:08:37 +0200
Message-ID: <1239811717.6981.10.camel@johannes.local>
References: <1238921730.3782.3.camel@johannes.local>
	<s5hocuz2xau.wl%tiwai@suse.de>
	<1239715639.22047.0.camel@johannes.local>
	<s5hd4bf2w27.wl%tiwai@suse.de>
	<1239716613.22047.2.camel@johannes.local>
	<s5h63h60zwf.wl%tiwai@suse.de> <1239809427.4809.7.camel@johannes.local>
	<s5hmyaiylkm.wl%tiwai@suse.de> <1239811206.6981.9.camel@johannes.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5260298929531640169=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sipsolutions.net (xc.sipsolutions.net [83.246.72.84])
	by alsa0.perex.cz (Postfix) with ESMTP id 1DEDD244B2
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 18:09:09 +0200 (CEST)
In-Reply-To: <1239811206.6981.9.camel@johannes.local>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


--===============5260298929531640169==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-pffFmKkzu/crpOrsa2ow"


--=-pffFmKkzu/crpOrsa2ow
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-04-15 at 18:00 +0200, Johannes Berg wrote:
> On Wed, 2009-04-15 at 17:37 +0200, Takashi Iwai wrote:
>=20
> > Do you mean that it has no effect on the playback volumes, or on the
> > recording level?  The former is a bug, the latter not.
>=20
> > > And the last time I could record sound it was all choppy and sounded
> > > clipped.
> >=20
> > This might have been improved in the recent version.
>=20
> Actually, nothing seems to have an impact on the recording level, which
> is my problem -- audio is clipped.

No, that was wrong, there are just too many controls, I need to use
"Capture" rather than "Capture 1" or "Capture 2" and for some reason it
defaulted to max. Sorry!

johannes

--=-pffFmKkzu/crpOrsa2ow
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Comment: Johannes Berg (powerbook)

iQIcBAABAgAGBQJJ5gaCAAoJEKVg1VMiehFYV00QAIEld1E0jprT1PrcA0AAbg58
i1AnpVXBSFDgPnGVEOzHNihkGVNvHXUGUXYeme+AwuaZetnBi5h3Cjb/VvqxLH6J
pr0DsBZv+TFjXBkp1ARQGFV3nFxRnLbJJ2Q32DBf7sI52EC35OMARHsAKhRkk16Y
GSIUU7+wTFeen2BhustMgpFvtIsF9wUH/LObDToaQ+jQiPzPVMIbhPmktel1RFdN
ekVIkZJnGJxf03MTzSw8wqXgtB7CacUBSHB+cnIWMiH5K1oroPY6XxASS6bpRaP1
qujnKvTqq/s6AdvpKJDUoJbQYBrHf1KSutVro5YbUE07PdBVRTCKD1IDlZpcdKj8
kmW6TcB+b1KK1N7GETV6YSJuWXQykmRhEySfySru8hOk2ICH57fBglQyToQ3gM/W
KHqgkUJlkqgIASiz+ZR/KmZdCXt6rl/RFIzdhmVGiy9HkueDjnZmicou+JhBVifs
QnmjUR69cVUBS7XJqVywS2TE0KJ8ZaXKDwR4V+Gn0CdXSuTk8JAOrcfQ0bbZTcZo
ehN1iFnEnD2k0FF5F6RFPgK7UJBZSWnBPromHP+CQr6e0ktIhiN9KEI3ZQ1U8h3z
ZqzV52X8jEkxh1DfJaFXku5nrxVOds6dGR2+PnosSsf8q8La7SS4ES5EfxfdKDh3
SbJj97RxrE0+SpaieSFB
=U03Y
-----END PGP SIGNATURE-----

--=-pffFmKkzu/crpOrsa2ow--


--===============5260298929531640169==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5260298929531640169==--
