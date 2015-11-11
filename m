From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] PCM: Support up to 384kHz sample rate.
Date: Wed, 11 Nov 2015 17:13:56 +0100
Message-ID: <1447258436-32238-1-git-send-email-peda@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Peter Rosin <peda@lysator.liu.se>, alsa-devel@alsa-project.org, Peter Rosin <peda@axentia.se>
List-Id: alsa-devel@alsa-project.org

From: Peter Rosin <peda@axentia.se>

Some codecs support it in the kernel (e.g. pcm512x).

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 include/pcm_plugin.h |    2 +-
 src/pcm/pcm_simple.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

I'm not sure it really is this simple, but the things I'm using start to
work...

Cheers,
Peter

diff --git a/include/pcm_plugin.h b/include/pcm_plugin.h
index eea1d82..958bc89 100644
--- a/include/pcm_plugin.h
+++ b/include/pcm_plugin.h
@@ -39,7 +39,7 @@
  */
   
 #define SND_PCM_PLUGIN_RATE_MIN 4000	/**< minimal rate for the rate plugin */
-#define SND_PCM_PLUGIN_RATE_MAX 192000	/**< maximal rate for the rate plugin */
+#define SND_PCM_PLUGIN_RATE_MAX 384000	/**< maximal rate for the rate plugin */
 
 /* ROUTE_FLOAT should be set to 0 for machines without FP unit - like iPAQ */
 #ifdef HAVE_SOFT_FLOAT
diff --git a/src/pcm/pcm_simple.c b/src/pcm/pcm_simple.c
index ce11083..2fda841 100644
--- a/src/pcm/pcm_simple.c
+++ b/src/pcm/pcm_simple.c
@@ -173,7 +173,7 @@ int snd_spcm_init(snd_pcm_t *pcm,
 	snd_pcm_sw_params_alloca(&sw_params);
 
 	assert(pcm);
-	assert(rate >= 5000 && rate <= 192000);
+	assert(rate >= 5000 && rate <= 384000);
 	assert(channels >= 1 && channels <= 512);
 
 	rrate = rate;
@@ -233,7 +233,7 @@ int snd_spcm_init_duplex(snd_pcm_t *playback_pcm,
 
 	assert(playback_pcm);
 	assert(capture_pcm);
-	assert(rate >= 5000 && rate <= 192000);
+	assert(rate >= 5000 && rate <= 384000);
 	assert(channels >= 1 && channels <= 512);
 
 	pcms[0] = playback_pcm;
-- 
1.7.10.4
