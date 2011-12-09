From: =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Subject: [PATCH 0/5] ASoC: mxs: Several cleanups and bugfixes for the MXS sound driver
Date: Fri,  9 Dec 2011 14:38:07 +0100
Message-ID: <cover.1323436034.git.LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Dong Aisheng-B29396 <B29396@freescale.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, =?utf-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
List-Id: alsa-devel@alsa-project.org


Lothar Wa=C3=9Fmann (5):
  General cleanups
  Add .owner to struct snd_soc_card
  Export symbols 'mxs_saif_put_mclk()' and 'mxs_saif_get_mclk()'
  Add missing MODULE_LICENSE("GPL")
  Add appropriate MODULE_ALIAS()

 sound/soc/codecs/sgtl5000.c  |   13 ++++++-------
 sound/soc/mxs/mxs-pcm.c      |    3 +++
 sound/soc/mxs/mxs-saif.c     |    4 +++-
 sound/soc/mxs/mxs-sgtl5000.c |    2 ++
 4 files changed, 14 insertions(+), 8 deletions(-)
