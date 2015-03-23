From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 01/10 v3] ASoC: core: add
 snd_soc_get_dai_drv() to get DAI driver
Date: Mon, 23 Mar 2015 12:01:51 -0700
Message-ID: <20150323190151.GP14954@sirena.org.uk>
References: <87mw39eide.wl%kuninori.morimoto.gx@renesas.com>
 <87lhiteic9.wl%kuninori.morimoto.gx@renesas.com>
 <20150322180827.GU6643@sirena.org.uk>
 <878ueo5gol.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1260386387762796269=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C8FD2606D5
 for <alsa-devel@alsa-project.org>; Mon, 23 Mar 2015 20:01:25 +0100 (CET)
In-Reply-To: <878ueo5gol.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, shiiba <naoya.shiiba.nx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Das Biju <biju.das@bp.renesas.com>
List-Id: alsa-devel@alsa-project.org


--===============1260386387762796269==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9pS2hy4/DrI8BQlq"
Content-Disposition: inline


--9pS2hy4/DrI8BQlq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 07:14:51AM +0000, Kuninori Morimoto wrote:
> > > Sometimes sound card driver want to get cpu/codec driver.
> > > This patch adds snd_soc_get_dai_drv() and enable it.

> > Why would a sound card driver need to get the DAI driver?  The changelog
> > should explain this.

> Because, sound card needs to set dai_link->dpcm_playback / dai_link->dpcm_capture
> on soc_new_pcm() if it was DPCM. but, it is depends on CPU/Codec driver.
> So, sound card driver need to get DAI driver, and consider it.
> I will add this explain in v4

Hrm, I see.  This doesn't feel quite elegant - can we do something like
factor this check out into the core here?  It feels like something the
card driver ought not to need to worry about.

--9pS2hy4/DrI8BQlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEGMfAAoJECTWi3JdVIfQDSYH/2kgf5JM8Hbhm1yU7Z5rFi14
fi5dkoHxb7a1Rr6bY1gJ0mM5p8xC+VgxxXUYYKTZk1pwWbWpkTbm3unWcJGptVgX
r9icUF955z60EnvXJyQZwic3ZXRt1vPUEPvxSrVjGPuC+rPvMlQtSxTEQ8uYRSGp
eorlZdt0uNpORB1/MZ2jjm3Vpm9nzTsDWNHpJ3noAo5O3VUN2dPLZfIOn7fGLzVu
sochEp+gKxKf/r/T5vShwC7Y/h/laHy51EpjlQ56/1kAicF+6joFoDOTyVg17Rac
NzfV4LZ5J/+rEi2MQJuXXywJ0uj/MZT4S+hmVB+LGhMITpIYWMR/h7bDxANU1ko=
=6iGm
-----END PGP SIGNATURE-----

--9pS2hy4/DrI8BQlq--

--===============1260386387762796269==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1260386387762796269==--
