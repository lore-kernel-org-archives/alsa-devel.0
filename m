From: Steven Newbury <steve@snewbury.org.uk>
Subject: Re: No speaker output with kernel 3.15 and later
Date: Tue, 01 Jul 2014 12:49:32 +0100
Message-ID: <1404215372.2290.0.camel@snewbury.org.uk>
References: <1404050996.31259.2.camel@snewbury.org.uk>
 <s5hr426sqbq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3174281666641347280=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from know-smtprelay-omc-11.server.virginmedia.net
 (know-smtprelay-omc-11.server.virginmedia.net [80.0.253.75])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C7EC261A83
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 13:49:57 +0200 (CEST)
In-Reply-To: <s5hr426sqbq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3174281666641347280==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-WybSedh4LnT8suFlWM5/"


--=-WybSedh4LnT8suFlWM5/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2014-06-30 at 11:24 +0200, Takashi Iwai wrote:
> At Sun, 29 Jun 2014 15:09:56 +0100,
> Steven Newbury wrote:
> >  I sent=20
> > Takashi an email mentioning this regression a month ago, and
> >  it's=20
> > taken me this long to send this email... :-$
> >  Since updating to=20
> > kernel versions >=3D3.15 I've had no audio from my
> >  laptop speakers. =20
> > Earlier versions worked fine.
> >  It's a CLEVO W270EUQ laptop.  The=20
> > output mixer device is showing up,
> >  but no sound comes out at any=20
> > volume level.
> >  As requested I've attached compressed alsa-info.sh=20
> > output for both the
> >  working and non-working cases.
> >  I'm perfectly=20
> > willing to test patches etc.
> =20
> Hm, I see no significant difference between 3.14 and 3.15 alsa-info.sh
> outputs, and there's been very little change for VIA codecs between
> these versions.  So, in short, I have no idea what went wrong.
> =20
> Could you double-check whether it's really a kernel issue?
> That is, switch between 3.14 and 3.15 and confirm the problem happens
> only with 3.15.  Also, for testing the sound, try like
> =20
>         % aplay -Dplughw -vv foo.wav
>=20
Checked again.

3.16-rc2: silence
3.14.3: works fine


--=-WybSedh4LnT8suFlWM5/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlOyoEwACgkQGcb56gMuC62MhwCfYilkFFaw7Vd+S65bCtsGtcFu
jWEAn2ys4StysMEogfjL4gPHHi+vQz1/
=G6PO
-----END PGP SIGNATURE-----

--=-WybSedh4LnT8suFlWM5/--


--===============3174281666641347280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3174281666641347280==--
