From: Nate Case <ncase@xes-inc.com>
Subject: snd_pcm_avail() and snd_pcm_avail_update() always
 returns buffer_size
Date: Wed, 10 Apr 2013 10:09:16 -0500 (CDT)
Message-ID: <9206524.125916.1365606552656.JavaMail.ncase@ncase1>
References: <7690603.125468.1365197646502.JavaMail.ncase@natec>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from xes-mad.com (xes-mad.com [216.165.139.218])
 by alsa0.perex.cz (Postfix) with ESMTP id 81C22265FA3
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 17:09:18 +0200 (CEST)
Received: from zimbra.xes-mad.com (cal [10.52.0.127])
 by xes-mad.com (8.13.8/8.13.8) with ESMTP id r3AF9Glr005582
 for <alsa-devel@alsa-project.org>; Wed, 10 Apr 2013 10:09:16 -0500
In-Reply-To: <7690603.125468.1365197646502.JavaMail.ncase@natec>
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

Hello,

I'm debugging an issue where both snd_pcm_avail_update() and
snd_pcm_avail() are always returning buffer_size, even after
successfully calling snd_pcm_writei() repeatedly.

This is causing problems when I first start playback.  My goal was to
fill up the playback buffer until it's almost full when first starting,
and then enter my regular playback loop where I write period_size
at a time.

However, I'm not able to tell when the playback buffer is full from
snd_pcm_avail() or snd_pcm_avail_update() as expected.  In case it's
useful, the full snd_pcm_dump() output of the playback device is
available here:

    http://pastebin.com/ai3e0cer

To summarize the configuration, I'm using a chain of PCM devices
that looks like this:

    Soft volume ->
    Rate conversion ->
    Route conversion ->
    HW PCM (USB audio)

(notes: buffer_size for soft volume PCM is 640 [80ms], period size is
160 [20ms].  buffer_size for HW PCM is 3846 and period_size is 960.  I'm
opening the playback device in blocking mode, although the same thing
appears to happen in non-blocking mode)

Here is the sequence of events I'm seeing:

1) Call snd_pcm_writei() with 160 frames successfully.  Function
returns immediately in less than 1ms because the buffer is empty.

2) snd_pcm_avail() returns 640 (expected 640-160 = 480)
snd_pcm_dump() shows the following for the HW PCM device:
    appl_ptr     : 960
    hw_ptr       : 0

3) Call snd_pcm_writei() again with 160 frames successfully.  Function
returns immediately again.

4) snd_pcm_avail() returns 640 (expected 480-160 = 320)
snd_pcm_dump() shows the following for the HW PCM device:
    appl_ptr     : 1920
    hw_ptr       : 0

5) Cycle repeats two more times, with these values for apply_ptr/hw_ptr
reported after each subsequent snd_pcm_writei() call:
    appl_ptr     : 2880
    hw_ptr       : 288

    appl_ptr     : 3840
    hw_ptr       : 288

All along, snd_pcm_avail() returns 640.

6) Call snd_pcm_writei() with 160 frames again.  This time, the buffer
is actually full, so it blocks for 20 ms as expected.

7) snd_pcm_avail() returns 640
snd_pcm_dump() shows the following for the HW PCM device:
    appl_ptr     : 4800
    hw_ptr       : 960

8) Continue this loop, with each subsequent snd_pcm_writei() call
blocking for 20 ms, while snd_pcm_avail() always returns 640.

Any ideas on why this could be happening?  Or am I misunderstanding
something here?

Thanks,

Nate Case <ncase@xes-inc.com>
