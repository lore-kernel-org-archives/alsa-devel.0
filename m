From: Xiubo Li <Li.Xiubo@freescale.com>
Subject: [PATCH v3 0/3] Add TDM slot info OF parsing supports
Date: Fri, 14 Feb 2014 09:34:33 +0800
Message-ID: <1392341676-4143-1-git-send-email-Li.Xiubo@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, lars@metafoo.de
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, b47053@freescale.com, Xiubo Li <Li.Xiubo@freescale.com>
List-Id: alsa-devel@alsa-project.org

Change in v3:
   - Add .of_xlate_tdm_slot_mask().
   - Add snd_soc_of_xlate_tdm_slot_mask().
   - Remove TDM slot masks OF parsing...
   - Split the TDM infomation into two properties.



Xiubo Li (3):
  ASoC: binding: add tdm-slot.txt
  ASoC: core: add TDM slot parsing from DT supports
  ASoC: simple-card: add slot information parsing supports

 .../devicetree/bindings/sound/simple-card.txt      |  5 ++
 .../devicetree/bindings/sound/tdm-slot.txt         | 20 ++++++++
 include/sound/simple_card.h                        |  2 +
 include/sound/soc-dai.h                            |  2 +
 include/sound/soc.h                                |  3 ++
 sound/soc/generic/simple-card.c                    | 18 +++++++
 sound/soc/soc-core.c                               | 59 ++++++++++++++++++++++
 7 files changed, 109 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tdm-slot.txt

-- 
1.8.4
