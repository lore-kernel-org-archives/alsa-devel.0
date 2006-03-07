From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: kernel threads etc
Date: Tue, 07 Mar 2006 21:19:42 +0000
Message-ID: <1141766382.9232.10.camel@localhost.localdomain>
References: <1141684061.9230.15.camel@localhost.localdomain>
	 <1141686718.25487.76.camel@mindpipe>
	 <1141687750.9230.24.camel@localhost.localdomain>
	 <1141688891.25487.91.camel@mindpipe>
	 <1141690313.9230.32.camel@localhost.localdomain>
	 <1141690930.25487.104.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 8B819196
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 22:19:46 +0100 (MET)
In-Reply-To: <1141690930.25487.104.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-sh <linuxsh-dev@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-06 at 19:22 -0500, Lee Revell wrote:
> On Tue, 2006-03-07 at 00:11 +0000, Adrian McMenamin wrote:
> > It transfers - without CPU intervention - memory from the SH4 (main
> > CPU)
> > memory to the ARM7 (sound processing chip) memory (ie the playback
> > ring
> > buffer). The function simply sets the register values and off it goes
> > 
> > 
> 
> OK - so it's the same DMA I am familiar with, it just needs to be
> reprogrammed every period - IOW you can't tell it "repeatedly transfer
> audio to this location until I tell you to stop".
> 
> If this is the case then I would say forget about the kernel thread and
> the copy/silence callbacks - just do all the work in the interrupt
> handler.
> 
OK. I am doing this (dealing with it in the interrupt handler) and so
far it seems to work quite well, though it is still stuck in an endless
loop, but I have a fair idea why, but i'm not sure how to deal with it.

Right now this is what happens:

0. Create a DMA buffer in SH4 space - this is used as the source for the
dma transfer (the target is in the ARM7's memory space). Alsa seems to
fill up this buffer easily enough

1. Fill the ring buffer completely with first DMA transfer (ring buffer
has space for 8 periods) on receiving the SNDDRV_PCM_TRIGGER_START, then
start the ARM7 playback

2. ARM7 fires interrupt on SH4 bus every time period is played

3. SH4 interrupt handler counts interrupts - have 4 elapsed? if yes then
fill up first half of ring buffer - have 8 elapsed? then fill up second
half

4. However the data in the DMA buffer never seems to change - ie I just
play the same 8 periods worth of sound, and the buffer never fills up
with new material from the user space/application/alsa middle layer -
and the calling app blocks ad infinitum, because clearly it is never
told to send any more data


How do I fix this?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
