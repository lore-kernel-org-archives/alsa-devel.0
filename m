From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: pointer callback in pcm
Date: Sat, 11 Mar 2006 15:53:08 +0000
Message-ID: <1142092388.9496.17.camel@localhost.localdomain>
References: <1141942882.10937.5.camel@localhost.localdomain>
	 <1141952015.13319.90.camel@mindpipe>
	 <1142020261.9246.3.camel@localhost.localdomain>
	 <4412B17F.7080200@superbug.co.uk>
	 <1142076452.9496.8.camel@localhost.localdomain>
	 <4412F001.5020404@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4412F001.5020404@superbug.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Lee Revell <rlrevell@joe-job.com>, Alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2006-03-11 at 15:42 +0000, James Courtier-Dutton wrote:

> >>     
> 
> Some questions:
> 1) How does the main CPU discover the hardware pointer of the current 
> ADC position? Needed for the pointer() callback.

Reads a value in a register in the ARM7/SPU memory - simple proceedure


> 2) Can you start and stop the samples being played?
> 

Yes - by poking a value into a different register

> Initialisation:
> 1) Wait for the application to fill 8 periods.  (you can simulate other 
> periods models later if you wish. e.g You could simulate 2 periods to 
> the application, even though you have 8 in hardware.)
> 2) The application will then call trigger to start playing the samples 
> in the buffer.
> 

Not sure I understand this! How can my kernel code know what the
application has done?


> I would recommend you try the following in the audio interrupt:
> 1) receive audio interrupt
> 2) start DMA transfer of one period.
>     Which period you copy is the important bit here. At this point the 
> hardware will have played 1 period, so you replace the period that has 
> just played, not the period that is about to be played.


I do this already. the problem is that the buffer contents never change
- ie when I replay period 0 after it has played I am just replacing it
with exactly the same sample as was there in the first place - nothing
new gets sucked in from userspace

> 3) call snd_period_elapsed()
> 4) poll for DMA complete in the ack() callback.

This is something I am not doing now but it's easy to do if somewhat
processor intensive. Can the ack callback sleep?

> 5) period_elapsed will in turn call the pointer() callback.
> 
> James
> 



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
