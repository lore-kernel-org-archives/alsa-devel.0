From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/5] ASoC codec: SSM2602: assign last substream
	to the master when shutting down
Date: Tue,  2 Jun 2009 00:18:54 -0400
Message-ID: <1243916337-29953-2-git-send-email-vapier@gentoo.org>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 9701424141
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 06:19:07 +0200 (CEST)
In-Reply-To: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Fixes crash when shutting down.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/codecs/ssm2602.c |   25 ++++++++++++++++---------
 1 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/ssm2602.c b/sound/soc/codecs/ssm2602.c
index d6af069..1fc4c8e 100644
--- a/sound/soc/codecs/ssm2602.c
+++ b/sound/soc/codecs/ssm2602.c
@@ -336,15 +336,17 @@ static int ssm2602_startup(struct snd_pcm_substream *substream,
 			master_runtime->sample_bits,
 			master_runtime->rate);
 
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_RATE,
-					     master_runtime->rate,
-					     master_runtime->rate);
-
-		snd_pcm_hw_constraint_minmax(substream->runtime,
-					     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
-					     master_runtime->sample_bits,
-					     master_runtime->sample_bits);
+		if (master_runtime->rate != 0)
+			snd_pcm_hw_constraint_minmax(substream->runtime,
+						     SNDRV_PCM_HW_PARAM_RATE,
+						     master_runtime->rate,
+						     master_runtime->rate);
+
+		if (master_runtime->sample_bits != 0)
+			snd_pcm_hw_constraint_minmax(substream->runtime,
+						     SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+						     master_runtime->sample_bits,
+						     master_runtime->sample_bits);
 
 		ssm2602->slave_substream = substream;
 	} else
@@ -372,6 +374,11 @@ static void ssm2602_shutdown(struct snd_pcm_substream *substream,
 	struct snd_soc_device *socdev = rtd->socdev;
 	struct snd_soc_codec *codec = socdev->card->codec;
 	struct ssm2602_priv *ssm2602 = codec->private_data;
+
+	if (ssm2602->master_substream == substream)
+		ssm2602->master_substream = ssm2602->slave_substream;
+
+	ssm2602->slave_substream = NULL;
 	/* deactivate */
 	if (!codec->active)
 		ssm2602_write(codec, SSM2602_ACTIVE, 0);
-- 
1.6.3.1
