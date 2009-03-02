From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC updates for 2.6.30
Date: Mon, 2 Mar 2009 17:17:46 +0000
Message-ID: <20090302171745.GA31475@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 692DD243F5
	for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2009 18:17:47 +0100 (CET)
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

The following changes since commit 6d5643455ced9ee45a4aa7403fe8056d826bde85:
  Takashi Iwai (1):
        ASoC: wm8753 - Fix build error

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Ben Dooks (1):
      ASoC: Fix copyright statements on Simtec files

Daniel Mack (2):
      ASoC: Add cs4270 support for slave mode configurations
      ASoC: fix typo and removed unneeded switch case for cs4270

Mark Brown (1):
      ASoC: Add SND_SOC_DAPM_PIN_SWITCH controls for exposing DAPM pins

 include/sound/soc-dapm.h        |   12 +++++++
 sound/soc/codecs/cs4270.c       |   22 ++++++++++++-
 sound/soc/s3c24xx/s3c24xx-i2s.c |    2 +-
 sound/soc/s3c24xx/s3c24xx-pcm.c |    2 +-
 sound/soc/soc-dapm.c            |   70 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 105 insertions(+), 3 deletions(-)
