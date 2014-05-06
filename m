From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 5/5] ASoC: Remove runtime field from DAI
Date: Tue,  6 May 2014 09:39:41 +0200
Message-ID: <1399361981-18518-6-git-send-email-lars@metafoo.de>
References: <1399361981-18518-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-167.synserver.de (smtp-out-016.synserver.de
 [212.40.185.16])
 by alsa0.perex.cz (Postfix) with ESMTP id DC792261A18
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 09:39:54 +0200 (CEST)
In-Reply-To: <1399361981-18518-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Bo Shen <voice.shen@atmel.com>
List-Id: alsa-devel@alsa-project.org

This was initially removed in commit 6423c1875 ("ASoC: Remove runtime field from
DAI"), but was, presumably by accident, brought back in commit f0fba2ad1 ("ASoC:
multi-component - ASoC Multi-Component Support"). But has never been
initialized to anything but NULL ever since. This commit removes it again.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 include/sound/soc-dai.h  | 1 -
 sound/soc/soc-compress.c | 1 -
 sound/soc/soc-pcm.c      | 1 -
 3 files changed, 3 deletions(-)

diff --git a/include/sound/soc-dai.h b/include/sound/soc-dai.h
index e2c3e45..688f2ba 100644
--- a/include/sound/soc-dai.h
+++ b/include/sound/soc-dai.h
@@ -252,7 +252,6 @@ struct snd_soc_dai {
 	unsigned int symmetric_rates:1;
 	unsigned int symmetric_channels:1;
 	unsigned int symmetric_samplebits:1;
-	struct snd_pcm_runtime *runtime;
 	unsigned int active;
 	unsigned char probed:1;
 
diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 91083e6..5320e86 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -203,7 +203,6 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 
 	if (platform->driver->compr_ops && platform->driver->compr_ops->free)
 		platform->driver->compr_ops->free(cstream);
-	cpu_dai->runtime = NULL;
 
 	if (cstream->direction == SND_COMPRESS_PLAYBACK) {
 		if (snd_soc_runtime_ignore_pmdown_time(rtd)) {
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 2cedf09..cc00252 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -555,7 +555,6 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 
 	if (platform->driver->ops && platform->driver->ops->close)
 		platform->driver->ops->close(substream);
-	cpu_dai->runtime = NULL;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		if (snd_soc_runtime_ignore_pmdown_time(rtd)) {
-- 
1.8.0
