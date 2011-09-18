From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 1/4] src/pcm/pcm_rate.c: add missing free
Date: Sun, 18 Sep 2011 22:04:34 +0200
Message-ID: <1316376277-1224-1-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id C234D247D3
	for <alsa-devel@alsa-project.org>;
	Sun, 18 Sep 2011 22:04:45 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, sumsaha@gmail.com
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Something that is allocated using calloc is not freed on one
or more error paths.

Signed-off-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Suman Saha <sumsaha@gmail.com>

---
Compile-tested only.

 src/pcm/pcm_rate.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 70e30e5..eb35e4a 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -1392,11 +1392,13 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	} else {
 		SNDERR("Invalid type for rate converter");
 		snd_pcm_close(pcm);
+		free(rate);
 		return -EINVAL;
 	}
 	if (err < 0) {
 		SNDERR("Cannot find rate converter");
 		snd_pcm_close(pcm);
+		free(rate);
 		return -ENOENT;
 	}
 #else
@@ -1405,6 +1407,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	err = open_func(SND_PCM_RATE_PLUGIN_VERSION, &rate->obj, &rate->ops);
 	if (err < 0) {
 		snd_pcm_close(pcm);
+		free(rate);
 		return err;
 	}
 #endif
@@ -1413,6 +1416,7 @@ int snd_pcm_rate_open(snd_pcm_t **pcmp, const char *name,
 	    ! rate->ops.input_frames || ! rate->ops.output_frames) {
 		SNDERR("Inproper rate plugin %s initialization", type);
 		snd_pcm_close(pcm);
+		free(rate);
 		return err;
 	}
 
