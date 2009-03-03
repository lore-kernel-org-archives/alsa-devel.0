From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Tue, 3 Mar 2009 18:45:22 +0000
Message-ID: <20090303184521.GA30349@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EF3E7103823
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 19:45:22 +0100 (CET)
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

The following changes since commit ff09d49ad0176a5f52a398c137a7ff5f669d6be4:
  Daniel Mack (1):
        ASoC: fix typo and removed unneeded switch case for cs4270

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Philipp Zabel (4):
      ASoC: Remove version display from the UDA1380 driver
      ASoC: UDA1380: change decimator/interpolator register handling
      ASoC: Use network mode with 2 slots for 16-bit stereo in pxa-ssp/Zylonite
      ASoC: UDA1380: DATAI is slave only

 sound/soc/codecs/uda1380.c |  113 +++++++++++++++++++++-----------------------
 sound/soc/pxa/pxa-ssp.c    |    3 +-
 sound/soc/pxa/zylonite.c   |    7 ++-
 3 files changed, 60 insertions(+), 63 deletions(-)
