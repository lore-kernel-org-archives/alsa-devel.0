From: Krakora Robert-B42341 <B42341@freescale.com>
Subject: Re: Races in alsa-lib with threads
Date: Thu, 15 Nov 2012 13:05:00 +0000
Message-ID: <5175C6FEA820754B902FF6873E9285B00C9876BE@039-SN2MPN1-021.039d.mgd.msft.net>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de>	<509FD3BE.7090504@perex.cz>
 <loom.20121112T203721-204@post.gmane.org>	<s5hwqxqvwra.wl%tiwai@suse.de>
 <CA+7tXijc833Bvi-E-L2itnRGF0CNBEY-sahgRhzD_uuws+TQwA@mail.gmail.com>
 <5175C6FEA820754B902FF6873E9285B00C985240@039-SN2MPN1-021.039d.mgd.msft.net>
 <s5h4nktipd5.wl%tiwai@suse.de>
 <CA+7tXii5Lecb3GW4GPgMg6UWYe1jmpEWi_FHM24_nEB5Q7YT0w@mail.gmail.com>
 <50A34FFD.4040603@canonical.com>
 <CA+7tXigU4WhmSFQyUBRmrtZksvwu-4Vj2jsOiN5u6BH9c0itGw@mail.gmail.com>,
 <s5h7gpnb9gx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 by alsa0.perex.cz (Postfix) with ESMTP id AEC59265B58
 for <alsa-devel@alsa-project.org>; Thu, 15 Nov 2012 14:05:05 +0100 (CET)
In-Reply-To: <s5h7gpnb9gx.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Trent Piepho <tpiepho@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

From: Takashi Iwai [tiwai@suse.de]
Sent: Thursday, November 15, 2012 2:39 AM
To: Trent Piepho
Cc: David Henningsson; alsa-devel@alsa-project.org; Krakora Robert-B42341
Subject: Re: [alsa-devel] Races in alsa-lib with threads

At Wed, 14 Nov 2012 14:49:36 -0500,
Trent Piepho wrote:
>
> On Wed, Nov 14, 2012 at 3:02 AM, David Henningsson
> <david.henningsson@canonical.com> wrote:
> > On 11/13/2012 08:41 PM, Trent Piepho wrote:
> >>
> >> On Tue, Nov 13, 2012 at 8:50 AM, Takashi Iwai <tiwai@suse.de> wrote:
> >>>
> >>> At Tue, 13 Nov 2012 13:39:24 +0000,
> >>> Krakora Robert-B42341 wrote:
> >>>>
> >>>> The way that the GStreamer ALSA Sink Plugin is using ALSA Lib assumes
> >>>> that it is thread safe.  The fix crafted by one of Trent's colleagues
> >>>> (attached) seems to be the way to go.  However, I don't know how it would
> >>>> impact other functionality within ALSA Lib.
> >>>
> >>>
> >>> No, sorry, we don't want to introduce pthread_lock in alsa-lib PCM
> >>> stuff.
> >>>
> >>
> >> The problem with introduction serialization outside alsa-lib is that
> >> you must now serialize entire ALSA calls.  The locks must be held for
> >> far too long.
> >>
> >> Consider snd_pcm_writei(), most of the time is usually spent blocked
> >> waiting for a period to elapse.  It is perfectly ok to call
> >> snd_pcm_delay() during this time.  But if one isn't allowed to make
> >> any other pcm calls during snd_pcm_writei() then this can't be done.
> >>
> >> It's a pretty big problem.  Most code using blocking mode is going to
> >> write another period as soon as the writei call returns from the last
> >> write.  It will spend almost all its time inside snd_pcm_writei() and
> >> thus will always be holding the app's pcm stream lock.  As soon as it
> >> releases the lock it grabs it again for the next write.  Another
> >> thread trying to call snd_pcm_delay() will virtually NEVER get a
> >> chance.  Not only is it unnecessary stopped from getting the delay
> >> while another thread is blocked inside writei(), but it won't get a
> >> chance to call it between writei() calls either.
> >>
> >> But there doesn't need to be a conflict, since the actual critical
> >> section that needs locking is very small, far smaller than the time
> >> spent sleeping inside writei() or wait().  How can just the critical
> >> section be protected without placing the locking inside alsa-lib?
> >
> > Hmm, but the great majority of programs are not interested in accessing
> > alsa-lib from multiple threads in the way that's currently unsafe. That
> > includes programs who are very dependent on low latency. I would not like to
> > see all these programs to suffer from the overhead of adding locks here and
> > there, even if those locks are small.
>
> Maybe they just don't know it's unsafe and don't hit a race often
> enough to notice?

