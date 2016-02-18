From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [RFC v4 0/8] ASoC: Add mediatek HDMI codec support
Date: Thu, 18 Feb 2016 15:58:38 +0100
Message-ID: <1455807526-16918-1-git-send-email-p.zabel@pengutronix.de>
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
the mediatek hdmi bridge driver. The accesses to the hcp->eld field are
now locked by a mutex, and I have added a patch to use the hdmi helper
function [2] for N/CTS calculation.

Changes since v3:
 - Add mutex to lock hcp->eld
 - Use helper function for N and CTS calculation

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
  ASoC: mediatek: Add HDMI dai-links in the machine driver

Philipp Zabel (7):
  drm/mediatek: hdmi: Add audio interface to the hdmi-codec driver
  ASoC: mediatek: address dai link array entries by enum
  video: rmk's HDMI notification prototype
  drm/mediatek: hdmi: issue notifications
  ASoC: hdmi-codec: Use HDMI notifications to add jack support
  ASoC: hdmi-codec: Add ELD control
  drm/mediatek: hdmi: use helper function for N and CTS calculation

 .../bindings/sound/mt8173-rt5650-rt5676.txt        |   5 +-
 drivers/gpu/drm/mediatek/Kconfig                   |   1 +
 drivers/gpu/drm/mediatek/mtk_cec.c                 |  11 ++
 drivers/gpu/drm/mediatek/mtk_drm_hdmi_drv.c        | 148 +++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_hdmi.c                |  89 +++++-----
 drivers/gpu/drm/mediatek/mtk_hdmi.h                |  10 +-
 drivers/gpu/drm/mediatek/mtk_hdmi_hw.c             | 179 ++++-----------------
 drivers/gpu/drm/mediatek/mtk_hdmi_hw.h             |   4 +-
 drivers/video/Makefile                             |   2 +-
 drivers/video/hdmi-not.c                           |  61 +++++++
 include/linux/hdmi-not.h                           |  39 +++++
 include/sound/hdmi-codec.h                         |   6 +
 sound/soc/codecs/hdmi-codec.c                      | 123 +++++++++++++-
 sound/soc/mediatek/mt8173-rt5650-rt5676.c          |  66 +++++++-
 14 files changed, 528 insertions(+), 216 deletions(-)
 create mode 100644 drivers/video/hdmi-not.c
 create mode 100644 include/linux/hdmi-not.h

-- 
2.7.0
