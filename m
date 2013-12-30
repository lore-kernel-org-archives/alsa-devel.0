From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 17/19] ASoC: txx9: Don't set unused struct
 snd_pcm_hardware fields
Date: Mon, 30 Dec 2013 13:58:15 +0000
Message-ID: <20131230135815.GG31886@sirena.org.uk>
References: <1387545625-19240-1-git-send-email-lars@metafoo.de>
 <1387545625-19240-17-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5537120514366301356=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 98A4E2625EA
 for <alsa-devel@alsa-project.org>; Mon, 30 Dec 2013 14:58:17 +0100 (CET)
In-Reply-To: <1387545625-19240-17-git-send-email-lars@metafoo.de>
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


--===============5537120514366301356==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="piopQj3F5GMtthHx"
Content-Disposition: inline


--piopQj3F5GMtthHx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2013 at 02:20:23PM +0100, Lars-Peter Clausen wrote:
> The ASoC core assumes that the PCM component of the ASoC card transparently
> moves data around and does not impose any restrictions on the memory layout or
> the transfer speed. It ignores all fields from the snd_pcm_hardware struct for
> the PCM driver that are related to this. Setting these fields in the PCM driver
> might suggest otherwise though, so rather not set them.

Applied, thanks.

--piopQj3F5GMtthHx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSwXv0AAoJELSic+t+oim97KUP/0elZZXZDqMw94oK7ih+IdSI
Nu7xyaG+FCE55RIMzYuDo36mHITxftftUdLkV4h1lq2sR9b020+ckYdcXlyBdlsy
GOTqqF5vRenjP08nmeZm3cHrZ50qmzAWTYmeCyGgOla3mG19FxOVO4vNp8wg5GJ7
MCcy0PITx6GLV7akIF+/wcjbbp2mpNoDZ8bg+pG0rdCE4sDz9wayB3PN7tSOCSx6
u1xpbj4issBeBJR69heQOTnuVKFqQ/We7dqvjrGh9tzpqNGsItSvf+iKCvhOE47D
BRY4iB5tdfNFL1HvLgPMN1rM4ZM7dWgZH2V6dO7qbHtkbm4+V+vhcQ5X7f0W4MYN
PqQqblsmCRwQoSjf6t840DicsAdfoFoBjpJsUvSVPFMhbwjOcuLmEzRYPTVWQSkd
7eG1K7R33loDHjwuM1PgM18eeB800l2NbAMFoSiSq1Cvdi04RwB0Er4o6DdRdCfJ
7FqhVU2bHzWP8xVPrkJE5RKgJczjh/2lrbLe++ou/Xp5GtLs8b9ol/OspJSTFeYo
K+E8SgR9mNZF7aJ7YZt92vZNML19iOM34HD4kKBsfcms04jkRuCNpDWAtgpp745h
bwTepwzso6iXVcg3m2amx9vEjwPCY85jJC8Enpe15ncEL/5GIuFO2/b/vv0Q9nYa
XsU2zcKMXNHMDFra5mOJ
=gkNJ
-----END PGP SIGNATURE-----

--piopQj3F5GMtthHx--

--===============5537120514366301356==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5537120514366301356==--
