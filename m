From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: soc-dapm: Fix parameter comment for
	snd_soc_dapm_free
Date: Fri, 26 Aug 2011 16:33:52 +0300
Message-ID: <1314365632-8987-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 53A402463D
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Aug 2011 15:33:52 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We have dapm_context instead of codec parameter.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hello Mark, Liam,

Bumped to this while adding the snd_soc_dapm_attach_dai_supply.
It must have been overlooked, when the API changed.

Peter

 sound/soc/soc-dapm.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 8839202..5072b3b 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2763,7 +2763,7 @@ EXPORT_SYMBOL_GPL(snd_soc_dapm_ignore_suspend);
 
 /**
  * snd_soc_dapm_free - free dapm resources
- * @card: SoC device
+ * @dapm: DAPM context
  *
  * Free all dapm widgets and resources.
  */
-- 
1.7.6.1
