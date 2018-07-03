From: <twischer@de.adit-jv.com>
Subject: [PATCH - JACK IO plug 1/2] jack: Avoid call to
	snd_pcm_avail_update() from JACK thread
Date: Tue, 3 Jul 2018 14:23:59 +0200
Message-ID: <1530620639-6173-1-git-send-email-twischer@de.adit-jv.com>
References: <s5hmuv8zfjk.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [62.225.105.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 334E326735C
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 14:24:52 +0200 (CEST)
In-Reply-To: <s5hmuv8zfjk.wl-tiwai@suse.de>
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

snd_pcm_avail_update() can call snd_pcm_jack_stop() but
snd_pcm_jack_stop() should not be called by the JACK thread.
It should only be called by the thread how has called
snd_pcm_jack_start().

In addition the execution of snd_pcm_avail_update() can take a while.
Therefore it should not be called by the JACK thread to not block this
thread.

Signed-off-by: Timo Wischer <twischer@de.adit-jv.com>

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index e3df4d2..5a57e13 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -62,13 +62,13 @@ static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io);
 static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
 {
 	static char buf[32];
-	snd_pcm_sframes_t avail;
+	snd_pcm_uframes_t avail;
 	snd_pcm_jack_t *jack = io->private_data;
 
 	if (io->state == SND_PCM_STATE_RUNNING ||
 	    (io->state == SND_PCM_STATE_PREPARED && io->stream == SND_PCM_STREAM_CAPTURE)) {
-		avail = snd_pcm_avail_update(io->pcm);
-		if (avail >= 0 && avail < jack->min_avail) {
+		avail = snd_pcm_ioplug_avail(io, jack->hw_ptr, io->appl_ptr);
+		if (avail < jack->min_avail) {
 			while (read(io->poll_fd, &buf, sizeof(buf)) == sizeof(buf))
 				;
 			return 1;
@@ -81,11 +81,11 @@ static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
 static int pcm_poll_unblock_check(snd_pcm_ioplug_t *io)
 {
 	static char buf[1];
-	snd_pcm_sframes_t avail;
+	snd_pcm_uframes_t avail;
 	snd_pcm_jack_t *jack = io->private_data;
 
-	avail = snd_pcm_avail_update(io->pcm);
-	if (avail < 0 || avail >= jack->min_avail) {
+	avail = snd_pcm_ioplug_avail(io, jack->hw_ptr, io->appl_ptr);
+	if (avail >= jack->min_avail) {
 		write(jack->fd, &buf, 1);
 		return 1;
 	}
-- 
2.7.4
