From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 5/7] ASoC: soc-compress: Deduce stream direction
Date: Thu, 11 Apr 2013 19:00:43 +0100
Message-ID: <1365703245-20738-6-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 57B012661EB
 for <alsa-devel@alsa-project.org>; Thu, 11 Apr 2013 20:10:02 +0200 (CEST)
In-Reply-To: <1365703245-20738-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@opensource.wolfsonmicro.com, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, vinod.koul@intel.com, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Previously we just hard coded all streams as playback streams, this
patch checks the DAI to see if it is a capture or playback stream. It is
worth noting that at this time only unidirectional streams are
supported.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/soc-compress.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-compress.c b/sound/soc/soc-compress.c
index d3f03f6..e16ce86 100644
--- a/sound/soc/soc-compress.c
+++ b/sound/soc/soc-compress.c
@@ -376,7 +376,14 @@ int soc_new_compress(struct snd_soc_pcm_runtime *rtd, int num)
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
