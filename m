From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.30
Date: Thu, 29 Jan 2009 14:09:42 +0000
Message-ID: <20090129140941.GF12179@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id A3354103882
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 15:09:50 +0100 (CET)
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

The following changes since commit 67fcdead3c7424d51e7108c220c9ab1a5e752ed3:
  Takashi Iwai (1):
        Merge branch 'topic/snd_card_new-err' into topic/asoc

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.30

Mark Brown (2):
      ASoC: Fix null string usage with WM8753 DAIs
      Merge branch 'for-2.6.29' into for-2.6.30

Misael Lopez Cruz (1):
      ASoC: OMAP: Initialize XCCR and RCCR registers in McBSP DAI driver

Peter Ujfalusi (1):
      ASoC: TWL4030: Add analog loopback support

 sound/soc/codecs/twl4030.c  |  212 ++++++++++++++++++++++++++++++++++++++++---
 sound/soc/codecs/twl4030.h  |   15 +++
 sound/soc/codecs/wm8753.c   |    9 ++-
 sound/soc/omap/omap-mcbsp.c |    4 +
 4 files changed, 226 insertions(+), 14 deletions(-)
