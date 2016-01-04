From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [RFC v2 0/6] ASoC: Add mediatek HDMI codec support
Date: Mon,  4 Jan 2016 20:09:05 +0100
Message-ID: <1451934551-21333-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 104582604DF
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 20:09:13 +0100 (CET)
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

this time we add an interface for Jyri's generic hdmi-codec driver [1] to
the mediatek hdmi bridge driver. In place of a separate machine driver,
the existing mt8173-rt5650-rt5676 driver is extended to link to the
hdmi-codec instance provided by the hdmi bridge driver.

The alsa jack support, previously implemented by the custom mediatek hdmi
codec and machine drivers, is bolted on top of hdmi-codec using Russell's
HDMI notifier prototype. It's all still a bit rough, but I could use some
feedback at this point. Have we achieved consensus to go forward with the
hdmi-codec approach? Is it ok to use an alsa jack for HDMI HPD status
reporting?

The mediatek drm patches apply on top of
https://patchwork.kernel.org/patch/7949021/ ("drm/mediatek: Add HDMI support")
the asoc patches depend on these two patches:
https://patchwork.kernel.org/patch/7215121/ ("ALSA: pcm: add IEC958 channel status helper for hw_params")
[1] https://patchwork.kernel.org/patch/7215271/ ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")

best regards
Philipp

Koro Chen (1):
  ASoC: mediatek: Add HDMI dai-links in the machine driver

Philipp Zabel (5):
  drm/mediatek: hdmi: Add audio interface to the hdmi-codec driver
  ASoC: mediatek: address dai link array entries by enum
  video: rmk's HDMI notification prototype
  drm/mediatek: hdmi: issue notifications
  ASoC: hdmi-codec: Use HDMI notifications to add jack support

 .../bindings/sound/mt8173-rt5650-rt5676.txt        |   5 +-
 drivers/gpu/drm/mediatek/Kconfig                   |   1 +
 drivers/gpu/drm/mediatek/mtk_cec.c                 |   5 +
 drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c        | 192 +++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  26 +++
 drivers/gpu/drm/mediatek/mtk_hdmi.h                |   4 +
 drivers/video/Makefile                             |   2 +-
 drivers/video/hdmi-not.c                           |  61 +++++++
 include/linux/hdmi-not.h                           |  39 +++++
 include/sound/hdmi-codec.h                         |   6 +
 sound/soc/codecs/hdmi-codec.c                      |  72 +++++++-
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |  66 ++++++-
 12 files changed, 470 insertions(+), 9 deletions(-)
 create mode 100644 drivers/video/hdmi-not.c
 create mode 100644 include/linux/hdmi-not.h

-- 
2.6.2
