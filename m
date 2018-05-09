From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 08/13] ASoC: Add SoundWire stream
	programming interface
Date: Wed, 9 May 2018 17:55:34 +0900
Message-ID: <20180509085534.GX13402@sirena.org.uk>
References: <1524748809-21860-1-git-send-email-vkoul@kernel.org>
 <1524748809-21860-9-git-send-email-vkoul@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8179953383448413011=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 75CB22677A3
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:29:18 +0200 (CEST)
In-Reply-To: <1524748809-21860-9-git-send-email-vkoul@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vkoul@kernel.org>
Cc: ALSA <alsa-devel@alsa-project.org>, tiwai@suse.de, Greg KH <gregkh@linuxfoundation.org>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, patches.audio@intel.com, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============8179953383448413011==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="reSNjdE3Iylkp4B8"
Content-Disposition: inline


--reSNjdE3Iylkp4B8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 26, 2018 at 06:50:04PM +0530, Vinod Koul wrote:
> From: Shreyas NC <shreyas.nc@intel.com>
>=20
> SoundWire stream needs to be propagated to all the DAIs(cpu, codec).
> So, add a snd_soc_dai_set_sdw_stream() API for the same.

Acked-by: Mark Brown <broonie@kernel.org>

--reSNjdE3Iylkp4B8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlryt4YACgkQJNaLcl1U
h9Dxqgf8Dt1rZ5wRzorOiGCqwScjTghcWtoGODYVpMO0JzOSj/7AYZ3o4ONrG46h
BkWUAj97qm2YUrJdZU2bdKJPwBQg/hb7i6I/nWIVreWsHzqiN4DZ5p3jtjo1ZFFY
ltq4vQ9fKAoqfdbG7mLGzrTb+DY5shW5vdidiOOnRAR+h2+0XLHBtX810fA7PVxo
W5a90Acvwhe0xCa8bPqRdvszBpKBeQENYJ8qrI9aR/ZB4VTb/JURjURanAcLw3PO
T1XkUeZNe6nKMQuycEu0dkypuPfMlH7pF+1cRyuF0IIBMoukh8+jJemPsoi1gumB
6ESOehQMsppuPh/VI6cqVuuRjX7OoQ==
=331f
-----END PGP SIGNATURE-----

--reSNjdE3Iylkp4B8--

--===============8179953383448413011==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8179953383448413011==--
