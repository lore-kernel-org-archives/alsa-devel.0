From: Tobias Peters <tpeters@uni-oldenburg.de>
Subject: Re: usb sampling rate
Date: Wed, 29 Oct 2003 12:23:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F9FA349.40305@uni-oldenburg.de>
References: <E1AEOiU-0000Cp-00@hpux02.hrz.uni-oldenburg.de> <s5hllr564wy.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hllr564wy.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
> At Tue, 28 Oct 2003 08:56:37 +0100,
> Tobias Peters wrote:
> 
>>On Tue, 21 Oct 2003 14:26:24 +0200
>>Takashi Iwai <tiwai@suse.de> wrote:
>>
>>
>>>but 1ms period alignment is important:  if you want a RT process with
>>>the USB audio device, choose the sample rate with multiple of 1000.
>>>for example, avoid 44.1kHz, but use 48k instead.
>>
>>Wouldn't the clocks of the usb and of the d/a converter get out sync
>>anyway, because of the drift? Why is a multiple of 1000 important then?
> 
> 
> partly because the damn USB-1.1 specification and partly because of
> the basic design of ALSA.  the USB-1.1 always invokes the interrupts
> in 1ms period regardless of the sample rate.  meanwhile, the ALSA
> assumes that the period size is constant in frames.
> 
> when the sample rate is the multple of 1000, e.g. 48kHz, 1ms
> corresponds always to the integer frames (e.g. 48 frames).  so, it's
> not big problem.

My concern is, that the 48kHz are unlikely to be exact 48000.000000Hz. 
The clock of the usb is also inexact. Both clocks will drift away from 
each other, and occurrences of 47 or 49 frames become possible. Thus, 
there cannot be any benefit from using 48kHz over 44.1kHz, or can there?

> however, when you run 44.1kHz, the interrupt frequency is not in
> integer frames, ie. 44.1 frames.  if the period size were variable,
> this inconsistency can be compensated by changing the period size
> occasionally (such as 44, 44, ..., 45, 44...).  instead, the current
> USB driver updates two periods to compensate the delay.  this doesn't
> work well if you use only two periods, typically in RT apps.

I see. This means an extra millisecond delay on both, capture and 
playback sides, doesn't it?

> 
> 
> Takashi





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
