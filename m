From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: ics43432: Add codec driver for
 InvenSense ICS-43432
Date: Wed, 19 Aug 2015 10:57:34 -0700
Message-ID: <20150819175734.GY10748@sirena.org.uk>
References: <alpine.DEB.2.02.1508190931170.27635@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0429042376229054190=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1A5CE26512F
 for <alsa-devel@alsa-project.org>; Wed, 19 Aug 2015 19:57:47 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.02.1508190931170.27635@lnxricardw1.se.axis.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ricard Wanderlof <ricard.wanderlof@axis.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0429042376229054190==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IVYlynmSqqZxW4fI"
Content-Disposition: inline


--IVYlynmSqqZxW4fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2015 at 09:37:46AM +0200, Ricard Wanderlof wrote:

> V2: Update after comments from Lars-Peter: set rate to CONTINUOUS and let=
=20
> ALSA figure out the details, also removing hw_params as it is then not=20
> needed. I've left the checks in dai_set_fmt, as (IIUC) there currently=20
> doesn't seem to be a way for the ALSA framework to handle format=20
> constraints using the codec configuration struct.

Please remove set_fmt(), it's not doing anything - like I say, if you
want to enforce this provide a way of recording the valid configurations
as data.

--IVYlynmSqqZxW4fI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1MONAAoJECTWi3JdVIfQLFAH/RZgN+TpMvHGyq60tc81EyRN
w2YaDd2czSlIh6On0qVPMh1cPzK9wEHQ7sMo9yow1N38xIGNvLVfiuQu+f/02E9v
dWj0mgQ3SurdonB8W4cRtfWn1Kz0kPb6CLZS9C3tkpbTDDjRfz0vSD9iADrprvBj
G1xkxvkiz/e8GAx18dj7AXykynmcTlotfKLOtZd/gmrSvhpBShaNv/BloqocHoTo
PErBPBlqaMSZXVer/GVS7AvgqZxxhKGwAs3J290twKjJik+ts1GIDx8cAJxFfWPC
xiHYwp5qKEgk3/mV5Rocy/raY+GJCS+hX6qdfRBGkxmxfq4j1Mv23d0iDWOwXlg=
=pELW
-----END PGP SIGNATURE-----

--IVYlynmSqqZxW4fI--

--===============0429042376229054190==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0429042376229054190==--
