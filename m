From: Carlo Wood <carlo@alinoe.com>
Subject: Re: Re: [xvoice] Hacking ViaVoice, part 4
Date: Sun, 13 Jul 2003 01:05:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030712230539.GA9060@alinoe.com>
References: <20030712135025.GA6553@alinoe.com> <Pine.LNX.4.44.0307122025230.1101-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0307122025230.1101-100000@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: "xvoice@yahoogroups.com" <xvoice@yahoogroups.com>, "kai.vehmanen@wakkanet.fi" <kai.vehmanen@wakkanet.fi>, "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 12, 2003 at 08:56:16PM +0200, Jaroslav Kysela wrote:
> On Sat, 12 Jul 2003, Carlo Wood wrote:
> 
> > On Sat, Jul 12, 2003 at 02:08:34PM +0200, Carlo Wood wrote:
> > > Hence, the problem is now reduced to the question:
> > > Why is snd_pcm_update_hw_ptr_interrupt not called anymore
> > > after we did run into an xrun?
> > 
> > I added a few more printk's and already I can guess
> > what is the reason that the 'blackbox' (the rest)
> > stops calling snd_pcm_update_hw_ptr_interrupt:
> > 
> > I thought it was said that an xrun should simply be ignored?
> 
> Yes, but at another level - in the OSS emulation code.

Well, I traced back to this point from an application
that only uses the OSS interface.

> > What is the correct way to recover from this, to continue
> > recording in this case, after the xrun?
> 
> Call read() or poll(POLLIN) again. I think that your problem might be that 
> poll(POLLIN) does not trigger the input in the current ALSA code. Please, 
> try this patch with ViaVoice (the patch is also in the ALSA CVS tree):

This application (ViaVoice) calls neither poll() nor select().
It only calls read() when the SNDCTL_DSP_GETISPACE ioctl returns
that there are bytes that can be read without blocking.

I applied the patch, but it won't do anything: poll is never called.


Allow me to give a summary of the problem:

An old application that uses the OSS interface opens /dev/dsp
and goes in a loop where it only calls read() when the
SNDCTL_DSP_GETISPACE ioctl reports that there is data to be read.

However, before it actually starts that loop is wastes some cpu
so that the (small) recording buffer runs full (with a Creative
soundblaster Live! that happens after 128 ms).

OSS interface or not, the sound recording causes
`snd_pcm_update_hw_ptr_interrupt' to be called.   And as soon
as the buffer overruns this function calls:

    snd_pcm_stop(substream,
		 runtime->status->state == SNDRV_PCM_STATE_DRAINING ?
		 SNDRV_PCM_STATE_SETUP : SNDRV_PCM_STATE_XRUN);

Stopping the stream.

The application calls ioctl(fd, SNDCTL_DSP_GETISPACE, &info)
which runs that there is 2048 bytes available.  The application
calls read() and reads 1024 bytes; THIS read() DOES NOT CAUSE
THE STREAM TO BE STARTED AGAIN.  Next the application calls
again ioctl(fd, SNDCTL_DSP_GETISPACE, &info), which now returns
1024 bytes, and reads the last 1024 bytes.  Again, this read
does not start the stream again.

If subsequential reads would start the stream again, then
this isn't helpful because the application never calls read()
again as ioctl(fd, SNDCTL_DSP_GETISPACE, &info) returns
zero bytes to be read from then on.

Isn't this a bug in the OSS emulation of ALSA?  The correct
behaviour seems to be that the stream is started again as soon
as there is space in the buffer again, thus after the first 'read()',
or after the second read when at least one fragment of space is
available, or in the very least after the read() that causes
the buffer to be empty.

If not, then it is a bug in ViaVoice - how *should* ViaVoice have
worked to this deadlock?

-- 
Carlo Wood <carlo@alinoe.com>


-------------------------------------------------------
This SF.Net email sponsored by: Parasoft
Error proof Web apps, automate testing & more.
Download & eval WebKing and get a free book.
www.parasoft.com/bulletproofapps1
