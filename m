From: Krakora Robert-B42341 <B42341@freescale.com>
Subject: Re: Races in alsa-lib with threads
Date: Tue, 13 Nov 2012 20:55:30 +0000
Message-ID: <5175C6FEA820754B902FF6873E9285B00C9862EA@039-SN2MPN1-021.039d.mgd.msft.net>
References: <CA+7tXig7cz8bOuKf3Dqk+iPErY9OKz4hD5L=MM=1vHFUdtPJQQ@mail.gmail.com>
 <s5hbof5ef7s.wl%tiwai@suse.de>	<509FD3BE.7090504@perex.cz>
 <loom.20121112T203721-204@post.gmane.org>	<s5hwqxqvwra.wl%tiwai@suse.de>
 <CA+7tXijc833Bvi-E-L2itnRGF0CNBEY-sahgRhzD_uuws+TQwA@mail.gmail.com>
 <5175C6FEA820754B902FF6873E9285B00C985240@039-SN2MPN1-021.039d.mgd.msft.net>
 <s5h4nktipd5.wl%tiwai@suse.de>
 <CA+7tXii5Lecb3GW4GPgMg6UWYe1jmpEWi_FHM24_nEB5Q7YT0w@mail.gmail.com>,
 <s5hy5i5nt69.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 876772615EB
 for <alsa-devel@alsa-project.org>; Tue, 13 Nov 2012 21:55:39 +0100 (CET)
In-Reply-To: <s5hy5i5nt69.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

At Tue, 13 Nov 2012 14:41:40 -0500,
Trent Piepho wrote:
>
> On Tue, Nov 13, 2012 at 8:50 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > At Tue, 13 Nov 2012 13:39:24 +0000,
> > Krakora Robert-B42341 wrote:
> >> The way that the GStreamer ALSA Sink Plugin is using ALSA Lib assumes that it is thread safe.  The fix crafted by one of Trent's colleagues (attached) seems to be the way to go.  However, I don't know how it would impact other functionality within ALSA Lib.
> >
> > No, sorry, we don't want to introduce pthread_lock in alsa-lib PCM
> > stuff.
> >
>
> The problem with introduction serialization outside alsa-lib is that
> you must now serialize entire ALSA calls.  The locks must be held for
> far too long.
>
> Consider snd_pcm_writei(), most of the time is usually spent blocked
> waiting for a period to elapse.  It is perfectly ok to call
> snd_pcm_delay() during this time.  But if one isn't allowed to make
> any other pcm calls during snd_pcm_writei() then this can't be done.
>
> It's a pretty big problem.  Most code using blocking mode is going to
> write another period as soon as the writei call returns from the last
> write.  It will spend almost all its time inside snd_pcm_writei() and
> thus will always be holding the app's pcm stream lock.  As soon as it
> releases the lock it grabs it again for the next write.  Another
> thread trying to call snd_pcm_delay() will virtually NEVER get a
> chance.  Not only is it unnecessary stopped from getting the delay
> while another thread is blocked inside writei(), but it won't get a
> chance to call it between writei() calls either.
>
> But there doesn't need to be a conflict, since the actual critical
> section that needs locking is very small, far smaller than the time
> spent sleeping inside writei() or wait().  How can just the critical
> section be protected without placing the locking inside alsa-lib?

Well, in general it's no good idea to use a blocking write for
multi-thread programs.  Most of codes I know use a direct poll() call
for a better control.  The blocking mode is basically for dumb program
that doesn't need a control.

Though, I see your point, too.  Of course it'd be better if there is
an atomic snd_pcm_delay() call.  I think it's possible to give a
consistent value without locking.  Here I meant a value that doesn't
express the exact position of the very current time, but at least a
position that is being processed.  It'll likely end up calling
snd_pcm_mmap_avail(), and this won't involve with the sync / update
procedure.

Well, just a thought, for now.


Takashi


So, the "dumb program" is the GStreamer ALSA Sink plugin.  What does an ALSA "poll" example look like?
