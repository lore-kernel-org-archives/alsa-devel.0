From: David Dillow <dave@thedillows.org>
Subject: Re: PROBLEM: SIS7019 stops recording after 42 min
Date: Mon, 21 Jun 2010 10:06:20 -0400
Message-ID: <1277129180.22889.64.camel@obelisk.thedillows.org>
References: <AANLkTimO5PXmJiIPDw82MTA53mLSl-OC0e1SOEh7v8pH@mail.gmail.com>
	<1276972298.22889.16.camel@obelisk.thedillows.org>
	<AANLkTimwZFNLBNJWODyzKXwx9CbIorg3OCA53XZchkeN@mail.gmail.com>
	<1277043970.22889.45.camel@obelisk.thedillows.org>
	<AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from amavis-smtp.knology.net (amavis-smtp.knology.net [75.76.199.6])
	by alsa0.perex.cz (Postfix) with ESMTP id B60DE103853
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 16:06:29 +0200 (CEST)
In-Reply-To: <AANLkTikBTMq3d-Ov65wYLJ_Vw-7Jde4AOwfXcEPB0wLr@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux@schou.dk
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2010-06-21 at 07:56 +0200, Hans Schou wrote:
> 2010/6/20 David Dillow <dave@thedillows.org>:
> 
> > You caught the correct files, yes. Did that command produce 10 second
> > pauses? If not, then I need to see the same information from the rec
> > command you were using to reproduce the issue before. It may be easier
> > to just run the rec command for a moment to collect the data rather than
> > wait the 40+ minutes to see if arecord also demonstrates the issue.
> 
> Over night I have been running arecord several times. Alle wav-files
> are much below the expected size 264600000 bytes (44100*2*60s*50min).

> Only 35 minutes of recording but I was running in 50min.

Ok, cool, we see the problem with arecord as well, though you were
getting overrun messages as well?

> > I'm guessing that rec (sox) is using the mmap interface, and
> > I've not done much with that -- though perhaps there is a bug in sox's
> > overrun handling. You could enable SND_PCM_XRUN_DEBUG to see if overruns
> > are happening when sox starts taking 10 seconds.
> 
> How do I enable SND_PCM_XRUN_DEBUG with sox?

Sorry, that should be CONFIG_SND_PCM_XRUN_DEBUG in the kernel
configuration, but if we can demonstrate this with arecord, there's no
real reason to recompile your kernel at this point.

> > Getting overruns on SiS 550 based devices isn't entirely surprising, as
> > it doesn't have a huge amount of horsepower or memory.
> 
> Well, I usually don't have problem with that. I have samba running but
> I don't access the recorded files while recording, so it is not a
> problem.
> 
> Right now uptime says
>    load average: 0.19, 0.21, 0.18
> but strace and top is the bad guys, not arecord.

An overrun means that arecord didn't run for 500ms, and the load average
won't really tell you much about that -- latency can happen with low
loads. That said, I'm suspecting that you've found a problem in the
driver, and I'd lay odds it is in the handling of multiple periods per
buffer.

> >> > Can you try using arecord? You can use options to tell it how to
> >> > configure the PCM. Especially interesting will be to configure 2 periods
> >> > per buffer vs whatever rec uses. 2 periods per buffer uses the hardware
> >> > interrupts to clock out periods, where as 3+ uses a more complex
> >> > mechanism. You can also use -M to use mmap vs not.
> >>
> >> Options like this?
> >> strace -tt -o arec.log arecord -c 1 -r 44100 -f S16 -M arec.wav
> 
> I tried this one:
>   arecord -c 1 -r 44100 -f S16 -M -D hw:0,0 -v arec.wav
> but it did not change anything. Still the files are much too small.

Ok, read/write vs mmap is not a differentiating factor, good deal.

> So most often 'avail' is 27562 after an overrun when  running arecord.
> 
> I think it would be better to test with sox-rec but which options
> should be used?

I don't know the options available on sox, but if you can use arecord to
reproduce, then that is probably the best tool for the job. Can you set
it up to use two periods per buffer and see if you still can reproduce?
Options would look like -B 250000 -F 125000. A second test with -B
1000000 -F 500000 would be interesting, if the hw can handle buffers of
that size -- I don't recall offhand.

I will hopefully have my hardware back up and running tonight; BTW, what
distro are you using? I'm trying Fedora 13, but I'm expecting to run
into trouble with the lack of cmov support on the processor.

Thanks,
Dave
