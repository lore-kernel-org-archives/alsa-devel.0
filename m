From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: PCM questions
Date: Sat, 6 Mar 2004 11:10:23 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403050839190.1869@pnote.perex-int.cz>
References: <1078416129.1865.868.camel@renegade>
 <Pine.LNX.4.58.0403041720490.2204@pnote.perex-int.cz>  <1078422542.1866.899.camel@renegade>
  <Pine.LNX.4.58.0403041932480.2204@pnote.perex-int.cz> <1078430057.30309.921.camel@renegade>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1078430057.30309.921.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 4 Mar 2004, Ove Kaaven wrote:

> tor, 04.03.2004 kl. 19.43 skrev Jaroslav Kysela:
> > Not really. I don't know, what you're trying to do. The silence extension
> > can be used to silence played area automatically from the interrupt 
> > contents. If you set "silence_threshold" and "silence_size" to 
> > buffer_size, then the whole _unused_ portion of the ring buffer will be 
> > filled with silence. Perhaps, that's the behaviour what you expect.
> 
> Well, I was afraid that mode would not work well when I rewinded to add
> more sfx, I would risk getting any existing sfx in the buffer cleared.
> Or wouldn't I?

Yes, of course. If you rewind, you must fill all next samples again in 
this case. The auto-silence was designed to silence the buffer ahead
to not write a broken samples to output when a xrun condition occurs.

> > > Well, concerns of having to resort to messy application-side code to
> > > reimplement ALSA API features aside, there's also the issue of whether
> > > to rewind to before the playing position, or rather to forward to one
> > > buffer size after the playing position, to insert the silence, since for
> > > the ALSA API, there's a difference. But perhaps forward makes most
> > > sense. I guess I can do that.
> > 
> > I don't understand.
> 
> Well, for example, if the buffer size is 16384 frames, the app frame
> position is 24576, and the currently playing position is 20480 (so that
> snd_pcm_delay returns 4096). Now I want to clear the last 4096 frames
> that completed playing. Do I
> 
> 1) call snd_pcm_rewind(8192), so that app frame position is 16384, which
> is logically behind play position (and in a xrun condition)

You cannot do that. You cannot rewind behing the actual hardware pointer.

> or
> 
> 2) call snd_pcm_forward(8192), so that app frame position is 32768,
> which is logically after play position (and seeking past potentially
> invalid data to get there)
> 
> In both cases, begin_mmap should return a pointer at the beginning of
> the buffer and let me clear the desired area of it. But it might make a
> difference to xrun recovery, auto-silence, and who knows what else...
> 
> But I'll just go for 2), it seems to be most straightforward to achieve
> with the current abstraction in our code.

Yes, it's only correct way.

I also extended the "auto-silence" function in driver in our CVS.
Now, the code detects the written samples so snd_pcm_start() doesn't
silence the whole ring buffer in this case.

Here is the patch for driver:

Index: pcm_lib.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/core/pcm_lib.c,v
retrieving revision 1.48
retrieving revision 1.49
diff -u -r1.48 -r1.49
--- pcm_lib.c	2 Mar 2004 15:32:35 -0000	1.48
+++ pcm_lib.c	6 Mar 2004 10:02:48 -0000	1.49
@@ -67,8 +67,11 @@
 			frames = runtime->silence_size;
 	} else {
 		if (new_hw_ptr == ULONG_MAX) {	/* initialization */
-			runtime->silence_filled = 0;
-			runtime->silence_start = runtime->control->appl_ptr;
+			snd_pcm_sframes_t avail = snd_pcm_playback_hw_avail(runtime);
+			runtime->silence_filled = avail > 0 ? avail : 0;
+			runtime->silence_start = (runtime->status->hw_ptr +
+						  runtime->silence_filled) %
+						 runtime->boundary;
 		} else {
 			ofs = runtime->status->hw_ptr;
 			frames = new_hw_ptr - ofs;

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
