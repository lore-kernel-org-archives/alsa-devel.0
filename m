From: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Subject: Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
Date: Tue, 07 Mar 2006 22:53:55 -0800
Message-ID: <1141800836.6150.3.camel@cmn3.stanford.edu>
References: <1141769000.5565.21.camel@cmn3.stanford.edu>
	 <20060307220628.GA27536@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20060307220628.GA27536@elte.hu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ingo Molnar <mingo@elte.hu>
Cc: nando@ccrma.Stanford.EDU, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, cc@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-03-07 at 23:06 +0100, Ingo Molnar wrote:
> * Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:
> 
> > The symptoms are as follows:
> >   - start jack using qjackctl
> >   - start qsynth (gui front end for fluidsynth, a synth)
> >   - start rosegarden (midi sequencer and audio recorder)
> >   - load a midi file into rosegarden
> >   - midi file plays successfully
> >   - close rosegarden
> > at this point one of the threads of rosegarden fails to exit and stays
> > forever in the process list, in a ps axuw it shows as:
> > 
> > nando 5484 0.0 0.0 0 0 pts/1    D    13:32   0:00 [rosegardenseque]
> > 
> > Anything else that I try to stop that touches the alsa sequencer never
> > dies (qjackctl, vkeybd, qsynth, etc). Anything I try to start that tries
> > to use it does not start. This happened with two widely different
> 
> could you get a tasklist-dump? It's either SysRq-T, or:
> 
> 	echo t > /proc/sysrq-trigger
> 
> that should dump all tasks and their backtraces - including the hung 
> rosegardensequencer task.

I'll try to do that tomorrow. 

In the meanwhile I think this might be the same problem that was solved
in -rt20? (building it as I type). I have been trying to catch up to the
subset of lkml that I manage to read and found some reports that
apparently point to similar problems with the alsa sequencer (Rui, in
particular, and then Karsten's post in this thread).

-- Fernando




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
