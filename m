From: <twischer@de.adit-jv.com>
Subject: [PATCH] pcm: null: Do not allow a period size of 0
Date: Fri, 5 Apr 2019 16:09:53 +0200
Message-ID: <1554473393-5757-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org, tiwai@suse.com
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

Some applications do not expect that get_period_size_min() could
return 0. Therefore these applications cannot use the null plugin without
this patch.
Due to there is no use case for having a period size of 0 this patch
disallows a period size of 0 when using the null plugin.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
---
 src/pcm/pcm_null.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_null.c b/src/pcm/pcm_null.c
index ff61624..c95fad8 100644
--- a/src/pcm/pcm_null.c
+++ b/src/pcm/pcm_null.c
@@ -261,7 +261,18 @@ static snd_pcm_sframes_t snd_pcm_null_mmap_commit(snd_pcm_t *pcm,
 
 static int snd_pcm_null_hw_refine(snd_pcm_t *pcm ATTRIBUTE_UNUSED, snd_pcm_hw_params_t *params)
 {
-	int err = snd_pcm_hw_refine_soft(pcm, params);
+	int err;
+
+	/* Do not return a period size of 0 because for example portaudio cannot
+	 * handle it. In addition such small buffers would only increase the CPU
+	 * load but there is no benefit when throwing the samples anyway away.
+	 */
+	err = _snd_pcm_hw_param_set_min(params, SND_PCM_HW_PARAM_PERIOD_SIZE,
+					32, 0);
+	if (err < 0)
+		return err;
+
+	err = snd_pcm_hw_refine_soft(pcm, params);
 	params->info = SND_PCM_INFO_MMAP | SND_PCM_INFO_MMAP_VALID |
 		       SND_PCM_INFO_RESUME | SND_PCM_INFO_PAUSE;
 	params->fifo_size = 0;
-- 
2.7.4
