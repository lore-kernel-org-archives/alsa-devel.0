From: Ahmet =?utf-8?B?xLBuYW4=?= <ainan@mathematik.uni-freiburg.de>
Subject: Re: [PATCH] improved snd-aloop quality when
	using	certain samplerates and kernel HZ
Date: Fri, 22 Feb 2008 19:05:28 +0100
Message-ID: <20080222180528.GD6860@mathematik.uni-freiburg.de>
References: <20080219030144.GA12698@mathematik.uni-freiburg.de>
	<20080219125046.GA6455@mathematik.uni-freiburg.de>
	<s5hhcg3svd4.wl%tiwai@suse.de>
	<20080220141906.GA15096@mathematik.uni-freiburg.de>
	<s5h3arnpq4i.wl%tiwai@suse.de>
	<20080221000601.GA4829@mathematik.uni-freiburg.de>
	<s5hmypusssj.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx01.qsc.de (mx01.qsc.de [213.148.129.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 0A42F243F7
	for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2008 19:05:31 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hmypusssj.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

when the time interval for a period is smaller than kernel HZ, then
snd-aloop and snd-dummy cannot call snd_pcm_period_elapsed as fast enough
annymore. this happens for example with games. but the app still needs to
see, that the buffer actually did go further, which is provided by these
patches.

[snd-aloop - better realtime app support]
http://www.mathematik.uni-freiburg.de/IAM/homepages/ainan/alsa-driver-hg-=
aloop-ainan-patch2.diff
[Signed-off-by: Ahmet =C4=B0nan <ainan <at> mathematik.uni-freiburg.de>]

[snd-dummy - better realtime app support]
http://www.mathematik.uni-freiburg.de/IAM/homepages/ainan/alsa-kernel-hg-=
dummy-ainan-patch1.diff
[Signed-off-by: Ahmet =C4=B0nan <ainan <at> mathematik.uni-freiburg.de>]

patches are relative to current hg-tree.

finally even realtime apps like games work smooth.
only one thing left for perfection :)

ahmet

--
admin der abteilung f=C3=BCr angewandte mathematik, tel. 0761-203-5626

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="alsa-driver-hg-aloop-ainan-patch2.diff"

diff -r 89222d702376 drivers/aloop-kernel.c
--- a/drivers/aloop-kernel.c	Thu Feb 21 07:54:16 2008 +0100
+++ b/drivers/aloop-kernel.c	Fri Feb 22 18:16:56 2008 +0100
@@ -198,10 +198,10 @@ static void snd_card_loopback_timer_func
 	spin_lock_irq(&dpcm->lock);
 
 	dpcm->pcm_irq_pos += dpcm->pcm_bps;
+	dpcm->pcm_buf_pos += dpcm->pcm_bps;
+	dpcm->pcm_buf_pos %= dpcm->pcm_buffer_size * dpcm->pcm_hz;
 	if (dpcm->pcm_irq_pos >= dpcm->pcm_period_size * dpcm->pcm_hz) {
 		dpcm->pcm_irq_pos %= dpcm->pcm_period_size * dpcm->pcm_hz;
-		dpcm->pcm_buf_pos += dpcm->pcm_period_size;
-		dpcm->pcm_buf_pos %= dpcm->pcm_buffer_size;
 		spin_unlock_irq(&dpcm->lock);	
 		snd_pcm_period_elapsed(dpcm->substream);
 	} else {
@@ -213,7 +213,7 @@ static snd_pcm_uframes_t snd_card_loopba
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_card_loopback_pcm_t *dpcm = runtime->private_data;
-	return bytes_to_frames(runtime, dpcm->pcm_buf_pos);
+	return bytes_to_frames(runtime, dpcm->pcm_buf_pos / dpcm->pcm_hz);
 }
 
 static struct snd_pcm_hardware snd_card_loopback_info =

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="alsa-kernel-hg-dummy-ainan-patch1.diff"

diff -r 1d499d7e155e drivers/dummy.c
--- a/drivers/dummy.c	Thu Feb 21 12:40:00 2008 +0100
+++ b/drivers/dummy.c	Fri Feb 22 18:25:20 2008 +0100
@@ -259,10 +259,10 @@ static void snd_card_dummy_pcm_timer_fun
 	dpcm->timer.expires = 1 + jiffies;
 	add_timer(&dpcm->timer);
 	dpcm->pcm_irq_pos += dpcm->pcm_bps;
+	dpcm->pcm_buf_pos += dpcm->pcm_bps;
+	dpcm->pcm_buf_pos %= dpcm->pcm_buffer_size * dpcm->pcm_hz;
 	if (dpcm->pcm_irq_pos >= dpcm->pcm_period_size * dpcm->pcm_hz) {
 		dpcm->pcm_irq_pos %= dpcm->pcm_period_size * dpcm->pcm_hz;
-		dpcm->pcm_buf_pos += dpcm->pcm_period_size;
-		dpcm->pcm_buf_pos %= dpcm->pcm_buffer_size;
 		spin_unlock_irqrestore(&dpcm->lock, flags);
 		snd_pcm_period_elapsed(dpcm->substream);
 	} else
@@ -274,7 +274,7 @@ static snd_pcm_uframes_t snd_card_dummy_
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct snd_dummy_pcm *dpcm = runtime->private_data;
 
-	return bytes_to_frames(runtime, dpcm->pcm_buf_pos);
+	return bytes_to_frames(runtime, dpcm->pcm_buf_pos / dpcm->pcm_hz);
 }
 
 static struct snd_pcm_hardware snd_card_dummy_playback =

--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--ReaqsoxgOBHFXBhH--
