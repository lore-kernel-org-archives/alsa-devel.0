From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Remove extra space in runtime struct
	definition
Date: Thu, 10 Nov 2011 11:48:09 +0000
Message-ID: <1320925689-3923-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id EA980103ABF
	for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2011 12:48:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

My usual technique for finding definitions is to search for "name {"
which breaks with the extra space.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 877fcc1..02a5c55 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -843,7 +843,7 @@ struct snd_soc_card {
 };
 
 /* SoC machine DAI configuration, glues a codec and cpu DAI together */
-struct snd_soc_pcm_runtime  {
+struct snd_soc_pcm_runtime {
 	struct device dev;
 	struct snd_soc_card *card;
 	struct snd_soc_dai_link *dai_link;
-- 
1.7.7.2
