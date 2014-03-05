From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/7] ASoC: Fix active count tracking for CODEC
	to CODEC links
Date: Wed,  5 Mar 2014 13:17:44 +0100
Message-ID: <1394021868-11860-3-git-send-email-lars@metafoo.de>
References: <1394021868-11860-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-014.synserver.de (smtp-out-163.synserver.de
 [212.40.185.163])
 by alsa0.perex.cz (Postfix) with ESMTP id 235D826501B
 for <alsa-devel@alsa-project.org>; Wed,  5 Mar 2014 13:17:20 +0100 (CET)
In-Reply-To: <1394021868-11860-1-git-send-email-lars@metafoo.de>
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
Cc: Viresh Kumar <viresh.kumar@linaro.org>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

For CODEC to CODEC links we need to make sure to also manage the 'active' field
of the cpu_dai CODEC.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/soc-pcm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 1a98575..71a01dd 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -61,7 +61,9 @@ void snd_soc_runtime_activate(struct snd_soc_pcm_runtime *rtd, int stream)
 
 	cpu_dai->active++;
 	codec_dai->active++;
-	rtd->codec->active++;
+	if (cpu_dai->codec)
+		cpu_dai->codec->active++;
+	codec_dai->codec->active++;
 }
 
 /**
@@ -91,7 +93,9 @@ void snd_soc_runtime_deactivate(struct snd_soc_pcm_runtime *rtd, int stream)
 
 	cpu_dai->active--;
 	codec_dai->active--;
-	rtd->codec->active--;
+	if (cpu_dai->codec)
+		cpu_dai->codec->active--;
+	codec_dai->codec->active--;
 }
 
 /**
-- 
1.8.0
