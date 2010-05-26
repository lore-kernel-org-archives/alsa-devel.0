From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 2.6.35
Date: Wed, 26 May 2010 08:50:14 -0700
Message-ID: <20100526155013.GB17973@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4D9E7103941
	for <alsa-devel@alsa-project.org>;
	Wed, 26 May 2010 17:50:06 +0200 (CEST)
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

The following changes since commit ad8332c1302bcb4f80d593fd3eb477be9d7f5604:

  ASoC: tpa6130a2: Remove CPVSS and HPVdd supplies (2010-05-20 10:28:39 +0100)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-2.6.35

This fixes up the build of the i.MX SSI driver, a minor warning fix for
SH and fix the dB scales for a bunch of Wolfson CODECs.

Guennadi Liakhovetski (1):
      ASoC: fix uninitialised variable in siu_dai.c

Mark Brown (3):
      ASoC: Fix dB scales for WM835x
      ASoC: Fix dB scales for WM8400
      ASoC: Fix dB scales for WM8990

Stuart Longland (1):
      ASoC: Update Freescale i.MX SSI driver DMA parameter handling

 sound/soc/codecs/wm8350.c       |    4 ++--
 sound/soc/codecs/wm8400.c       |   18 +++++++++---------
 sound/soc/codecs/wm8990.c       |   18 +++++++++---------
 sound/soc/imx/imx-pcm-dma-mx2.c |    7 ++++---
 sound/soc/sh/siu_dai.c          |    2 ++
 5 files changed, 26 insertions(+), 23 deletions(-)
