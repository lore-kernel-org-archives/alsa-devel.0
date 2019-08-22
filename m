From: Jiaxin Yu <jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: [PATCH 0/2] ASoC: MediaTek: fix mt8183-mt6358 tdm out issues
Date: Thu, 22 Aug 2019 20:50:59 +0800
Message-ID: <1566478261-13464-1-git-send-email-jiaxin.yu@mediatek.com>
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
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, ck.hu-c+3QU6Y0cdFWk0Htik3J/w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jiaxin.yu-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tzungbi-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, eason.yen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

These two patches are used to fix several issues related to TDM OUT.
The patches are based on broonie tre "for-next" branch.

Jiaxin Yu (2):
  ASoC: mediatek: mt8183: switch tdm pins gpio function when playback on
    or off
  ASoC: mediatek: mt8183: fix tdm out issue

 sound/soc/mediatek/common/mtk-afe-fe-dai.c         |   3 +-
 sound/soc/mediatek/mt8183/mt8183-dai-tdm.c         | 177 +++++++++++++++++----
 .../mt8183/mt8183-mt6358-ts3a227-max98357.c        | 118 +++++++++++++-
 sound/soc/mediatek/mt8183/mt8183-reg.h             |   8 +-
 4 files changed, 261 insertions(+), 45 deletions(-)

-- 
1.8.1.1.dirty
