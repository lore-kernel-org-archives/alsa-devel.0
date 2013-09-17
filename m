From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/4] ASoC: rsnd: gen: rsnd_gen_ops cares
 .probe and .remove
Date: Tue, 17 Sep 2013 13:58:26 +0100
Message-ID: <20130917125826.GA14323@sirena.org.uk>
References: <87sixrre8r.wl%kuninori.morimoto.gx@renesas.com>
 <87mwnvsy7a.wl%kuninori.morimoto.gx@renesas.com>
 <87ioyjsxvj.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6429194568692323607=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 16A4A265141
 for <alsa-devel@alsa-project.org>; Tue, 17 Sep 2013 14:58:30 +0200 (CEST)
In-Reply-To: <87ioyjsxvj.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Simon <horms@verge.net.au>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6429194568692323607==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Sep 01, 2013 at 08:31:16PM -0700, Kuninori Morimoto wrote:
> Current rsnd_gen_ops didn't care about .probe and .remove
> functions, but it was not good sense.
> This patch tidyup it

Applied, thanks.

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.21 (GNU/Linux)

iQIcBAEBAgAGBQJSOFHvAAoJELSic+t+oim927oP+wYaBN5BCsDvCPGC0ZweDcW/
YVCSjxo4N/LgM2JGfyFa620WkMzQ+O12DuQo5xB3OmA4wTk3jVpdbYFcM1OdFqrI
7r8Mts+y3t9/v7GpNnJSINflSp6Wt/ny5PgJouNWJFR4xzFMx5TU2cCL2u/7dLj5
BobDkJJTAct8Ztd7GRaAq5pBy54fteIkW+mt6U44eutSveL6XPPz5fV34elbcyOE
52OiBjWCsEeYzb9R66sc6vE0XlP4A5sbtEzL4z5qqQgb7nOiGrKWXdYIYWjHOaxO
s8R+nzr8+pepLiveSLqi9AoZ1Za/fkRGwmWh3Dn9+SVlAtXOVCefKanCFmylPTxi
hdFn1alucNRT83dGKMh4ynpft+K1oCsnGDZNS29fg6n66fNh3jSWOD/HmLI3Y3Ig
Fxxx5rkTXrnNWMEW3xvMTsiThC/DCn0/ohq39p3Y4lB0/hLmF2CBVc1Q+6lMnXy/
HEZtC2+ysjl5M/fUVrASUonJ2QrXgjk2tZGrUl116Q/+sDrSjNlvcKFFJrFrIVkQ
VTeaV1xQAhgV2wWPOYOU56TgBYzaPi9mOMajFt9aKYzboKOOOwf9KPEgx7ghivQF
vU8Vby/jRngekEj851uTKNlWPvc8Vsup7GeHbBu8oL0YJAnNTVMcYz3dHJ/2EQoO
VsIxUbnALJopVFFPi6Gf
=0Ca9
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

--===============6429194568692323607==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6429194568692323607==--
