From: Guilhem Tardy <guilhem_tardy@yahoo.com>
Subject: Re: documentation
Date: Fri, 3 May 2002 09:11:33 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020503161133.96309.qmail@web11507.mail.yahoo.com>
References: <s5hvgaejqfm.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from web11507.mail.yahoo.com (web11507.mail.yahoo.com [216.136.172.39])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id SAA01860
	for <alsa-devel@alsa-project.org>; Fri, 3 May 2002 18:11:37 +0200
In-Reply-To: <s5hvgaejqfm.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hi,

Now, I have this new driver which manages to open/close a pcm channel whenever
one attempts to play a file with "play test.au", but complains (Sound protocol
it not compatible) with "aplay test.au". Any idea what's wrong?
Besides, I have no mixer defined (I would just to allow open/close a playback
or capture channel, no more) and wonder if it is a problem?
I am just loading the driver manually for now (insmod snd, snd-timer, snd-pcm,
...), is there any special configuration I need? How to tell the driver to
unmute?

Thanks,
Guilhem.

> > > the copy and silence ops are called when write() is called (more
> > > exactly on alsa it's ioctl) - the thread writing to the device does
> > > actually work like DMA.  on mmap mode, there is no such one.  so you
> > > need an extra thread (or if it's not too heavy then tasklet might be
> > > available) anyway.

> no, i posted to alsa-devel ML, a month ago or so.
> the document you read is for the user library, not for the driver.

> in your case, you need to copy the data on the buffer to the hw by
> yourself.  then what is the merit of mmap? 
> (well, it would be a bit more efficient than copy_from_user(), but
>  the advantage of copy_from_user() is that you can use non-contiguous
>  buffer while alsa's mmap supports, so far, only contiguous region.)

> on alsa, when the program runs in the mmap mode, no read/write is
> called but the data is read/written on the mmapped buffer, and the
> also mmaped status is updated.  during the app writes data, DMA
> transfers the data from the mmaped buffer.
> that is, the thread is free from the kernel mode.


__________________________________________________
Do You Yahoo!?
Yahoo! Health - your guide to health and wellness
http://health.yahoo.com

_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
