From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: Export snd_soc_runtime_set_dai_fmt()
Date: Thu,  8 Jan 2015 12:23:05 +0100
Message-ID: <1420716185-11974-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-080.synserver.de (smtp-out-080.synserver.de
 [212.40.185.80])
 by alsa0.perex.cz (Postfix) with ESMTP id CE644260320
 for <alsa-devel@alsa-project.org>; Thu,  8 Jan 2015 12:23:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Export snd_soc_runtime_set_dai_fmt() so it can be used in modules.

Fixes: ce64c8b9cf5b ("ASoC: Add helper function for changing the DAI link format")
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 4b8dc5f..2c02e9c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1491,6 +1491,7 @@ int snd_soc_runtime_set_dai_fmt(struct snd_soc_pcm_runtime *rtd,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(snd_soc_runtime_set_dai_fmt);
 
 static int snd_soc_instantiate_card(struct snd_soc_card *card)
 {
-- 
1.8.0
