From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH v2 0/2] Add support for select accessory detect
 mode to HPDETL or HPDETR
Date: Tue, 21 Apr 2015 13:11:43 +0900
Message-ID: <1429589505-11954-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, cw00.choi@samsung.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, Inha Song <ideal.song@samsung.com>
List-Id: alsa-devel@alsa-project.org

This set of patches adds support for select accessory detect mode to HPDETL or HPDETR.

Changes in v2:
  - Use the value in pdata instead of hpdet_channel in extcon_info.
  - Wrap arizona_extcon_of_get in IS_ENABLED(CONFIG_OF).
  - Change hpdet_channel type to unsigned from signed in pdata.
  - Move ARIZONA_ACCDET_MODE_* define to dt-binding header and directly set it to pdata.

Inha Song (2):
  extcon: arizona: Add support for select accessory detect mode when
    headphone detection
  mfd: arizona: Update DT binding to support hpdet channel

 Documentation/devicetree/bindings/mfd/arizona.txt |  6 +++++
 drivers/extcon/extcon-arizona.c                   | 28 ++++++++++++++++-------
 include/dt-bindings/mfd/arizona.h                 |  8 +++++++
 include/linux/mfd/arizona/pdata.h                 |  3 +++
 4 files changed, 37 insertions(+), 8 deletions(-)
 create mode 100644 include/dt-bindings/mfd/arizona.h

-- 
2.0.0.390.gcb682f8
