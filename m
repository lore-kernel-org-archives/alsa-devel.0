From: Ahmet =?utf-8?B?xLBuYW4=?= <ainan@mathematik.uni-freiburg.de>
Subject: Re: [PATCH] improved snd-aloop quality when
	using	certain samplerates and kernel HZ
Date: Wed, 20 Feb 2008 15:19:06 +0100
Message-ID: <20080220141906.GA15096@mathematik.uni-freiburg.de>
References: <20080219030144.GA12698@mathematik.uni-freiburg.de>
	<20080219125046.GA6455@mathematik.uni-freiburg.de>
	<s5hhcg3svd4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lEGEL1/lMxI0MVQ2"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx01.qsc.de (mx01.qsc.de [213.148.129.14])
	by alsa0.perex.cz (Postfix) with ESMTP id 34E952443E
	for <alsa-devel@alsa-project.org>; Wed, 20 Feb 2008 15:19:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hhcg3svd4.wl%tiwai@suse.de>
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


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

more cleanups.

removed some unneeded stuff.
patch is relative to current hg-tree.

http://www.mathematik.uni-freiburg.de/IAM/homepages/ainan/alsa-driver-hg-=
aloop-ainan-patch0.diff

Signed-off-by: Ahmet =C4=B0nan <ainan <at> mathematik.uni-freiburg.de>

btw, my "nice" idea turned out to be a bitch, again. its really funny how
worse almoust always is better. :(

ahmet

--
admin der abteilung f=C3=BCr angewandte mathematik, tel. 0761-203-5626

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="alsa-driver-hg-aloop-ainan-patch0.diff"

diff -r 4ce2c0f9f2ef drivers/aloop-kernel.c
--- a/drivers/aloop-kernel.c	Wed Feb 20 12:46:42 2008 +0100
+++ b/drivers/aloop-kernel.c	Wed Feb 20 15:05:16 2008 +0100
@@ -86,7 +86,6 @@ typedef struct snd_card_loopback_pcm {
 	unsigned int pcm_bps;		/* bytes per second */
 	unsigned int pcm_hz;		/* HZ */
 	unsigned int pcm_irq_pos;	/* IRQ position */
-	unsigned int pcm_buf_pos;	/* position in buffer */
 	unsigned int pcm_period_pos;	/* period aligned pos in buffer */
 	struct snd_pcm_substream *substream;
 	struct snd_card_loopback_cable *cable;
@@ -165,7 +164,6 @@ static int snd_card_loopback_prepare(str
 	dpcm->pcm_size = frames_to_bytes(runtime, runtime->buffer_size);
 	dpcm->pcm_count = frames_to_bytes(runtime, runtime->period_size);
 	dpcm->pcm_irq_pos = 0;
-	dpcm->pcm_buf_pos = 0;
 	dpcm->pcm_period_pos = 0;
 
 	cable->hw.formats = (1ULL << runtime->format);
@@ -216,8 +214,6 @@ static void snd_card_loopback_timer_func
 	spin_lock_irq(&dpcm->lock);
 
 	dpcm->pcm_irq_pos += dpcm->pcm_bps;
-	dpcm->pcm_buf_pos += dpcm->pcm_bps;
-	dpcm->pcm_buf_pos %= dpcm->pcm_size * dpcm->pcm_hz;
 	if (dpcm->pcm_irq_pos >= dpcm->pcm_count * dpcm->pcm_hz) {
 		dpcm->pcm_irq_pos %= dpcm->pcm_count * dpcm->pcm_hz;
 		dpcm->pcm_period_pos += dpcm->pcm_count;

--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--lEGEL1/lMxI0MVQ2--
