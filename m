From: Steve deRosier <derosier@pianodisc.com>
Subject: Re: Sync between MIDI and audio
Date: Tue, 02 Sep 2003 09:39:04 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F54C7A8.8030006@pianodisc.com>
References: <200308290127.h7T1RWfg019789@oud>
Reply-To: derosier@pianodisc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308290127.h7T1RWfg019789@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul,

Ah, well that explains it.  Thanks.  Can you point me to some info on 
how I would link the two clocks (I guess it would be to make the seq use 
the PCM clock)?

As far as using kernel 2.5/2.6 or the backport of the hi-res timers 
code... unfortunately this isn't an option for me.  I can't change the 
kernel version and even if I could, the rest of the people wouldn't 
allow it at this point.  But, even if I used the hi-res stuff, wouldn't 
I still have the same problem with having 2 clocks and those drifting 
apart over time?

Thanks,
- Steve

Paul Davis wrote:
>>The problem: the MIDI and audio start synced up, but after a while they 
>>start to drift further and further apart.  I've checked my stuff 
>>exaustively to make sure that it's not the fault of my program, so I'm 
>>figuring it is caused by me not setting up something properly in alsa to 
>>make the two streams synced up.
> 
> 
> you either have to force the sequencer queue to use the PCM device as
> a clock, or you have to use the RTC as the clock for both (which will
> cause audio glitches every so often since it drifts w.r.t. the audio
> clock). you can't expect this to "just work" - you've created a system
> with two clocks (the sequencer queue and the PCM device), and such
> systems will never stay in sync.
> 
> this is a very tricky area of linux audio/MIDI programming, and my
> personal advice would be to use kernel 2.5/2.6 or the backport of the
> hi-res timers code. you can then get usec-accurate scheduling of
> events (in SCHED_FIFO tasks, anyway) and forget the ALSA
> queue. hopefully, the ALSA sequencer will at some point take advantage
> of the new timers. even so, its still not a simple thing to do.
> 
> --p
> 



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
