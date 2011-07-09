From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: ASoC updates for 3.1
Date: Sat, 9 Jul 2011 18:20:26 +0900
Message-ID: <20110709092024.GB14959@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0DA54103847
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 12:36:08 +0200 (CEST)
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

The following changes since commit f187700c2d769bd3160b52f99cc4e747d5c5014b:

  Merge branch 'for-3.1' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6 into topic/asoc (2011-07-05 08:20:19 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound-2.6.git for-3.1

Axel Lin (1):
      ASoC: pxa2xx-pcm: remove unused variable 'dai'

Kuninori Morimoto (1):
      ASoC: ak4642: fixup snd_soc_update_bits mask for PW_MGMT2

Liam Girdwood (4):
      ASoC: core - Add API call to register platform kcontrols.
      ASoC: core - Add platform widget IO
      ASoC: core - Add convenience register for platform kcontrol and DAPM
      ASoC: core - Add platform IO tracing

Mark Brown (3):
      ASoC: Manage WM8731 ACTIVE bit as a supply widget
      ASoC: Manage WM8731 ACTIVE bit as a supply widget
      Merge branch 'for-3.0' into for-3.1

Stephen Warren (1):
      ASoC: Tegra: Implement SPDIF CPU DAI

 include/sound/soc-dapm.h      |    2 +
 include/sound/soc.h           |   12 +
 include/trace/events/asoc.h   |   45 ++++
 sound/soc/codecs/ak4642.c     |    2 +-
 sound/soc/codecs/wm8731.c     |   29 +---
 sound/soc/pxa/pxa2xx-pcm.c    |    1 -
 sound/soc/soc-core.c          |   47 ++++
 sound/soc/soc-dapm.c          |   13 +-
 sound/soc/tegra/Kconfig       |    9 +
 sound/soc/tegra/Makefile      |    2 +
 sound/soc/tegra/tegra_spdif.c |  371 ++++++++++++++++++++++++++++++++
 sound/soc/tegra/tegra_spdif.h |  473 +++++++++++++++++++++++++++++++++++++++++
 12 files changed, 976 insertions(+), 30 deletions(-)
 create mode 100644 sound/soc/tegra/tegra_spdif.c
 create mode 100644 sound/soc/tegra/tegra_spdif.h
