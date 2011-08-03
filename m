From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: EeePC 1005PE microphone is "stereo only",
 silent in mono
Date: Wed, 03 Aug 2011 10:56:01 +0200
Message-ID: <1312361761.4004.14.camel@mattotaupa>
References: <20110731233945.1frwedfvso8c8kck-cebfxv@webmail.spamcop.net>
	<s5hwrex5xd4.wl%tiwai@suse.de>
	<20110801131229.d0smwpen9cw0wg8k-cebfxv@webmail.spamcop.net>
	<s5hk4aws0r0.wl%tiwai@suse.de> <4E384D7A.2020206@gnu.org>
	<s5h1ux3sjlp.wl%tiwai@suse.de> <4E385AD2.7060904@gnu.org>
	<s5hty9zqace.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2566682822725860742=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id BB3062463D
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Aug 2011 10:56:05 +0200 (CEST)
Received: from f053043040.adsl.alicedsl.de ([78.53.43.40]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1QoXFH-0007v6-EZ
	for alsa-devel@alsa-project.org; Wed, 03 Aug 2011 08:56:07 +0000
In-Reply-To: <s5hty9zqace.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2566682822725860742==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-MfMXqcLOAEfgg1o/cblK"


--=-MfMXqcLOAEfgg1o/cblK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Mittwoch, den 03.08.2011, 08:26 +0200 schrieb Takashi Iwai:

[=E2=80=A6]

> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda - Fix digital-mic mono recording on ASUS eeePC

The official spelling seems to be Eee PC [1].

> The digital-mic unit on ASUS eeePC gives PDM signals instead of the norma=
l

Dito.

> stereo PCM, thus you can't record a mono stream from the stereo stream as
> is; the summing the stereo signal results in almost zero level, and you'l=
l

Should =C2=BBthe summing=C2=AB be =C2=BBin summary=C2=AB?

> hear only noise.
>=20
> As a workaround, use ALC269-specific COEF to manipulate the dmic route
> for mono, like used for ALC271x.  Since this is implemented as a fix-up
> and the auto-parser works fine for eeePC, the patch drops the model
> quirk entries for them, too.

So as a consequence everyone using `model=3Dauto` can drop that from
`/etc/modprobe.d/`?

I do not know how high the regression chance might be, but if there is
any, maybe split the patch and write all models in the commit summary

        ALSA: hda - Use auto parser for ASUS UX50, Eeepc P901, Eeepc S101 a=
nd P1005HA

for people looking through the commit log.

> Reported-by: Pavel Roskin <proski@gnu.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  sound/pci/hda/alc269_quirks.c |    7 -------
>  sound/pci/hda/patch_realtek.c |   26 ++++++++++++++++++++++++++
>  2 files changed, 26 insertions(+), 7 deletions(-)

[=E2=80=A6]


Thanks,

Paul


[1] http://www.asus.com/Eee/

--=-MfMXqcLOAEfgg1o/cblK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk45DSEACgkQPX1aK2wOHViXxACcC7AbySz/Kr9pYI9vjsGT5AeC
nzQAnR3TQjPU4TI/vXchnNpyhmOkta2a
=8DNs
-----END PGP SIGNATURE-----

--=-MfMXqcLOAEfgg1o/cblK--


--===============2566682822725860742==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2566682822725860742==--
