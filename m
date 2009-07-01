From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Wed, 1 Jul 2009 21:45:05 +0100
Message-ID: <20090701204503.GA11465@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 0222824405
	for <alsa-devel@alsa-project.org>;
	Wed,  1 Jul 2009 22:45:12 +0200 (CEST)
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

The following changes since commit 10121a12e2380fb34b6e646a8e367add06d036c3:
  Takashi Iwai (1):
        Merge branch 'for-2.6.31' of git://git.kernel.org/.../broonie/sound-2.6 into fix/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Grant Likely (2):
      ASoC: Fix typo in MPC5200 PSC AC97 driver Kconfig
      ASoC: remove BROKEN from Efika and pcm030 fabric drivers

Janusz Krzysztofik (1):
      ASoC: OMAP: fix OMAP1510 broken PCM pointer callback

Mark Brown (1):
      ASoC: Only disable pxa2xx-i2s clocks if we enabled them

 sound/soc/fsl/Kconfig      |    6 +++---
 sound/soc/omap/omap-pcm.c  |   11 +++++++----
 sound/soc/pxa/pxa2xx-i2s.c |    7 ++++++-
 3 files changed, 16 insertions(+), 8 deletions(-)
