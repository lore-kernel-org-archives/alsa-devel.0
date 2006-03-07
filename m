From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.15-rt18, alsa sequencer, rosegarden -> alsa hangs
Date: Tue, 7 Mar 2006 23:06:28 +0100
Message-ID: <20060307220628.GA27536@elte.hu>
References: <1141769000.5565.21.camel@cmn3.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751581AbWCGWHg@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1141769000.5565.21.camel@cmn3.stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net, cc@ccrma.Stanford.EDU
List-Id: alsa-devel@alsa-project.org


* Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU> wrote:

> The symptoms are as follows:
>   - start jack using qjackctl
>   - start qsynth (gui front end for fluidsynth, a synth)
>   - start rosegarden (midi sequencer and audio recorder)
>   - load a midi file into rosegarden
>   - midi file plays successfully
>   - close rosegarden
> at this point one of the threads of rosegarden fails to exit and stays
> forever in the process list, in a ps axuw it shows as:
> 
> nando 5484 0.0 0.0 0 0 pts/1    D    13:32   0:00 [rosegardenseque]
> 
> Anything else that I try to stop that touches the alsa sequencer never
> dies (qjackctl, vkeybd, qsynth, etc). Anything I try to start that tries
> to use it does not start. This happened with two widely different

could you get a tasklist-dump? It's either SysRq-T, or:

	echo t > /proc/sysrq-trigger

that should dump all tasks and their backtraces - including the hung 
rosegardensequencer task.

	Ingo
