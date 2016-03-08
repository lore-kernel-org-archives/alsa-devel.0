From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v6 00/10] ASoC: Add mediatek HDMI codec support
Date: Tue,  8 Mar 2016 14:31:39 +0100
Message-ID: <1457443909-14807-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id C10FE260524
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2016 14:31:56 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

these patches add an interface for Jyri's generic hdmi-codec driver [1] to
the mediatek hdmi bridge driver. This version fixes the hdmi-codec
notification patch and splits the jack support out of the ASoC machine
driver patches.

Changes since v5:
 - select SND_SOC_HDMI_CODEC and HDMI_NOTIFIERS where appropriate
 - split out jack support from machine driver patches
 - fix include of hdmi-notifier.h in hdmi-codec notification support
 - Drop applied patch: commit 05f5afd3f0d9 ("ASoC: mediatek: address dai
   link array entries by enum")

The mediatek drm patches apply on top of
https://patchwork.kernel.org/patch/8534251/ ("drm/mediatek: Add HDMI support"),
and need this patch:
[2] https://patchwork.kernel.org/patch/8091531/ ("video: hdmi: add helper function for N and CTS")
The asoc patches depend on these two patches:
https://patchwork.kernel.org/patch/7215121/ ("ALSA: pcm: add IEC958 channel status helper for hw_params")
[1] https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")

regards
Philipp

Koro Chen (1):
  ASoC: mediatek: Add HDMI dai-links in the mt8173-rt5650-rt5676 machine
    driver

PC Liao (1):
  ASoC: mediatek: Add HDMI dai-links to the mt8173-rt5650 machine driver

Philipp Zabel (8):
  drm/mediatek: hdmi: Add audio interface to the hdmi-codec driver
  video: rmk's HDMI notification prototype
  drm/mediatek: hdmi: issue notifications
  ASoC: hdmi-codec: Use HDMI notifications to add jack support
  ASoC: hdmi-codec: Add ELD control
  drm/mediatek: hdmi: use helper function for N and CTS calculation
  ASoC: mediatek: Add jack detection support to mt8173-rt5650-rt5676
    machine driver
  ASoC: mediatek: Add jack detection support to the mt8173-rt5650
    machine driver

 .../bindings/sound/mt8173-rt5650-rt5676.txt        |   5 +-
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |   5 +-
 drivers/gpu/drm/mediatek/Kconfig                   |   1 +
 drivers/gpu/drm/mediatek/mtk_cec.c                 |  11 ++
 drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c        | 148 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  89 +++++-----
 drivers/gpu/drm/mediatek/mtk_hdmi.h                |  10 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_hw.c             | 179 ++++-----------------
 drivers/gpu/drm/mediatek/mtk_hdmi_hw.h             |   4 +-
 drivers/video/Kconfig                              |   3 +
 drivers/video/Makefile                             |   1 +
 drivers/video/hdmi-notifier.c                      |  61 +++++++
 include/linux/hdmi-notifier.h                      |  44 +++++
 include/sound/hdmi-codec.h                         |   6 +
 sound/soc/codecs/Kconfig                           |   1 +
 sound/soc/codecs/hdmi-codec.c                      | 123 +++++++++++++-
 sound/soc/mediatek/Kconfig                         |   2 +
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |  48 ++++++
 sound/soc/mediatek/mt8173-rt5650.c                 |  47 ++++++
 19 files changed, 576 insertions(+), 212 deletions(-)
 create mode 100644 drivers/video/hdmi-notifier.c
 create mode 100644 include/linux/hdmi-notifier.h

-- 
2.7.0
