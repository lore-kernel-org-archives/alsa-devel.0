From: Ahmet =?utf-8?B?xLBuYW4=?= <ainan@mathematik.uni-freiburg.de>
Subject: Re: [PATCH] improved snd-aloop quality when using
	certain samplerates and kernel HZ
Date: Tue, 19 Feb 2008 13:50:46 +0100
Message-ID: <20080219125046.GA6455@mathematik.uni-freiburg.de>
References: <20080219030144.GA12698@mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx02.qsc.de (mx02.qsc.de [213.148.130.14])
	by alsa0.perex.cz (Postfix) with ESMTP id D182A10391F
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 13:50:49 +0100 (CET)
Received: from localhost (port-92-194-71-124.dynamic.qsc.de [92.194.71.124])
	by mx02.qsc.de (Postfix) with ESMTP id 90A4816C00DA
	for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2008 13:50:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20080219030144.GA12698@mathematik.uni-freiburg.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

sorry, forget about the patch before. this one here is a lot better to re=
ad
and fixes one silly mistake.

http://www.mathematik.uni-freiburg.de/IAM/homepages/ainan/alsa-driver-1.0=
.15-aloop-ainan-patch1.diff
=20
Signed-off-by: Ahmet =C4=B0nan <ainan <at> mathematik.uni-freiburg.de>
=20
please also include my email address when responding - i have no intentio=
n
to enable recieving emails from the list.

ahmet

--
admin der abteilung f=C3=BCr angewandte mathematik, tel. 0761-203-5626

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="alsa-driver-1.0.15-aloop-ainan-patch1.diff"

--- aloop-kernel-orig.c	2008-02-19 03:27:10.203115360 +0100
+++ aloop-kernel.c	2008-02-19 13:39:27.040593408 +0100
@@ -32,9 +32,6 @@
 
 /* comment in to trash your kernel logfiles */
 /* #define SND_CARD_LOOPBACK_VERBOSE */
-/* comment in for synchronization on start trigger
- * works well on alsa apps but bad on oss emulation */
-/* #define SND_CARD_LOOPBACK_START_SYNC */
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@perex.cz>");
 MODULE_DESCRIPTION("A loopback soundcard");
@@ -85,15 +82,12 @@
 	snd_card_loopback_t *loopback;
 	spinlock_t lock;
 	struct timer_list timer;
-	int stream;
-	unsigned int pcm_1000_size;
-	unsigned int pcm_1000_count;
 	unsigned int pcm_size;
 	unsigned int pcm_count;
 	unsigned int pcm_bps;		/* bytes per second */
-	unsigned int pcm_1000_jiffie;	/* 1000 * bytes per one jiffie */
-	unsigned int pcm_1000_irq_pos;	/* IRQ position */
-	unsigned int pcm_1000_buf_pos;	/* position in buffer */
+	unsigned int pcm_hz;		/* HZ */
+	unsigned int pcm_irq_pos;	/* IRQ position */
+	unsigned int pcm_buf_pos;	/* position in buffer */
 	unsigned int pcm_period_pos;	/* period aligned pos in buffer */
 	struct snd_pcm_substream *substream;
 	struct snd_card_loopback_cable *cable;
