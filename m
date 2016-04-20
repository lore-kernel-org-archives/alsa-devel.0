From: Philipp Zabel <p.zabel@pengutronix.de>
Subject: [PATCH v7 0/9] ASoC: MT8173 HDMI codec support
Date: Wed, 20 Apr 2016 10:59:55 +0200
Message-ID: <1461142804-26728-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.4.pengutronix.de (metis.ext.4.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 67D64261B0A
 for <alsa-devel@alsa-project.org>; Wed, 20 Apr 2016 11:00:09 +0200 (CEST)
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
Cc: Jean-Francois Moine <moinejf@free.fr>, Koro Chen <koro.chen@mediatek.com>, Lars-Peter Clausen <lars@metafoo.de>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Philipp Zabel <p.zabel@pengutronix.de>, Arnaud Pouliquen <arnaud.pouliquen@st.com>, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Cawa Cheng <cawa.cheng@mediatek.com>, Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org, Daniel Kurtz <djkurtz@chromium.org>, kernel@pengutronix.de, PC Liao <pc.liao@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>
List-Id: alsa-devel@alsa-project.org

Since the hdmi-codec patches are now applied [1], I have merged the
hdmi-codec interface into the initial MT8173 HDMI [2] driver submission.
This series now only enables the HDMI dai-links in the mt8173-rt5650-rt5676
and mt8173-rt5650 machine drivers and adds hdmi-codec ELD support and
the still up in the air hdmi notifications between DRM encoder driver and
hdmi-codec.

Changes since v6:
 - Dropped "drm/mediatek: hdmi: Add audio interface to the hdmi-codec driver",
   patch now merged into MT8173 HDMI encoder patch.
 - Fixed jack detection in case HDMI is already connected at boot and the
   hdmi-codec driver registers the notifier block after the HDMI_CONNECTED
   notification is issued.

[1] commit 09184118a8ab ("ASoC: hdmi-codec: Add hdmi-codec for external HDMI-encoders")
    of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/hdmi
The mediatek drm patches apply on top of
[2] https://patchwork.kernel.org/patch/8887051/ ("drm/mediatek: Add HDMI support")
and need this patch:
[3] https://patchwork.kernel.org/patch/8091531/ ("video: hdmi: add helper function for N and CTS")

regards
Philipp

Koro Chen (1):
  ASoC: mediatek: Add HDMI dai-links in the mt8173-rt5650-rt5676 machine
    driver

PC Liao (1):
  ASoC: mediatek: Add HDMI dai-links to the mt8173-rt5650 machine driver

Philipp Zabel (7):
  ASoC: hdmi-codec: Add ELD control
  video: rmk's HDMI notification prototype
  ASoC: hdmi-codec: Use HDMI notifications to add jack support
  ASoC: mediatek: Add jack detection support to mt8173-rt5650-rt5676
    machine driver
  ASoC: mediatek: Add jack detection support to the mt8173-rt5650
    machine driver
  drm/mediatek: hdmi: issue notifications
  drm/mediatek: hdmi: use helper function for N and CTS calculation

 .../bindings/sound/mt8173-rt5650-rt5676.txt        |   5 +-
 .../devicetree/bindings/sound/mt8173-rt5650.txt    |   5 +-
 drivers/gpu/drm/mediatek/mtk_cec.c                 |  11 ++
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  88 ++++-----------
 drivers/video/Kconfig                              |   3 +
 drivers/video/Makefile                             |   1 +
 drivers/video/hdmi-notifier.c                      |  61 ++++++++++
 include/linux/hdmi-notifier.h                      |  44 ++++++++
 include/sound/hdmi-codec.h                         |   6 +
 sound/soc/codecs/Kconfig                           |   1 +
 sound/soc/codecs/hdmi-codec.c                      | 124 +++++++++++++++++++--
 sound/soc/mediatek/Kconfig                         |   2 +
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |  48 ++++++++
 sound/soc/mediatek/mt8173-rt5650.c                 |  47 ++++++++
 14 files changed, 370 insertions(+), 76 deletions(-)
 create mode 100644 drivers/video/hdmi-notifier.c
 create mode 100644 include/linux/hdmi-notifier.h

-- 
2.8.0.rc3
