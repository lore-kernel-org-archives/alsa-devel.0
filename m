From: Alistair Buxton <a.j.buxton@gmail.com>
Subject: Re: [PATCH] Meter causes freeze when closing audio
	device
Date: Mon, 6 Mar 2017 03:01:47 +0000
Message-ID: <CAO-Op+GZ_eX44eUpABF38LiAFrMDUYP+0SiySscBdjQz4XO8ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f196.google.com (mail-wr0-f196.google.com
 [209.85.128.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D1E7266871
 for <alsa-devel@alsa-project.org>; Mon,  6 Mar 2017 04:01:48 +0100 (CET)
Received: by mail-wr0-f196.google.com with SMTP id l37so20004935wrc.3
 for <alsa-devel@alsa-project.org>; Sun, 05 Mar 2017 19:01:48 -0800 (PST)
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
List-Id: alsa-devel@alsa-project.org

After adding assert(0); to snd_timer_stop I got the following backtrace:

#0  0x00007ffff730d428 in __GI_raise (sig=sig@entry=6) at
../sysdeps/unix/sysv/linux/raise.c:54
#1  0x00007ffff730f02a in __GI_abort () at abort.c:89
#2  0x00007ffff7305bd7 in __assert_fail_base (fmt=<optimised out>,
assertion=assertion@entry=0x7ffff7b9439e "0",
    file=file@entry=0x7ffff7b9e8b9 "timer.c", line=line@entry=918,
    function=function@entry=0x7ffff7b9e9c8 <__PRETTY_FUNCTION__.10913>
"snd_timer_stop") at assert.c:92
#3  0x00007ffff7305c82 in __GI___assert_fail
(assertion=assertion@entry=0x7ffff7b9439e "0",
    file=file@entry=0x7ffff7b9e8b9 "timer.c", line=line@entry=918,
    function=function@entry=0x7ffff7b9e9c8 <__PRETTY_FUNCTION__.10913>
"snd_timer_stop") at assert.c:101
#4  0x00007ffff7b64503 in snd_timer_stop (timer=<optimised out>) at timer.c:918
#5  0x00007ffff7b5158d in snd_pcm_dmix_sync_ptr0
(pcm=pcm@entry=0x622de0, slave_hw_ptr=<optimised out>)
    at pcm_dmix.c:421
#6  0x00007ffff7b51aac in snd_pcm_dmix_status (pcm=0x622de0,
status=0x7ffff6af1e80) at pcm_dmix.c:496
#7  0x00007ffff7b18f11 in snd_pcm_status (pcm=pcm@entry=0x622de0,
status=status@entry=0x7ffff6af1e80) at pcm.c:977
#8  0x00007ffff7b48bc0 in snd_pcm_meter_thread (data=0x622940) at
pcm_meter.c:200
#9  0x00007ffff76a86ba in start_thread (arg=0x7ffff6af2700) at
pthread_create.c:333
#10 0x00007ffff73de82d in clone () at
../sysdeps/unix/sysv/linux/x86_64/clone.S:109

So the meter thread is indirectly stopping the timer while the main
thread is trying to poll it.

The following patch avoids this issue. Is it the right way to fix it?

>From f21cd1ec8245198279cc2ad606041f7f59e8341d Mon Sep 17 00:00:00 2001
From: Alistair Buxton <a.j.buxton@gmail.com>
Date: Mon, 6 Mar 2017 02:50:35 +0000
Subject: [PATCH] pcm: meter: Put a mutex around slave drain to prevent
 deadlock

The meter thread calls _status on its slave. If this happens while
dmix is draining, the timer will be stopped, causing the main thread
 to get stuck in poll().
---
 src/pcm/pcm_meter.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_meter.c b/src/pcm/pcm_meter.c
index d71af7a..43a25fc 100644
--- a/src/pcm/pcm_meter.c
+++ b/src/pcm/pcm_meter.c
@@ -324,6 +324,18 @@ static int snd_pcm_meter_start(snd_pcm_t *pcm)
 	return err;
 }

+static int snd_pcm_meter_drain(snd_pcm_t *pcm)
+{
+	snd_pcm_meter_t *meter = pcm->private_data;
+	int err;
+	pthread_mutex_lock(&meter->running_mutex);
+	err = snd_pcm_drain(meter->gen.slave);
+	if (err >= 0)
+		pthread_cond_signal(&meter->running_cond);
+	pthread_mutex_unlock(&meter->running_mutex);
+	return err;
+}
+
 static snd_pcm_sframes_t snd_pcm_meter_rewind(snd_pcm_t *pcm,
snd_pcm_uframes_t frames)
 {
 	snd_pcm_meter_t *meter = pcm->private_data;
@@ -530,7 +542,7 @@ static const snd_pcm_fast_ops_t snd_pcm_meter_fast_ops = {
 	.reset = snd_pcm_meter_reset,
 	.start = snd_pcm_meter_start,
 	.drop = snd_pcm_generic_drop,
-	.drain = snd_pcm_generic_drain,
+	.drain = snd_pcm_meter_drain,
 	.pause = snd_pcm_generic_pause,
 	.rewindable = snd_pcm_generic_rewindable,
 	.rewind = snd_pcm_meter_rewind,
-- 
2.7.4



-- 
Alistair Buxton
a.j.buxton@gmail.com
