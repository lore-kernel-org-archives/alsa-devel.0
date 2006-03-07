From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: kernel threads etc
Date: Tue, 07 Mar 2006 21:32:19 +0000
Message-ID: <1141767139.9232.17.camel__36386.3223036335$1141767215$gmane$org@localhost.localdomain>
References: <1141684061.9230.15.camel@localhost.localdomain>
	 <1141686718.25487.76.camel@mindpipe>
	 <1141687750.9230.24.camel@localhost.localdomain>
	 <1141688891.25487.91.camel@mindpipe>
	 <1141690313.9230.32.camel@localhost.localdomain>
	 <1141690930.25487.104.camel@mindpipe>
	 <1141766382.9232.10.camel@localhost.localdomain>
	 <1141766941.767.73.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 70FD6196
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2006 22:32:24 +0100 (MET)
In-Reply-To: <1141766941.767.73.camel@mindpipe>
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

On Tue, 2006-03-07 at 16:29 -0500, Lee Revell wrote:
> On Tue, 2006-03-07 at 21:19 +0000, Adrian McMenamin wrote:
> > 0. Create a DMA buffer in SH4 space - this is used as the source for
> > the
> > dma transfer (the target is in the ARM7's memory space). Alsa seems to
> > fill up this buffer easily enough
> > 
> > 1. Fill the ring buffer completely with first DMA transfer (ring
> > buffer
> > has space for 8 periods) on receiving the SNDDRV_PCM_TRIGGER_START,
> > then
> > start the ARM7 playback
> > 
> > 2. ARM7 fires interrupt on SH4 bus every time period is played
> > 
> > 3. SH4 interrupt handler counts interrupts - have 4 elapsed? if yes
> > then
> > fill up first half of ring buffer - have 8 elapsed? then fill up
> > second
> > half
> > 
> > 4. However the data in the DMA buffer never seems to change - ie I
> > just
> > play the same 8 periods worth of sound, and the buffer never fills up
> > with new material from the user space/application/alsa middle layer -
> > and the calling app blocks ad infinitum, because clearly it is never
> > told to send any more data
> > 
> 
> You should be transferring one period of data every interrupt - why are
> you transferring 4 at a time?
> 
Because you or someone else in an earlier conversation suggested most
people partitioned their buffer in this way. makes no odds :)



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
