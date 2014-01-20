From: Mark Brown <broonie@kernel.org>
Subject: ASoC updates for v3.14
Date: Mon, 20 Jan 2014 14:46:38 +0000
Message-ID: <20140120144638.GO17314@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7020969945531650726=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 088082608D6
 for <alsa-devel@alsa-project.org>; Mon, 20 Jan 2014 15:46:55 +0100 (CET)
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


--===============7020969945531650726==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="e4annfiqlsPm5rKd"
Content-Disposition: inline


--e4annfiqlsPm5rKd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 258753361534a40ad7180c742da813fc659e427b:

  Merge branch 'for-next' into for-linus (2014-01-20 10:20:14 +0100)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git tags/asoc-v3.14-3

for you to fetch changes up to ac6d7c48e3a5e82e876114b9ca0b489e96997743:

  Merge remote-tracking branch 'asoc/topic/compress' into asoc-next (2014-01-20 11:50:41 +0000)

----------------------------------------------------------------

ASoC: Last updates for the merge window

A couple more fixes plus some extensions to DPCM for use with compressed
audio from Liam which arrived just after my previous pull request.

----------------------------------------------------------------
Arun Shamanna Lakshmi (1):
      ASoC: dapm: Fix double prefix addition

Liam Girdwood (2):
      ASoC: DPCM: make some DPCM API calls non static for compressed usage
      ASoC: compress: Add suport for DPCM into compressed audio

Mark Brown (3):
      Merge remote-tracking branch 'asoc/topic/dapm' into asoc-next
      Merge remote-tracking branch 'asoc/topic/dma' into asoc-next
      Merge remote-tracking branch 'asoc/topic/compress' into asoc-next

Xiubo Li (1):
      ASoC: core: Fix possible NULL pointer dereference of pcm->config

 include/sound/soc-dpcm.h              |  22 +++
 include/sound/soc.h                   |   1 +
 sound/soc/soc-compress.c              | 301 +++++++++++++++++++++++++++++++++-
 sound/soc/soc-dapm.c                  |  11 +-
 sound/soc/soc-generic-dmaengine-pcm.c |   9 +-
 sound/soc/soc-pcm.c                   |  29 ++--
 6 files changed, 347 insertions(+), 26 deletions(-)

--e4annfiqlsPm5rKd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS3TbLAAoJELSic+t+oim9+2cP/RXPeGiT2eTRlPFC5ctxBWD6
LxFilNClHMEue5jwsvL27Toy7sCs9ovQBmhyICZYNH9Nk0fpcxGyLJyhk3LnvPIZ
3uQEetzIhjxQ7EE9mAwxnVrQLI7Tq140bbdVFW6romKNb6xumTWYVP+M0d52u5AD
7Wu7U/kZo1WmFGx/xHCKcUQgGMenBT6ea9HyWiXB8Fb3vQHWn90hrfzYM//MuzkG
GyffqXEBEQfYiasHINS2UnEeGZYx/qjH6eyVBfJXDzqTBVf4jBD61rgjW0lnJYDi
ar2Jl1xLVftvZPjWlP977ZoyZzyEe8ZvsbyL33u65ErVXWoJvpd/9rM91qzdKlT/
2mo017p30g/aXXlpThEFo85qHpg2cqWSPIa5PrO6+D8K3x4CVAggTnLU4fsuY6pn
NRRV3Uq3j6HS4NIlt8KFx7F7jIBFAjQf+bL3m3oGGCQy7E8sM9Z2R4Onfc6l1NEY
zAWpO09TqbUQqQnSv3kINzTf973zrhdMu7N4oFZNiHxTwC6YWuwq352T1174XzP1
X/YABDf3qYSnGK79mz3SBTCReGTPxK15ZjaVRn9wpcpp29Mkh766iy/byS85se5Y
faYWKXjnD3abMsZW/NIAnGXk+UaAxX+3FNWV6XqgXWAKCTEXH4+qTSQIh14B49ts
MORmu9BJiEWpk4FT0ltb
=xf1Y
-----END PGP SIGNATURE-----

--e4annfiqlsPm5rKd--

--===============7020969945531650726==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7020969945531650726==--
