From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Re: The obsolence of OSS, Was: big smiley
Date: Wed, 25 Feb 2004 15:20:19 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <403CBD33.9060302@superbug.demon.co.uk>
References: <20040225133759.GH8820@sunrise.pg.gda.pl> <200402251417.i1PEHsZQ025905@dhin.linuxaudiosystems.com> <20040225145020.GI8820@sunrise.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040225145020.GI8820@sunrise.pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Adam Tla/lka <atlka@pg.gda.pl>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Adam Tla/lka wrote:
> 
>>sigh. of course! because the kernel has no idea that your audio
>>application needs to run with real-time priority, and is instead
>>treating all apps as if they are normal interactive programs. if you
>>tell the kernel that your app needs to run with RT priority (there are
> 
> So why I think about some api to tell the kernel that some app nedds CPU
> in more deterministic manner. Generally if we could do this by /proc too
> like tunnig ALSA for particular programs it would be good for old
> proprietary programs which we couldn't improve.
> It's not RT but some sheduler modification to treat some programs
> specially.
> 
> 
> 
>>OSS cannot affect this in any way - its a function of the kernel
>>scheduler and not the audio device API.
> 
> OK but we could have some kernel RT thread which is doing mixing
> or MIDI emulation.
> 
> Regards

The ideal scheduler for realtime apps would be one that has an api that 
allows for a call like "schedule me at exactly 10ms intervals+-1ms".
This would cause the scheduler to automatically juggle the other 
processes around so that at the exact time of the 10ms interval, our 
process gets CPU time. We would have to also configure +-ms so that the 
scheduler has some leaway to allow for some optimisations.

This api should be flexible enough to allow us to do the same, but using 
the sound card's hardware clock as the trigger.
The same again for the video card's clock/frame interrupt.

The current schedular gives every process X microseconds of CPU time or 
less (process calls nano_sleep() )
We should be able to get the schedular to give a process less CPU time 
if the next process to schedule is the realtime interval process.

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