Maybe, but many multi-threaded codes are carefully holding locks
already in the caller side.

> > You claim that the Gstreamer ALSA sink plugin accesses alsa-lib from two
> > threads simultaneously. Could you elaborate on how this can happen, maybe it
> > is easy to fix?
>
> gstreamer has no lock around the call to snd_pcm_delay().  So it can
> race with snd_pcm_wait() or snd_pcm_writei(), which are called in
> another thread.  There is a lock around the block of code calling
> wait()/writei(), but this lock isn't used for calling delay().  It
> seems that they didn't know there would be a problem.

Actually the atomic lock things found in alsa-lib code is no proper
lock for avoiding this kind of race.  It's equivalent with seq_lock()
in kernel, and it's used to make snd_pcm_status() consistent.  It
doesn't protect against the data corruption due to concurrent
accesses.

A part of concurrent access problems in the rate plugin can be fixed
by a patch like below.  In essence, it avoids updating the internal
hw_ptr value but just calculates the current hw_ptr and returns.  Most
of other changes in pcm_local.h are only refactoring. But this is
obviously just a bandaid on the spot, it doesn't solve the whole
problems at all.  So I don't buy this.

One modest solution would be to add a bit flag SND_PCM_THREAD_SAFE to
snd_pcm_open(), and activate pthread mutex locks conditionally only
with this bit set.  This isn't designed for any performance-wise
codes, and it's just for protecting concurrent accesses, so should be
called like SND_PCM_THREAD_SAFE_FOR_DUMMIES...


Takashi

---
diff --git a/src/pcm/pcm_local.h b/src/pcm/pcm_local.h
index 8cf7c3d..af4695b 100644
--- a/src/pcm/pcm_local.h
+++ b/src/pcm/pcm_local.h
@@ -420,10 +420,15 @@ static inline int snd_pcm_check_error(snd_pcm_t *pcm, int err)
        return err;
 }

-static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
+static inline snd_pcm_uframes_t
+_snd_pcm_calc_avail(snd_pcm_t *pcm, snd_pcm_uframes_t hw_ptr,
+                   snd_pcm_uframes_t appl_ptr)
 {
        snd_pcm_sframes_t avail;
-       avail = *pcm->hw.ptr + pcm->buffer_size - *pcm->appl.ptr;
+
+       avail = hw_ptr - appl_ptr;
+       if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
+               avail += pcm->buffer_size;
        if (avail < 0)
                avail += pcm->boundary;
        else if ((snd_pcm_uframes_t) avail >= pcm->boundary)
@@ -431,44 +436,22 @@ static inline snd_pcm_uframes_t snd_pcm_mmap_playback_avail(snd_pcm_t *pcm)
        return avail;
 }

-static inline snd_pcm_uframes_t snd_pcm_mmap_capture_avail(snd_pcm_t *pcm)
-{
-       snd_pcm_sframes_t avail;
-       avail = *pcm->hw.ptr - *pcm->appl.ptr;
-       if (avail < 0)
-               avail += pcm->boundary;
-       return avail;
-}
-
 static inline snd_pcm_uframes_t snd_pcm_mmap_avail(snd_pcm_t *pcm)
 {
-       if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-               return snd_pcm_mmap_playback_avail(pcm);
-       else
-               return snd_pcm_mmap_capture_avail(pcm);
+       return _snd_pcm_calc_avail(pcm, *pcm->hw.ptr, *pcm->appl.ptr);
 }

