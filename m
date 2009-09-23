From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.32
Date: Wed, 23 Sep 2009 10:48:47 -0700
Message-ID: <20090923174845.GA31233@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 1CEFC1038B6
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 19:49:38 +0200 (CEST)
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

The following changes since commit 877ae70763fa0b19ffbe25e7e119fc96f52fbbd3:
  Phil Vandry (1):
        ASoC: wm8753: fix mapping when MONOMIX is set to Stereo

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.32

Chaithrika U S (1):
      ASoC: DaVinci: Correct McASP FIFO initialization

Cliff Cai (1):
      ASoC: Blackfin: fix inverted handling of SPORT0 on PORT F/G

Troy Kisky (2):
      ASoC: DaVinci: Fix divide by zero error during 1st execution
      ASoC: Davinci: Fix race with cpu_dai->dma_data

 sound/soc/blackfin/bf5xx-i2s.c    |    8 ++--
 sound/soc/blackfin/bf5xx-tdm.c    |    8 ++--
 sound/soc/davinci/davinci-i2s.c   |   37 ++++++-----------
 sound/soc/davinci/davinci-mcasp.c |   80 +++++++++++++------------------------
 sound/soc/davinci/davinci-mcasp.h |    7 +++-
 sound/soc/davinci/davinci-pcm.c   |   13 +++---
 sound/soc/davinci/davinci-pcm.h   |    1 -
 7 files changed, 60 insertions(+), 94 deletions(-)
