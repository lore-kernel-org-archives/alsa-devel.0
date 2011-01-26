From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.38
Date: Wed, 26 Jan 2011 11:34:02 +0000
Message-ID: <20110126113402.GA6252@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7DCAA24542
	for <alsa-devel@alsa-project.org>; Wed, 26 Jan 2011 12:33:45 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 20a4e7fc7e213365ea3771d7bf1e10a6bab853be:

  ASoC: Handle low measured DC offsets for wm_hubs devices (2011-01-21 18:20:16 +0000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.38

Dmitry Eremin-Solenikov (1):
      ASoC: correct link specifications for corgi, poodle and spitz

Lars-Peter Clausen (2):
      ASoC: Fix codec device id format used by some dai_links
      ASoC: Samsung: Fix outdated cpu_dai_name for s3c24xx i2s

 sound/soc/atmel/snd-soc-afeb9260.c             |    2 +-
 sound/soc/blackfin/bf5xx-ssm2602.c             |    2 +-
 sound/soc/pxa/corgi.c                          |    4 ++--
 sound/soc/pxa/poodle.c                         |    2 +-
 sound/soc/pxa/spitz.c                          |    4 ++--
 sound/soc/samsung/neo1973_gta02_wm8753.c       |    6 +++---
 sound/soc/samsung/neo1973_wm8753.c             |    6 +++---
 sound/soc/samsung/s3c24xx_simtec_hermes.c      |    4 ++--
 sound/soc/samsung/s3c24xx_simtec_tlv320aic23.c |    4 ++--
 sound/soc/samsung/s3c24xx_uda134x.c            |    2 +-
 10 files changed, 18 insertions(+), 18 deletions(-)
