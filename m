From: Chuck Winters <cwinters@atl.lmco.com>
Subject: Re: Configuration Spaces
Date: Tue, 17 Sep 2002 15:54:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020917155419.A801@atl.lmco.com>
References: <20020917094800.A3340@atl.lmco.com> <E17rJ03-0005lg-00@usw-sf-list1.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <E17rJ03-0005lg-00@usw-sf-list1.sourceforge.net>; from pbd@op.net on Tue, Sep 17, 2002 at 10:08:40AM -0400
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for the great reply.  I got my test pgms working for capture and playback.

I am now trying to get working with full duplex.  There seem to be many problems 
with it though.  Do you have any tips/tricks on programming with full duplex 
operation?

Thanks Again,
Chuck

On Tue, Sep 17, 2002 at 10:08:40AM -0400, Paul Davis wrote:
> >My knowledge of signals is that the period is the time it takes a signal to 
> >complete 1 cycle.  So what is the snd_pcm_hw_params_set_period used for?
> >Is the "period" a property of the signal, or an arbitrary property set by
> >the programmer for performance, fidelity, etc.
> 
> no, a period in ALSA is, put relatively simply, the interval between
> interrupts from the audio interface. it defines the latency for audio
> handling. 
> 
> if you set the buffer size to 256 frames, and the period size to 64
> frames, there will be 4 interrupts per iteration over the buffer:
> every time the card has 64 frames of audio or space in the buffer, it
> will interrupt the CPU. 
> 
> for background on how an audio interface works and some perspectives
> on programming with ALSA, check out
> 
>     http://www.op.net/~pbd/alsa-audio.html
> 
> --p
> 
> 
> -------------------------------------------------------
> Sponsored by: AMD - Your access to the experts on Hammer Technology! 
> Open Source & Linux Developers, register now for the AMD Developer 
> Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
