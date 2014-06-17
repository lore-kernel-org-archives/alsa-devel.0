From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.16
Date: Tue, 17 Jun 2014 12:07:25 +0100
Message-ID: <20140617110725.GM5099@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3406473643556327253=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A0DB926557B
 for <alsa-devel@alsa-project.org>; Tue, 17 Jun 2014 13:07:42 +0200 (CEST)
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


--===============3406473643556327253==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TQdceJAPMCgoeI5/"
Content-Disposition: inline


--TQdceJAPMCgoeI5/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 7171511eaec5bf23fb06078f59784a3a0626b38f:

  Linux 3.16-rc1 (2014-06-15 17:45:28 -1000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.16-rc1

for you to fetch changes up to 28e48f0e262fd94a613613d06ac5eaf6745b18a8:

  Merge remote-tracking branches 'asoc/fix/fsl-dma', 'asoc/fix/fsl-spdif', 'asoc/fix/pxa', 'asoc/fix/rcar' and 'asoc/fix/sigmadsp' into asoc-linus (2014-06-16 16:05:16 +0100)

----------------------------------------------------------------

ASoC: Fixes for v3.16

Quite a few build coverage fixes in here among the usual small driver
fixes includling the sigmadsp change from Lars - moving the driver to
separate modules per bus (which is basically just code motion) avoids
issues with some combinations of buses being enabled.

----------------------------------------------------------------

Anssi Hannula (1):
      ASoC: fsl_spdif: Fix integer overflow when calculating divisors

Arnd Bergmann (2):
      ASoC: pxa: add I2C dependencies as needed
      ASoC: MMP audio needs sram support

Guenter Roeck (1):
      ASoC: fsl: Fix build problem

Jarkko Nikula (1):
      ASoC: dapm: Make sure register value is in sync with DAPM kcontrol state

Kuninori Morimoto (1):
      ASoC: rsnd: fixup index of src/dst mod when capture

Lars-Peter Clausen (1):
      ASoC: sigmadsp: Split regmap and I2C support into separate modules

Mark Brown (2):
      Merge remote-tracking branch 'asoc/fix/core' into asoc-linus
      Merge remote-tracking branches 'asoc/fix/fsl-dma', 'asoc/fix/fsl-spdif', 'asoc/fix/pxa', 'asoc/fix/rcar' and 'asoc/fix/sigmadsp' into asoc-linus

Nicolin Chen (1):
      ASoC: fsl_spdif: Fix incorrect usage of regmap_read()

 sound/soc/codecs/Kconfig           | 12 +++++--
 sound/soc/codecs/Makefile          |  4 +++
 sound/soc/codecs/sigmadsp-i2c.c    | 35 ++++++++++++++++++++
 sound/soc/codecs/sigmadsp-regmap.c | 36 +++++++++++++++++++++
 sound/soc/codecs/sigmadsp.c        | 65 ++------------------------------------
 sound/soc/codecs/sigmadsp.h        | 20 ++++++++++++
 sound/soc/fsl/fsl_dma.c            |  4 +--
 sound/soc/fsl/fsl_spdif.c          |  6 ++--
 sound/soc/pxa/Kconfig              | 11 ++++---
 sound/soc/sh/rcar/core.c           |  2 +-
 sound/soc/soc-dapm.c               | 29 +++++++++--------
 11 files changed, 135 insertions(+), 89 deletions(-)
 create mode 100644 sound/soc/codecs/sigmadsp-i2c.c
 create mode 100644 sound/soc/codecs/sigmadsp-regmap.c

--TQdceJAPMCgoeI5/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJToCFpAAoJELSic+t+oim9s8wQAIrCZOoYF+NCxLEFZkzpvTA+
R/duuB8bR7cWjXXCuqm2bEAVmZpQF0c9oIKREr4b1O4N0XDaFay9V5/VrrTUT6mF
X6moJaCCYkDPhUcXP0I1zwmZSLMbQGFjQvhEOcB8j1k9jtIyAT1wlTbgq4V0kr+i
eE7naxkMioed5nH3LLk+4VtXiA1td6HFAx7Vq/BzKNHiImQPS+WEFC3lUnlbBfx9
dtSHb/RWf13klc+fhSjAl8B3E/H/EGGRNny4rgm+fgAX4NcpyiePgxf/oCAd2SvE
ncvL3v3O8Bq5ohW5QcdyIS8doqkEKs3OC8O2m6RxFggt7o8CYnpZrqsX105NrZjv
I6/ayd/ItoH2i0iBXRlbOtprlwzRdAmUUTbjQwFPwZJQvtyxipbL2TY0SUhbxKT+
NVgPGT2MSHN65ED1NsAT32nE91xNo+nwGXCY9El1HMit/UipOlkwKVHJCcnlPtyn
KvlfvzfmtEufJGPxoLWT/gGXeEEPIGR9a+hm69m/eIEh2VH1HAfhjI5dZytdkN/P
0boX6MNwC7yEAOVVSVO8bmL66uPM9viBx/MtVpqmHB+un6aVuQXtX1k0vto+J+HZ
pYBihiG6la8h2OMvq3uCS4ehDIQU6hmCAXWfpm0d2bB9zc/4dARZ0sLgwnwyNqK9
ulCxiFIr3NU3SB223n4w
=a5yf
-----END PGP SIGNATURE-----

--TQdceJAPMCgoeI5/--

--===============3406473643556327253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3406473643556327253==--
