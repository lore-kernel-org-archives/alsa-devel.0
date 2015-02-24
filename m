From: Mark Brown <broonie@kernel.org>
Subject: Re: Adjust the the codec and dai_link close sequence
Date: Wed, 25 Feb 2015 00:03:08 +0900
Message-ID: <20150224150308.GR6236@finisterre.sirena.org.uk>
References: <A63A0DC671D719488CD1A6CD8BDC16CF5ABD84382B@SC-VEXCH4.marvell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7202843230916475339=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 475FB2604BB
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 16:04:13 +0100 (CET)
In-Reply-To: <A63A0DC671D719488CD1A6CD8BDC16CF5ABD84382B@SC-VEXCH4.marvell.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Zhao Ye <zhaoy@marvell.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Qiao Zhou <zhouqiao@marvell.com>, Liam Girdwood <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7202843230916475339==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4TSNxiJ5t2iBNdYs"
Content-Disposition: inline


--4TSNxiJ5t2iBNdYs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2015 at 06:22:00PM -0800, Zhao Ye wrote:

Please fix your mailer to word wrap within paragraphs at something
confortably less than 80 columns, it makes your messages much easier to
read.

> We meet a issue, when we close the audio path, we found the dai link
> will closed after the codec. And the codec dai register will write
> fail.  This is because our audio codec is a I2C device, and the codec
> dai=E2=80=99s dai_link register is in the I2C device. If we close the cod=
ec
> chip fisrt, The whole I2C chip=E2=80=99s power will be off, then we write=
 the
> dai_link=E2=80=99s register will be fail.

I'm a little unclear on the exact scenario here but this sounds like the
CODEC driver is probably buggy - it should either be putting the device
regmap into cache only mode when powered off (if there is no need for
the writes to take immediate effect) or not powering off until after
whatever cleanup is being done in the DAI is done.  Without knowing more
about what the CODEC is trying to do at each stage it's hard to say
exactly but it doesn't sound like an ordering issue.

> So I think we should adjust the
> rtd->dai_link->ops->shutdown(substream); before to
> codec_dai->driver->ops->shutdown(substream, codec_dai); in the
> soc_pcm_close() function.

Doing that then means that we run into trouble on systems where the
CODEC somehow depends on clocks from the DAI (which does happen)...
really there's no perfect ordering here and attempting to shuffle this
stuff around is likely to create bugs in other places as their
dependencies on the current ordering get exposed.  If there is some core
work needed it would be better to do something that explicitly shows the
dependencies so we don't get this sort of fragility.

--4TSNxiJ5t2iBNdYs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU7JKrAAoJECTWi3JdVIfQlIIH/1uHSK5Uln12ezieQwixknaU
JtV0L0ozTxNmoP1D5EKyJ2jC0Y1E/D5ZOs3pxPG+ToxXZIjmewJIKM3zo93duuP9
TCOifvpISMMMpuPNbdMX2kUYNKk+A98pzizQpj2+PuvwHckeotMfhrZp1g+kqGEc
ujPHvWcoODZkJvhYc3SQ+erzMBNSIVRaro14TM7z1E7Q18CcnjUXp7Ci4lu3FtxI
th49FIoGig5uow4xTVVRwOMQzazluX7IsLoY5qm1/eYkoWarep8ut5oYaWfC0Jsl
uFuTp+Xg+2paYKWGsmF8CaBdncltdUL7r8rqSzIMKotQxtpfCX0/3atq7H36f2A=
=Ao+6
-----END PGP SIGNATURE-----

--4TSNxiJ5t2iBNdYs--

--===============7202843230916475339==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7202843230916475339==--
