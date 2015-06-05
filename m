From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH] ASoC: wm8741: Allow master clock
 switching
Date: Fri, 5 Jun 2015 17:56:45 +0100
Message-ID: <20150605165645.GX14071@sirena.org.uk>
References: <1433505944-3961-1-git-send-email-ce3a@gmx.de>
 <20150605152219.GA32730@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0938547642556508514=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FDC126689A
 for <alsa-devel@alsa-project.org>; Fri,  5 Jun 2015 18:57:00 +0200 (CEST)
In-Reply-To: <20150605152219.GA32730@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Sergej Sawazki <ce3a@gmx.de>, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org


--===============0938547642556508514==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Wqp2XNkat9H91DRI"
Content-Disposition: inline


--Wqp2XNkat9H91DRI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 05, 2015 at 04:22:19PM +0100, Charles Keepax wrote:
> On Fri, Jun 05, 2015 at 02:05:44PM +0200, Sergej Sawazki wrote:
> > The set of supported sample rates depends on the master clock supplied
> > to the codec. Allow the machine driver to set the required master clock

Please delete undeleted context when replying.

> I think rather than removing the constraints entirely here,
> perhaps just don't set any constraints if there is no SYSCLK yet.
> That way we get the benefits of the constraints for single clock
> systems (such as user-space being able to arrange appropriate
> software resampling) but those like yours can configure the clock
> later.

Yes, that's the ideal thing.  The machine driver should reset the clock
back to zero when things go idle.

--Wqp2XNkat9H91DRI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVcdTNAAoJECTWi3JdVIfQWAMH/iuUey616NbTaAp4AE8kisp6
JaT575A2wSAeVXY+24mUqdDIuckkdFMdyXj0LiDVsx8bCpEgtXLG6vEnfSzpv72f
5PqFBTdkCF7SGavm2jpWB6TtVF23CUTB7kJAr6c6T40L7vPa3uZkA9rzTWY01fAM
UGEvctoi1J4EyrG09NWM3Xp3ciDY0rGx1fo4z9CnB/v0pt6h4xOehVPDc32Y4DIA
9rp1tGtP6PuLHJPEZd83ypPFKqBiaNgEbunxhgTpAWjXfR8dBqfYXHaPTQlgJ3op
wPTgybiJ8yRZR4TQEAkjd3DaL1gEzeRZl5YvauC3dan1vZN1hNbPPgEyboFyJ1A=
=Hd2P
-----END PGP SIGNATURE-----

--Wqp2XNkat9H91DRI--

--===============0938547642556508514==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0938547642556508514==--
