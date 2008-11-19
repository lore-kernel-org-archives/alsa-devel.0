From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/6] ASoC updates
Date: Wed, 19 Nov 2008 13:34:27 +0000
Message-ID: <20081119133427.GA3687@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 005982461B
	for <alsa-devel@alsa-project.org>; Wed, 19 Nov 2008 14:34:28 +0100 (CET)
Content-Disposition: inline
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

The following changes since commit 72f2b894455775b980a5ac7ae70ab560b3d3d247:
  Mark Brown (1):
        ASoC: Move uda134x_codec.h to uda134x.h

are available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-asoc for-tiwai

Arun KS (1):
      ASoC: Add support for omap2evm board

Hugo Villeneuve (2):
      ASoC: Add PCM3008 ALSA SoC driver
      ASoC: Add driver for the Lyrtech SFFSDR board

Mark Brown (3):
      ASoC: Remove unused snd_soc_machine_config declaration
      ASoC: s3c24xx_uda134x DAI accessor functions and static cleanup
      ASoC: Convert blackfin machines to use DAI accessor functions

 include/sound/soc.h                 |    1 -
 sound/soc/blackfin/bf5xx-ad73311.c  |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c  |    6 +-
 sound/soc/codecs/Kconfig            |    4 +
 sound/soc/codecs/Makefile           |    2 +
 sound/soc/codecs/pcm3008.c          |  201 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/pcm3008.h          |   25 +++++
 sound/soc/davinci/Kconfig           |   10 ++
 sound/soc/davinci/Makefile          |    2 +
 sound/soc/davinci/davinci-sffsdr.c  |  156 +++++++++++++++++++++++++++
 sound/soc/omap/Kconfig              |    9 ++
 sound/soc/omap/Makefile             |    2 +
 sound/soc/omap/omap2evm.c           |  150 ++++++++++++++++++++++++++
 sound/soc/s3c24xx/s3c24xx_uda134x.c |   27 +++---
 14 files changed, 578 insertions(+), 19 deletions(-)
 create mode 100644 sound/soc/codecs/pcm3008.c
 create mode 100644 sound/soc/codecs/pcm3008.h
 create mode 100644 sound/soc/davinci/davinci-sffsdr.c
 create mode 100644 sound/soc/omap/omap2evm.c
