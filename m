From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000645]: azx driver is a bit broken
Date: Sat, 27 Nov 2004 19:32:00 +0100
Message-ID: <940da05432399c4f41565e9a9bedca90@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 15627266
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2004 19:32:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=645> 
======================================================================
Reported By:                russell
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   645
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian/Ubuntu
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             11-12-2004 16:58 CET
Last Modified:              11-27-2004 19:32 CET
======================================================================
Summary:                    azx driver is a bit broken
Description: 
The azx driver doesn't work well on the hardware which I have. It pretty
much doesn't work at all in OSS emulation mode. The following patch
improves its stability on my machine enormously (although it is still not
100%), and makes OSS emulation work nicely. As a side effect, the code is
simplified, and to my fairly untrained eyes seems a bit more efficient.

There are also a number of fixes in this patch which make the driver work
more like my understanding of the Intel "High Definition Audio
Specification Revision 1.0" document, and my limited understanding of the
ALSA system. These include:

 - ALSA buffer size now matches the Cyclic Buffer Length (length of entire
buffer)
 - ALSA period size now matches size of each BDL, the number of BDLs are
properly set, and the BDLEs are not changed during playback (as suggested
in the azx spec)

The #define'd STREAM_REST_BIT was renamed to STREAM_RESET_BIT (because
that's what it is).

This is a patch to azx.c only, and is against the current CVS version
(1.11).

I have not done *ANY* work on the capture side of things -- most of my
diffs for output can probably be translated almost directly for input.

There are some other issues which should be addressed in this driver. Off
the top of my head:
 - Will pci_set_dma_mask() be needed if the card is not capable of 64 bit
addressing? Perhaps.
 - The mixer code in 1.0.7rc2 causes a crash on my system, I have pointed
this out to Clemens Ladisch in email. I will work on this problem soon if
nobody else has the time. Commenting out the mixer initialisation code is
working well for me at the moment :)
 - The driver still does not work 100%. When my system is very idle, I get
repeated sections of sound. I used to get a LOT of static, but with my
changes it now just sounds like ALSA is never updating the buffer. I'm
completely baffled by this, any suggestions for me to try, or hints on
debugging this sort of behaviour would be appreciated!

And one issue which I am unclear on, what does the fifo_size field in the
snd_pcm_hardware_t struct actually define?
======================================================================

----------------------------------------------------------------------
 pforai - 11-27-04 16:06 
----------------------------------------------------------------------
@russell:
I have _exactly_ the same problem with my i915GAVL onboard (alc860) snd
card! 
reported by lspci as:
Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High Definition Audio
Controller (rev 03)

didn't have time to apply the patch, is alsa-drvr 1.07 within 2.6.10rcX?
azx isn't even shipped with kernel 2.6.9-mmX, so couldn't test it by now.


tried with 1.07 - mixer crashes system.

edited on: 11-27-04 16:06

----------------------------------------------------------------------
 tiwai - 11-27-04 19:32 
----------------------------------------------------------------------
I'm rewriting the driver code heavily for the time being.
The code from Realtek will be merged there, too, so the support on
ALC880/260 should be improved.  Will check your patch, too.

About the DMA mask, no, it's not needed.  The chip supports 64bit - that
is, it accepts any physical address in 64bit.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-12-04 16:58 russell        New Issue                                    
11-12-04 16:58 russell        File Added: azx.c.diff                       
11-12-04 16:58 russell        Distribution              => Debian/Ubuntu   
11-12-04 16:58 russell        Kernel Version            => 2.6.8.1         
11-12-04 17:30 russell        Note Added: 0002399                          
11-15-04 22:28 Grazy          Issue Monitored: Grazy                       
11-23-04 21:53 footcow        Note Added: 0002531                          
11-27-04 16:04 pforai         Note Added: 0002615                          
11-27-04 16:06 pforai         Note Edited: 0002615                         
11-27-04 19:32 tiwai          Note Added: 0002617                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
