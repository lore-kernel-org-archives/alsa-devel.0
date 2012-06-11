From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3] ASoC: codecs: Add DA732x codec driver
Date: Mon, 11 Jun 2012 12:41:04 +0800
Message-ID: <20120611044058.GM4218@opensource.wolfsonmicro.com>
References: <201206061634.q56GYWVk010054@sw-eng-lt-apt-vm1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8967852801001508319=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5608224B17
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2012 06:41:21 +0200 (CEST)
In-Reply-To: <201206061634.q56GYWVk010054@sw-eng-lt-apt-vm1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Adam Thomson <Adam.Thomson@diasemi.com>
Cc: alsa-devel@alsa-project.org, Michal Hajduk <Michal.Hajduk@diasemi.com>
List-Id: alsa-devel@alsa-project.org


--===============8967852801001508319==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5V5c01chtBAiSHoy"
Content-Disposition: inline


--5V5c01chtBAiSHoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2012 at 04:35:39PM +0000, Adam Thomson wrote:
> This patch adds support for the Dialog DA732x audio codec.
>=20
> Signed-off-by: Michal Hajduk <Michal.Hajduk@diasemi.com>
> Signed-off-by: Adam Thomson <Adam.Thomson@diasemi.com>

This doesn't apply, please always submit new code against current
development code for the subsystem.  You've also got something else
wrong with your setup, the Date: header for your mail is "Date: $(date
-R)" which is upsetting the tools.

Please also send followups adding the specific devices to the ID table.

--5V5c01chtBAiSHoy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1XbRAAoJEBus8iNuMP3dIiUP/3ZowKyfeQDq7YfYWbbD7ssv
qeULSmnV9oNjwI8naz19wOC9eRGv9PDCsShdY8aFCCp4FGmAGQxQh8/lRTDtD6h5
WqA6DJs6vx7auhCYmG9rC9QcJArGdD62VsT9z6rULvZOFaSEL/evRRGv6JTEXaWY
fcMYu2U9lUQW+OwyZVhEbPnjya1lLw/X79sBGhkKiGRpoBXvPaChLNIG+S0e8LWw
l/By9oZCPqRL3U3RUjQYt7CBoKnskoEyWBTUW4sHwZf7FMGgcPmBGrkMapx5CzGV
3VKPSCaLB5Ola/QHw0cq0s67d6dDtpBGGY8O+RkdwWBjcCFATLlJDnxBPY/uZibJ
AY4jTlPRYbzJICPUxvZvVa23ZKhBfUhMnQq1N6Zf3rBsM8Gq4QOD+JwJp2lIjGfO
81ekQrgBVMPRxLsK/m6C83hBwyKa6ef9ZOU2Ydpd4NcTe0Ank871s10azOekt7+a
7729UqOsuiogrTTxTP9jZWwH0FLtsSUhHFhn0VcMDpjTLasr/Q1cyEfU/k92OeqO
zQbXH1hd/3+Wu/Jwt3iUwO6/HIGtuHsnOrDN+2jnqug6K3i9uhPAmM6S2d/oxDvc
6lsiHGrle0k/bcnGKWNR+PPWDRlEzTuJyci0g9cqerlG2PJKoCQTkBir+HgTbl3B
mKDDWsGA/EfI3G5zS1xd
=P8Ev
-----END PGP SIGNATURE-----

--5V5c01chtBAiSHoy--

--===============8967852801001508319==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8967852801001508319==--
