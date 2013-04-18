Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C8CC7265E72
 for <alsa-devel@alsa-project.org>; Thu, 18 Apr 2013 12:02:43 +0200 (CEST)
Date: Thu, 18 Apr 2013 11:02:38 +0100
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Message-ID: <5f1a4011237943bc9ecbe249364c7450273d20ca.1366278354.git.rf@open
 source.wolfsonmicro.com>
References: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1366278354.git.rf@opensource.wolfsonmicro.com>
Subject: [alsa-devel] [PATCH 5/7] ASoC: soc-compress: Deduce stream direction
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tiwai@suse.de, vinod.koul@intel.com
Cc: girdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, ckeepax@opensource.wolfsonmicro.com
List-ID: <alsa-devel@alsa-project.org>

Previously we just hard coded all streams as playback streams, this
patch checks the DAI to see if it is a capture or playback stream. It is
worth noting that at this time only unidirectional streams are
supported.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index da83e56..3853f7e 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -384,7 +384,14 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
 	/* check client and interface hw capabilities */
 	snprintf(new_name, sizeof(new_name), "%s %s-%d",
 			rtd->dai_link->stream_name, codec_dai->name, num);
-	direction = SND_COMPRESS_PLAYBACK;
+
+	if (codec_dai->driver->playback.channels_min)
+		direction = SND_COMPRESS_PLAYBACK;
+	else if (codec_dai->driver->capture.channels_min)
+		direction = SND_COMPRESS_CAPTURE;
+	else
+		return -EINVAL;
+
 	compr = kzalloc(sizeof(*compr), GFP_KERNEL);
 	if (compr == NULL) {
 		snd_printk(KERN_ERR "Cannot allocate compr\n");
-- 
1.7.2.5

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
