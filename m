From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v5 0/4] Support ZTE zx296702 SPDIF/I2S
Date: Thu,  4 Jun 2015 21:34:43 +0800
Message-ID: <1433424887-11694-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id A55D62606F9
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:35:09 +0200 (CEST)
Received: by pdjm12 with SMTP id m12so31138701pdj.3
 for <alsa-devel@alsa-project.org>; Thu, 04 Jun 2015 06:35:08 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: jason.liu@linaro.org, alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, Jun Nie <jun.nie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Changes vs v4:
  - Fix devm_zalloc argument issue in SPDIF driver and static issue in i2s.

Changes vs v3:
  - remove HDMI stuff and will add it in video side later
  - Polish SPDIF driver with devm_*

Changes vs v2:
  - remove pcm dma driver and merge the related call into DAI driver
  - Add zx HDMI codec with direct HDMI function call
  - Other typo and minor fix

Jun Nie (4):
  dt: Add documentation for the ZTE SPDIF controller
  dt: Add documentation for the ZTE I2S controller
  ASoC: zx: Add zx296702 SPDIF support
  ASoC: zx: Add ZTE zx296702 I2S DAI driver

 .../devicetree/bindings/sound/zte,zx-i2s.txt       |  44 +++
 .../devicetree/bindings/sound/zte,zx-spdif.txt     |  28 ++
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/zte/Kconfig                              |  17 +
 sound/soc/zte/Makefile                             |   2 +
 sound/soc/zte/zx296702-i2s.c                       | 437 +++++++++++++++++++++
 sound/soc/zte/zx296702-spdif.c                     | 370 +++++++++++++++++
 8 files changed, 900 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-spdif.txt
 create mode 100644 sound/soc/zte/Kconfig
 create mode 100644 sound/soc/zte/Makefile
 create mode 100644 sound/soc/zte/zx296702-i2s.c
 create mode 100644 sound/soc/zte/zx296702-spdif.c

-- 
1.9.1
