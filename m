From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC fix for 3.3
Date: Sun, 4 Mar 2012 14:55:50 +0000
Message-ID: <20120304145550.GA4978@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3026429874819099159=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 914302470B
	for <alsa-devel@alsa-project.org>; Sun,  4 Mar 2012 15:55:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3026429874819099159==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 5ed80a75b248bfaf840ea6b38f941edcf6ee7dc7:

  ASoC: i.MX SSI: Fix DSP_A format. (2012-02-23 18:58:17 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.3

for you to fetch changes up to b2ccf065f7b23147ed135a41b01d05a332ca6b7e:

  ASoC: neo1973: fix neo1973 wm8753 initialization (2012-03-04 14:30:18 +0000)

----------------------------------------------------------------
A driver specific fix that wasn't noticed as the OpenMoko guys have been
stuck on 2.6.39 for a very long time now and are just starting to catch
up again.
----------------------------------------------------------------

Denis 'GNUtoo' Carikli (1):
      ASoC: neo1973: fix neo1973 wm8753 initialization

 sound/soc/samsung/neo1973_wm8753.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPU4JqAAoJEBus8iNuMP3dBncP/27S3bAbw+LU6E8jCjasSHd4
lsA6eT9uogZ1OMXPsh3OasZAmeNum/N/VN3drkbGJMO7vBw/a07K4V26JOOigT6+
av7PKSLi2MQbt6o57zQ7dQvAuVpiJ9eAjNR2JWd4mgbyRhdhxbYqyKuG5smEIRXt
SPQqGQLpTQ+Kqx8/BhV90GT3iksSIBfL2kSVF1hnvVIin/avS9xy2EC2VSJ6s7IJ
l35B17GLSoErl/FoFWNH2qVJfDZzj0wCaGQEjJmrJjjxttNsbAzj1WC6NwaLIzzN
nJgGco2GsNv/jzH/SmxK6GxUBz2vU9CqpIN3ogRYfGobdYYgdNDYPItTt8Ev5mc2
oeDRIDgAVKrO4hLyTY3od5LEExDEX5ZrvIqIL1NGXEIDcYHbuheb/ZVeMCP7mms1
Fqn9sE78aRdYAwnUVO/X7z7hQAoIPHXMwaghocsmtctAudHt43Yg2T9LFcdYDTlv
yiPTvgfYHL1n5cV4zShOBv8+Cmpe35b6HkttQn4tMdzGWVz9V7qxvVcsYQlhDog+
ikWx1nurBPWhJgILpnZP4nwHbWvIl1mmkE+Is6T9+M3Ijg36LPgOD/jPkNCUMbx5
9Op+PEQzgvDk8EoGLa0XY6UfHLM/o27YPq7e/nN18ULjymD/vDLwBniDpzvKUVjH
SCMWbbzRLAQzvPMqsN1N
=7yta
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

--===============3026429874819099159==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3026429874819099159==--
