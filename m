From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v8 2/3] ASoC: add es8328 codec driver
Date: Thu, 17 Jul 2014 21:46:28 +0100
Message-ID: <20140717204628.GK17528@sirena.org.uk>
References: <1405388494-21232-1-git-send-email-xobs@kosagi.com>
 <1405388494-21232-3-git-send-email-xobs@kosagi.com>
 <20140717195709.GI17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6086151142451430946=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 95E6026507D
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 22:47:10 +0200 (CEST)
In-Reply-To: <20140717195709.GI17528@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sean Cross <xobs@kosagi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, devicetree@vger.kernel.org, Takashi Iwai <tiwai@suse.de>, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, bunnie@kosagi.com, Philipp Zabel <p.zabel@pengutronix.de>, Grant Likely <grant.likely@linaro.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============6086151142451430946==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BRF4e1IEQp0HoEFj"
Content-Disposition: inline


--BRF4e1IEQp0HoEFj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2014 at 08:57:09PM +0100, Mark Brown wrote:
> On Tue, Jul 15, 2014 at 09:41:33AM +0800, Sean Cross wrote:
>=20
> > Add a codec driver for the Everest ES8328.  It supports two separate au=
dio
> > outputs and two separate audio inputs.
>=20
> This looks mostly fine so I've applied it, there are some issues below -
> please send followups fixing them.

=2E..except it doesn't actually build since you use the variable ret in
the probe function without declaring it.  Reverted, please fix this
along with the other more minor issues and resubmit.

--BRF4e1IEQp0HoEFj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTyDYgAAoJELSic+t+oim9QGoP/jFybnXBLqvSWjrjdFHUfPIY
C5W6WQKtLG3KL10lhlQxr/KBJL3LJfBZAdxTg0r8RBRFEEJTFisfa3Z58lDsUkSN
Bgr2qRy4uTrfEJJs1pTpait8fhzQAoZFLQkU7NVIDBtidY4+WDizEzXU4g931/Nr
xPwdlMWWMqsDsmahoxovB/A8lSTjSg4CWemk/e8NyphZlbKCWyq1KJi7SXQwx2Ix
hHTSnfRKjMfOw5qQHSSQY6lLJ02LSR23/2p4gmvz4y4OR4ipBYemvK54YxicCj+0
DJoV80CQU7HZFvB0/H9EULVQLhJbvyhLAvrv8Q1kmlj9qWgnlVR8nkN7V0fXiIT5
EpVqBaackV9zkX0dOIT6eoZERTVkt0n3Jjeu5TcIrDEMgaSyNjxRIuAtGaPekhwX
oVmbJey8jSLeicKgiW/urXLN6hPTofD9QqNYnssAHsbe4dbDJ7esaAsikwjhJRoH
1dcmuZsD/n5fZnpdj1Vs0B4jx0PDP167mN2sebRKVihzFNJx5vq0mleJFIaaT41R
6OsjgMHdecNNsSj6YR66zsyEJm5aRleKB55tuP+/6jsUDP+5mBFUvls7ZB/6i4T6
NZVAZ76SAhhnJiVHslpvtaWcxLBSPzlVS92o1QaBbwXVW40WZ57qzlykKLQUfwFA
zlm52up6Lkcube0mSYiP
=xgl/
-----END PGP SIGNATURE-----

--BRF4e1IEQp0HoEFj--

--===============6086151142451430946==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6086151142451430946==--
