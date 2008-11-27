From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Clean up kernel-doc for
	snd_soc_dai_set_fmt
Date: Thu, 27 Nov 2008 15:16:39 +0000
Message-ID: <1227799001-16074-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081127151553.GA15999@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A7DA52434A
	for <alsa-devel@alsa-project.org>; Thu, 27 Nov 2008 16:16:42 +0100 (CET)
In-Reply-To: <20081127151553.GA15999@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Qinghuang Feng <qhfeng.kernel@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Qinghuang Feng <qhfeng.kernel@gmail.com>

There is no argument named @clk_id in snd_soc_dai_set_fmt,
remove its' comment.

Signed-off-by: Qinghuang Feng <qhfeng.kernel@gmail.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index dbd92e1..00fccdd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1883,7 +1883,6 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_set_pll);
 /**
  * snd_soc_dai_set_fmt - configure DAI hardware audio format.
  * @dai: DAI
- * @clk_id: DAI specific clock ID
  * @fmt: SND_SOC_DAIFMT_ format value.
  *
  * Configures the DAI hardware format and clocking.
-- 
1.5.6.5
