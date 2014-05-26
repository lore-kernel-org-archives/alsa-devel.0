From: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Subject: =?utf-8?q?=5BPATCH=5D_alsa-plugins=3A_jack=3A_fix_po?=
 =?utf-8?q?lling_and_recovering?=
Date: Mon, 26 May 2014 07:54:05 +0400
Message-ID: <1401076445.134807312@f158.i.mail.ru>
Reply-To: =?UTF-8?B?U2VyZ2V5?= <sergemp@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from f158.i.mail.ru (f158.i.mail.ru [94.100.178.202])
 by alsa0.perex.cz (Postfix) with ESMTP id 027AA264F03
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 05:54:05 +0200 (CEST)
Received: from mail by f158.i.mail.ru with local (envelope-from
 <sergemp@mail.ru>) id 1WolzB-00088E-66
 for alsa-devel@alsa-project.org; Mon, 26 May 2014 07:54:05 +0400
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?YWxzYS1kZXZlbA==?= <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

This patch fixes polling in alsa-to-jack plugin.
It makes poll()+_poll_revents() return correct values
when there's something to read/write.
It also makes jack pcm survive snd_pcm_recover(-EPIPE).
---
 jack/pcm_jack.c |   62 ++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 7 deletions(-)

diff --git a/jack/pcm_jack.c b/jack/pcm_jack.c
index 7a8b24d..36fbdc9 100644
--- a/jack/pcm_jack.c
+++ b/jack/pcm_jack.c
@@ -42,6 +42,7 @@ typedef struct {
 	unsigned int num_ports;
 	unsigned int hw_ptr;
 	unsigned int sample_bits;
+	snd_pcm_uframes_t min_avail;
 
 	unsigned int channels;
 	snd_pcm_channel_area_t *areas;
@@ -50,6 +51,41 @@ typedef struct {
 	jack_client_t *client;
 } snd_pcm_jack_t;
 
+static int snd_pcm_jack_stop(snd_pcm_ioplug_t *io);
+
+static int pcm_poll_block_check(snd_pcm_ioplug_t *io)
+{
+	static char buf[32];
+	snd_pcm_sframes_t avail;
+	snd_pcm_jack_t *jack = io->private_data;
+
+	if (io->state == SND_PCM_STATE_RUNNING ||
+	    (io->state == SND_PCM_STATE_PREPARED && io->stream == SND_PCM_STREAM_CAPTURE)) {
+		avail = snd_pcm_avail_update(io->pcm);
+		if (avail >= 0 && avail < jack->min_avail) {
+			while (read(io->poll_fd, &buf, sizeof(buf)) == sizeof(buf));
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
+static int pcm_poll_unblock_check(snd_pcm_ioplug_t *io)
+{
+	static char buf[1];
+	snd_pcm_sframes_t avail;
+	snd_pcm_jack_t *jack = io->private_data;
+
+	avail = snd_pcm_avail_update(io->pcm);
+	if (avail < 0 || avail >= jack->min_avail) {
+		write(jack->fd, &buf, 1);
+		return 1;
+	}
+
+	return 0;
+}
+
 static void snd_pcm_jack_free(snd_pcm_jack_t *jack)
 {
 	if (jack) {
@@ -81,14 +117,10 @@ static int snd_pcm_jack_poll_revents(snd_pcm_ioplug_t *io,
 				     struct pollfd *pfds, unsigned int nfds,
 				     unsigned short *revents)
 {
-	static char buf[1];
-	
 	assert(pfds && nfds == 1 && revents);
 
-	read(pfds[0].fd, buf, 1);
-
 	*revents = pfds[0].revents & ~(POLLIN | POLLOUT);
-	if (pfds[0].revents & POLLIN)
+	if (pfds[0].revents & POLLIN && !pcm_poll_block_check(io))
 		*revents |= (io->stream == SND_PCM_STREAM_PLAYBACK) ? POLLOUT : POLLIN;
 	return 0;
 }
@@ -105,7 +137,6 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 	snd_pcm_jack_t *jack = io->private_data;
 	const snd_pcm_channel_area_t *areas;
 	snd_pcm_uframes_t xfer = 0;
-	static char buf[1];
 	unsigned int channel;
 	
 	for (channel = 0; channel < io->channels; channel++) {
@@ -145,7 +176,7 @@ snd_pcm_jack_process_cb(jack_nframes_t nframes, snd_pcm_ioplug_t *io)
 		xfer += frames;
 	}
 
-	write(jack->fd, buf, 1); /* for polling */
+	pcm_poll_unblock_check(io); /* unblock socket for polling if needed */
 
 	return 0;
 }
@@ -154,9 +185,26 @@ static int snd_pcm_jack_prepare(snd_pcm_ioplug_t *io)
 {
 	snd_pcm_jack_t *jack = io->private_data;
 	unsigned int i;
+	snd_pcm_sw_params_t *swparams;
+	int err;
 
 	jack->hw_ptr = 0;
 
+	jack->min_avail = io->period_size;
+	snd_pcm_sw_params_alloca(&swparams);
+	err = snd_pcm_sw_params_current(io->pcm, swparams);
+	if (err == 0) {
+		snd_pcm_sw_params_get_avail_min(swparams, &jack->min_avail);
+	}
+
+	/* deactivate jack connections if this is XRUN recovery */
+	snd_pcm_jack_stop(io);
+
+	if (io->stream == SND_PCM_STREAM_PLAYBACK)
+		pcm_poll_unblock_check(io); /* playback pcm initially accepts writes */
+	else
+		pcm_poll_block_check(io); /* block capture pcm if that's XRUN recovery */
+
 	if (jack->ports)
 		return 0;
 
-- 
1.7.10.4
