From: Stas Sergeev <stsp@aknet.ru>
Subject: underruns and strange code in pcm_rate.c (and patch)
Date: Mon, 05 Nov 2007 02:48:52 +0300
Message-ID: <472E5A64.6010705@aknet.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030308040501030007070207"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.AKNET.ru [77.246.241.226])
	by alsa0.perex.cz (Postfix) with ESMTP id 34BE9243F9
	for <alsa-devel@alsa-project.org>; Mon,  5 Nov 2007 00:47:24 +0100 (CET)
Received: from ppp91-76-91-117.pppoe.mtu-net.ru ([91.76.91.117])
	by mail.aknet.ru with esmtpa (Exim 4.68 (FreeBSD))
	(envelope-from <stsp@aknet.ru>) id 1IopBb-000Bzt-61
	for alsa-devel@alsa-project.org; Mon, 05 Nov 2007 02:47:23 +0300
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

This is a multi-part message in MIME format.
--------------030308040501030007070207
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi.

I spent 4 week-ends debugging the
constant underruns and lock-ups with
the libao-based programs.
Now I've finally tracked the problem
to some strange code in pcm_rate.c,
namely snd_pcm_rate_poll_descriptors().
I am not sure what was the reason
behind altering the "avail_min" every
time. Looks like some heuristic was
intended, say "see what amount of
fragment part was written now, and
make sure that amount of free space will
be available next time, after poll".
Whatever, this code gives underruns.
It can increase avail_min by almost period_size.
libao sets avail_min==period_size,
so we can end up with avail_min==period_size*2.
libao sets buffer_size==stop_threshold==period_size*2.
So we end up with avail_min~=stop_threshold,
which gives underruns.
Since I don't know how this code was
indended to work, I just removed it,
and everything works perfectly now
(also had to patch libao to check
the returned rate).

The patch is attached, any comments?

Signed-off-by: Stas Sergeev <stsp@aknet.ru>


--------------030308040501030007070207
Content-Type: text/x-patch;
 name="pcm_rate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcm_rate.diff"

--- alsa-lib/src/pcm/pcm_rate.c.old	2007-11-04 17:57:01.000000000 +0300
+++ alsa-lib/src/pcm/pcm_rate.c	2007-11-05 02:20:36.000000000 +0300
@@ -715,38 +715,6 @@
 	return n;
 }
 
-static int snd_pcm_rate_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds, unsigned int space)
-{
-	snd_pcm_rate_t *rate = pcm->private_data;
-	snd_pcm_uframes_t avail_min;
-	int ret, err;
-
-	ret = snd_pcm_generic_poll_descriptors(pcm, pfds, space);
-	if (ret < 0)
-		return ret;
-
-	avail_min = rate->appl_ptr % pcm->period_size;
-	if (avail_min > 0) {
-		recalc(pcm, &avail_min);
-		if (avail_min < rate->gen.slave->buffer_size &&
-		    avail_min != rate->gen.slave->period_size)
-			avail_min++;	/* 1st small little rounding correction */
-		if (avail_min < rate->gen.slave->buffer_size &&
-		    avail_min != rate->gen.slave->period_size)
-			avail_min++;	/* 2nd small little rounding correction */
-		avail_min += rate->orig_avail_min;
-	} else {
-		avail_min = rate->orig_avail_min;
-	}
-	if (rate->sw_params.avail_min == avail_min)
-		return ret;
-	rate->sw_params.avail_min = avail_min;
-	err = snd_pcm_sw_params(rate->gen.slave, &rate->sw_params);
-	if (err < 0)
-		return err;
-	return ret;
-}
-
 static int snd_pcm_rate_commit_area(snd_pcm_t *pcm, snd_pcm_rate_t *rate,
 				    snd_pcm_uframes_t appl_offset,
 				    snd_pcm_uframes_t size,
@@ -1229,7 +1197,7 @@
 	.avail_update = snd_pcm_rate_avail_update,
 	.mmap_commit = snd_pcm_rate_mmap_commit,
 	.poll_descriptors_count = snd_pcm_generic_poll_descriptors_count,
-	.poll_descriptors = snd_pcm_rate_poll_descriptors,
+	.poll_descriptors = snd_pcm_generic_poll_descriptors,
 	.poll_revents = snd_pcm_rate_poll_revents,
 };
 

--------------030308040501030007070207
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030308040501030007070207--
