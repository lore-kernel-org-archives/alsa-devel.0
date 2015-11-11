From: Peter Rosin <peda@lysator.liu.se>
Subject: [PATCH] pcm: simple: Fix asserts
Date: Wed, 11 Nov 2015 17:07:32 +0100
Message-ID: <1447258052-32203-1-git-send-email-peda@lysator.liu.se>
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

Do not error out on the boundaries.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 src/pcm/pcm_simple.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/pcm/pcm_simple.c b/src/pcm/pcm_simple.c
index f943ec0..ce11083 100644
--- a/src/pcm/pcm_simple.c
+++ b/src/pcm/pcm_simple.c
@@ -173,8 +173,8 @@ int snd_spcm_init(snd_pcm_t *pcm,
 	snd_pcm_sw_params_alloca(&sw_params);
 
 	assert(pcm);
-	assert(rate > 5000 && rate < 192000);
-	assert(channels > 1 && channels < 512);
+	assert(rate >= 5000 && rate <= 192000);
+	assert(channels >= 1 && channels <= 512);
 
 	rrate = rate;
 	err = set_buffer_time(latency, &buffer_time);
@@ -233,8 +233,8 @@ int snd_spcm_init_duplex(snd_pcm_t *playback_pcm,
 
 	assert(playback_pcm);
 	assert(capture_pcm);
-	assert(rate > 5000 && rate < 192000);
-	assert(channels > 1 && channels < 512);
+	assert(rate >= 5000 && rate <= 192000);
+	assert(channels >= 1 && channels <= 512);
 
 	pcms[0] = playback_pcm;
 	pcms[1] = capture_pcm;
-- 
1.7.10.4
