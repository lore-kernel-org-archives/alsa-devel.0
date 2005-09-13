From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: [PATCH] Reduce interrupt latency in sound/pci/via82xx.c
Date: Tue, 13 Sep 2005 13:18:25 +0200
Message-ID: <200509131318.25702.annabellesgarden@yahoo.de>
References: <200509121418.05184.annabellesgarden@yahoo.de> <200509121631.32066.annabellesgarden@yahoo.de> <4325FA70.3090702@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <4325FA70.3090702@superbug.co.uk>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Dienstag, 13. September 2005 00:00 schrieb James Courtier-Dutton:
> Karsten Wiese wrote:
> > Am Montag, 12. September 2005 15:09 schrieb Takashi Iwai:
> > 
> >>Hmm, then let's fix the handling of 0 read in all cases.
> >>We can simply assume the next period in this case as an exception.
> > 
> > 
> > No. I've looked at the change sequence of CUR_COUNT through an iopl(3)ed
> > app running as root polling CUR_COUNT.
> > The problem case looks like this:
> > step    value
> > ======  ==========
> > 0	0x01000020	// page index 1, 32 bytes left to transfer
> > 1	0x01000000	// page index 1 complete
> > 2	0x02000000	// switched to page index 2, looks like complete
> > 			// _but hasn't yet started!_
> > 3	0x02001000	// page index 2, 4096 bytes left to transfer
> > 
> > 
> > Step 1 values could be red up to ~270 times in a row.
> > Step 2 values occurred maximum 2 times in a row so far.
> > 
> 
> That looks truely horrible.
> So upper byte in counting up, and lower 3 bytes are counting down!!!

bits 31-24 hold s(catter)g(ather)d(ma) page index,
bits 23-0  show the count of bytes still to transfer.

> 
> Can you please give me some indication of how long the register stays at 
> each value, and at what point the interrupt happens.

I think the interrupt line is activated, where the first Step 1 value
is red. Haven't checked the exact times in useconds.

> 
> Are you also saying that the count can proceed like this:
> 0x01000000
> 0x02000000
> 0x02001000
> 0x02000fff
> ...
> 0x02000001
> 0x02000000
> 0x03000000

yes
> 
> So, here we actually have 0x0200000 twice in the same sequence. That 
> sort of situation will never work well and there is really not a lot 
> that can be done except to say that whenever ((value & 0xffffff) == 0) 
> we don't have a clue where we are in the buffer!
> 
> You say the Step 1 values could be red up to ~270 times in a row but 
> Step 2 values occured max 2 times in a row. Can we assume therefore that 
> the counter is getting stuck st Step 1 for some reason?

Yes, it waits shortly when it has finished a period.

So if above assumption about when the interrupt triggers is correct,
another strategy to solve the ((value & 0xffffff) == 0) situation,
when not in interrupt would look like:
	int c_status = inb(VIADEV_REG(viadev, OFFSET_STATUS))
	if (c_status & (VIA_REG_STAT_EOL|VIA_REG_STAT_FLAG))
		we have finished the period
	else
		we are still at the start of the period,
		interrupt routine has just run,
		use last interrupt position

Will take some time before I try that. Urgent stuff piling up here...

   Karsten

	

	
		
___________________________________________________________ 
Gesendet von Yahoo! Mail - Jetzt mit 1GB Speicher kostenlos - Hier anmelden: http://mail.yahoo.de



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
