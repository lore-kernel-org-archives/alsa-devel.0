From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: wm8804: Fix small issues in
	probe error path
Date: Mon, 2 Mar 2015 18:03:51 +0000
Message-ID: <20150302180351.GA21293@sirena.org.uk>
References: <1425319075-10400-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7568895080110974777=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C4B42605D7
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 19:04:01 +0100 (CET)
In-Reply-To: <1425319075-10400-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, info@crazy-audio.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7568895080110974777==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TJSosNbLKuAD/VC1"
Content-Disposition: inline


--TJSosNbLKuAD/VC1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 02, 2015 at 05:57:54PM +0000, Charles Keepax wrote:

> The regulator notifiers were not being cleared up on the error path in
> wm8804_probe and the nothing was being cleared up if
> snd_soc_register_codec failed. This patch fixes these issues.

Why not fix this at source by adding a devm_ notifier registration?

--TJSosNbLKuAD/VC1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU9KYGAAoJECTWi3JdVIfQByoH/2vT6up21XIScMSK2AIs92W1
GETvM+/FgxosF/m28J40bnCWg8xLK1zD+j/7Z3pmwZR3lC3iplhIZOX+kSPL+n9b
LeOYuTuxPLnZsJ8HGeoX5DpQBBkWLqBL20GbToqp9THZOGtzN7wjUA86/f0QhiPV
gSnzAIeLAHMtCoouZSAFBmnNJaQimQlCDmhIwRkuYMJueV2uj/vIE5BMhgmtCLXY
a9D5KUSyhoBoa2mO1ulZmY2NP5mt9XRalo/tCM+hLG9rjjRA79VWwARVvm5mF7IO
tymaRfeFA03/a7WqrUdGixZnJTXtQAs9BwCDvpnZrwFgTykN99tgT6HaL/f5+io=
=cREO
-----END PGP SIGNATURE-----

--TJSosNbLKuAD/VC1--

--===============7568895080110974777==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7568895080110974777==--
