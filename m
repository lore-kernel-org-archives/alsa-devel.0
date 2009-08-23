From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 2.6.32
Date: Sun, 23 Aug 2009 18:38:28 +0100
Message-ID: <20090823173828.GA5516@opensource.wolfsonmicro.com>
References: <20090823101656.GA11491@sirena.org.uk>
	<s5hvdkeiho6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CCF4D244D5
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Aug 2009 22:26:50 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hvdkeiho6.wl%tiwai@suse.de>
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
Cc: Marek Vasut <marek.vasut@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, Aug 23, 2009 at 07:06:17PM +0200, Takashi Iwai wrote:

> Hm, this causes merge errors regarding wm97xx battery driver.

Causes merge errors with which tree?  It's a straight fast forward
aginst topic/asoc.

> Also, when I merge with 2.6.31-rc7, it gives more merge errors in
> arch code.

> Do they depend on other tree changes like linux-arm?

I suspect they're at most only textual.  In any case, this is all
causing far too much trouble so I've just dropped all of the patches
that are causing issues.

Marek, I suggest that you submit the patch to use IRQs against the power
tree.  I also suggest that you submit a version of the battery platform
data changes against the power tree which avoids making the platforms
instabuggy then when that's applied submit changes to Eric to use the
new platform data, making it clear that the machine changes will need to
wait for both power and ALSA trees to be merged during the merge window.
This is the approach that's been suggested previously - it makes life
much easier if changes go through the relevant trees.

The following changes since commit a0a499c5792b8656cd51e11d5e0db9fb21640f58:
  Eduardo Valentin (1):
        ASoC: OMAP: Use DMA operating mode of McBSP

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Ben Dooks (4):
      ASoC: S3C24XX: Add audio core and tlv320aic23 for Simtec boards
      ASoC: tlv320aic3x: Change to use device model
      ASoC: tlv320aic3x: fixup board device changes
      ASoC: S3C24XX: Support for Simtec Hermes boards

Kuninori Morimoto (2):
      ASoC: Add ak4642/ak4643 codec support
      ASoC: Add FSI-AK4642 sound support for SuperH

Marek Vasut (1):
      ASoC: Pass correct platform data from pxa2xx-ac97

Mark Brown (1):
      ASoC: Add DAPM widget power decision debugfs files

Roel Kluin (1):
      ASoC: free socdev if init_card() fails in wm9705_soc_probe()

 arch/arm/plat-s3c/include/plat/audio-simtec.h  |   37 ++
 include/sound/soc-dapm.h                       |    1 +
 include/sound/soc.h                            |    1 +
 sound/arm/pxa2xx-ac97.c                        |    4 +-
 sound/soc/codecs/Kconfig                       |    4 +
 sound/soc/codecs/Makefile                      |    2 +
 sound/soc/codecs/ak4642.c                      |  502 ++++++++++++++++++++++++
 sound/soc/codecs/ak4642.h                      |   20 +
 sound/soc/codecs/tlv320aic3x.c                 |  221 ++++++-----
 sound/soc/codecs/tlv320aic3x.h                 |    2 -
 sound/soc/codecs/wm9705.c                      |    2 +-
 sound/soc/davinci/davinci-evm.c                |   12 +-
 sound/soc/omap/n810.c                          |   12 +-
 sound/soc/pxa/pxa2xx-ac97.c                    |    4 +-
 sound/soc/s3c24xx/Kconfig                      |   19 +
 sound/soc/s3c24xx/Makefile                     |    7 +
 sound/soc/s3c24xx/s3c24xx_simtec.c             |  394 +++++++++++++++++++
 sound/soc/s3c24xx/s3c24xx_simtec.h             |   22 +
 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c      |  153 +++++++
 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c |  137 +++++++
 sound/soc/s6000/s6105-ipcam.c                  |   12 +-
 sound/soc/sh/Kconfig                           |    8 +
 sound/soc/sh/Makefile                          |    2 +
 sound/soc/sh/fsi-ak4642.c                      |  107 +++++
 sound/soc/soc-core.c                           |    8 +
 sound/soc/soc-dapm.c                           |   86 ++++
 26 files changed, 1661 insertions(+), 118 deletions(-)
 create mode 100644 arch/arm/plat-s3c/include/plat/audio-simtec.h
 create mode 100644 sound/soc/codecs/ak4642.c
 create mode 100644 sound/soc/codecs/ak4642.h
 create mode 100644 sound/soc/s3c24xx/s3c24xx_simtec.c
 create mode 100644 sound/soc/s3c24xx/s3c24xx_simtec.h
 create mode 100644 sound/soc/s3c24xx/s3c24xx_simtec_hermes.c
 create mode 100644 sound/soc/s3c24xx/s3c24xx_simtec_tlv320aic23.c
 create mode 100644 sound/soc/sh/fsi-ak4642.c
