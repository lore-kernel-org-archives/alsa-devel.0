From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.34
Date: Thu, 28 Jan 2010 15:51:38 +0000
Message-ID: <20100128155137.GB11254@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CD2D510386C
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 16:51:39 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 0d34e91596ef537c2893a031f0483014bb82adf3:
  Guennadi Liakhovetski (1):
        ASoC: add a WM8978 codec driver

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.34

Kuninori Morimoto (1):
      ASoC: fsi: Add spin lock operation for accessing shared area

Mark Brown (3):
      ASoC: Remove version display from WM9713
      ASoC: Add TLV information and additional volumes to WM9713
      ASoC: Set codec->dev for AC97 devices

Peter Ujfalusi (1):
      ASoC: TWL4030: Modify codec default settings

 sound/soc/codecs/twl4030.c |    8 +++---
 sound/soc/codecs/wm9713.c  |   64 ++++++++++++++++++++++++++++++-------------
 sound/soc/sh/fsi.c         |   29 ++++++++++++++++++--
 sound/soc/soc-core.c       |    1 +
 4 files changed, 75 insertions(+), 27 deletions(-)
