From: Chris Raphael <raphael@math.umass.edu>
Subject: Re: underrun behavior
Date: Thu, 17 Jul 2003 23:50:54 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307180350.h6I3os903465@fafner.math.umass.edu>
References: <Pine.LNX.4.44.0307172208150.1277-100000@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <Pine.LNX.4.44.0307172208150.1277-100000@pnote.perex-int.cz>
	(message from Jaroslav Kysela on Thu, 17 Jul 2003 22:13:20 +0200
	(CEST))
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Jaroslav,  Thanks for your reply.  I looked at the section of code you
pointed to and wondered if you meant I should use
  snd_pcm_sw_params_stop_threshold() 
rather than start_threshold, as you suggested.  
I couldn't actually get snd_pcm_sw_params_get_boundary() to work since
it wouldn't compile for me, but I tried various boundary values for the stop
threshold.  When doing this, I managed to eliminate the underruns.  However,
when my sample-writing routine is invoked by a late signal, then some strange
noise creeps into my output audio and never goes away.  I don't understand this
since I am replenishing the buffer with new audio so I would expect the noise
to go away as soon as it is overwritten.  

Maybe I should ask the question in a more open-ended way.  I have both incoming
and outgoing audio and the two drift apart when I get playing underruns.
Although it is not really the case, you could think of the outgoing audio as
"echoing" the incoming audio.  Why does this happen and what can I do about it?



Thaks Very Much,
Chris 

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
something better (in case of underrun of course)


-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
