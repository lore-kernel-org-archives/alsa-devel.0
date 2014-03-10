From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: omap-abe-twl6040: No need to
 register DMIC routes seperatly
Date: Mon, 10 Mar 2014 09:12:50 +0000
Message-ID: <20140310091250.GD28112@sirena.org.uk>
References: <1394302616-15991-1-git-send-email-lars@metafoo.de>
 <531D7427.5020006@ti.com> <531D756A.6000505@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7193796623557130534=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA51F2650BE
 for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2014 10:13:06 +0100 (CET)
In-Reply-To: <531D756A.6000505@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7193796623557130534==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UpdKy7mRHviOTiWe"
Content-Disposition: inline


--UpdKy7mRHviOTiWe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 10, 2014 at 09:18:50AM +0100, Lars-Peter Clausen wrote:

> Hm, ok, missed that part. Makes sense. I'll respin the patch to just
> use the card's DAPM context when registering the DMIC DAPM routes.

In general anything keying this stuff off DT is going to have that sort
of thing going on - most if not all of the things that are registering
in several chunks are doing so because some of it is conditional.

--UpdKy7mRHviOTiWe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHYIPAAoJELSic+t+oim9xOQP+wVW/457/CzTgu8pvFpA2zE0
fZNYPtQcLKfOU15Z5deUH2mejmbVDwEgjr+c2UBsVIFpbC5Y9I7fGvUkgj6LrFTz
MGQy0Z7p4Iv+fjpGfEp7cUaTR7Exkem793yhg+/6I180/324siFhs1vpqiXNSPL2
rcpMo/PkkMACqpjOAVon7MC5zjAEYiit4v5CEjHk4a6VNm8MNmRfq64bJ3blP+4/
WMnij53pAwiTEpRQlpJcv4WkXWHPpBfIOt0yhX8Qrn8q4Lo1mE+g4KJlHXzM3gv9
iZg1BJBTJI6NGSVeU/ay1SlkukmzlBAfu+eH8SvNbJABBUtXJ6pDE2FcZFSyrOdd
vLpu7h4IqhQBNeqyWnKfMjOKI87241PBKVKwZmyJ/GdG5i/j7gqAmd++skk1bg1f
phrEDLg0A1c2FrwfhWpW8u48jLa9t506jvs+e27P8aXGlxrEe5J1vjMyAWQed8G4
eFKt5NhN6XjGhrMRhwiW1GG2vgZgYsp7XfxUmhuS6vO1IoVWOhBEXdTFwIjPr/7E
LY4VrtFm61YQsQaUU28+FkqYuHekbn8dsrx/B5OUgAj4IS1SJKr8T74gDQ+qiI2e
wqLaJBNio8xICvO5LXrrtrjnNrsDWFPM+RXnuQYER9FZ3yj458M9kMweYnH1a7gB
9wcDUxDAz6vW+Pl6IcD7
=SoIT
-----END PGP SIGNATURE-----

--UpdKy7mRHviOTiWe--

--===============7193796623557130534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7193796623557130534==--
