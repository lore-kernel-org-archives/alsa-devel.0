From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dapm: Add cache to speed up
	adding of routes
Date: Tue, 12 May 2015 11:40:03 +0100
Message-ID: <20150512104003.GQ2761@sirena.org.uk>
References: <1431348630-23462-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7130367527609527635=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 91E08265705
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2015 12:40:15 +0200 (CEST)
In-Reply-To: <1431348630-23462-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org


--===============7130367527609527635==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JQ29orswtRjjfiJM"
Content-Disposition: inline


--JQ29orswtRjjfiJM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 01:50:30PM +0100, Charles Keepax wrote:
> Some CODECs have a significant number of DAPM routes and for each route,
> when it is added to the card, the entire card widget list must be
> searched. When adding routes it is very likely, however, that adjacent

Applied, thanks.

--JQ29orswtRjjfiJM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUdiDAAoJECTWi3JdVIfQ6+MH/jpdr2NMmfqGsJkRSmnvkZZd
Zk2WBEHcdz+4yNDk/EA6qrKnxZrSVSVKPFapeoASD0QN5Zsiz8F6bpmjmMS7ykz2
ppR0K47tTNl/7f5Q/eVklII1ERA99OrsZpAs/vj8AU7e57iZ1NnPe4KYiHwvM5TN
tc+n360D2Wg7Dh50gQhNpe6tC7UAdro2czxnRu0z0x4KrnAPprXQQb/CHq1lkxth
aH5qYeFOBMHTmy//sWb41tR1R1QDLK+hF4zFMMuMCjNK1XzRsns3ZlxNwXB5cmAA
ALzGGiICRHBKbRnDng9fERn7N9M6wjEnGHU+oXwn8344npXjtkTnBnI9Nb71WqU=
=C5m0
-----END PGP SIGNATURE-----

--JQ29orswtRjjfiJM--

--===============7130367527609527635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7130367527609527635==--
