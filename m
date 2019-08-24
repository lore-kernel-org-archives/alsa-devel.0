From: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH v2 0/3] ASoC: mediatek: mt8183: fix mt8183-mt6358 tdm out
 issues
Date: Sat, 24 Aug 2019 12:37:22 +0800
Message-ID: <1566621445-26989-1-git-send-email-jiaxin.yu@mediatek.com>
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
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eason.yen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org


v2: 
	1. Base on branch asoc-next that merged branch 'asoc-5.4'.
	2. Split the PATCH 2/2 that in v1 into three patches.

v1: 
	1. Base on branch asoc-next that merged branch 'asoc-5.3'.
	2. Mark suggest the patch would be split up into separate patches,
	   each fixing single issue.
	3. PATCH 1/2 has been applied to the asoc tree 'asoc-5.4'.

Jiaxin Yu (3):
  ASoC: mediatek: mt8183: fix tdm out data align issue
  ASoC: mediatek: mt8183: tdm hw support tdm out and 8ch i2s out
  ASoC: mediatek: mt8183: fix tdm out data is valid on rising edge

 sound/soc/mediatek/common/mtk-afe-fe-dai.c    |   3 +-
 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c    | 177 ++++++++++++++----
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c   |   3 +
 sound/soc/mediatek/mt8183/mt8183-reg.h        |   8 +-
 4 files changed, 152 insertions(+), 39 deletions(-)

-- 
2.18.0
