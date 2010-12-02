From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 1/2] ASoC: Make the DAI ops constant in the DAI
	structure
Date: Thu,  2 Dec 2010 17:05:15 +0000
Message-ID: <1291309516-10322-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 73BD2103AE6
	for <alsa-devel@alsa-project.org>; Thu,  2 Dec 2010 18:05:19 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Neither drivers nor the core should be fiddling with the actual ops
structure at runtime.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc-dai.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index 0195b7e..1bafe95 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -203,7 +203,7 @@ struct snd_soc_dai_driver {
 	int (*resume)(struct snd_soc_dai *dai);
 
 	/* ops */
-	struct snd_soc_dai_ops *ops;
+	const struct snd_soc_dai_ops *ops;
 
 	/* DAI capabilities */
 	struct snd_soc_pcm_stream capture;
-- 
1.7.1
