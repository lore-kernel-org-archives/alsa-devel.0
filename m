From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Tue, 31 May 2016 17:53:58 +0100
Message-ID: <20160531165358.GH29837@sirena.org.uk>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
 <20160517234333.GB29471@Asurada-Nvidia>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1686586332965054659=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8CFE9265900
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 18:54:03 +0200 (CEST)
In-Reply-To: <20160517234333.GB29471@Asurada-Nvidia>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, paul.handrigan@cirrus.com, tim.howe@cirrus.com
List-Id: alsa-devel@alsa-project.org


--===============1686586332965054659==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="14PCYtZiSn5RZRtk"
Content-Disposition: inline


--14PCYtZiSn5RZRtk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 17, 2016 at 04:43:33PM -0700, Nicolin Chen wrote:

> In this case, would it be more appropriate to create one single DAI
> with channels_max = 4 over here?

Yes.

> Another question is for its TDM support. This chip outputs 4-channel
> data on two data output pins (SDOUT1 and SDOUT2) as normal mode; it
> outputs 4-channel data on one data output pin (SDOUT1) as TDM mode.
> However, the mode selection for a 4-channel recording should depend
> on the hardware design: whether the SDOUT2 is connected or not. So
> I am wondering if there is a common way or existing way to indicate
> this hardware design. Or just by simply defining a new DT property?

That's a really rare thing to have as an option, most things either do
TDM or parallel data signals but not both.

--14PCYtZiSn5RZRtk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXTcGkAAoJECTWi3JdVIfQ1v4H/iDKaR9z4UVoYPpdF038C7gg
ILcSao2SIsfznGkeNsg5AsZjd8XfrhRo9VGI1S7+uV7fJB9ffuw2o3GxtjSGRyqL
JV7HkEBYXKZ8QeuCKGYB9ClLRIXkRYYWpoKxC3VK4OjaHm2utP9BFa3sbHLdaHG3
FOM2axC46fBR6orKxUA0MY2wV31no1npSn1T2hoOBHYoFdspVD2p0G8fx1Lelaaa
JMTd2WJVxE79a+gOuUSFjWuFB/Kt/lfTkR4r/b979/816tb5oeQHg5ujrzLBAZON
AHJVrJZupW72dRYOVJqi+1zKbEda+EYLGYPKlRA1OPd//ncPD9dTFZvX1FJKzUc=
=I0vA
-----END PGP SIGNATURE-----

--14PCYtZiSn5RZRtk--

--===============1686586332965054659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1686586332965054659==--
