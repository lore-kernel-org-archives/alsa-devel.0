From: Garlic Tseng <garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [alsa-devel] [PATCH 0/7] ASoC: Mediatek: Add support for MT2701 SOC
Date: Fri, 29 Apr 2016 21:00:41 +0800
Message-ID: <1461934848-60011-1-git-send-email-garlic.tseng@mediatek.com>
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
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ir.lian-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, PC.Liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds basic support for Mediatek AFE for MT2701 SoC.
The patch is based on broonie tree "for-next" branch.

Change since RFC v2:
add BT function
refine Kconfig and Makefile
add prefix 'mt8173' and 'mt2701' for relative drivers.

Garlic Tseng (7):
  ASoC: mediatek: Refine mt8173 driver and change config option
  ASoC: mediatek: add documents for mt2701
  ASoC: mediatek: add clock and irq control for 2701 platform driver
  ASoC: mediatek: add mt2701 platform driver implementation.
  ASoC: bt-sco: extend rate and add a general compatible string
  ASoC: mediatek: add BT implementation
  ASoC: mediatek: Add mt2701-cs42448 driver and config option.

 Documentation/devicetree/bindings/sound/bt-sco.txt |    2 +-
 .../devicetree/bindings/sound/mt2701-afe-pcm.txt   |  150 ++
 .../devicetree/bindings/sound/mt2701-cs42448.txt   |   43 +
 sound/soc/codecs/bt-sco.c                          |    5 +-
 sound/soc/mediatek/Kconfig                         |   35 +-
 sound/soc/mediatek/Makefile                        |    9 +-
 sound/soc/mediatek/mt2701/Makefile                 |   20 +
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c  |  344 ++++
 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h  |   33 +
 sound/soc/mediatek/mt2701/mt2701-afe-common.h      |  228 +++
 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c         | 1825 ++++++++++++++++++++
 sound/soc/mediatek/mt2701/mt2701-cs42448.c         |  412 +++++
 sound/soc/mediatek/mt2701/mt2701-irq.c             |   74 +
 sound/soc/mediatek/mt2701/mt2701-irq.h             |   26 +
 sound/soc/mediatek/mt2701/mt2701-reg.h             |  195 +++
 sound/soc/mediatek/mt8173/Makefile                 |    7 +
 sound/soc/mediatek/mt8173/mt8173-afe-common.h      |  101 ++
 .../{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c}     |  488 +++---
 sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c  |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c   |    2 +-
 .../mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c   |    4 +-
 sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c    |    2 +-
 sound/soc/mediatek/mtk-afe-common.h                |  101 --
 23 files changed, 3740 insertions(+), 368 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt2701-cs42448.txt
 create mode 100644 sound/soc/mediatek/mt2701/Makefile
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-clock-ctrl.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-common.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-cs42448.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-irq.c
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-irq.h
 create mode 100644 sound/soc/mediatek/mt2701/mt2701-reg.h
 create mode 100644 sound/soc/mediatek/mt8173/Makefile
 create mode 100644 sound/soc/mediatek/mt8173/mt8173-afe-common.h
 rename sound/soc/mediatek/{mtk-afe-pcm.c => mt8173/mt8173-afe-pcm.c} (67%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-max98090.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5514.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650-rt5676.c (99%)
 rename sound/soc/mediatek/{ => mt8173}/mt8173-rt5650.c (99%)
 delete mode 100644 sound/soc/mediatek/mtk-afe-common.h

-- 
1.9.1
