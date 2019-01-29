From: Jaroslav Kysela <perex@perex.cz>
Subject: [PATCH 2/3] ALSA: pcm: remove the file member from
	struct pcm
Date: Tue, 29 Jan 2019 18:59:08 +0100
Message-ID: <20190129175909.17423-3-perex@perex.cz>
References: <20190129175909.17423-1-perex@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 6F1EA2675B6
 for <alsa-devel@alsa-project.org>; Tue, 29 Jan 2019 18:59:52 +0100 (CET)
In-Reply-To: <20190129175909.17423-1-perex@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>, Baolin Wang <baolin.wang@linaro.org>, Leo Yan <leo.yan@linaro.org>
List-Id: alsa-devel@alsa-project.org

This member is no longer used.

Signed-off-by: Jaroslav Kysela <perex@perex.cz>
---
 include/sound/pcm.h      | 1 -
 sound/core/oss/pcm_oss.c | 1 -
 sound/core/pcm_native.c  | 4 +---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index e7deb03b6702..61e4c69e73c7 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -470,7 +470,6 @@ struct snd_pcm_substream {
 	struct snd_pcm_group self_group;	/* fake group for non linked substream (with substream lock inside) */
 	struct snd_pcm_group *group;		/* pointer to current group */
 	/* -- assigned files -- */
-	void *file;
 	int ref_count;
 	atomic_t mmap_count;
 	unsigned int f_flags;
diff --git a/sound/core/oss/pcm_oss.c b/sound/core/oss/pcm_oss.c
index b3738c228f39..222ddf9e4859 100644
--- a/sound/core/oss/pcm_oss.c
+++ b/sound/core/oss/pcm_oss.c
@@ -2427,7 +2427,6 @@ static int snd_pcm_oss_open_file(struct file *file,
 		}
 
 		pcm_oss_file->streams[idx] = substream;
-		substream->file = pcm_oss_file;
 		snd_pcm_oss_init_substream(substream, &setup[idx], minor);
 	}
 	
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index a6d2a5024ab5..3ab6fbd7acae 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -2455,10 +2455,8 @@ static int snd_pcm_open_file(struct file *file,
 		return -ENOMEM;
 	}
 	pcm_file->substream = substream;
-	if (substream->ref_count == 1) {
-		substream->file = pcm_file;
+	if (substream->ref_count == 1)
 		substream->pcm_release = pcm_release_private;
-	}
 	file->private_data = pcm_file;
 
 	return 0;
-- 
2.13.6
