From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add ak4554 driver
Date: Tue, 2 Jul 2013 10:42:02 +0100
Message-ID: <20130702094202.GZ27646@sirena.org.uk>
References: <87bo6mixuj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2082322371087581524=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id E8DF1265325
 for <alsa-devel@alsa-project.org>; Tue,  2 Jul 2013 11:42:06 +0200 (CEST)
In-Reply-To: <87bo6mixuj.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lgirdwood@gmail.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2082322371087581524==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sQwJCUUiTMMw/Obe"
Content-Disposition: inline


--sQwJCUUiTMMw/Obe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 30, 2013 at 11:43:51PM -0700, Kuninori Morimoto wrote:

> ak4554 is very simple DA/AD converter which has no setting register.
> But, playback format is SND_SOC_DAIFMT_RIGHT_J,
> and, capture  format is SND_SOC_DAIFMT_LEFT_J on same bit clock, LR clock.
> Because of that, snd_soc_dai_driver consists from
> "playback only" and "capture only" here,
> and it has software base symmetric_rates check.

If the device is hard coded to these formats just use a single DAI
without a set_dai_fmt() operation, either the machine can create two
links to the DAI or things can be set up without any extra clocks so
that both formats are met.  Otherwise this looks good apart from the
things Lars-Peter already noticed.

--sQwJCUUiTMMw/Obe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR0qBnAAoJELSic+t+oim9pa8P/185spCUd9TGGNLgt4PH5QxX
qDSbbWPbOQg0YmJ3mwzLlSvVdW7+zWbXB0o4oiN1wJ2RAqWXstSFYG0t2prblWxK
/1udUKqyyxN17xzXfIIt6SkPaOFhvtOtUSDI/zIszXbmUWBtNW7nWDc0fI2Dcd/k
BPvEI2n4YQccNYAyBqlNr+k0WSFP5KBD6lxlsfoLQxS3Y8VaSUibyLeHgVFsl78l
tALZLJgvvCWQjesFnuKmAS8qW/0olZHQ4G3YktPwegUQPXztTrga4nGhfnYi7UjQ
wm0OHyi9nuxpfd5KGj5lzMwpDmpKCbds1rg9BBQGV+ZI5yTlVkzgIpYRoiLurGcQ
Fn6V78Fnz1uPI5rE1685FXt9sQE4uoGwAMuAWeKpDvOPFoEJdNLbc32+exMF3Iu3
R9L+SyC/VhekHCle6olmiSusRxKIPujbVu7tItPRtvzCYJI1v57ciUGJZvTXCwtb
nQQXe8tB2AiiKvBdlzo6Ru/LhkKGBC6vyXYoeUbGUDpX+8zn73q326Mn34QtBwEy
cw7Ai+Egdd24XehRTzu7akaiV2Q5nvp9nrShPS0Tg/DjbnxErVK91Jw3euGIR2Ao
OGVp0Kz/54UY35jZ8IKDJ4OU7Si60upq6aDYixsoFj02TyqP5gVpamXDdrCJ66jL
VL8XYVREM7IZQC7ryJbg
=nNzM
-----END PGP SIGNATURE-----

--sQwJCUUiTMMw/Obe--

--===============2082322371087581524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2082322371087581524==--
