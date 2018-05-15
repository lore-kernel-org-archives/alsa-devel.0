From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH] ASoC: rt5663: rt5663_set_jack_detect() can
	be static
Date: Tue, 15 May 2018 22:53:38 +0800
Message-ID: <20180515145338.GA109360@lkp-ib03>
References: <1526364015-28504-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by alsa0.perex.cz (Postfix) with ESMTP id F0DEA267045
 for <alsa-devel@alsa-project.org>; Tue, 15 May 2018 16:54:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1526364015-28504-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, cychiang@google.com, lgirdwood@gmail.com, broonie@kernel.org, kbuild-all@01.org, shumingf@realtek.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


Fixes: 9958e8afbcad ("ASoC: rt5663: Use the set_jack() instead of the export function")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 rt5663.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index eefa918..9bd24ad 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1856,7 +1856,7 @@ static irqreturn_t rt5663_irq(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-int rt5663_set_jack_detect(struct snd_soc_component *component,
+static int rt5663_set_jack_detect(struct snd_soc_component *component,
 	struct snd_soc_jack *hs_jack, void *data)
 {
 	struct rt5663_priv *rt5663 = snd_soc_component_get_drvdata(component);
