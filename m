From: pl bossart <bossart.nospam@gmail.com>
Subject: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Wed, 2 Dec 2009 03:15:16 -0600
Message-ID: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id E2C9F24458
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 10:15:17 +0100 (CET)
Received: by pwj11 with SMTP id 11so7925335pwj.32
	for <alsa-devel@alsa-project.org>; Wed, 02 Dec 2009 01:15:16 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

Hi,
I have been having issues for a while now with PulseAudio running on
an older Thinkpad X41. PulseAudio relies on snd_pcm_avail() to detect
underflows and increases the timer watermark when they happen. There
are actually no audible underflows though...
So I instrumented both PulseAudio (enabling DEBUG_TIMING in the
alsa-sink.c code) and the kernel (latest alsa-kernel git) by adding
the following printk  in pcm.h:

static inline snd_pcm_uframes_t snd_pcm_playback_avail(struct
snd_pcm_runtime *runtime)
{
	snd_pcm_sframes_t avail = runtime->status->hw_ptr +
runtime->buffer_size - runtime->control->appl_ptr;
	if (avail < 0)
		avail += runtime->boundary;
	else if ((snd_pcm_uframes_t) avail >= runtime->boundary)
		avail -= runtime->boundary;
        //plb
        if(avail > runtime->buffer_size) {
            snd_printk(KERN_ERR "avail %d hw_ptr %d buffer %d appl_ptr %d \n",
                       avail, runtime->status->hw_ptr,
runtime->buffer_size, runtime->control->appl_ptr);
        }
	return avail;
}

In my tests this error condition where avail is larger than the ring
buffer happens fairly often. The dmesg log show messages such as
[  834.524479] ALSA include/sound/pcm.h:600: avail 16403 hw_ptr 24351
buffer 16384 appl_ptr 24332
[  835.266937] ALSA include/sound/pcm.h:600: avail 16407 hw_ptr 55841
buffer 16384 appl_ptr 55818
and these messages are correlated with the times when PulseAudio
detects underflows.
The full log can be found at http://pastebin.com/f210aa108.

I believe the issue is the accuracy of the hw_ptr reported by
snd_intel8x0_pcm_pointer. If indeed such a condition occurred, it
should be flagged as underflow, shouldn't it? There's been some
changes in this part of the code to avoid extremely large values, here
the issue seems more subtle, the pointer is only slightly off in most
cases. This does screw-up PulseAudio though, the timer watermark keeps
increasing and low-latency isn't possible.

I'd be more than happy to run more experiments, however I have no idea
what the hardware does to report the position of the hw pointer.
Thanks for your feedback
- Pierre
