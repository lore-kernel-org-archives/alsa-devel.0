From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.31
Date: Mon, 20 Apr 2009 12:58:08 +0100
Message-ID: <20090420115808.GB22181@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 993B324406
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 13:58:09 +0200 (CEST)
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

The following changes since commit 8d98f2246d7c622198ae0b8ca66f1c82b8a25377:
  Mark Brown (1):
        Merge branch 'for-2.6.30' into for-2.6.31

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.31

Jarkko Nikula (1):
      ASoC: OMAP: Update contact addresses

Joonyoung Shim (1):
      ASoC: TWL4030: Add support Voice DAI

Mark Brown (1):
      Merge branch 'for-2.6.30' into for-2.6.31

Peter Ujfalusi (1):
      ASoC: TWL4030: Fix for the constraint handling

Philipp Zabel (1):
      ASoC: pxa-ssp: Don't use SSCR0_SerClkDiv and SSCR0_SCR

 sound/soc/codecs/twl4030.c    |  258 +++++++++++++++++++++++++++++++++++++----
 sound/soc/codecs/twl4030.h    |   18 +++-
 sound/soc/omap/n810.c         |    4 +-
 sound/soc/omap/omap-mcbsp.c   |    5 +-
 sound/soc/omap/omap-mcbsp.h   |    3 +-
 sound/soc/omap/omap-pcm.c     |    5 +-
 sound/soc/omap/omap-pcm.h     |    3 +-
 sound/soc/omap/omap2evm.c     |    2 +-
 sound/soc/omap/omap3beagle.c  |    2 +-
 sound/soc/omap/omap3pandora.c |    4 +-
 sound/soc/omap/overo.c        |    2 +-
 sound/soc/omap/sdp3430.c      |    2 +-
 sound/soc/pxa/pxa-ssp.c       |   36 +++++--
 13 files changed, 297 insertions(+), 47 deletions(-)
