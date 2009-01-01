From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 0/4] ASoC updates for next
Date: Thu, 1 Jan 2009 15:31:14 +0000
Message-ID: <20090101153113.GA5966@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E6D32434A
	for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2009 16:31:22 +0100 (CET)
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

The following changes since commit 6a94cb73064c952255336cc57731904174b2c58f:
  Linus Torvalds (1):
        Merge branch 'for-linus' of git://oss.sgi.com/xfs/xfs

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-tiwai

If merging these patches just now is going to cause hassle then let me
know.

Mark Brown (1):
      ASoC: Clean up kerneldoc warnings

Peter Ujfalusi (2):
      ASoC: TWL4030: Make the enum filter generic for twl4030
      ASoC: TWL4030: DAPM based capture implementation

Stephen Ware (1):
      ASoC: Fix pxa2xx-pcm checks for invalid DMA channels

 sound/soc/codecs/twl4030.c |  377 ++++++++++++++++++++++----------------------
 sound/soc/codecs/twl4030.h |    7 +
 sound/soc/pxa/pxa2xx-pcm.c |    4 +-
 sound/soc/soc-core.c       |   46 +++---
 sound/soc/soc-dapm.c       |   10 +-
 5 files changed, 227 insertions(+), 217 deletions(-)
