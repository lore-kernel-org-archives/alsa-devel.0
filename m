From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: The obsolence of OSS, Was: big smiley
Date: Wed, 25 Feb 2004 16:03:40 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403CC75C.5070409@superbug.demon.co.uk>
References: <200402251537.i1PFbwSv026765@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200402251537.i1PFbwSv026765@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Adam Tla/lka <atlka@pg.gda.pl>, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>The ideal scheduler for realtime apps would be one that has an api that 
>>allows for a call like "schedule me at exactly 10ms intervals+-1ms".
> 
> 
> no, thats not true.
> 
> the system clock does not run in sync with the sample clock. the drift
> in this would become noticeable in a few minutes.

I know that. I was saying that we should be able to use the sample clock 
  in scheduling descisions as well as the system clock, but as you say, 
for sound, we don't really care about the sample clock, only the 
interrupt that happens as a result.

It would still be nice to have a system clock based interval process for 
applications that require activity at specific intervals, but are not to 
do with sound or video.

> 
> the only time to run an audio app is ASAP after the interrupt from the
> device is recieved (assuming minimum latency; there is a more
> involved, but still interrupt-driven deadline with non-minimal
> latency).
> 
> --p
> 

An audio hardware interrupt can interrupt any process at any time.
Is there already a procedure in linux so that the interrupt_handler can 
cause the scheduler to select a particular process to run immeadiately 
after this interrupt_handler has finished?
I can see problems with the following setup: -
Audio interrupt occurs
Audio interrupt_handler finishes.
Audio user space process get control of CPU.
Some other interrupt occurs
Some other interrupt_handler informs the scheduler to run xyz process next.
Question: -
Which process should be run next?
Continue with the audio user space process, or start the new xyz process?

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
