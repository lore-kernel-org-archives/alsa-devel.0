From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/8] ASoC: jack: Manage gpios via devres
Date: Tue, 22 Aug 2017 13:59:43 +0200
Message-ID: <20170822115951.6679-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 77FB62675DD
 for <alsa-devel@alsa-project.org>; Tue, 22 Aug 2017 13:59:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

while debugging the recent GPIO regression with (still not-merged)
cx2072x codec driver, I noticed the driver misses the 
snd_soc_jack_free_gpios() call.

This patch set is rather making it redundant, change the ASoC jack
code to manage gpios via devres.  It follows the cleanups of
superfluous snd_soc_jack_free_gpios() in each driver.  This resulted
in lots of reductions of remove callbacks.


Takashi

===

Takashi Iwai (8):
  ASoC: jack: Manage gpios via devres
  ASoC: fsl: Remove superfluous snd_soc_jack_free_gpios() call
  ASoC: simple-card: Remove superfluous snd_soc_jack_free_gpios() call
  ASoC: intel: Remove superfluous snd_soc_jack_free_gpios() call
  ASoC: omap: Remove superfluous snd_soc_jack_free_gpios() call
  ASoC: pxa: Remove superfluous snd_soc_jack_free_gpios() call
  ASoC: samsung: Remove superfluous snd_soc_jack_free_gpios() call
  ASoC: tegra: Remove superfluous snd_soc_jack_free_gpios() call

 sound/soc/fsl/imx-es8328.c            |  3 --
 sound/soc/generic/simple-card.c       | 10 -------
 sound/soc/intel/boards/byt-max98090.c | 12 --------
 sound/soc/omap/ams-delta.c            | 10 -------
 sound/soc/omap/omap-twl4030.c         | 13 ---------
 sound/soc/omap/rx51.c                 |  9 ------
 sound/soc/pxa/hx4700.c                |  8 ------
 sound/soc/samsung/h1940_uda1380.c     |  9 ------
 sound/soc/samsung/rx1950_uda1380.c    | 10 -------
 sound/soc/samsung/smartq_wm8987.c     |  9 ------
 sound/soc/soc-jack.c                  | 52 +++++++++++++++++++++++++++--------
 sound/soc/tegra/tegra_alc5632.c       | 13 ---------
 sound/soc/tegra/tegra_max98090.c      | 18 ------------
 sound/soc/tegra/tegra_rt5640.c        | 13 ---------
 sound/soc/tegra/tegra_rt5677.c        | 18 ------------
 sound/soc/tegra/tegra_wm8903.c        |  5 ----
 16 files changed, 41 insertions(+), 171 deletions(-)

-- 
2.14.0
