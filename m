From: <twischer@de.adit-jv.com>
Subject: [PATCH - IOPLUG DRAIN 1/1] ioplug: drain: Wait with
	pollwhen EAGAIN in blocking mode
Date: Thu, 22 Mar 2018 14:48:56 +0100
Message-ID: <1521726537-7651-2-git-send-email-twischer@de.adit-jv.com>
References: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 811262673B2
 for <alsa-devel@alsa-project.org>; Thu, 22 Mar 2018 14:49:37 +0100 (CET)
In-Reply-To: <1521726537-7651-1-git-send-email-twischer@de.adit-jv.com>
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

With this changes an IO plugin should not block by it self in the
its own snd_pcm_drain() implementation. It should return -EAGAIN and
inform the ALSA library via the poll_descriptors that draining is
done.

In non-blocking mode this implementation expects that the user blocks on
the poll_descriptors whenever snd_pcm_drain() returns -EAGAIN. In
addition the user has to call snd_pcm_drain() again to check if draining
is really done.

This change will not harm existing IO plugins which are blocking in its
snd_pcm_drain() callback.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/include/pcm_ioplug.h b/include/pcm_ioplug.h
index c1310e3..aa08962 100644
--- a/include/pcm_ioplug.h
+++ b/include/pcm_ioplug.h
@@ -169,6 +169,12 @@ struct snd_pcm_ioplug_callback {
 	int (*prepare)(snd_pcm_ioplug_t *io);
 	/**
 	 * drain; optional
+	 * This function should never block. It should return -EAGAIN in case of
+	 * it is not yet done. In this case it will be called again by the ALSA
+	 * library (in blocking mode) or by the user (in non blocking mode).
+	 * In case of -EAGAIN the poll_descriptors have to be used to inform the
+	 * ALSA library that draining is possibly done and this callback has to
+	 * be called again.
 	 */
 	int (*drain)(snd_pcm_ioplug_t *io);
 	/**
diff --git a/src/pcm/pcm_ioplug.c b/src/pcm/pcm_ioplug.c
index 8c0ed48..7682dcd 100644
--- a/src/pcm/pcm_ioplug.c
+++ b/src/pcm/pcm_ioplug.c
@@ -492,17 +492,37 @@ static int snd_pcm_ioplug_drop(snd_pcm_t *pcm)
 static int snd_pcm_ioplug_drain(snd_pcm_t *pcm)
 {
 	ioplug_priv_t *io = pcm->private_data;
-	int err;
+	int err = 0;
 
 	if (io->data->state == SND_PCM_STATE_OPEN)
 		return -EBADFD;
 
 	io->data->state = SND_PCM_STATE_DRAINING;
-	if (io->data->callback->drain)
-		io->data->callback->drain(io->data);
-	snd_pcm_lock(pcm);
-	err = snd_pcm_ioplug_drop(pcm);
-	snd_pcm_unlock(pcm);
+	if (io->data->callback->drain) {
+		err = io->data->callback->drain(io->data);
+
+		/* in blocking mode wait unti draining is done or
+		 * an issue was detected.
+		 */
+		if (!io->data->nonblock) {
+			while (err == -EAGAIN) {
+				snd_pcm_lock(pcm);
+				err = snd_pcm_wait_nocheck(pcm, -1);
+				snd_pcm_unlock(pcm);
+				if (err  < 0)
+					break;
+				err = io->data->callback->drain(io->data);
+			}
+		}
+	}
+
+	/* only drop if draining is done or there was an issue */
+	if (err != -EAGAIN) {
+		snd_pcm_lock(pcm);
+		err = snd_pcm_ioplug_drop(pcm);
+		snd_pcm_unlock(pcm);
+	}
+
 	return err;
 }
 
-- 
2.7.4
