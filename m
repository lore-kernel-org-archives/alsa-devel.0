From: Feng Tang <feng.tang@intel.com>
Subject: [PATCH] ALSA: remove the dead code from
	snd_pcm_open_file()
Date: Mon, 10 Oct 2011 10:31:48 +0800
Message-ID: <1318213908-23709-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id AD0002464C
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Oct 2011 04:30:04 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Feng Tang <feng.tang@intel.com>
List-Id: alsa-devel@alsa-project.org

The rpcm_file parameter is never used in current ALSA code, so remove
it to make it cleaner.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 sound/core/pcm_native.c |   12 +++---------
 1 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 1c6be91..2d3af5d 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2058,16 +2058,12 @@ EXPORT_SYMBOL(snd_pcm_open_substream);
 
 static int snd_pcm_open_file(struct file *file,
 			     struct snd_pcm *pcm,
-			     int stream,
-			     struct snd_pcm_file **rpcm_file)
+			     int stream)
 {
 	struct snd_pcm_file *pcm_file;
 	struct snd_pcm_substream *substream;
 	int err;
 
-	if (rpcm_file)
-		*rpcm_file = NULL;
-
 	err = snd_pcm_open_substream(pcm, stream, file, &substream);
 	if (err < 0)
 		return err;
@@ -2083,8 +2079,7 @@ static int snd_pcm_open_file(struct file *file,
 		substream->pcm_release = pcm_release_private;
 	}
 	file->private_data = pcm_file;
-	if (rpcm_file)
-		*rpcm_file = pcm_file;
+
 	return 0;
 }
 
@@ -2113,7 +2108,6 @@ static int snd_pcm_capture_open(struct inode *inode, struct file *file)
 static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream)
 {
 	int err;
-	struct snd_pcm_file *pcm_file;
 	wait_queue_t wait;
 
 	if (pcm == NULL) {
@@ -2131,7 +2125,7 @@ static int snd_pcm_open(struct file *file, struct snd_pcm *pcm, int stream)
 	add_wait_queue(&pcm->open_wait, &wait);
 	mutex_lock(&pcm->open_mutex);
 	while (1) {
-		err = snd_pcm_open_file(file, pcm, stream, &pcm_file);
+		err = snd_pcm_open_file(file, pcm, stream);
 		if (err >= 0)
 			break;
 		if (err == -EAGAIN) {
-- 
1.7.1
