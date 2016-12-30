From: sutar.mounesh@gmail.com
Subject: [PATCH 3/6] alsa-lib: pcm:dshare enable silence
Date: Fri, 30 Dec 2016 11:59:11 +0530
Message-ID: <1483079351-28905-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Alexander Jahn <ajahn@de.adit-jv.com>, Andreas Pape <apape@de.adit-jv.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Alexander Jahn <ajahn@de.adit-jv.com>

This issue depends on system load - if the process using dshare is scheduled
fast enough, then there is no noise. A delay of e.g >~2ms produces hearable noise.

Reproduction with instrumented aplay(sleep every 100th period for a given time):
During the sleep time of 2000000us (2s) the hardware plays old samples in a
loop before xrun is detected and recovered after the sleep.
This is resolved by placing it in silence, in case of dshare plugin.

Signed-off-by: Alexander Jahn <ajahn@de.adit-jv.com>
Signed-off-by: Andreas Pape <apape@de.adit-jv.com>

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 4234d66..779845c 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1240,7 +1240,7 @@ int snd_pcm_direct_initialize_slave(snd_pcm_direct_t *dmix, snd_pcm_t *spcm, str
 		return ret;
 	}
 
-	if (dmix->type != SND_PCM_TYPE_DMIX)
+	if ((dmix->type != SND_PCM_TYPE_DMIX)&&(dmix->type != SND_PCM_TYPE_DSHARE))
 		goto __skip_silencing;
 
 	ret = snd_pcm_sw_params_set_silence_threshold(spcm, &sw_params, 0);
-- 
1.7.9.5
