From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Thu, 16 Apr 2009 14:50:27 +0100
Message-ID: <20090416135026.GA10878@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2BCF6243B7
	for <alsa-devel@alsa-project.org>;
	Thu, 16 Apr 2009 15:50:28 +0200 (CEST)
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

The following changes since commit 6967963d6d5cac40a091d075326f0e3ccb95c58a:
  Mark Brown (1):
        Merge branch 'for-2.6.30' into for-2.6.31

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Ben Dooks (4):
      ASoC: Fix jive_wm8750.c build problems
      ASoC: s3c-i2s-v2.c fix for s3c_i2sv2_iis_calc_rate
      ASoC: Fix s3c-i2s-v2.c snd_soc_dai changes
      ASoC: Fix include build error in s3c2412-i2s.c

Daniel Mack (1):
      ASoC: pxa-ssp: allow setting of dai format 0

Jarkko Nikula (2):
      ASoC: OMAP: Fix DSP_B format in OMAP McBSP DAI driver
      ASoC: OMAP: Fix FS polarity in OSK5912 machine driver

Mark Brown (4):
      ASoC: Check we have DAI ops when calling via accessor functions
      ASoC: Volume controls are never of boolean type
      ASoC: Request shared rates for WM8903
      Merge branch 'for-2.6.30' into for-2.6.31

Peter Ujfalusi (2):
      ASoC: OMAP: Use single-phase for DSP mode
      ASoC: OMAP: Add DSP_A mode support for mcbsp

 sound/soc/codecs/wm8903.c       |    1 +
 sound/soc/omap/omap-mcbsp.c     |   45 ++++++++++++++++++++++++++------------
 sound/soc/omap/osk5912.c        |    4 +-
 sound/soc/pxa/pxa-ssp.c         |    1 +
 sound/soc/s3c24xx/jive_wm8750.c |   12 +++++-----
 sound/soc/s3c24xx/s3c-i2s-v2.c  |   18 ++++++++-------
 sound/soc/s3c24xx/s3c2412-i2s.c |    2 +-
 sound/soc/soc-core.c            |   20 ++++++++--------
 8 files changed, 62 insertions(+), 41 deletions(-)
