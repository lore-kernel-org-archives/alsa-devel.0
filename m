From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA calling pcm_pointer excessively?
Date: Thu, 10 May 2012 19:05:56 +0200
Message-ID: <4FABF574.7090804@ladisch.de>
References: <20120510160601.GC12727@n2100.arm.linux.org.uk>
	<20120510162930.GA17361@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 505BF10BAE1
	for <alsa-devel@alsa-project.org>;
	Thu, 10 May 2012 19:06:15 +0200 (CEST)
In-Reply-To: <20120510162930.GA17361@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Russell King - ARM Linux wrote:
> I think what's happening is that snd_pcm_lib_write1() is looping, and
> each time it updates the hardware position, it finds that it can
> transfer 8 or 16 bytes to the buffer.  Once it's transferred that,
> it re-updates the hardware position which has now advanced by another
> 8 or 16 bytes.  Repeat, and you find that snd_pcm_lib_write1() spends
> a lot of time inefficiently copying the buffer.
>
> It seems that it will only sleep if the hardware pointer stops making
> progress.

I'd guess that most existing hardware is fast enough to transfer
samples and has a big enough granularity (typically 32 byte bursts
for PCI) that the pointer doesn't change in consecutive loop
iterations.

This (untested) patch tries to avoid too many busy looping.


Regards,
Clemens


--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -1894,7 +1894,7 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	snd_pcm_uframes_t xfer = 0;
 	snd_pcm_uframes_t offset = 0;
-	int err = 0;
+	int busy_loops = 0, err = 0;

 	if (size == 0)
 		return 0;
@@ -1919,12 +1919,17 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 	runtime->twake = runtime->control->avail_min ? : 1;
 	while (size > 0) {
 		snd_pcm_uframes_t frames, appl_ptr, appl_ofs;
-		snd_pcm_uframes_t avail;
+		snd_pcm_uframes_t avail, avail_wait_max;
 		snd_pcm_uframes_t cont;
+
+		if (busy_loops < 5)
+			avail_wait_max = 0;
+		else
+			avail_wait_max = min(runtime->control->avail_min, size);
 		if (runtime->status->state == SNDRV_PCM_STATE_RUNNING)
 			snd_pcm_update_hw_ptr(substream);
 		avail = snd_pcm_playback_avail(runtime);
-		if (!avail) {
+		if (avail <= avail_wait_max) {
 			if (nonblock) {
 				err = -EAGAIN;
 				goto _end_unlock;
@@ -1934,6 +1939,9 @@ static snd_pcm_sframes_t snd_pcm_lib_write1(struct snd_pcm_substream *substream,
 			err = wait_for_avail(substream, &avail);
 			if (err < 0)
 				goto _end_unlock;
+			busy_loops = 0;
+		} else {
+			busy_loops++;
 		}
 		frames = size > avail ? avail : size;
 		cont = runtime->buffer_size - runtime->control->appl_ptr % runtime->buffer_size;