@@ -123,18 +117,7 @@
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
-#ifdef SND_CARD_LOOPBACK_START_SYNC
-	snd_card_loopback_pcm_t *capture_dpcm;
-#endif
 	if (cmd == SNDRV_PCM_TRIGGER_START) {
-#ifdef SND_CARD_LOOPBACK_START_SYNC
-		if (dpcm->cable->capture_running) {
-			capture_dpcm = dpcm->cable->capture->runtime->private_data;
-			dpcm->pcm_1000_irq_pos = capture_dpcm->pcm_1000_irq_pos;
-			dpcm->pcm_1000_buf_pos = capture_dpcm->pcm_1000_buf_pos;
-			dpcm->pcm_period_pos = capture_dpcm->pcm_period_pos;
-		}
-#endif
 		dpcm->cable->playback_running = 1;
 		snd_card_loopback_timer_start(substream);
 	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
@@ -154,18 +137,7 @@
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
-#ifdef SND_CARD_LOOPBACK_START_SYNC
-	snd_card_loopback_pcm_t *playback_dpcm;
-#endif
 	if (cmd == SNDRV_PCM_TRIGGER_START) {
-#ifdef SND_CARD_LOOPBACK_START_SYNC
-		if (dpcm->cable->playback_running) {
-			playback_dpcm = dpcm->cable->playback->runtime->private_data;
-			dpcm->pcm_1000_irq_pos = playback_dpcm->pcm_1000_irq_pos;
-			dpcm->pcm_1000_buf_pos = playback_dpcm->pcm_1000_buf_pos;
-			dpcm->pcm_period_pos = playback_dpcm->pcm_period_pos;
-		}
-#endif
 		dpcm->cable->capture_running = 1;
 		snd_card_loopback_timer_start(substream);
 	} else if (cmd == SNDRV_PCM_TRIGGER_STOP) {
@@ -190,13 +162,11 @@
 	if (bps <= 0)
 		return -EINVAL;
 	dpcm->pcm_bps = bps;
-	dpcm->pcm_1000_jiffie = (1000 * bps) / HZ;
+	dpcm->pcm_hz = HZ;
 	dpcm->pcm_size = frames_to_bytes(runtime, runtime->buffer_size);
 	dpcm->pcm_count = frames_to_bytes(runtime, runtime->period_size);
-	dpcm->pcm_1000_size = 1000 * frames_to_bytes(runtime, runtime->buffer_size);
-	dpcm->pcm_1000_count = 1000 * frames_to_bytes(runtime, runtime->period_size);
-	dpcm->pcm_1000_irq_pos = 0;
-	dpcm->pcm_1000_buf_pos = 0;
+	dpcm->pcm_irq_pos = 0;
+	dpcm->pcm_buf_pos = 0;
 	dpcm->pcm_period_pos = 0;
 
 	cable->hw.formats = (1ULL << runtime->format);
@@ -246,11 +216,11 @@
 	add_timer(&dpcm->timer);
 	spin_lock_irq(&dpcm->lock);
 
-	dpcm->pcm_1000_irq_pos += dpcm->pcm_1000_jiffie;
-	dpcm->pcm_1000_buf_pos += dpcm->pcm_1000_jiffie;
-	dpcm->pcm_1000_buf_pos %= dpcm->pcm_1000_size;
-	if (dpcm->pcm_1000_irq_pos >= dpcm->pcm_1000_count) {
-		dpcm->pcm_1000_irq_pos %= dpcm->pcm_1000_count;
+	dpcm->pcm_irq_pos += dpcm->pcm_bps;
+	dpcm->pcm_buf_pos += dpcm->pcm_bps;
+	dpcm->pcm_buf_pos %= dpcm->pcm_size * dpcm->pcm_hz;
+	if (dpcm->pcm_irq_pos >= dpcm->pcm_count * dpcm->pcm_hz) {
+		dpcm->pcm_irq_pos %= dpcm->pcm_count * dpcm->pcm_hz;
 		dpcm->pcm_period_pos += dpcm->pcm_count;
 		dpcm->pcm_period_pos %= dpcm->pcm_size;
 		spin_unlock_irq(&dpcm->lock);	
@@ -381,7 +351,6 @@
 	dpcm->timer.data = (unsigned long)dpcm;
 	dpcm->timer.function = snd_card_loopback_timer_function;
 	dpcm->cable = &loopback->cables[substream->number][half];
-	dpcm->stream = substream->stream;
 	runtime->private_data = dpcm;
 	runtime->private_free = snd_card_loopback_runtime_free;
 	runtime->hw = snd_card_loopback_info;

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--HlL+5n6rz5pIUxbD--
