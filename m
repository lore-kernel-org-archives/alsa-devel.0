From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Fri, 13 Jun 2008 18:47:48 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0806131835180.1798@tm8103-a.perex-int.cz>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<20080613142526.GB21255@tango.0pointer.de>
	<s5hod65qqhh.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806131800160.1798@tm8103-a.perex-int.cz>
	<s5hhcbxqp1y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 7AFCA1037F3
	for <alsa-devel@alsa-project.org>;
	Fri, 13 Jun 2008 18:47:51 +0200 (CEST)
In-Reply-To: <s5hhcbxqp1y.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>, Lennart Poettering <mznyfn@0pointer.de>
List-Id: alsa-devel@alsa-project.org

On Fri, 13 Jun 2008, Takashi Iwai wrote:

> At Fri, 13 Jun 2008 18:11:12 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > On Fri, 13 Jun 2008, Takashi Iwai wrote:
> > 
> > > What about just providing three pointers: curr_ptr, hw_ptr and
> > > appl_ptr?  curr_ptr corresponds to the point being played, and hw_ptr
> > > is the point where the data was already sent to h/w, and appl_ptr is
> > > the point where the data is filled by user.  The above definitions are
> > > all combinations of these pointers.
> > 
> > But I think that curr_ptr can be managed in drivers, thus invisible to 
> > user space (except for snd_pcm_delay() propagation).
> 
> Ditto for hw_ptr.  Why is it hidden at all?

Does it improve something to show this pointer to apps? I don't see any 
reason to show it outside alsa-lib.

> > If driver requires 
> > extra handling of samples, it can allocate and manage extra buffers 
> > itself. I don't see the point to have "locked" samples already processed 
> > by hardware in the main ring buffer described by appl_ptr / hw_ptr.
> > Application can use this space for new samples.
> > 
> > The only advantage with your implementation might be zero-copy, but USB 
> > and PCMCIA cards have or create own buffers, so I don't think that this 
> > advantage can be used in actual drivers and I cannot even imagine 
> > hardware which work in way to use zero-copy in this situation.
> 
> Wait, wait.  Please don't mix up.  The above doesn't imply anything
> about the further implementation of usb-audio driver.  What I
> suggested is, instead of hiding two pointers (hw_ptr and curr_ptr) and
> creating a complex API, simply expose them.

I don't see a reason to make current API more complex. We have already two 
functions, One showing overall latency and second one how much samples can 
be processed by application. It's enough. We need only improve things 
internaly in alsa-lib <-> kernel (provide correct information for 
snd_pcm_delay()).

> Now, regarding the usb-driver.  Honestly, I don't understand what you
> want to do with an extra URB.

Note that we don't need to have extra URBs, just change hw_ptr handling 
in USB driver.

> As now, usb-audio driver handles as curr_ptr == hw_ptr.  But, in
> reality, curr_ptr = hw_ptr - samples_in_urbs.  So, in the case
> of USB-audio, hw_ptr is ahead of curr_ptr.  (And the granularity is
> samples_in_urbs).

As Lennart mentioned, in this case you can reach underrun at different 
position than expected (when URB cannot be filled). In my case, you'll 
reach underrun exactly at point when whole ring buffer is drained. So 
application can better estimate queueing and also it makes things more 
logical.

USB:
application -> ring buffer -> driver's buffer -> DMA -> hardware FIFO -> DAC

stardard PCI card:
application -> ring buffer -> DMA -> hardware FIFO -> DAC

When we add the additional latency of extra buffers to snd_pcm_delay() 
and fifo_size() (or any other similimar function providing maximum extra 
added latency), application can change ring buffer parameters to match 
own requirements.

						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
