From: Padmavathi Venna <padma.v@samsung.com>
Subject: [PATCH 0/2] ASOC: SAMSUNG: Add dt support for i2s
Date: Wed, 25 Jul 2012 17:39:28 +0530
Message-ID: <1343218170-30483-1-git-send-email-padma.v@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org
Cc: padma.v@samsung.com, rcsekar@samsung.com, sbkim73@samsung.com, sangsu4u.park@samsung.com, ben-linux@fluff.org, kgene.kim@samsung.com, olofj@google.com, thutt@chromium.org, joshi@samsung.com
List-Id: alsa-devel@alsa-project.org

This patch series adds device tree based discovery support for Samsung's
i2s controller. This is tested on Exynos5250 with 8994 codec for playback
and capturing modes on 3.5.0-rc7

Padmavathi Venna (2):
  ASOC: SAMSUNG: Add DT support for i2s
  ASOC: SAMSUNG: Add dma_prop variable in s3c_dma_params

 .../devicetree/bindings/sound/samsung-i2s.txt      |   62 ++++++
 sound/soc/samsung/dma.c                            |    1 +
 sound/soc/samsung/dma.h                            |    1 +
 sound/soc/samsung/i2s.c                            |  228 +++++++++++++++-----
 4 files changed, 243 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt

-- 
1.7.4.4
