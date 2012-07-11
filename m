From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Free memory in the error paths of
 soc_of_parse_audio_routing()
Date: Wed, 11 Jul 2012 18:43:37 +0100
Message-ID: <20120711174337.GO3938@opensource.wolfsonmicro.com>
References: <20120711153634.GJ1258@darwin>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7117978912250050832=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1124D245C0
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2012 19:43:39 +0200 (CEST)
In-Reply-To: <20120711153634.GJ1258@darwin>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Matthias Kaehlcke <matthias@kaehlcke.net>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7117978912250050832==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXygN3QAmJYWdGtb"
Content-Disposition: inline


--xXygN3QAmJYWdGtb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 11, 2012 at 05:36:34PM +0200, Matthias Kaehlcke wrote:
> Release the memory of the routing table before leaving the function upon errors
> in the device tree

Applied, thanks.

--xXygN3QAmJYWdGtb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP/bs8AAoJEBus8iNuMP3dxqkP/i2lFiQMJAXViAlSM9S13VF1
0Ii1hyORnWs7hVsJC9HNOS/rjEPKL2tJsDsCtu318jTiCrBtVgVEvPhuZ2UHADYR
B+07hIOPK504J6a1Nb8u97BN1qGzXAMtWI7Cdx/+OcEItuU3qYl+/yzFRRUZQCk3
7qBc4T5fd91VwEGhJljCzyQ+kmWunUMuxr6wCQe8+PFW5CCfa79047GV1UCfRay3
RiQasNghcaqlpOKh9RGu04MV8qKDl/i2E1zRnxr99983TA/xV+Dse+6ld1BZOJ1I
GIqr4hrtn9tjmdX1BOVudtZU5+RrUTNygbGlIelRtQADgtx0uyZbIPjPIwbr1JWF
ogfFA9RQ4oXUsEYkt94jQzEAJbmqYHfmj32EdBWTuL/5MjQKyNPHOh5VGZgnWUDd
jMYcYS6DLH/e/Qv7j11wMh1G1PjUqtXTfCYyqKxPsBA59DuOzUELo/K6jZvAGdcK
W48/6MZloM64f/HXztOrG1mLnfVmjn//oegfXE3CQYVhSrRSmN60nlmPEQ/rAj8r
Tc8BEID+8PpqdSN4bekffnpcdofVBmGFEgKd5IfopWT9t9uH7hXk5bSNx3Y40Ksg
GcYHRZwzEvZr3IuiWu8pwlEuGKDCRP/SI66jWIc+xA7WbHe4vmWCRzmeMPT3eMKb
KK+duF8T6jE1AilkbpGb
=0B/d
-----END PGP SIGNATURE-----

--xXygN3QAmJYWdGtb--

--===============7117978912250050832==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7117978912250050832==--
