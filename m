From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000645]: azx driver is a bit broken
Date: Thu, 16 Dec 2004 18:45:38 +0100
Message-ID: <51d99ac9d8f91972f4987b4a31629183@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B1A80249
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 18:45:38 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=645> 
======================================================================
Reported By:                russell
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   645
Category:                   PCI - azx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian/Ubuntu
Kernel Version:             2.6.8.1
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             11-12-2004 16:58 CET
Last Modified:              12-16-2004 18:45 CET
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
 tiwai - 12-08-04 19:52 
----------------------------------------------------------------------
The new driver is now on CVS.  Give it a try.
(But, wait for a while until sourceforge's anon cvs tree is sync'ed.)

----------------------------------------------------------------------
 tiwai - 12-16-04 18:45 
----------------------------------------------------------------------
Other guys confirmed the driver working.  So, this is resolved as FIXED
now.
If you have still problems, reopen again.

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
11-28-04 12:39 pforai         Note Added: 0002622                          
11-28-04 12:48 pforai         Note Edited: 0002622                         
11-28-04 12:49 pforai         Issue Monitored: pforai                      
12-02-04 22:24 swarren        Issue Monitored: swarren                     
12-05-04 23:46 pforai         Note Added: 0002724                          
12-08-04 19:52 tiwai          Note Added: 0002790                          
12-13-04 09:27 aboaboit       Issue Monitored: aboaboit                    
12-14-04 00:11 gaima          Issue Monitored: gaima                       
12-16-04 18:45 tiwai          Status                   new => resolved     
12-16-04 18:45 tiwai          Resolution               open => fixed       
12-16-04 18:45 tiwai          Assigned To               => tiwai           
12-16-04 18:45 tiwai          Note Added: 0002840                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
