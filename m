From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 014/102] ASoC: wm8983: Remove superfluous
	const
Date: Thu, 20 Feb 2014 10:57:57 +0900
Message-ID: <20140220015757.GC2669@sirena.org.uk>
References: <1392723148-12597-1-git-send-email-tiwai@suse.de>
 <1392723148-12597-12-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7452380791877991101=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 66AF5265646
 for <alsa-devel@alsa-project.org>; Thu, 20 Feb 2014 02:58:14 +0100 (CET)
In-Reply-To: <1392723148-12597-12-git-send-email-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7452380791877991101==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2UPnqFQyhpFUUpcd"
Content-Disposition: inline


--2UPnqFQyhpFUUpcd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:32:26PM +0100, Takashi Iwai wrote:
> As SOC_ENUM_SINGLE_DECL() itself contains const modifier now, we can
> reduce const from its users.

Applied, thanks.

--2UPnqFQyhpFUUpcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBWEiAAoJELSic+t+oim9yVAP/iX3nCWjkyO8LnvgFlc2XXvj
wNS83Oe++44VyQoTyFiIZPFsXvZBGU3bPU3IkU0u0ROCr0ahE55msTxYpNQsTgN0
9IQ/BqnqtwztdRuisQB1mbsw29GlNQ67OZU+Jdkp+reawflYbdiNRR/KjlvSODtB
iR7ueoCmbWjAdQU4SiYtue57OLLdwxFzxPAQzvQayaj08DAMb6omfC+VbQ5pIvaU
IaT14aBraJ7PZn3CUqsJRKIan4NxIxxd4erY5vkdCq1spToJXONOCG9UlKPRpV5d
JYX3duYExsoCLhMc8Uti3OLouvA9S3pyVXuFC+EAe2aV+Z/vOBbtfs0CGioisgeS
+X0m2JqmI4Dg6wIvcRTSdrlWWZv6Rwl3dKZSRWDrp08HqAa/Qb7D4r4zNmNiNPXE
zgHmFIKBeGq9/ZsUTTTzQvmZR0apSG5vYsyI6TrRv/alxI4Wyy3r9r6RrmKL0Bkt
3qnLJmtxjv0cJ5F7maTRBUHwhGIVkrr0gAS+TBInCSLrEyAqV3dF4hI7XOYArUN4
N/eLBQa9NdOfL+wtjf63tEh+bZISMkbZFaIwo9av1aUEitdTCwKgHQIIlUTRbjBx
S1LZtU+HIHpd6KQ9xiBYIaNcjHp1pzzOR+k358kFLfNDH/tv3UWKg5Vo/0+LstJC
7S1NaxAt8leZWGchbCta
=0mWI
-----END PGP SIGNATURE-----

--2UPnqFQyhpFUUpcd--

--===============7452380791877991101==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7452380791877991101==--
