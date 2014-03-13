From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 11/12] ASoC: pxa: tosa: Convert to table
 based DAPM and control setup
Date: Thu, 13 Mar 2014 09:41:26 +0000
Message-ID: <20140313094126.GG366@sirena.org.uk>
References: <1394634460-15889-1-git-send-email-lars@metafoo.de>
 <1394634460-15889-12-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1355487560431080304=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FCAD265175
 for <alsa-devel@alsa-project.org>; Thu, 13 Mar 2014 10:41:41 +0100 (CET)
In-Reply-To: <1394634460-15889-12-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Ryan Mallon <rmallon@gmail.com>, Vinod Koul <vinod.koul@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Daniel =?iso-8859-1?Q?Gl=F6ckner?= <daniel-gl@gmx.net>, Benoit Cousson <bcousson@baylibre.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org


--===============1355487560431080304==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RMedoP2+Pr6Rq0N2"
Content-Disposition: inline


--RMedoP2+Pr6Rq0N2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 12, 2014 at 03:27:39PM +0100, Lars-Peter Clausen wrote:
> Use table based setup to register the controls and DAPM widgets and routes. This
> on one hand makes the code a bit shorter and cleaner and on the other hand the
> board level DAPM elements get registered in the card's DAPM context rather than

Applied, thanks.

--RMedoP2+Pr6Rq0N2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTIX1DAAoJELSic+t+oim9HgIP/1OQMJOkjzxa9nylUQPtZdpF
QN7Oy+0ApLFxwMC8LVXMAxJYejtaDU1G5z+Lv7JOsVupg7SY0ALKhpMfW6j5VD9P
ijo/o0t3ryEobBfktgoKLGUvhgvIezNyckuaPsWOpME4+kAAiXHq1rBne0UEe7UW
+LeXg++Lra8WvlkmRS1jioQhNfxivdDCIj7GiRb7hQIKVVI0g1yQdbfVdezZKjdv
cWL3fX1VKt/m6XYHnyP+bUJZ6+Rppdx/Lwu0FT2BkNqn5khgoJN/lTRuZHX/D0Bk
MJjglv8EZsJj1YcOXH4bwC3OMwZWADKa4Uyp1zirCDT4YIfgCdXMDul9/bhorGma
HN7HiEhptqIpmIx8m6MiAGTUwAvvZ4F5SCZppBzgcHYOtunuEMQ8BE6G2FDB/THl
RJeLB7X2OVcsNdLCPj56jKlVUvPGftNk0fiqUhKLjNFWjmTqJwxxT5Z9axSFDBjH
vPvblb9AYJCqedkCZqw4Ef+qpdr21CWxjNXquG65ZZ5Bszz15+80DlhQ504ekipd
E675J3zr6vS/AKM4Nis2zD19Jsu65LtSwqzFKHVQpbGsxLeefwe2juTBLCQ8T82T
9iZ7jX2S3JANgGxWOHtJn8leoGFRIq0sPRwAsX2obDyCj1GMfViX/C0E3PM9PA25
MfRJjYNpITnlLRerh+3M
=92Y+
-----END PGP SIGNATURE-----

--RMedoP2+Pr6Rq0N2--

--===============1355487560431080304==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1355487560431080304==--
