From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/5 v3] ASoC: add generic
	simple-card	support
Date: Mon, 16 Apr 2012 11:05:10 +0100
Message-ID: <20120416100509.GF3238@opensource.wolfsonmicro.com>
References: <87y5qchyqj.wl%kuninori.morimoto.gx@renesas.com>
	<20120406175848.GN19424@opensource.wolfsonmicro.com>
	<87sjgd7ozb.wl%kuninori.morimoto.gx@renesas.com>
	<87pqbh7dbt.wl%kuninori.morimoto.gx@renesas.com>
	<87obr17d3o.wl%kuninori.morimoto.gx@renesas.com>
	<20120413103529.GQ3168@opensource.wolfsonmicro.com>
	<87r4vo5exv.wl%kuninori.morimoto.gx@renesas.com>
	<20120416082239.GB3238@opensource.wolfsonmicro.com>
	<87obqs5baf.wl%kuninori.morimoto.gx@renesas.com>
	<s5hvcl0ror0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3279764670377508483=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 366522413A
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Apr 2012 12:05:14 +0200 (CEST)
In-Reply-To: <s5hvcl0ror0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============3279764670377508483==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SxgehGEc6vB0cZwN"
Content-Disposition: inline


--SxgehGEc6vB0cZwN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2012 at 11:48:35AM +0200, Takashi Iwai wrote:

> It's the call in sound/last.c.  Only devices that have been preoprly
> regstered at this point of __init calls are shown.  So, it's often
> misleading.

I keep wondering if we should just remove it due to confusion like this.

--SxgehGEc6vB0cZwN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPi+vpAAoJEBus8iNuMP3dknMP/2lCIs7lMJqd266diwWUizZ5
RGX5XixyvFyavka6SIUxX35/esjCFJhYzI+CqyCZGmKsX/OrpegHvauNooh80cBo
5rmZryYd/8Ywttu45le4GNMZE69pZAZMfxgdRoA2R7bl7splyCt08NhAAqxGixK3
Vyh/beqyTROvpz2iiv5S+nIvt49H+0M/cDXl5Ez6zAT1OFhyQgM7q1Pe12eWo/45
14DVWmFhancx3KBShp/6ABPKfYGpOw2+dBhHh9UyDfLNaiRZrxwrNu0JqvDBD2hJ
fo8/X3NXPn90oB84eeugUIK6q8K/oo9fc+Mc8ko5ePFtWqq8cooyXIGLWSDNJmAJ
hJ0VF9B1GcS3CXdPdcYdzSmfhJma88AFC6H0nWLScDTSJVR0LCKDlA/drQLFAPEW
syhyGx0z6goltOoA/SHLx4zuuNYAkoWA8ZyUStOznerkiS3LxE9xAiVANNBt33QJ
3IwTIOoAff01KtqMIUUcRxe4d0KcHp54vVmMdSXR9INoJKkOt8QW4JL4bwSbbM7+
bG5bkX7Cz7Z0Pcfs+33DOTKMoeBQvM5Y3GXylcTQufaXYI6oRH4PvG8QyjOylbVq
nKdegsnydMv6qSJO4RvqREVvJA2qJ7Ln/glx5Bm/+8U7zh/OI7ougeVu/9ExXY3s
2AqE6yCvqP3x3zfGoR+O
=pbfD
-----END PGP SIGNATURE-----

--SxgehGEc6vB0cZwN--

--===============3279764670377508483==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3279764670377508483==--
