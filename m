From: KaiChieh Chuang <kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [RFC PATCH V2 0/2] ASoC: mediatek: add btcvsd driver
Date: Wed, 30 Jan 2019 14:47:09 +0800
Message-ID: <1548830831-17387-1-git-send-email-kaichieh.chuang@mediatek.com>
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
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

The driver function for transferring/receiving
BT encoded data to/from BT hardware.

V2:
	prevent noisy log, dev_info -> dev_dbg
	use simple number control for Switch control

*** BLURB HERE ***

KaiChieh Chuang (2):
  ASoC: mediatek: add btcvsd driver
  ASoC: mediatek: add documents for btcvsd driver

 .../bindings/sound/mtk-btcvsd-snd.txt         |   24 +
 sound/soc/mediatek/Kconfig                    |    9 +
 sound/soc/mediatek/common/Makefile            |    2 +
 sound/soc/mediatek/common/mtk-btcvsd.c        | 1364 +++++++++++++++++
 4 files changed, 1399 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mtk-btcvsd-snd.txt
 create mode 100644 sound/soc/mediatek/common/mtk-btcvsd.c

-- 
2.18.0
