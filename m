From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v8 0/5] ASoC: MT8173 HDMI jack detection
Date: Thu, 11 Aug 2016 11:20:22 +0200
Message-ID: <1470907227-899-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id B9392266A7B
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 11:20:40 +0200 (CEST)
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, Hans Verkuil <hans.verkuil@cisco.com>, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mediatek@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

now that kernel v4.8-rc1 is released and includes the new CEC framework in
drivers/staging/media/cec, I wonder how to proceed with this. To allow the
ASoC drivers to present HDMI cable connection state as an ALSA jack, and
to allow them to update sink capabilities when it signals an EDID change,
we need a notification mechanism between CEC/HDMI, and ALSA drivers.

I had used Russell's hdmi notification prototype to let the CEC/HDMI
drivers notify the hdmi-codec and ASoC machine drivers of changes. The
mtk_cec driver currently is just a placeholder that only handles the HPD
interrupts.

Should the notifications be integrated with the CEC framework for those
devices that do have CEC support?

Changes since v7 ("ASoC: MT8173 HDMI codec support"):
 - Dropped the already applied ELD control and machine driver patches
 - Dropped the N/CTS helper patch for now, as the helpers don't exist yet.
 - Lock ELD mutex while copying ELD in hdmi_eld_ctl_get

regards
Philipp

Philipp Zabel (5):
  video: rmk's HDMI notification prototype
  ASoC: hdmi-codec: Use HDMI notifications to add jack support
  ASoC: mediatek: Add jack detection support to mt8173-rt5650-rt5676
    machine driver
  ASoC: mediatek: Add jack detection support to the mt8173-rt5650
    machine driver
  drm/mediatek: hdmi: issue notifications

 drivers/gpu/drm/mediatek/mtk_cec.c               | 11 +++
 drivers/gpu/drm/mediatek/mtk_hdmi.c              |  3 +
 drivers/video/Kconfig                            |  3 +
 drivers/video/Makefile                           |  1 +
 drivers/video/hdmi-notifier.c                    | 61 ++++++++++++++++
 include/linux/hdmi-notifier.h                    | 44 ++++++++++++
 include/sound/hdmi-codec.h                       |  6 ++
 sound/soc/codecs/Kconfig                         |  1 +
 sound/soc/codecs/hdmi-codec.c                    | 88 +++++++++++++++++++++---
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c | 21 ++++++
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        | 21 ++++++
 11 files changed, 252 insertions(+), 8 deletions(-)
 create mode 100644 drivers/video/hdmi-notifier.c
 create mode 100644 include/linux/hdmi-notifier.h

-- 
2.8.1
