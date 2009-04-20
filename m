From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Mon, 20 Apr 2009 12:55:45 +0100
Message-ID: <20090420115544.GA22181@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B24CF24402
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Apr 2009 13:55:46 +0200 (CEST)
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

The following changes since commit 002fbad829883a3ad9b185077f9e54c37dc7502d:
  Jarkko Nikula (1):
        ASoC: OMAP: Fix FS polarity in OSK5912 machine driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Jarkko Nikula (1):
      ASoC: OMAP: Update contact addresses

Philipp Zabel (1):
      ASoC: pxa-ssp: Don't use SSCR0_SerClkDiv and SSCR0_SCR

Russell King - ARM Linux (1):
      ASoC: Fix warning in wm9705

 sound/soc/codecs/wm9705.c   |    2 +-
 sound/soc/omap/n810.c       |    4 ++--
 sound/soc/omap/omap-mcbsp.c |    5 +++--
 sound/soc/omap/omap-mcbsp.h |    3 ++-
 sound/soc/omap/omap-pcm.c   |    5 +++--
 sound/soc/omap/omap-pcm.h   |    3 ++-
 sound/soc/pxa/pxa-ssp.c     |   36 ++++++++++++++++++++++++++++--------
 7 files changed, 41 insertions(+), 17 deletions(-)
