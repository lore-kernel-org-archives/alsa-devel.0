From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Callback after a specified number of samples
Date: Wed, 9 Oct 2002 07:58:31 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0210082004150.2054-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.21.0209302200530.25497-100000@mailserver.intern.bfad.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.21.0209302200530.25497-100000@mailserver.intern.bfad.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: tomasz motylewski <T.Motylewski@bfad.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 30 Sep 2002, tomasz motylewski wrote:

> On Mon, 30 Sep 2002, Jaroslav Kysela wrote:
> 
> > > me directly that - the current position in the buffer?) I can calculate when
> > > the required position _will_ happen. So  I can just schedule the timer or sleep
> > > until that time. When it arrives I can check again snd_pcm_avail_update to see
> > > whether my calculation way correct and adjust the sleep period.
> > > 
> > > I do not understand why ALSA drivers (or at least some plug-ins) could not do
> > > the same?
> > 
> > What same? Offer position in ring buffer?
> 
> No, I ment, use the timing information to wake up application ealier if the
> period interrupt is too long.

We can use the system timer (or any timer, if available) inside the kernel 
space to do this. See the get_tick_time and set_tick_time (also -t option 
in alsa-lib/test/latency.c).

> > Use snd_pcm_status() to get the accurate timing information. The 
> > avail_update function is light version which does not need a context 
> > switch between user and kernel space.
> 
> Thank you. This is a very valuable information. I was mislead by this "_update"
> and I have thought that it will query the card.  
> 
> The documentation says "The function snd_pcm_avail_update updates (! here
> should be written: reads, not updates) the current available count of samples
> for writing (playback) or filled samples for reading (capture). ".

That's right. It updates pointers for read/write/begin/commit operations.

> And may be "Obtaining fast device status" should be changed to ""Obtaining
> device status fast" and written clearly that avail_update will in fact only
> read the number.

Changed.

> BTW. I have just read (alsa-lib DOC) that snd_pcm_avail_update should always
> return a positive number when there is no error. 
> 
> But unfortunately there is a bug in alsa-lib in snd_pcm_mmap_playback_avail and
> snd_pcm_mmap_capture_avail (src/pcm/pcm_local.h) which may cause a negative
> value to be returned. Just think what could happen if the initial avail is not
> only < 0 , but avail < pcm->boundary as well. Then avail+pcm->boundary < 0
> still.

Well. I think that you've reached another bug. hw.ptr and appl.ptr should 
be inside interval 0 .. (boundary - 1). So, in the worse case, first avail 
should be:

(1) hw.ptr + buffer_size = buffer_size
(2) appl.ptr = boundary - 1

(1) - (2) = buffer_size - (boundary - 1)

It's definitely greater value than -boundary, so the first if case should 
be hited and value should be corrected to regular interval from 0 to 
(boundary-1).

I really wonder, how you can get negative values. It seems that hw.ptr or 
appl.ptr goes outside boundary range which is bad.

> This may happen if pcm->appl.ptr is not updated (I want the card to just
> play/record all the time independent whether my application cares or not at the
> moment). No underruns. This works, but I had to check for negative values
> coming out of avail_update. This should be at least documented (fixing will not
> be as easy as I have initially thought).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project  http://www.alsa-project.org
SuSE Linux    http://www.suse.com




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
