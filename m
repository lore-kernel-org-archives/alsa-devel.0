From: Xiubo Li <lixiubo@cmss.chinamobile.com>
Subject: [PATCH 0/2] ASoC: fsl: Use usleep_range() instead of msleep()
Date: Fri, 15 Jan 2016 19:35:23 +0800
Message-ID: <1452857725-32414-1-git-send-email-lixiubo@cmss.chinamobile.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Xiubo Li <lixiubo@cmss.chinamobile.com>
List-Id: alsa-devel@alsa-project.org

Xiubo Li (2):
  ASoC: fsl_sai: Use usleep_range() instead of msleep()
  ASoC: fsl-mpc5200: Use usleep_range() instead of msleep()

 sound/soc/fsl/fsl_sai.c          | 3 ++-
 sound/soc/fsl/mpc5200_psc_ac97.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
1.8.3.1
