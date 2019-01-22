From: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/6] ASoC: Mediatek: Add support for MT8183 AoC and MT6358
 Codec
Date: Tue, 22 Jan 2019 14:39:07 +0800
Message-ID: <1548139153-18783-1-git-send-email-shunli.wang@mediatek.com>
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
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, wsd_upstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

This patch adds support for Mediatek AFE for MT8183 SoC and codec for MT8183.
The patch is based on broonie tree "for-next" branch.

Shunli Wang (6):
  ASoC: mediatek: mt8183: add platform driver
  ASoC: mediatek: mt8183: add audio afe document
  ASoC: mediatek: mt6358: add codec driver
  ASoC: mediatek: mt6358: add codec document
  ASoC: mediatek: mt8183: add mt8183-mt6358 machine driver
  ASoC: mediatek: add document for mt8183-mt6358

 Documentation/devicetree/bindings/sound/mt6358.txt |   18 +
 .../devicetree/bindings/sound/mt8183-afe-pcm.txt   |   36 +
 .../devicetree/bindings/sound/mt8183-mt6358.txt    |   12 +
 sound/soc/codecs/Kconfig                           |    7 +
 sound/soc/codecs/Makefile                          |    2 +
 sound/soc/codecs/mt6358.c                          | 2336 ++++++++++++++++++++
 sound/soc/codecs/mt6358.h                          | 2314 +++++++++++++++++++
 sound/soc/mediatek/Kconfig                         |   20 +
 sound/soc/mediatek/Makefile                        |    1 +
 sound/soc/mediatek/mt8183/Makefile                 |   13 +
 sound/soc/mediatek/mt8183/mt8183-afe-clk.c         |  611 +++++
 sound/soc/mediatek/mt8183/mt8183-afe-clk.h         |   38 +
 sound/soc/mediatek/mt8183/mt8183-afe-common.h      |  108 +
 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c         | 1237 +++++++++++
 sound/soc/mediatek/mt8183/mt8183-dai-adda.c        |  501 +++++
 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c    |  118 +
 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c         | 1040 +++++++++
 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c         |  318 +++
 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c         |  639 ++++++
 sound/soc/mediatek/mt8183/mt8183-interconnection.h |   33 +
 sound/soc/mediatek/mt8183/mt8183-mt6358.c          |  208 ++
 sound/soc/mediatek/mt8183/mt8183-reg.h             | 1666 ++++++++++++++
 22 files changed, 11276 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt6358.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-afe-pcm.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-mt6358.txt
 create mode 100644 sound/soc/codecs/mt6358.c
 create mode 100644 sound/soc/codecs/mt6358.h
 create mode 100644 sound/soc/mediatek/mt8183/Makefile
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-clk.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-common.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-afe-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-adda.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-hostless.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-i2s.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-pcm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-interconnection.h
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-mt6358.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-reg.h

-- 
1.9.1
