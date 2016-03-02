From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v5 0/9] ASoC: Add mediatek HDMI codec support
Date: Wed,  2 Mar 2016 15:49:04 +0100
Message-ID: <1456930153-11853-1-git-send-email-p.zabel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mediatek/>
List-Post: <mailto:linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mediatek>,
 <mailto:linux-mediatek-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-mediatek" <linux-mediatek-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-mediatek-bounces+glpam-linux-mediatek=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Hi,

these patches add an interface for Jyri's generic hdmi-codec driver [1] to
the mediatek hdmi bridge driver. Since there haven't been many comments
after the last submission, the patches are mostly unchanged. A new patch
adds HDMI dai-links to the recently merged mt8173-rt5650 machine driver
and I have updated the HDMI notification patch (and renamed patch 3 to
mention the mt8173-rt5650-rt5676 machine driver).

Changes since v4:
 - Update hdmi notifier to latest version
 - Added HDMI dai-links to new mt8173-rt5650 machine driver

The mediatek drm patches apply on top of
https://patchwork.kernel.org/patch/8337071/ ("drm/mediatek: Add HDMI support"),
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

Philipp Zabel (7):
  drm/mediatek: hdmi: Add audio interface to the hdmi-codec driver
  ASoC: mediatek: address dai link array entries by enum
  video: rmk's HDMI notification prototype
  drm/mediatek: hdmi: issue notifications
  ASoC: hdmi-codec: Use HDMI notifications to add jack support
  ASoC: hdmi-codec: Add ELD control
  drm/mediatek: hdmi: use helper function for N and CTS calculation

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
 sound/soc/codecs/hdmi-codec.c                      | 123 +++++++++++++-
 sound/soc/mediatek/Kconfig                         |   1 +
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |  66 +++++++-
 sound/soc/mediatek/mt8173-rt5650.c                 |  47 ++++++
 18 files changed, 587 insertions(+), 217 deletions(-)
 create mode 100644 drivers/video/hdmi-notifier.c
 create mode 100644 include/linux/hdmi-notifier.h

-- 
2.7.0
