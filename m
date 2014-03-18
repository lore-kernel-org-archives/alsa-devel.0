From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: add RT286 CODEC driver
Date: Tue, 18 Mar 2014 13:01:37 +0000
Message-ID: <20140318130137.GZ11706@sirena.org.uk>
References: <1394521896-27721-1-git-send-email-bardliao@realtek.com>
 <20140314191244.GZ366@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D73A0212@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9061317482161327570=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F18AE26072A
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 14:01:47 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D73A0212@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>, Gustaw Lewandowski <gustaw.lewandowski@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============9061317482161327570==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="quagH4H09id5XL2e"
Content-Disposition: inline


--quagH4H09id5XL2e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 12:41:41PM +0000, Bard Liao wrote:

Please fix your mailer to word wrap within paragraphs, this will make
your mail more legible.

> A verb command contains three parts, NID, VID, and PID.
> For example, if I want to unmute headphone, I should set:
> VID =3D 3'h (Set Amplifier Gain)
> NID =3D 22'h (headphone)
> PID =3D b000'h (Set left, right output unmute)

So VID+NID is an address and PID is a value?

> > - if you need more let's extend them.  Storing data in virtual register=
s just
> > makes things confusing and fragile.  Some older CODEC drivers did it and
> > they're harder to work with now than they should be.

> Use SOC_DAPM_SINGLE_VIRT?

Yes, that'd be a much better fit.

> If I combine NID and VID to be used as a register address, and let PID as=
 register value,
> it will be very difficult to define(or use) a _update_btis function.
> Because I need to put all NID, VID and PID in the register address area w=
hen I issue a I2C read command.

I don't see how this follows at all - all update_bits() is doing is a
read/modify/write so if you can implement write and read then it comes
along for free.  It sounds like you need to do a cache read to get the
current PID to do a read but it's not at all obvious what that has to do
with update_bits() or how putting the value into the address avoids
having to know the current value to do a read?=20

I think what you're saying above is that your read needs to have a cache
read in it to function if you use normal register values?

--quagH4H09id5XL2e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTKEOtAAoJELSic+t+oim9kKYP/RXvprzjga2D4exMTDORgnl1
boVdiLGzLs7ZiTYE3PU4RaHCpK8ody/vX7ylGbZuKRLVL9M1ihhjIwqdYkWBVuis
lDQb/BMDjlPt2Afem5/ndXYnrQOzyJLa+zFysQLig9XutDIW+h4alut1UQc7puuf
QIOEi/Tz7K/g6x6+8VHzx3fPk/KoGhKeweDaQRNTKov7SDPMd5XPNSapQrfzqB9t
N1qyZ2ZjCl1vOGgAf6gDcMwd2DPjW1N8vsRkJpVBsyRsuwCffVyvrjEyUK7svPOu
qVntGICr1oktXMwBBfjCfhCKlY2qaRkEiD9J0okIHmwNdrvPtoUws5S3a3qN1nFK
xwKNJrsXWHL6kRJxO0uH8yW+N1aB9G7mMNK+luEZ8YXqjnMS6pM+T64ziQei1GUl
JRSfSdMhTaaovjrBH9pMsawOgdil7TGkCjtqtBNi/mSuyzbZn5Jx9wqlpxUGrQ3D
gUNHxXqCoSzYmck57NyAba7050LOHsKvRZIVqI+UHn5F0NeC2RHBPEghGXLOHoh+
3l610XLGhOdTZr9fpluzpCTpSJcb1ncMlXyorCYrd65vNeI06rzdwhY4+WZCc/xt
aRW08pkyQk3P0jdFF7OGqNL2OTnaF5pnSU2IYw0a8s/TkwZFnCW9Ya66QboBvalH
I+rYWcJgdHb7XA+eZt6q
=XvQl
-----END PGP SIGNATURE-----

--quagH4H09id5XL2e--

--===============9061317482161327570==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9061317482161327570==--
