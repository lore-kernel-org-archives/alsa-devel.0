From: Shunli Wang <shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/4] ASoC: Mediatek: MT8183: Add support for machine driver
 with DA7219 or TS3A227
Date: Fri, 29 Mar 2019 16:34:45 +0800
Message-ID: <1553848489-27926-1-git-send-email-shunli.wang@mediatek.com>
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
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, garlic.tseng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, shunli.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, kaichieh.chuang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

ASoC: Mediatek: MT8183: Add support for machine driver with DA7219 or TS3A227

Shunli Wang (4):
  ASoC: Mediatek: MT8183: Add machine driver with TS3A227
  ASoC: Mediatek: Add document for mt8183-mt6358-ts3a227-max98357
  ASoC: Mediatek: MT8183: Add machine driver with DA7219
  ASoC: Mediatek: Add document for mt8183-da7219-max98357

 .../bindings/sound/mt8183-da7219-max98357.txt      |  15 +
 .../sound/mt8183-mt6358-ts3a227-max98357.txt       |  15 +
 sound/soc/mediatek/Kconfig                         |  26 ++
 sound/soc/mediatek/mt8183/Makefile                 |   2 +
 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c | 472 +++++++++++++++++++++
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c        | 382 +++++++++++++++++
 6 files changed, 912 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-da7219-max98357.txt
 create mode 100644 Documentation/devicetree/bindings/sound/mt8183-mt6358-ts3a227-max98357.txt
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-da7219-max98357.c
 create mode 100644 sound/soc/mediatek/mt8183/mt8183-mt6358-ts3a227-max98357.c

-- 
1.9.1
