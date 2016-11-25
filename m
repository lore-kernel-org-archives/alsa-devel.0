From: sutar.mounesh@gmail.com
Subject: [PATCH] alsa-lib: alsa dshare endless playback of
	buffer
Date: Fri, 25 Nov 2016 16:43:34 +0530
Message-ID: <1480072414-17398-1-git-send-email-sutar.mounesh@gmail.com>
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
Cc: alsa-devel@alsa-project.org, Anant Agrawal <Anant_Agrawal@mentor.com>, mounesh_sutar@mentor.com
List-Id: alsa-devel@alsa-project.org

From: Anant Agrawal <Anant_Agrawal@mentor.com>

On snd_pcm_drain() the slave PCM driven via plugin DSHARE is not filled with
silence. Result is endless playback of buffer content until pcm is closed.
In ALSA pcm dshare plugin, called do_silence method to fix the issue.

Signed-off-by: Anant Agrawal <Anant_Agrawal@mentor.com>

---
--- alsa-lib-1.0.29.orig/src/pcm/pcm_dshare.c	2015-04-28 08:20:44.662995477 -0700
+++ alsa-lib-1.0.29/src/pcm/pcm_dshare.c	2015-04-28 08:20:59.603077419 -0700
@@ -195,6 +195,7 @@
 		dshare->avail_max = avail;
 	if (avail >= pcm->stop_threshold) {
 		snd_timer_stop(dshare->timer);
+		do_silence(pcm);
 		gettimestamp(&dshare->trigger_tstamp, pcm->tstamp_type);
 		if (dshare->state == SND_PCM_STATE_RUNNING) {
 			dshare->state = SND_PCM_STATE_XRUN;
