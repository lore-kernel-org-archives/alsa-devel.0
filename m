From: "Arkadiusz (Arkq) Bokowy" <arkadiusz.bokowy@gmail.com>
Subject: [PATCH 2/3] ioplug: Check for callback error codes
Date: Sun, 7 Jan 2018 14:31:07 +0100
Message-ID: <20180107143107.5d4dbf8d@sambook>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf0-f66.google.com (mail-lf0-f66.google.com
 [209.85.215.66])
 by alsa0.perex.cz (Postfix) with ESMTP id E7BCC267035
 for <alsa-devel@alsa-project.org>; Sun,  7 Jan 2018 14:33:16 +0100 (CET)
Received: by mail-lf0-f66.google.com with SMTP id y71so9490362lfd.12
 for <alsa-devel@alsa-project.org>; Sun, 07 Jan 2018 05:33:16 -0800 (PST)
Received: from sambook (89-73-142-93.dynamic.chello.pl. [89.73.142.93])
 by smtp.gmail.com with ESMTPSA id f73sm1764330lfg.93.2018.01.07.05.33.15
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 07 Jan 2018 05:33:16 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ioplug: Check for callback error codes

Signed-off-by: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
---
 src/pcm/pcm_ioplug.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 7a782e68..06c20d7b 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -49,7 +49,7 @@ typedef struct snd_pcm_ioplug_priv {
 
 /* update the hw pointer */
 /* called in lock */
-static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
+static int snd_pcm_ioplug_hw_ptr_update(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
 	snd_pcm_sframes_t hw;
@@ -63,8 +63,10 @@ static void snd_pcm_ioplug_hw_ptr_update(snd_pcm_t
*pcm) delta = pcm->buffer_size + hw - io->last_hw;
 		snd_pcm_mmap_hw_forward(io->data->pcm, delta);
 		io->last_hw = hw;
+		return 0;
 	} else
 		io->data->state = SNDRV_PCM_STATE_XRUN;
+		return -EPIPE;
 }
 
 static int snd_pcm_ioplug_info(snd_pcm_t *pcm, snd_pcm_info_t *info)
@@ -119,7 +121,10 @@ static int snd_pcm_ioplug_delay(snd_pcm_t *pcm,
snd_pcm_sframes_t *delayp) io->data->callback->delay)
 		return io->data->callback->delay(io->data, delayp);
 	else {
-		snd_pcm_ioplug_hw_ptr_update(pcm);
+		int err;
+		err = snd_pcm_ioplug_hw_ptr_update(pcm);
+		if (err < 0)
+			return err;
 		*delayp = snd_pcm_mmap_hw_avail(pcm);
 	}
 	return 0;
@@ -468,11 +473,14 @@ static int snd_pcm_ioplug_start(snd_pcm_t *pcm)
 static int snd_pcm_ioplug_drop(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
+	int err;
 
 	if (io->data->state == SND_PCM_STATE_OPEN)
 		return -EBADFD;
 
-	io->data->callback->stop(io->data);
+	err = io->data->callback->stop(io->data);
+	if (err < 0)
+		return err;
 
 	gettimestamp(&io->trigger_tstamp, pcm->tstamp_type);
 	io->data->state = SND_PCM_STATE_SETUP;
@@ -488,8 +496,11 @@ static int snd_pcm_ioplug_drain(snd_pcm_t *pcm)
 
 	if (io->data->state == SND_PCM_STATE_OPEN)
 		return -EBADFD;
-	if (io->data->callback->drain)
-		io->data->callback->drain(io->data);
+	if (io->data->callback->drain) {
+		err = io->data->callback->drain(io->data);
+		if (err < 0)
+			return err;
+	}
 	snd_pcm_lock(pcm);
 	err = snd_pcm_ioplug_drop(pcm);
 	snd_pcm_unlock(pcm);
@@ -545,7 +556,7 @@ static int snd_pcm_ioplug_resume(snd_pcm_t *pcm)
 	ioplug_priv_t *io = pcm->private_data;
 
 	if (io->data->callback->resume)
-		io->data->callback->resume(io->data);
+		return io->data->callback->resume(io->data);
 	return 0;
 }
 
@@ -641,10 +652,11 @@ static snd_pcm_sframes_t
snd_pcm_ioplug_avail_update(snd_pcm_t *pcm) {
 	ioplug_priv_t *io = pcm->private_data;
 	snd_pcm_uframes_t avail;
+	int err;
 
-	snd_pcm_ioplug_hw_ptr_update(pcm);
-	if (io->data->state == SND_PCM_STATE_XRUN)
-		return -EPIPE;
+	err = snd_pcm_ioplug_hw_ptr_update(pcm);
+	if (err < 0)
+		return err;
 	if (pcm->stream == SND_PCM_STREAM_CAPTURE &&
 	    pcm->access != SND_PCM_ACCESS_RW_INTERLEAVED &&
 	    pcm->access != SND_PCM_ACCESS_RW_NONINTERLEAVED) {
@@ -799,13 +811,14 @@ static void clear_io_params(ioplug_priv_t *io)
 static int snd_pcm_ioplug_close(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
+	int err = 0;
 
 	clear_io_params(io);
 	if (io->data->callback->close)
-		io->data->callback->close(io->data);
+		err = io->data->callback->close(io->data);
 	free(io);
 
-	return 0;
+	return err;
 }
 
 static const snd_pcm_ops_t snd_pcm_ioplug_ops = {
-- 
2.13.6
