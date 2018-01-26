From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: compress: Remove some extraneous
	blank lines
Date: Fri, 26 Jan 2018 13:08:44 +0000
Message-ID: <20180126130845.7122-2-ckeepax@opensource.cirrus.com>
References: <20180126130845.7122-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 9AF1E267665
 for <alsa-devel@alsa-project.org>; Fri, 26 Jan 2018 14:08:56 +0100 (CET)
In-Reply-To: <20180126130845.7122-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, ladis@linux-mips.org, kuninori.morimoto.gx@renesas.com, vinod.koul@intel.com, lgirdwood@gmail.com, dan.carpenter@oracle.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/soc-compress.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index 7973f92cd40f5..b1cf758e3be20 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -145,7 +145,6 @@ static int soc_compr_open_fe(struct snd_compr_stream *cstream)
 		}
 	}
 
-
 	if (platform && platform->driver->compr_ops && platform->driver->compr_ops->open) {
 		ret = platform->driver->compr_ops->open(cstream);
 		if (ret < 0) {
@@ -307,7 +306,6 @@ static int soc_compr_free(struct snd_compr_stream *cstream)
 	if (!codec_dai->active)
 		codec_dai->rate = 0;
 
-
 	if (rtd->dai_link->compr_ops && rtd->dai_link->compr_ops->shutdown)
 		rtd->dai_link->compr_ops->shutdown(cstream);
 
@@ -460,7 +458,6 @@ static int soc_compr_trigger(struct snd_compr_stream *cstream, int cmd)
 	if (cpu_dai->driver->cops && cpu_dai->driver->cops->trigger)
 		cpu_dai->driver->cops->trigger(cstream, cmd, cpu_dai);
 
-
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		snd_soc_dai_digital_mute(codec_dai, 0, cstream->direction);
-- 
2.11.0
