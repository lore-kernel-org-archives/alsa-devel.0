From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: [RFC 1/4] ASoC: core: soc level wrapper for
	pcm_pointer callback
Date: Tue,  2 Mar 2010 15:39:48 +0200
Message-ID: <1267537191-25254-2-git-send-email-peter.ujfalusi@nokia.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 143CA1038CC
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:40:00 +0100 (CET)
In-Reply-To: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
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
Cc: tiwai@suse.de, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Create a soc level wrapper for pcm_pointer callbacks.
This will facilitate the soc level handling of different
HW buffers in the audio path.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
---
 sound/soc/soc-core.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index a03bac9..6e35741 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -797,6 +797,23 @@ static int soc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	return 0;
 }
 
+/*
+ * soc level wrapper for pointer and pcm_delay handling
+ */
+static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_device *socdev = rtd->socdev;
+	struct snd_soc_card *card = socdev->card;
+	struct snd_soc_platform *platform = card->platform;
+	snd_pcm_uframes_t offset = 0;
+
+	if (platform->pcm_ops->pointer)
+		offset = platform->pcm_ops->pointer(substream);
+
+	return offset;
+}
+
 /* ASoC PCM operations */
 static struct snd_pcm_ops soc_pcm_ops = {
 	.open		= soc_pcm_open,
@@ -805,6 +822,7 @@ static struct snd_pcm_ops soc_pcm_ops = {
 	.hw_free	= soc_pcm_hw_free,
 	.prepare	= soc_pcm_prepare,
 	.trigger	= soc_pcm_trigger,
+	.pointer	= soc_pcm_pointer,
 };
 
 #ifdef CONFIG_PM
@@ -1331,7 +1349,6 @@ static int soc_new_pcm(struct snd_soc_device *socdev,
 	dai_link->pcm = pcm;
 	pcm->private_data = rtd;
 	soc_pcm_ops.mmap = platform->pcm_ops->mmap;
-	soc_pcm_ops.pointer = platform->pcm_ops->pointer;
 	soc_pcm_ops.ioctl = platform->pcm_ops->ioctl;
 	soc_pcm_ops.copy = platform->pcm_ops->copy;
 	soc_pcm_ops.silence = platform->pcm_ops->silence;
-- 
1.7.0
