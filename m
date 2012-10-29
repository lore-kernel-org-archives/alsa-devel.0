From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: fsi: fsi_set_master_clk() was called
 from fsi_hw_xxx() only
Date: Mon, 29 Oct 2012 18:47:19 +0000
Message-ID: <20121029184718.GL4511@opensource.wolfsonmicro.com>
References: <87txtd4tld.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5932315639356174414=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 87196265D28
 for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2012 19:47:20 +0100 (CET)
In-Reply-To: <87txtd4tld.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Simon <horms@verge.net.au>, Liam Girdwood <lrg@ti.com>, Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============5932315639356174414==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PpocKf6TCvdC9BKE"
Content-Disposition: inline


--PpocKf6TCvdC9BKE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 29, 2012 at 12:37:22AM -0700, Kuninori Morimoto wrote:
> Current FSI driver is using fsi_set_master_clk() if it needs system clock.
> But this function was called from
> fsi_hw_shutdown()/fsi_dai_trigger()/fsi_resume() without a sense of unity.
> Because of this, sound playback after suspend failed sometimes.
> To keep consistency, fsi_master_clk() was called from
> fsi_hw_start/stop() only now.

Applied, thanks.

--PpocKf6TCvdC9BKE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQjs8tAAoJELSic+t+oim9YQsP/irkLtxuVc4JRNnLR/geM+Ig
Iz/7QLg+qPnKqwOjSXi71QJakOjNqCKnX3AllrcR6n6KufU36JtB2ngTOvRVAZ8r
AFqWZuqiVtBsrAeuB/GARUTGYYLJuQEp+WBHGEBEqdEkk+YVFNa6tHnDtVbbq9Wp
NdnnNbeurpgaBpeup0p3NBoNlGJ+9KiLpO6LSdYq0IFGOIN9PKcUQrLEqhOGw9h9
eNYjBC0sYqjCh5rsYMeXxwYqoFWzsL5i49B+VmoAUqLokTsWwFRj4fu4Ucqe1foR
efapZMDU0fhKuey3t2uQC1V+HZHFCQJTGVAIiUexWGKC4w3r3FsG+MnjtZXilmQi
UEiK5LOoTTov9gghAe2zxL3KMbAWig8N2zkeeqIPyZ6xbN6nZWAqGD7vekxG79TI
m76iaPfa9xEW68V0wE7xwY4+TjtYKnmmb54G5qpoxY6LEcaseBtmT4YmfioPbDt8
Aq8HdJ37yKvLk/sBXNn4b1ev6kfNOkSK2WXhjTF3AooOMFxLfuOYjBfMuoThi2kv
PsxPKkhaLeuY1RTf59fg9BofHcLCPyFktC3lXqnRkqROYUXsb5kBBw4pKrOxAyvr
Y0mZD4WLY7r72KLtqzIIhTflWlhIJdM54IDGUD10a75vI16Xb4oofpsIO7GAA+YV
fWUVxVxyASuzqjXOo3bm
=JuMd
-----END PGP SIGNATURE-----

--PpocKf6TCvdC9BKE--

--===============5932315639356174414==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5932315639356174414==--
