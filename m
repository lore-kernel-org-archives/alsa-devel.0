From: Daniel Mack <daniel@zonque.org>
Subject: [PATCH 0/7] ASoC: pxa: code refactoring
Date: Wed, 27 Jun 2018 21:33:52 +0200
Message-ID: <20180627193359.26631-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bugwerft.de (mail.bugwerft.de [46.23.86.59])
 by alsa0.perex.cz (Postfix) with ESMTP id 75E8A2679A6
 for <alsa-devel@alsa-project.org>; Wed, 27 Jun 2018 21:34:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org, robert.jarzmik@free.fr, lgirdwood@gmail.com, haojian.zhuang@gmail.com
List-Id: alsa-devel@alsa-project.org

This is a series to clean up the code base in the ASoC/PXA area a bit.
It folds some implementations, removes some files and brings pcm ops to
the CPU DAIS, so they can be used on DT platforms without platform
drivers.

They are a preparation for some more patches that will follow on top.

Daniel Mack (7):
  ASoC: fold pxa2xx-pcm into its only user, pxa2xx-ac97
  ASoC: pxa: clean up function names in pxa2xx-lib
  ASoC: pxa: move some functions to pxa2xx-lib
  ASoC: pxa2xx-pcm-lib: fix indenting
  ASoC: pxa: provide PCM ops for ssp, i2s and ac97 components
  ASoC: pxa: remove bindings from pxa2xx-pcm
  ASoC: pxa: make SND_PXA2XX_SOC_I2S selectable

 .../bindings/sound/mrvl,pxa2xx-pcm.txt        |  15 --
 include/sound/pxa2xx-lib.h                    |  13 +-
 sound/arm/Kconfig                             |   5 -
 sound/arm/Makefile                            |   3 -
 sound/arm/pxa2xx-ac97.c                       | 114 ++++++++++------
 sound/arm/pxa2xx-pcm-lib.c                    |  69 ++++++++--
 sound/arm/pxa2xx-pcm.c                        | 129 ------------------
 sound/arm/pxa2xx-pcm.h                        |  27 ----
 sound/soc/pxa/Kconfig                         |   2 +-
 sound/soc/pxa/pxa-ssp.c                       |   4 +-
 sound/soc/pxa/pxa2xx-ac97.c                   |   3 +
 sound/soc/pxa/pxa2xx-i2s.c                    |   3 +
 sound/soc/pxa/pxa2xx-pcm.c                    |  73 ----------
 13 files changed, 148 insertions(+), 312 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/mrvl,pxa2xx-pcm.txt
 delete mode 100644 sound/arm/pxa2xx-pcm.c
 delete mode 100644 sound/arm/pxa2xx-pcm.h

-- 
2.17.1
