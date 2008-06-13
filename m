From: Lennart Poettering <mznyfn@0pointer.de>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 15:51:29 +0200
Message-ID: <20080613135128.GA21255@tango.0pointer.de>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hfxrhhnff.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id B31961037F3
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 15:51:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hfxrhhnff.wl%tiwai@suse.de>
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

On Fri, 13.06.08 08:13, Takashi Iwai (tiwai@suse.de) wrote:

> > uh? I think we have a misunderstanding here. What you are explaining
> > here would suggest that the first answer is the right one, but you
> > actually claim it is the second one? This doesn't make sense to me.
> > 
> > As far as I understood the "hw_ptr" is the index where the PCM data is
> > *read* from the playback buffer, While "appl_ptr" is where the data is
> > *written* to the playback buffer. Right?
> 
> No, the hwptr is the point whether the data is being played... well,
> ideally.  The hwptr can behind the actual point.  But, it shouldn't be
> ahead the actual point.

Ah, that's good to know. Thanks for the clarification!

> > However, since the data is not dma'd
> > sample-by-sample but in a block at a time, the sample that is
> > currently hearable is still quite a bit before this index. Right? And
> > hence would snd_pcm_delay() when always defined as "appl_ptr - hw_ptr"
> > not really be suitable for synchronization because the hw_ptr is
> > always a bit ahead of what is actually being played -- and WINE's
> > interpretation would be right and the media player's (and mine)
> > wrong. In contrast to what James and you just said.
> 
> It's a problem of usb-driver.

OK, so to summarize the situation:

a) snd_pcm_delay() should actually return write-to-hear latency. And
   is supposed to be called *before* the next write and it will tell
   you when that next write will reach the speakers, in the sound card
   device time domain. For networked outputs it will most likely never 
   return 0.

b) for the usb driver this is however broken and it returns the fill
   level of the playback buffer

c) snd_pcm_hw_params_get_buffer_size() - snd_pcm_update_avail()
   returns the fill level, but only works on mmap.

d) The snd_pcm_hw_params_get_fifo_size() was supposed to return the
   'difference' between a) and c), but was never actually used
   for that.

(Since this matches Lennart's original interpretation of the situation
he's now happy... ;-))

Lennart

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net         ICQ# 11060553
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
