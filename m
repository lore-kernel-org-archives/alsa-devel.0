From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: dpcm: Fixup debugFS for DPCM state.
Date: Fri, 27 Apr 2012 11:33:46 +0100
Message-ID: <1335522826-22272-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
	[74.125.149.240])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E2C524157
	for <alsa-devel@alsa-project.org>;
	Fri, 27 Apr 2012 12:33:52 +0200 (CEST)
Received: by weyt57 with SMTP id t57so395030wey.41
	for <alsa-devel@alsa-project.org>; Fri, 27 Apr 2012 03:33:49 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Remove writable debugFS permission, use simple_open() and
fix indentation.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-pcm.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index ca19152..0e68d2d 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -2389,12 +2389,6 @@ static char *dpcm_state_string(enum snd_soc_dpcm_state state)
 	return "unknown";
 }
 
-static int dpcm_state_open_file(struct inode *inode, struct file *file)
-{
-	file->private_data = inode->i_private;
-	return 0;
-}
-
 static ssize_t dpcm_show_state(struct snd_soc_pcm_runtime *fe,
 				int stream, char *buf, size_t size)
 {
@@ -2472,15 +2466,14 @@ static ssize_t dpcm_state_read_file(struct file *file, char __user *user_buf,
 		offset += dpcm_show_state(fe, SNDRV_PCM_STREAM_CAPTURE,
 					buf + offset, out_count - offset);
 
-        ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
-
-        kfree(buf);
+	ret = simple_read_from_buffer(user_buf, count, ppos, buf, offset);
 
-        return ret;
+	kfree(buf);
+	return ret;
 }
 
 static const struct file_operations dpcm_state_fops = {
-	.open = dpcm_state_open_file,
+	.open = simple_open,
 	.read = dpcm_state_read_file,
 	.llseek = default_llseek,
 };
@@ -2496,7 +2489,7 @@ int soc_dpcm_debugfs_add(struct snd_soc_pcm_runtime *rtd)
 		return -EINVAL;
 	}
 
-	rtd->debugfs_dpcm_state = debugfs_create_file("state", 0644,
+	rtd->debugfs_dpcm_state = debugfs_create_file("state", 0444,
 						rtd->debugfs_dpcm_root,
 						rtd, &dpcm_state_fops);
 
-- 
1.7.5.4
