From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: Problem with arecord on Audigy 2 NX
Date: Sat, 27 Mar 2004 13:39:57 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0403271339440.1836@pnote.perex-int.cz>
References: <4064B687.C88E8575@cs.berkeley.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4064B687.C88E8575@cs.berkeley.edu>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Yitao Duan <duan@cs.berkeley.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 26 Mar 2004, Yitao Duan wrote:

> Hi,
> 
> I am having trouble recording using Creative Labs Sound Blaster Audigy 2
> NX. The linux rec program worked fine. But whenever I use arecord (e.g.
> arecord test.wav), I got Segmentation fault. I pinpointed the problem to
> the function  pcm_read in aplay.c. Specifically it was the line:
> 
>  r = readi_func(handle, data, count);
> 
> that caused the fault. readi_func was called 3 times without problem.
> But the 4th call will cause the fault. gdb showed that a NULL pointer
> was encountered in function snd_pcm_rate_grab_next_period: rate->slave
> was NULL. The following is a stack trace when the fault happened.
> However, rate->slave was not NULL during the 3 normal readi_func calls
> and I checked that the handle passed to readi_func was always the same.
> What could happen that made the pointer NULL for the 4th call? I am
> running 2.4.21-4.EL kernel and gcc 3.2.3. Any information will be highly
> appreciated.

Try alsa-lib-1.0.4rc1.

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
