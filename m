From: Josh Green <jgreen@users.sourceforge.net>
Subject: Re: Broken pipe mystery
Date: 13 Feb 2003 15:36:23 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045179388.1986.196.camel@sprekhole>
References: <Pine.LNX.4.21.0302081212550.32024-100000@mailserver.intern.bfad.de>
	<000001c2d3a2$a450b2f0$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <000001c2d3a2$a450b2f0$0100a8c0@Pblaptop>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Pete Barnard <petebarnard@tiscali.co.uk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-02-13 at 12:56, Pete Barnard wrote:
> :
> >
> > Does it always crash after the same time?
> 
> No. It didin't crash after the same time.  The problem is fixed now thanks
> to Josh Green's tip.   (I wrote a function that caught the EPIPE error and
> then did a snd_pcm_prepare). I left it for 2 nights with a system("date") in
> the catch function and got an EPIPE once on one night and not at all on the
> second night - so even though it is fixed I'm still slightly curious as to
> why I got this problem/feature at all.
> 
> Regards,
> 
> Pete
> 

Its due to your program not being able to meet the deadline for writing
an audio buffer for playback. This is often Linux kernel related and
there is lots of information about tuning your kernel (do a search for
"linux kernel low latency"). It can be somewhat of a black art, because
different hardware and Linux drivers can have adverse effects on
latency. For instance if your hard disk is IDE and isn't tuned right
(DMA not enabled for instance) you can get real long latency spikes when
reading/writing the hard disk. You'll also want to look into the lowlat
patch and perhaps the preempt patch as well. Kernels that come with
Linux distributions have a tendency to not be very low latency friendly,
so if you wan't low latency, build your own kernel with one of those
patches.

On your program side:
You can increase the audio buffer size and/or count to minimize
underruns (at the cost of higher latency audio playback).
If you require low latency, run your program with SCHED_FIFO scheduling
(see man sched_setscheduler, requires root privileges). Note that your
program then has the ability to lock up the machine, should it decide to
consume all the CPU time.

I think this is one of the main things that still needs to be solved
with Linux and audio. Low latency audio shouldn't entail buggy processes
being able to bring the system to its knees. Cheers.
	Josh Green



-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
