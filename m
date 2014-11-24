From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 09/32] ASoC: wm8737: Cleanup manual bias
	level transitions
Date: Mon, 24 Nov 2014 18:22:49 +0000
Message-ID: <20141124182249.GC7712@sirena.org.uk>
References: <1416746269-4935-1-git-send-email-lars@metafoo.de>
 <1416746269-4935-9-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2148984830754884520=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B15726067E
 for <alsa-devel@alsa-project.org>; Mon, 24 Nov 2014 19:24:54 +0100 (CET)
In-Reply-To: <1416746269-4935-9-git-send-email-lars@metafoo.de>
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
Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============2148984830754884520==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0PQOkvCAw33/u/bm"
Content-Disposition: inline


--0PQOkvCAw33/u/bm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Nov 23, 2014 at 01:37:25PM +0100, Lars-Peter Clausen wrote:
> Set the CODEC driver's suspend_bias_off flag rather than manually going to
> SND_SOC_BIAS_OFF in suspend and SND_SOC_BIAS_STANDBY in resume. This makes
> the code a bit shorter and cleaner.

Applied, thanks.

--0PQOkvCAw33/u/bm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUc3d4AAoJECTWi3JdVIfQptUH+waBVrns2b7NB72iQEqgynWU
Cn1YPlO3Q+dLbYa2KTV6OPa4PCTgCByH+12cSu6aDiB84xb4fwatl3BtGEn3q8/8
I0+e6pzp3JtDi0gKE5Upv3IJGn3Q5qRo9WLIXQBU/4sPQY2S86RTe2CGfNK1kqUc
66kS8fuQtF5s33kIwa3ogFHJBael3MA5FXEPAkuEvXw3miFbIQDRFqo63jcgjLFV
bI4pGKtoOgJ+pRoZOoc4ziFgqp0ohB1v8YHwgRh+TDWFzcpOmkPyo5GHxaDo/xd2
NL6nY79r0VJzK1J88ZDZC6J6ACIrxCUcRC8mB2qk+44hVQVttv47+4QIf0otRtk=
=VU2S
-----END PGP SIGNATURE-----

--0PQOkvCAw33/u/bm--

--===============2148984830754884520==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2148984830754884520==--
