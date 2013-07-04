From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: arizona: Add signal activity
 output for DRC
Date: Thu, 4 Jul 2013 11:24:46 +0100
Message-ID: <20130704102446.GT27646@sirena.org.uk>
References: <1372924588-14666-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1372924588-14666-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8082069915001016647=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B0E0261A8B
 for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2013 12:24:49 +0200 (CEST)
In-Reply-To: <1372924588-14666-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, sameo@linux.intel.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org


--===============8082069915001016647==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dz8vr1PRd6fSoenC"
Content-Disposition: inline


--dz8vr1PRd6fSoenC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 04, 2013 at 08:56:28AM +0100, Charles Keepax wrote:
> When doing signal activity detection, the only output from the DRC will
> often be a GPIO pin. This patch adds a signal activity output that is
> activated when a GPIO is configured to output the DRC signal activity
> detection.

Applied, thanks.

--dz8vr1PRd6fSoenC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR1U1rAAoJELSic+t+oim9ufAQAIWJ/o2G6GguKitOO8XKuYXk
/as8UIugMFx0DkjLWLxISmqdFPsk84EbN6P0TVUsLxIY98+CZ4WWQr/1yX/PyG68
n7UFjtW1sm736cPm9QN02P+T7du87lSEyRBb8s3+hBLU4Oibr7y5zf7uh3skyLcE
PGGrz5FrD0H581jdJbu3mSXrPVhUTKyyWYvT0LO/j6ZkdUxf57VrrPKVkxWRW/ub
cdkzHN2vVf5sVqK9IxmfLsgR4RhLFSd78ipJ/QQZS5eAXfTcMU0g1O/3ogG9NyRG
0cu8hybBpib5mLnjpCyvoQfUaYDFPRHaKyvw0XP1EE3Cti7HpkoRQOqoFvuBcnai
1EVTOISttXv9SqfUa4Ust1mDMOdHi+NY5A5ekxeeAPNmSq95bg8MzXd6ITEy0wsh
tTE52+N4Aed8iLqhOqTNvzgbsjW/wLJjbot6zeAI6v77MNJz8D0ZY8vf45QED1bR
CxGLBq9Mj/pPEwWXtsRVAHaDPromKuM822xfN6a7cAUJQeJvYcbxyMI4UCxa1d0I
C5yGoqULlNAunsaLCe94n0KZlyJuFh3h2dhc6TjbAZDRdP4jgAtvYd5TC/hiNV1J
DlOJ/IW7sFtObDZAWmfEPgBc4PmHFli1b16cBP8vjO8NOVBSk60eySWQWHWwe4Lh
Ug0NtZAuZ2nIHZx8JN/E
=VN/E
-----END PGP SIGNATURE-----

--dz8vr1PRd6fSoenC--

--===============8082069915001016647==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8082069915001016647==--
