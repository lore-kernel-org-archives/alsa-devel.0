From: Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v9 0/3] ASoC: MT8173 HDMI jack detection
Date: Tue, 15 Nov 2016 19:52:37 +0100
Message-ID: <1479235960-23696-1-git-send-email-p.zabel@pengutronix.de>
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
Cc: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>, Koro Chen <koro.chen-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Arnaud Pouliquen <arnaud.pouliquen-qxv4g6HH51o@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Cawa Cheng <cawa.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hans Verkuil <hans.verkuil-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, PC Liao <pc.liao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi,

now that a new HDMI state notifier RFC has been posted [1], I've updated this
series to use it instead of the previous prototype. I've also sent the
drm/mediatek part of this series separately [2], which is needed to actually
generate the events the hdmi-codec driver listens for.

Changes since v8:
 - Dropped the HDMI notification prototype patch
 - Rebased onto the "video: add HDMI state notifier support" patch by
   Hans Verkuil, based on Russell King's earlier version.
 - Dropped the drm/mediatek patch

regards
Philipp

[1] https://patchwork.linuxtv.org/patch/38109/
[2] https://patchwork.kernel.org/patch/9430337/

Philipp Zabel (3):
  ASoC: hdmi-codec: use HDMI state notifier to add jack support
  ASoC: mediatek: Add jack detection support to mt8173-rt5650-rt5676
    machine driver
  ASoC: mediatek: Add jack detection support to the mt8173-rt5650
    machine driver

 include/sound/hdmi-codec.h                       |   7 ++
 sound/soc/codecs/Kconfig                         |   1 +
 sound/soc/codecs/hdmi-codec.c                    | 107 +++++++++++++++++++++--
 sound/soc/mediatek/mt8173/mt8173-rt5650-rt5676.c |  42 +++++++++
 sound/soc/mediatek/mt8173/mt8173-rt5650.c        |  42 +++++++++
 5 files changed, 191 insertions(+), 8 deletions(-)

-- 
2.10.2
