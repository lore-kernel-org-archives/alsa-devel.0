From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: underrun behavior
Date: Fri, 18 Jul 2003 09:58:32 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0307180956060.7580-100000@pnote.perex-int.cz>
References: <200307180350.h6I3os903465@fafner.math.umass.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200307180350.h6I3os903465@fafner.math.umass.edu>
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

> 
> Jaroslav,  Thanks for your reply.  I looked at the section of code you
> pointed to and wondered if you meant I should use
>   snd_pcm_sw_params_stop_threshold() 
> rather than start_threshold, as you suggested.  
> I couldn't actually get snd_pcm_sw_params_get_boundary() to work since
> it wouldn't compile for me, but I tried various boundary values for the stop

You have use these defines before #include <alsa/asoundlib.h> to enable 
newer API:

#define ALSA_PCM_NEW_HW_PARAMS_API
#define ALSA_PCM_NEW_SW_PARAMS_API

> threshold.  When doing this, I managed to eliminate the underruns.  However,
> when my sample-writing routine is invoked by a late signal, then some strange
> noise creeps into my output audio and never goes away.  I don't understand this
> since I am replenishing the buffer with new audio so I would expect the noise
> to go away as soon as it is overwritten.  
> 
> Maybe I should ask the question in a more open-ended way.  I have both incoming
> and outgoing audio and the two drift apart when I get playing underruns.
> Although it is not really the case, you could think of the outgoing audio as
> "echoing" the incoming audio.  Why does this happen and what can I do about it?

I am sorry, but I have no idea... The playback has probably also 
underruns, so you have to fill buffer ahead again when this 
happens.

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