-static inline snd_pcm_sframes_t snd_pcm_mmap_playback_hw_avail(snd_pcm_t *pcm)
-{
-       return pcm->buffer_size - snd_pcm_mmap_playback_avail(pcm);
-}
-
-static inline snd_pcm_sframes_t snd_pcm_mmap_capture_hw_avail(snd_pcm_t *pcm)
-{
-       return pcm->buffer_size - snd_pcm_mmap_capture_avail(pcm);
-}
+#define snd_pcm_mmap_playback_avail    snd_pcm_mmap_avail
+#define snd_pcm_mmap_capture_avail     snd_pcm_mmap_avail

 static inline snd_pcm_sframes_t snd_pcm_mmap_hw_avail(snd_pcm_t *pcm)
 {
-       snd_pcm_sframes_t avail;
-       avail = *pcm->hw.ptr - *pcm->appl.ptr;
-       if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-               avail += pcm->buffer_size;
-       if (avail < 0)
-               avail += pcm->boundary;
-       return pcm->buffer_size - avail;
+       return pcm->buffer_size - snd_pcm_mmap_avail(pcm);
 }

+#define snd_pcm_mmap_playback_hw_avail snd_pcm_mmap_hw_avail
+#define snd_pcm_mmap_capture_hw_avail  snd_pcm_mmap_hw_avail
+
 static inline const snd_pcm_channel_area_t *snd_pcm_mmap_areas(snd_pcm_t *pcm)
 {
        if (pcm->stopped_areas &&
diff --git a/src/pcm/pcm_rate.c b/src/pcm/pcm_rate.c
index 54a3e67..340a4d3 100644
--- a/src/pcm/pcm_rate.c
+++ b/src/pcm/pcm_rate.c
@@ -613,21 +613,28 @@ static inline snd_pcm_sframes_t snd_pcm_rate_move_applptr(snd_pcm_t *pcm, snd_pc
        return diff;
 }

-static inline void snd_pcm_rate_sync_hwptr(snd_pcm_t *pcm)
+static inline snd_pcm_uframes_t snd_pcm_rate_get_hwptr(snd_pcm_t *pcm)
 {
        snd_pcm_rate_t *rate = pcm->private_data;
        snd_pcm_uframes_t slave_hw_ptr = *rate->gen.slave->hw.ptr;

        if (pcm->stream != SND_PCM_STREAM_PLAYBACK)
-               return;
+               return rate->hw_ptr;
        /* FIXME: boundary overlap of slave hw_ptr isn't evaluated here!
         *        e.g. if slave rate is small...
         */
-       rate->hw_ptr =
-               (slave_hw_ptr / rate->gen.slave->period_size) * pcm->period_size +
+       return (slave_hw_ptr / rate->gen.slave->period_size) * pcm->period_size +
                rate->ops.input_frames(rate->obj, slave_hw_ptr % rate->gen.slave->period_size);
 }

+static inline void snd_pcm_rate_sync_hwptr(snd_pcm_t *pcm)
+{
+       snd_pcm_rate_t *rate = pcm->private_data;
+
+       if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
+               rate->hw_ptr = snd_pcm_rate_get_hwptr(pcm);
+}
+
 static int snd_pcm_rate_hwsync(snd_pcm_t *pcm)
 {
        snd_pcm_rate_t *rate = pcm->private_data;
@@ -642,11 +649,11 @@ static int snd_pcm_rate_hwsync(snd_pcm_t *pcm)

 static int snd_pcm_rate_delay(snd_pcm_t *pcm, snd_pcm_sframes_t *delayp)
 {
-       snd_pcm_rate_hwsync(pcm);
-       if (pcm->stream == SND_PCM_STREAM_PLAYBACK)
-               *delayp = snd_pcm_mmap_playback_hw_avail(pcm);
-       else
-               *delayp = snd_pcm_mmap_capture_hw_avail(pcm);
+       snd_pcm_rate_t *rate = pcm->private_data;
+
+       snd_pcm_hwsync(rate->gen.slave);
+       *delayp = _snd_pcm_calc_avail(pcm, snd_pcm_rate_get_hwptr(pcm),
+                                     *pcm->appl.ptr);
        return 0;
 }

Hi Takashi,

I believe that we have a workable solution that does not break the paradigm established by ALSA conforming to calls made exclusively in a single thread or in multiple threads with the using application providing locking (less efficient).  There is a disconnect here with developers using ALSA in their applications and not fully understanding the paradigm or the ramifications of using it incorrectly in a multithreaded environment.  I have seen old threads (no pun intended) where thread safety and ALSA has come up before and I am sorry for bringing it up yet again.  I believe that Jarloslav's added caveat to the Wiki should help.  As always, thanks for your quick and detail analysis.

Best Regards,

Rob Krakora
