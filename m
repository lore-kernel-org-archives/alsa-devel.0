From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: dapm: Fix SUSPEND -> OFF bias
	sequence
Date: Mon, 12 May 2014 22:06:52 +0100
Message-ID: <20140512210651.GU12304@sirena.org.uk>
References: <1399365135-26877-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4543139010931428351=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id B0DD52650FA
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 23:07:07 +0200 (CEST)
In-Reply-To: <1399365135-26877-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============4543139010931428351==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KsVkpN3j6bpLJgwB"
Content-Disposition: inline


--KsVkpN3j6bpLJgwB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 10:32:15AM +0200, Lars-Peter Clausen wrote:
> Currently when the DAPM context bias level is SUSPEND and the target bias level
> is OFF dapm_pre_sequence_async() will first transition to PREPARE and
> dapm_post_sequence_async() will then transition back from PREPARE to STANDBY and
> then to OFF.

Applied, thanks.

--KsVkpN3j6bpLJgwB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTfoAAoJELSic+t+oim9pJQP/3SeZfIrK+2sDumsZwZcsEbn
q/JId3XH8axOfVTMWvQvuTiig6kbmG9pYlJw/4Pu18mmeWnjRSJusZZlD8ofKAXO
g8t55fCk37EL8jHiTsPJtRuLJXeG901cFJqWcANCxUKRIcTczYm9aVOqXfBNrIt0
qflSuVTNVnJh4xguznocBnT/W3vhqvdHMb8i7C6MDKydGOpxjSNlxHlCuOarp+V6
ikzGdkVnaMPOx/CprspnzTm5M15zQtW9szNcwaOyoRpjojC7llrkB2V5sel79VZ6
lwQfQB8SZ8UgqcnOoC8JqQ7gDGmNwiJNpA6V1SETbpFbGSe63VXYmxhpcl5Xq3yE
n/AbMFYrNPk3coVZCpMPtxwXaRtYXhjkZe+4k2O76Ngdu60lpZdOSlL1KSrmTpgu
niMEANKqqycjkcbLwvZ33rDrLBi+Zmuy85L/LKfbkxqze/wM+c9BxXdeET6EmfCz
Mi6586n2EvsE30HMS+mKGeNiVf1IDapmGXX3xqySiqpKApqoihWE/w1v9hN881aQ
OVsgy00IXqA/hblZJ0tXCnj/8cyu2EGYyeaFRnUJYR4nmaH9jdguuPDnUJVGXrrl
ypfxvgZooG4ild7E9N1p9W533lZ4OC+p5/Pk2LhJjEJ1MbQvQZrwurcV2oazxDAs
KyZzpnhTdBNL9KmWPPKO
=7Ula
-----END PGP SIGNATURE-----

--KsVkpN3j6bpLJgwB--

--===============4543139010931428351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4543139010931428351==--
