From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: underrun behavior
Date: Thu, 17 Jul 2003 22:13:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307172208150.1277-100000@pnote.perex-int.cz>
References: <200307171917.h6HJH0T01638@fafner.math.umass.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307171917.h6HJH0T01638@fafner.math.umass.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chris Raphael <raphael@math.umass.edu>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Thu, 17 Jul 2003, Chris Raphael wrote:

> Thanks to the many people who have helped with my earlier questions.
> 
> I am working on an application that simultaneously collects and plays
> sound.  About 4 out of 5 times the program runs fine, but occasionally
> I have a problem with the input audio and output audio drifting apart.  
> This seems to happen when I get playing underruns, although not all
> underruns seem to affect the synchronization.  It isn't possible for
> me to completely avoid underruns, because my application can only
> compute the output audio about 20 ms before it is actually played.
> 
> What I would like is for the audio driver to plays sample from the ring buffer in
> a circular manner, *whether or not there is an underrun*.  That is,
> if there is an underrun, I would like the driver to continue writing
> samples in a circular fashion, even though some of them are garbage.
> In the event of an underrun, I don't care what is played before
> my application supplies the driver with audio data.  But when the
> driver gets the audio I would like it to put it in the appropriate
> place in the ring buffer even though some garbage samples are *substituted*
> for my audio data.
> 
> Put another way,  I would like the driver to ignore underruns and simply
> allow the start and end pointers to cross over one another.
> 
> Is this possible (or clear)?

Why not? Simply set start_threshold from sw_params to boundary wrapper 
value. The nice example code is in alsa-lib/src/pcm/pcm_direct.c - look 
for snd_pcm_sw_params_get_boundary() and lines around it.

A side note: You might move the read pointer (capture) manually 
via the snd_pcm_forward() function to replace the garbage with silence or 
something better (in case of underrun of course).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
