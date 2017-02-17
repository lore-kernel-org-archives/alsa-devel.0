From: sutar.mounesh@gmail.com
Subject: [PATCH 1/6] pcm: dmix_rewind corrupts application
	pointer fix
Date: Fri, 17 Feb 2017 12:45:36 +0530
Message-ID: <1487315736-8950-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org, Ravikiran Polepalli <ravikiran_polepalli@mentor.com>, Mounesh Sutar <sutar.mounesh@gmail.com>, Mikhail Durnev <mikhail_durnev@mentor.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

sometimes pulseaudio stops with the following assertion in libasound.so:
alsa-lib-1.0.29/src/pcm/pcm.c:2761:
snd_pcm_area_copy: Assertion `dst < src || dst >= src + bytes' failed.
Application pointer is handled properly, in cases of rewind operations.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>
Signed-off-by: Ravikiran Polepalli <ravikiran_polepalli@mentor.com>
Signed-off-by: Mikhail Durnev <mikhail_durnev@mentor.com>
Signed-off-by: Mounesh Sutar <sutar.mounesh@gmail.com>

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index dd0356e..4b763e2 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -706,7 +706,7 @@ static snd_pcm_sframes_t snd_pcm_dmix_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
 {
 	snd_pcm_direct_t *dmix = pcm->private_data;
 	snd_pcm_uframes_t slave_appl_ptr, slave_size;
-	snd_pcm_uframes_t appl_ptr, size, transfer, result;
+	snd_pcm_uframes_t appl_ptr, size, transfer, result, frames_to_remix;
 	int err;
 	const snd_pcm_channel_area_t *src_areas, *dst_areas;
 
@@ -717,6 +717,11 @@ static snd_pcm_sframes_t snd_pcm_dmix_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
 			return err;
 	}
 
+	/* (appl_ptr - last_appl_ptr) indicates the frames which are not already mixed
+	   (last_appl_ptr - hw_ptr)  indicates the frames which are already mixed but not played yet.
+	   So they can be remixed.
+	 */
+
 	if (dmix->last_appl_ptr < dmix->appl_ptr)
 		size = dmix->appl_ptr - dmix->last_appl_ptr;
 	else
@@ -729,6 +734,9 @@ static snd_pcm_sframes_t snd_pcm_dmix_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
 		return size;
 	result = size;
 
+	/* Always at this point last_appl_ptr == appl_ptr
+	   So (appl_ptr - hw_ptr) indicates the frames which can be remixed
+	 */
 	if (dmix->hw_ptr < dmix->appl_ptr)
 		size = dmix->appl_ptr - dmix->hw_ptr;
 	else
@@ -741,9 +749,12 @@ static snd_pcm_sframes_t snd_pcm_dmix_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
 		slave_size = dmix->slave_appl_ptr + (pcm->boundary - dmix->slave_hw_ptr);
 	if (slave_size < size)
 		size = slave_size;
-	frames -= size;
-	result += size;
-		
+
+	/* frames which should be remixed will be saved
+	   to also backward the appl pointer on success
+	 */
+	frames_to_remix = size;
+
 	/* add sample areas here */
 	src_areas = snd_pcm_mmap_areas(pcm);
 	dst_areas = snd_pcm_mmap_areas(dmix->spcm);
@@ -769,15 +780,15 @@ static snd_pcm_sframes_t snd_pcm_dmix_rewind(snd_pcm_t *pcm, snd_pcm_uframes_t f
 		appl_ptr += transfer;
 		appl_ptr %= pcm->buffer_size;
 	}
-	dmix->last_appl_ptr -= frames;
-	dmix->last_appl_ptr %= pcm->boundary;
-	dmix->slave_appl_ptr -= frames;
-	dmix->slave_appl_ptr %= dmix->slave_boundary;
 	dmix_up_sem(dmix);
 
-	snd_pcm_mmap_appl_backward(pcm, frames);
+	snd_pcm_mmap_appl_backward(pcm, frames_to_remix);
+	result += frames_to_remix;
+	/* At this point last_appl_ptr and appl_ptr has to indicate the
+	 * position of the first not mixed frame
+	 */
 
-	return result + frames;
+	return result;
 }
 
 static snd_pcm_sframes_t snd_pcm_dmix_forwardable(snd_pcm_t *pcm)
-- 
2.7.4
