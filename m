From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001776]: Synchronisation of two m-audio delta 1010 cards
Date: Sun, 5 Feb 2006 17:50:58 +0100
Message-ID: <4bb71abc56d81a402028933325d9d2d9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id ADFDE1C5
	for <alsa-devel@alsa-project.org>; Sun,  5 Feb 2006 17:50:58 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1776> 
======================================================================
Reported By:                Schafwoller
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1776
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.13
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             01-23-2006 18:32 CET
Last Modified:              02-05-2006 17:50 CET
======================================================================
Summary:                    Synchronisation of two m-audio delta 1010 cards
Description: 
Now we´re able to use two ice1712 cards full duplex and without xruns. The
synchronisation via word-clock (with the "no-signal"-state in
envy24control) seems to work for audio up to 48kHz (using 75Ohm cable).
Midi is running on both cards without any problems. We're able to use a tc
m-one(external multi-effects-processor) over spdif connected to the master
sound card.
The problems:
While using 88,2 kHz we get a lot of noise on the pcm-inputs of the
slave-card. Also sending and receiving to/from m-one over spdif on the
slave-card (using 48kHz) is impossible. The sync-signal seems to be broken
because the m-one is reporting error messages regarding a wrong sync-rate!
======================================================================

----------------------------------------------------------------------
 perex - 02-02-06 09:21 
----------------------------------------------------------------------
We cannot do much in the driver. There is only one GPIO bit which selects
the wordclock, so I think that note by johnrigg that you're trying to go
beyond the hardware capabilities might be right.

----------------------------------------------------------------------
 perex - 02-05-06 17:50 
----------------------------------------------------------------------
>From johnrigg on alsa-devel:

fter some reverse engineering I've found out why I was having trouble
syncing my two Delta 1010s at high sample rates using the word clock
inputs.

The Delta 1010 uses a 74HC4046 phase-locked loop (PLL) to lock onto the
word
clock input signal. This is used in a feedback loop with a /256 counter
to
produce a frequency that's multiplied by 256x at the output of the PLL
oscillator. With a 48kHz input this gives a PLL frequency of 12.288MHz.

According to the 74HC4046 data sheet, the maximum frequency it can
work at is 13MHz. In other words, even a 48kHz clock is close to the
specified limit, so forget about higher frequencies. (I didn't discover
this until after I'd built a 96kHz word clock :-(. )

The S/PDIF receiver OTOH uses its own internal PLL which works with 96kHz
sample rate. However,I couldn't sync reliably using the S/PDIF in/outs
with
one card as master and the other as slave. At 96kHz jackd would die at
random
times with a floating point exception, so often it was unusable.
At 48kHz this would still happen, but not often (every couple of hours).
I'm guessing that this is due to a phase difference between master and
slave clocks.

My conclusion is that the only way to sync these cards reliably
at all frequencies is to clock them both from an external S/PDIF device,
and to make sure both cards are receiving the clock signal directly from
the
master device (ie. not going through the S/PDIF circuitry of the first
card
on the way to the second card).

John

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-23-06 18:32 Schafwoller    New Issue                                    
01-23-06 18:32 Schafwoller    Kernel Version            => 2.6.13          
01-23-06 18:34 Schafwoller    Issue Monitored: Schafwoller                    
01-24-06 01:31 johnrigg       Note Added: 0007768                          
02-02-06 09:21 perex          Status                   new => resolved     
02-02-06 09:21 perex          Resolution               open => not an issue
02-02-06 09:21 perex          Assigned To               => perex           
02-02-06 09:21 perex          Note Added: 0007872                          
02-05-06 17:50 perex          Note Added: 0007941                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
