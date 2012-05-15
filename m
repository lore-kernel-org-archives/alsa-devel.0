From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Last minute ASoC fixes for 3.4
Date: Tue, 15 May 2012 18:56:43 +0100
Message-ID: <20120515175623.GA19592@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1373533700808349478=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1E02524DBC
	for <alsa-devel@alsa-project.org>;
	Tue, 15 May 2012 19:56:46 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============1373533700808349478==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ew6BAiZeqk4r7MaW"
Content-Disposition: inline


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 06412088ce98f745405b8f65cfc51ddd6b842bbf:

  ASoC: s3c2412-i2s: Fix dai registration (2012-04-30 23:45:25 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-3.4

for you to fetch changes up to c7f5f2389377b66028bc129890aa653deafe8d39:

  ASoC: wm8994: Fix AIF2ADC power down (2012-05-15 18:29:30 +0100)

I'll send the big 3.5 update either later tonight or tomorrow.

----------------------------------------------------------------
ASoC: Last minute fixes

Some last minute fixes for ASoC.  Small, focused changes to specific
drivers.

----------------------------------------------------------------
Brian Austin (1):
      ASoC: cs42l73: Sync digital mixer kcontrols to allow for 0dB

Guennadi Liakhovetski (1):
      ASoC: sh: fix migor.c compilation

Mark Brown (1):
      ASoC: wm8994: Fix AIF2ADC power down

 sound/soc/codecs/cs42l73.c |   16 ++++++++--------
 sound/soc/codecs/wm8994.c  |    2 +-
 sound/soc/sh/migor.c       |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPspi9AAoJEBus8iNuMP3dSJ8P/2r0Ai9DsPmKPVGBq4qQJoYU
fd1XpOa3bXZDlG2JAMnaRiJRB8nVjXLOykfg0gjAOpNVHVGqDpGKiw525XTZxJGv
qui1Y0rAzBMEERXRilvZkgcfv9WhVa+fxf9KvCb3ShdV30m52+k8xOu9gpZF+z8D
DqEM/gOICN5dBMKn1C/7sasAzLzowiI5JPTB9ggeOg6MxUin9DARTy2ov3GRlag7
EkYPgaTqkmKrCMuDdTxljwDcsGTR9gi10s3/x8OKDRRuq6XaviGaN4Ggji8DU1ip
Om8HMRjO0v8x7RvEQZbg8dpIAuJkdN1aZb5T+htB+/1CZm0RzEkF1nJ4RGvCVMGm
1lppyhT830sOvpWCWF1u+RrnNupLMeSHzgiNA0ySI1cQOnAbz3PLAW2v/dtfqKlq
u1gSG4G5Wst8SMFsbawal6JxoCX4yp4qPCXtH6Z6ROZGCjQll6pWJo9h5K4vf7eg
9KHspiMd1KWG7Cb+f0DtNCa6ZfqVujNlJYL1FkRD9jgXG7CN99Fvo/+M0JUbbYYj
q2gK6wLqZAHQYG7jAKaBryjYQO3/XHDOVo5cuhXwXFCPR6ZAxZU2tfGA0MQXnQqZ
87MlqqM56ebprjpJ241PJWmVidlOkO8443Fc+7C5c0OlKpj8e2b9q3XPyxMqiQ6a
r8ROB2aD29yxyF4+mpNj
=y+N4
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--

--===============1373533700808349478==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1373533700808349478==--
