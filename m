From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] ASoC: dapm: Skip CODEC<->CODEC links in
	connect_dai_link_widgets()
Date: Wed,  7 May 2014 15:05:44 +0200
Message-ID: <1399467948-8770-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-016.synserver.de (smtp-out-029.synserver.de
 [212.40.185.29])
 by alsa0.perex.cz (Postfix) with ESMTP id 05CF62652CD
 for <alsa-devel@alsa-project.org>; Wed,  7 May 2014 15:05:57 +0200 (CEST)
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
Cc: Songhee Baek <sbaek@nvidia.com>, Arun Shamanna Lakshmi <aruns@nvidia.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

For CODEC to CODEC DAI links the paths are already created in
snd_soc_dapm_new_pcm(). Make sure to not create additional connections in
snd_soc_dapm_connect_dai_link_widgets() for CODEC to CODEC links.

Fixes: b893ea5 ("ASoC: sapm: Automatically connect DAI link widgets in DAPM graph.")
Cc: stable@vger.kernel.org (for 3.14+)
Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
The series applies on topic/dapm
---
 sound/soc/soc-dapm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index fb6c7b7..142a738 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3410,8 +3410,11 @@ void snd_soc_dapm_connect_dai_link_widgets(struct snd_soc_card *card)
 		cpu_dai = rtd->cpu_dai;
 		codec_dai = rtd->codec_dai;
 
-		/* dynamic FE links have no fixed DAI mapping */
-		if (rtd->dai_link->dynamic)
+		/*
+		 * dynamic FE links have no fixed DAI mapping.
+		 * CODEC<->CODEC links have no direct connection.
+		 */
+		if (rtd->dai_link->dynamic || rtd->dai_link->params)
 			continue;
 
 		/* there is no point in connecting BE DAI links with dummies */
-- 
1.8.0
