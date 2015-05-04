From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/5] ASoC: dapm: Remove local OOM error
	message
Date: Mon, 4 May 2015 13:04:10 +0100
Message-ID: <20150504120410.GJ15510@sirena.org.uk>
References: <1430480247-28753-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1430480247-28753-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7244023321328193176=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B6A3F262634
 for <alsa-devel@alsa-project.org>; Mon,  4 May 2015 15:16:12 +0200 (CEST)
In-Reply-To: <1430480247-28753-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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


--===============7244023321328193176==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bWEb1MG/o7IKOlQF"
Content-Disposition: inline


--bWEb1MG/o7IKOlQF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 12:37:24PM +0100, Charles Keepax wrote:
> The memory subsystem is pretty chatty on failure no need to have local
> OOM messages as well.

Applied, thanks.

--bWEb1MG/o7IKOlQF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVR2A5AAoJECTWi3JdVIfQ5WwH/jjghlVmZPOT56okXxgm8BZR
do9dLdEbRvrXFjMZiyPC3T1BjGOv5/ZF9LcxyCl7jZThNj5nuPj2qfIMI758oXIs
sJ5kWN9HkmB13ZhyTtCNFwUHnGjluumuMjIKvlj9NXO+ap2LJGHTlVFm9FXjxNtG
Ae4q/KgPU6QWRWJqGFuYQevAO0itQAdREkVL7jxpVbn6hLBpBkwv9TL/7ir6vgPv
C5rgb4/39b5t5Fa9v4h//Y3mrGKtFfLwJ2O6r2DGSnWrpilP0RBHu4ot7JwxNqhe
uL5T5Xp0EDQ5Bn4I82D5WfJIM5zlNT5ay8FIklh7NM+ilLHNIivp73rpWeQsrXY=
=MB/P
-----END PGP SIGNATURE-----

--bWEb1MG/o7IKOlQF--

--===============7244023321328193176==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7244023321328193176==--
