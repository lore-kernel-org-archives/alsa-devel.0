From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.29
Date: Thu, 29 Jan 2009 13:42:29 +0000
Message-ID: <20090129134227.GD12179@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 69A16103885
	for <alsa-devel@alsa-project.org>; Thu, 29 Jan 2009 14:42:39 +0100 (CET)
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

The following changes since commit 43d50807dbf47a139f83660fec14aebe936b3c80:
  Peter Ujfalusi (1):
        ASoC: Add missing comma to SND_SOC_DAPM_SWITCH_E in soc-dapm.h

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.29

Mark Brown (1):
      ASoC: Fix null string usage with WM8753 DAIs

Misael Lopez Cruz (1):
      ASoC: OMAP: Initialize XCCR and RCCR registers in McBSP DAI driver

 sound/soc/codecs/wm8753.c   |    9 ++++++++-
 sound/soc/omap/omap-mcbsp.c |    4 ++++
 2 files changed, 12 insertions(+), 1 deletions(-)
