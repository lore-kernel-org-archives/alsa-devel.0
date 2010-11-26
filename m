From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 0/4] Fixes resource leaks for Samsung SoCs
Date: Fri, 26 Nov 2010 14:50:45 +0800
Message-ID: <1290754245.25125.1.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chanwoo Choi <cw00.choi@samsung.com>, Graeme Gregory <graeme@openmoko.org>, Maurus Cuelenaere <mcuelenaere@gmail.com>, Seungwhan Youn <sw.youn@samsung.com>, Jassi Brar <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This serial of patches fixes resource leaks for Samsung SoCs.

Axel Lin (4):
  ASoC: Fix resource leask in goni_wm8994.c
  ASoC: Fix resource leask in neo1973_gta02_init() error path
  ASoC: Add missing gpio_free(S3C64XX_GPK(12)) in smartq_exit()
  ASoC: Fix resource leask in smdk_spdif.c

 sound/soc/samsung/goni_wm8994.c          |    9 +++++++--
 sound/soc/samsung/neo1973_gta02_wm8753.c |   22 +++++++++++-----------
 sound/soc/samsung/smartq_wm8987.c        |    1 +
 sound/soc/samsung/smdk_spdif.c           |   13 +++++++++----
 4 files changed, 28 insertions(+), 17 deletions(-)

-- 
1.7.2
