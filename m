From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Tue, 23 Feb 2010 19:48:53 +0000
Message-ID: <20100223194852.GA21422@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id C098F103875
	for <alsa-devel@alsa-project.org>; Tue, 23 Feb 2010 20:48:55 +0100 (CET)
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

The following changes since commit 6c5f1fed49f96a0600aa9a97ac3faf972c33a341:
  Mark Brown (1):
        ASoC: Make pmdown_time a long

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Candelaria Villareal, Jorge (1):
      ASoC: OMAP4: Add support for McPDM

Kuninori Morimoto (1):
      ASoC: fsi: Modify over/under run error settlement

Misael Lopez Cruz (2):
      ASoC: OMAP: data_type and sync_mode configurable in audio dma
      ASoC: OMAP4: Add McPDM platform driver

Peter Ujfalusi (1):
      ASoC: core: On resume also check the soc device state

 sound/soc/omap/Kconfig      |    3 +
 sound/soc/omap/Makefile     |    2 +
 sound/soc/omap/mcpdm.c      |  484 +++++++++++++++++++++++++++++++++++++++++++
 sound/soc/omap/mcpdm.h      |  151 ++++++++++++++
 sound/soc/omap/omap-mcbsp.c |    2 +
 sound/soc/omap/omap-mcpdm.c |  251 ++++++++++++++++++++++
 sound/soc/omap/omap-mcpdm.h |   29 +++
 sound/soc/omap/omap-pcm.c   |   15 +-
 sound/soc/omap/omap-pcm.h   |    4 +-
 sound/soc/sh/fsi.c          |   46 +++--
 sound/soc/soc-core.c        |    6 +
 11 files changed, 964 insertions(+), 29 deletions(-)
 create mode 100644 sound/soc/omap/mcpdm.c
 create mode 100644 sound/soc/omap/mcpdm.h
 create mode 100644 sound/soc/omap/omap-mcpdm.c
 create mode 100644 sound/soc/omap/omap-mcpdm.h
