From: Julia Lawall <julia@diku.dk>
Subject: [PATCH 3/4] src/pcm/pcm_ladspa.c: add missing free
Date: Sun, 18 Sep 2011 22:04:36 +0200
Message-ID: <1316376277-1224-3-git-send-email-julia@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw2.diku.dk (mgw2.diku.dk [130.225.96.92])
	by alsa0.perex.cz (Postfix) with ESMTP id C7037247D5
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

Something that is allocated using calloc is not freed on some
error paths.

Signed-off-by: Julia Lawall <julia@diku.dk>
Signed-off-by: Suman Saha <sumsaha@gmail.com>

---
Compile-tested only.

 src/pcm/pcm_ladspa.c |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_ladspa.c b/src/pcm/pcm_ladspa.c
index c413c10..84ebaa5 100644
--- a/src/pcm/pcm_ladspa.c
+++ b/src/pcm/pcm_ladspa.c
@@ -750,8 +750,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
                         if (instance->input.data == NULL ||
                             instance->input.m_data == NULL ||
                             instance->output.data == NULL ||
-                            instance->output.m_data == NULL)
+                            instance->output.m_data == NULL) {
+                                free(pchannels);
                                 return -ENOMEM;
+                        }
 			for (idx = 0; idx < instance->input.channels.size; idx++) {
 			        chn = instance->output.channels.array[idx];
 			        if (pchannels[chn] == NULL && chn < ichannels) {
@@ -761,8 +763,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
 			        instance->input.data[idx] = pchannels[chn];
 			        if (instance->input.data[idx] == NULL) {
                                         instance->input.data[idx] = snd_pcm_ladspa_allocate_zero(ladspa, 0);
-                                        if (instance->input.data[idx] == NULL)
+                                        if (instance->input.data[idx] == NULL) {
+                                                free(pchannels);
                                                 return -ENOMEM;
+                                        }
                                 }
                         }
                         for (idx = 0; idx < instance->output.channels.size; idx++) {
@@ -770,8 +774,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
                                 /* FIXME/OPTIMIZE: check if we can remove double alloc */
                                 /* if LADSPA plugin has no broken inplace */
                                 instance->output.data[idx] = malloc(sizeof(LADSPA_Data) * ladspa->allocated);
-                                if (instance->output.data[idx] == NULL)
+                                if (instance->output.data[idx] == NULL) {
+                                        free(pchannels);
                                         return -ENOMEM;
+                                }
                                 pchannels[chn] = instance->output.m_data[idx] = instance->output.data[idx];
                         }
 		}
@@ -793,8 +799,10 @@ static int snd_pcm_ladspa_allocate_memory(snd_pcm_t *pcm, snd_pcm_ladspa_t *lads
                                                 instance->output.data[idx] = NULL;
                                         } else {
                                                 instance->output.data[idx] = snd_pcm_ladspa_allocate_zero(ladspa, 1);
-                                                if (instance->output.data[idx] == NULL)
+                                                if (instance->output.data[idx] == NULL) {
+                                                        free(pchannels);
                                                         return -ENOMEM;
+                                                }
                                         }
                                 }
                         }
