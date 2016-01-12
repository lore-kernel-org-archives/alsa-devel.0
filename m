From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [RFC v3 0/7] ASoC: Add mediatek HDMI codec support
Date: Tue, 12 Jan 2016 16:38:09 +0100
Message-ID: <1452613096-8116-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 45BD826040E
 for <alsa-devel@alsa-project.org>; Tue, 12 Jan 2016 16:38:24 +0100 (CET)
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

Hi,

these patches add an interface for Jyri's generic hdmi-codec driver [1] to
the mediatek hdmi bridge driver. I have added an initial connector status
event, made the hdmi bridge driver reuse the hdmi_codec_params that include
the IEC958 channel state, included a fix to allow playback while HDMI is not
connected, and added an ELD mixer control to the hdmi-codec driver.

The mediatek drm patches apply on top of
https://patchwork.kernel.org/patch/8018331/ ("drm/mediatek: Add HDMI support"),
the asoc patches depend on these two patches:
https://patchwork.kernel.org/patch/7215121/ ("ALSA: pcm: add IEC958 channel status helper for hw_params")
[1] https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")

Changes since v2:
 - Pass down and reuse hdmi_codec_params, including the IEC958
   channel state.
 - Fixed hw_params not to fail when no hdmi cable is connected
 - Send an initial notification to set the correct jack state
 - Don't call get_eld, copy the ELD contained in the hdmi_event instead
 - Add an ELD control to the hdmi-codec driver

Koro Chen (1):
  ASoC: mediatek: Add HDMI dai-links in the machine driver

Philipp Zabel (6):
  drm/mediatek: hdmi: Add audio interface to the hdmi-codec driver
  ASoC: mediatek: address dai link array entries by enum
  video: rmk's HDMI notification prototype
  drm/mediatek: hdmi: issue notifications
  ASoC: hdmi-codec: Use HDMI notifications to add jack support
  ASoC: hdmi-codec: Add ELD control

 .../bindings/sound/mt8173-rt5650-rt5676.txt        |   5 +-
 drivers/gpu/drm/mediatek/Kconfig                   |   1 +
 drivers/gpu/drm/mediatek/mtk_cec.c                 |  11 ++
 drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c        | 148 +++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  89 ++++++-------
 drivers/gpu/drm/mediatek/mtk_hdmi.h                |  10 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_hw.c             |  94 ++-----------
 drivers/gpu/drm/mediatek/mtk_hdmi_hw.h             |   4 +-
 drivers/video/Makefile                             |   2 +-
 drivers/video/hdmi-not.c                           |  61 +++++++++
 include/linux/hdmi-not.h                           |  39 ++++++
 include/sound/hdmi-codec.h                         |   6 +
 sound/soc/codecs/hdmi-codec.c                      | 105 ++++++++++++++-
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |  66 ++++++++-
 14 files changed, 496 insertions(+), 145 deletions(-)
 create mode 100644 drivers/video/hdmi-not.c
 create mode 100644 include/linux/hdmi-not.h

-- 
2.6.4
