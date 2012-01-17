From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.3
Date: Tue, 17 Jan 2012 16:54:18 +0000
Message-ID: <20120117165418.GK2944@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BBF56103A33
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 17:54:32 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

The following changes since commit 29abceb67f8a230da806db4ed73899595bd2ae76:

  Merge branch 'for-3.3' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound into topic/asoc (2012-01-12 09:48:20 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.3

All small, easily reviewed fixes.

Javier Martin (1):
      ASoC: Fix DMA channel leak in imx-pcm-dma-mx2 driver.

Liam Girdwood (2):
      ASoC: dapm - Fix check for codec context in dapm_power_widgets().
      ASoC: core - Free platform DAPM context at platform removal.

Mark Brown (1):
      ASoC: Wait for WM8993 FLL to stabilise

Zeng Zhaoming (1):
      ASoC: sgtl5000: update author email address

 sound/soc/codecs/sgtl5000.c     |    2 +-
 sound/soc/codecs/wm8993.c       |    6 ++++++
 sound/soc/imx/imx-pcm-dma-mx2.c |   12 +++++++-----
 sound/soc/soc-core.c            |    4 ++++
 sound/soc/soc-dapm.c            |    2 +-
 5 files changed, 19 insertions(+), 7 deletions(-)
