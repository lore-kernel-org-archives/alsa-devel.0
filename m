From: Trent Piepho <tpiepho@gmail.com>
Subject: Races in alsa-lib with threads
Date: Fri, 9 Nov 2012 18:03:25 -0800
Message-ID: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f50.google.com (mail-vb0-f50.google.com
 [209.85.212.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 564AE26079C
 for <alsa-devel@alsa-project.org>; Sat, 10 Nov 2012 03:03:26 +0100 (CET)
Received: by mail-vb0-f50.google.com with SMTP id fa15so4375481vbb.9
 for <alsa-devel@alsa-project.org>; Fri, 09 Nov 2012 18:03:25 -0800 (PST)
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

We've found a race with alsa-lib functions are called from multiple
threads.  I was under the impression that alsa-lib was supposed to be
thread safe.  Is this not the case and all alsa calls should be done
one from thread or protected by a mutex?

The race we found was in sync_ptr1() in pcm_hw.c.  This issues the
ioctl() to get the current hw ptr from the kernel and send the app ptr
to the kernel.  The communication is done by passing a pointer to
hw->sync_ptr, a field in the snd_pcm_hw_t structure for the pcm.  Any
thread calling sync_ptr1 will pass the same structure to the kernel.
This should be a red flag for a race, having two threads write to the
same data structure at the same time.

This function gets called by snd_pcm_writei(), as part of that
function getting the current hw pointer so it can calculate the avail
value.  And again when it actually writes data to commit the new app
pointer to the kernel.

It also gets called by snd_pcm_delay() if a rate plugin is used.
snd_pcm_rate_delay() will end up calling snd_pcm_hw_hwsync() and that
does a sync_ptr1() call.

So imaging two threads, one writing data and calling snd_pcm_writei()
and another calling snd_pcm_delay() as part of trying to sync audio
playback.  gstreamer does this!

The ioctl is handled by snd_pcm_sync_ptr() in pcm_native.c.  It gets
the stream lock while it reads/writes the various fields a sync struct
on the stack, then releases the lock and calls copy_to_user to write
the sync struct from its stack to userspace.

Here's how the race works.
Thread 1 calls snd_pcm_delay().
  sync_ptr1 is called
  snd_pcm_sync_ptr gets the lock, fills a struct with the current
data, releases the lock.  Does not call copy_to_user yet!
  Thread 2 runs!  It calls snd_pcm_writei(), actually writes data too
    It calls sync_ptr1() to update the app pointer with the new data and returns
    The snd_pcm_writei() call returns
  Thread 1 runs again, calls copy_to_user
    The copy_to_user writes the OLD struct that was prepared back on
the 3rd line into userspace
    The hw and app pointer values, as far as the userspace copy in
alsa-lib is concerned, have regressed to what they were before the
call to snd_pcm_writei()!

You get an audio stutter as the data written is overwritten by the
next write.  The race turns out to not be that unlikely.  The stream
lock is held and then released before calling copy_to_user.  When it's
released irqs are enabled.  If a period has elapsed while the lock was
held, the irq handle runs now, the elapsing period will wake anything
blocked in poll() waiting for space, which then probably gets to run
immediately since the schedule likes tasks that have been sleeping and
just woke, and the new task was probably blocked waiting to write data
so that's what it does as soon as it runs.
