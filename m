From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Wed, 3 Jun 2009 11:51:50 +0100
Message-ID: <20090603105149.GA1198@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 61128243F7
	for <alsa-devel@alsa-project.org>;
	Wed,  3 Jun 2009 12:51:51 +0200 (CEST)
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

The following changes since commit 203350c1a8e23adf17fd9a96d8bfc7adf63c1ff6:
  Mark Brown (1):
        ASoC: Initialise dev for the dummy S/PDIF DAI

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Cliff Cai (3):
      ASoC: SSM2602: remove unsupported sample rates
      ASoC: Blackfin: set the transfer size according the ac97_frame size
      ASoC: SSM2602: assign last substream to the master when shutting down

Peter Ujfalusi (2):
      ASoC: TWL4030: Use reg_cache in twl4030_init_chip
      ASoC: TWL4030: Check the interface format for 4 channel mode

Sonic Zhang (1):
      ASoC: Blackfin: document how anomaly 05000250 is handled

 sound/soc/blackfin/bf5xx-ac97.c  |    9 +++++++++
 sound/soc/blackfin/bf5xx-sport.c |    4 ++--
 sound/soc/codecs/ssm2602.c       |   33 +++++++++++++++++++--------------
 sound/soc/codecs/twl4030.c       |   16 +++++++++++-----
 4 files changed, 41 insertions(+), 21 deletions(-)
