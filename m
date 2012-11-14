From: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
Subject: [PATCH 1/2] pcm_pulse: do not trigger immediately at
	start
Date: Wed, 14 Nov 2012 20:07:56 +0200
Message-ID: <1352916477-17552-1-git-send-email-remi@remlab.net>
References: <201211142007.19751@leon.remlab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from oyp.chewa.net (oyp.chewa.net [91.121.6.101])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E40A2617B0
 for <alsa-devel@alsa-project.org>; Wed, 14 Nov 2012 19:08:03 +0100 (CET)
In-Reply-To: <201211142007.19751@leon.remlab.net>
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
Cc: =?UTF-8?q?R=C3=A9mi=20Denis-Courmont?= <remi@remlab.net>
List-Id: alsa-devel@alsa-project.org

There are no samples to play at that point so this is useless.
The non-zero buffer_attr.prebuf ensures that the PulseAudio daemon will
start streaming automatically (like ALSA sw_params start_threshold).
---
 pulse/pcm_pulse.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/pulse/pcm_pulse.c b/pulse/pcm_pulse.c
index 24fd4da..0165120 100644
--- a/pulse/pcm_pulse.c
+++ b/pulse/pcm_pulse.c
@@ -204,8 +204,8 @@ static void stream_success_cb(pa_stream * p, int success, void *userdata)
 static int pulse_start(snd_pcm_ioplug_t * io)
 {
 	snd_pcm_pulse_t *pcm = io->private_data;
-	pa_operation *o, *u;
-	int err = 0, err_o = 0, err_u = 0;
+	pa_operation *o;
+	int err = 0, err_o = 0;
 
 	assert(pcm);
 
@@ -224,18 +224,12 @@ static int pulse_start(snd_pcm_ioplug_t * io)
 		goto finish;
 	}
 
-	u = pa_stream_trigger(pcm->stream, stream_success_cb, pcm);
-
 	pcm->underrun = 0;
 	err_o = pulse_wait_operation(pcm->p, o);
-	if (u)
-		err_u = pulse_wait_operation(pcm->p, u);
 
 	pa_operation_unref(o);
-	if (u)
-		pa_operation_unref(u);
 
-	if (err_o < 0 || err_u < 0) {
+	if (err_o < 0) {
 		err = -EIO;
 		goto finish;
 	}
-- 
1.7.10.4
