From: <twischer@de.adit-jv.com>
Subject: [PATCH - IOPLUG 1/1] pcm: ioplug: update prepare and
	draining state correctly
Date: Fri, 16 Mar 2018 11:20:46 +0100
Message-ID: <1521195646-21615-1-git-send-email-twischer@de.adit-jv.com>
References: <s5hk1uc5o43.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 002EF267380
 for <alsa-devel@alsa-project.org>; Fri, 16 Mar 2018 11:20:58 +0100 (CET)
In-Reply-To: <s5hk1uc5o43.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Timo Wischer <twischer@de.adit-jv.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Timo Wischer <twischer@de.adit-jv.com>

PREPARED should only be set when it is done and it was successfully.

DRAINING should be signalled when starting to drain. There is no need to
check if draining was successfully because it will change to drop (SETUP)
in any case.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/ChangeLog b/ChangeLog
index 22df356..3dff7fb 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,4 @@
+* Set IO plug state to PREPARED after calling the IO plugin prepare callback
 * update to libtool 1.3.3
 
 0.1.3 -> 0.2.0
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index af223a1..8c0ed48 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -146,13 +146,16 @@ static int snd_pcm_ioplug_prepare(snd_pcm_t *pcm)
 	ioplug_priv_t *io = pcm->private_data;
 	int err = 0;
 
-	io->data->state = SND_PCM_STATE_PREPARED;
 	snd_pcm_ioplug_reset(pcm);
 	if (io->data->callback->prepare) {
 		snd_pcm_unlock(pcm); /* to avoid deadlock */
 		err = io->data->callback->prepare(io->data);
 		snd_pcm_lock(pcm);
 	}
+	if (err < 0)
+		return err;
+
+	io->data->state = SND_PCM_STATE_PREPARED;
 	return err;
 }
 
@@ -493,6 +496,8 @@ static int snd_pcm_ioplug_drain(snd_pcm_t *pcm)
 
 	if (io->data->state == SND_PCM_STATE_OPEN)
 		return -EBADFD;
+
+	io->data->state = SND_PCM_STATE_DRAINING;
 	if (io->data->callback->drain)
 		io->data->callback->drain(io->data);
 	snd_pcm_lock(pcm);
-- 
2.7.4
