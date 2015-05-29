From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v3 0/6] Support ZTE zx296702 SPDIF/I2S
Date: Fri, 29 May 2015 21:31:15 +0800
Message-ID: <1432906281-27698-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 by alsa0.perex.cz (Postfix) with ESMTP id 8877A26068F
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 15:31:41 +0200 (CEST)
Received: by padbw4 with SMTP id bw4so59551244pad.0
 for <alsa-devel@alsa-project.org>; Fri, 29 May 2015 06:31:40 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, shawn.guo@linaro.org, wan.zhijun@zte.com.cn, Jun Nie <jun.nie@linaro.org>
List-Id: alsa-devel@alsa-project.org

Changes vs v2:
  - remove pcm dma driver and merge the related call into DAI driver
  - Add zx HDMI codec with direct HDMI function call
  - Other typo and minor fix

Jun Nie (6):
  dt: Add documentation for the ZTE SPDIF controller
  dt: Add documentation for the ZTE I2S controller
  dt: Add doc for the ZTE HDMI audio codec binding
  ASoC: zx: Add zx296702 SPDIF support
  ASoC: zx: Add ZTE zx296702 I2S DAI driver
  ASoC: zx: add zx296702 hdmi codec

 .../devicetree/bindings/sound/zte,zx-hdmi.txt      |  10 +
 .../devicetree/bindings/sound/zte,zx-i2s.txt       |  44 +++
 .../devicetree/bindings/sound/zte,zx-spdif.txt     |  28 ++
 include/sound/zx_hdmi_audio.h                      |   7 +
 sound/soc/Kconfig                                  |   1 +
 sound/soc/Makefile                                 |   1 +
 sound/soc/codecs/Kconfig                           |   3 +
 sound/soc/codecs/Makefile                          |   1 +
 sound/soc/codecs/zx296702_hdmi.c                   | 121 ++++++
 sound/soc/zte/Kconfig                              |  17 +
 sound/soc/zte/Makefile                             |   2 +
 sound/soc/zte/zx296702-i2s.c                       | 437 +++++++++++++++++++++
 sound/soc/zte/zx296702-spdif.c                     | 370 +++++++++++++++++
 13 files changed, 1042 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-hdmi.txt
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-i2s.txt
 create mode 100644 Documentation/devicetree/bindings/sound/zte,zx-spdif.txt
 create mode 100644 include/sound/zx_hdmi_audio.h
 create mode 100644 sound/soc/codecs/zx296702_hdmi.c
 create mode 100644 sound/soc/zte/Kconfig
 create mode 100644 sound/soc/zte/Makefile
 create mode 100644 sound/soc/zte/zx296702-i2s.c
 create mode 100644 sound/soc/zte/zx296702-spdif.c

-- 
1.9.1
