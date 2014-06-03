From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] ASoC updates for v3.16
Date: Tue, 3 Jun 2014 11:29:06 +0100
Message-ID: <20140603102906.GW31751@sirena.org.uk>
References: <20140603094645.GR31751@sirena.org.uk>
 <s5hoaya5nbx.wl%tiwai@suse.de> <s5hfvjm5mbb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0880724248912952113=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 11790260851
 for <alsa-devel@alsa-project.org>; Tue,  3 Jun 2014 12:51:15 +0200 (CEST)
In-Reply-To: <s5hfvjm5mbb.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0880724248912952113==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="qndya+I13rh6QJ0p"
Content-Disposition: inline


--qndya+I13rh6QJ0p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 03, 2014 at 12:17:44PM +0200, Takashi Iwai wrote:

> Now I get a few build warnings that look really buggy:

> sound/soc/omap/omap-twl4030.c:274:2: warning: initialization from incompatible p
> ointer type [enabled by default]
> sound/soc/omap/omap-twl4030.c:274:2: warning: (near initialization for 'omap_twl
> 4030_card.remove') [enabled by default]

> sound/soc/omap/rx51.c:379:2: warning: initialization from incompatible pointer t
> ype [enabled by default]
> sound/soc/omap/rx51.c:379:2: warning: (near initialization for 'rx51_sound_card.remove') [enabled by default]

> They come from Stephen's patch, commit e1d4d3c8
>     ASoC: free jack GPIOs before the sound card is freed

> The argument for remove callback should be struct snd_soc_card *.

> Mark, aren't any fixes queued in your tree yet?

No, not yet - I didn't have those drivers enabled in my config when I
tested.

--qndya+I13rh6QJ0p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTjaNvAAoJELSic+t+oim9zCwQAJYxkrhSauMGEsqii7WXE4m+
EuZhb60L5a+8ESjVIB9nPCOl7wTg/SO4CYuDeAJfz+tY+th50GTkGEuH895V257Z
q+a618WKw/y8p760hBAq4NadqMkMaXKAVwE/kCvai5PE1vMDfApqfJiiYN7Ldulz
TVTsBaZ9G++YYsKio4rBWYfhiMvGv3jBn2vgTbyKo/Djq3fFmw2iW3c2/KZllxBf
3z1KfdFuDU9YQPjmF5lUNXH+ebZLoqxynITYa85juzOdn0giB1zYnTzupf0bpoI3
mqwBpJSB6LlUV/O+K7vGUPSZVdbOM7ds75RdfsVPO3RG+Zqo9iWM2MS1nlEHpvIF
vb8QQI3T5V26N5YX4BhCtD9Y0q3ecYaWluAUf7z9O4J7TDPDaLEKoKSY9YOq22Jt
2W7cZMCPJ/EJ7xX4txvXMRzwfJBVA5eq/UjB89SK0VfnBCNvOzPKFxPtjajU1ArJ
IDu9zLwAvaCCAgi7V1w4BC7UHW5u87NeK/leNdunFmR/QAe3cjn3igY0f3lyk53n
NCHhRK4hCh5XWtnIqZ577lXbNL3S4lIlXBBz2xvLAwXHUEMeD1Na4wQO6l7Y1525
/y7RWCoKUhRMWelPWoRx+aBqVHxspa3D0nn+PwClit/FIsy+kM12e5XRWGjAZJdx
4f0RfQxF9aJk02V5oqF8
=qLBO
-----END PGP SIGNATURE-----

--qndya+I13rh6QJ0p--

--===============0880724248912952113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0880724248912952113==--
