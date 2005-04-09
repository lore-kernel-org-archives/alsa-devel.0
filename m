From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000523]: Unable to get SPDIF output on Biostar IDEQ minipc
Date: Sat, 9 Apr 2005 16:39:40 +0200
Message-ID: <2efee2f54fee5ba1df75e887c3bebb8e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2561424F
	for <alsa-devel@alsa-project.org>; Sat,  9 Apr 2005 16:39:41 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=523> 
======================================================================
Reported By:                pharm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   523
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian unstable
Kernel Version:             2.4.27-1-k7 with alsa 1.0.6a (1.0.7rc1 doesn't work
either)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-22-2004 22:48 CEST
Last Modified:              04-09-2005 16:39 CEST
======================================================================
Summary:                    Unable to get SPDIF output on Biostar IDEQ minipc
Description: 
I have a Biostar IDEQ 210V minipc. As well as 6 channel analog out (which
appears to work, at least stereo analog out does for certain) there are
two digital (optical) SPDIF outputs. Unfortunately I can't get anything to
recognise these -- mplayer complains about the lack of IEC958 mixer
entries if I try to use the hwac3 output, and if I point the 
alsa output at any of the list of hardware outputs I get nothing from the
digital amp -- it doesn't appear to get any signal.

Assuming I'm not doing something dumb, is there anything else I should
try? I've tried all the ac97_quirk options.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000537 VIA VT8237: rear L/R switched with Cent...
======================================================================

----------------------------------------------------------------------
 pharm - 10-21-04 15:29 
----------------------------------------------------------------------
Argh. Lets try that again: With speaker-test -Dsurround51 -c6

Output    Output heard
Front R   Front L
Front L   Front R
Rear R    Center[*]
Rear L    Center[*]
Center    (Nothing)   
LFE       (Nothing)

[*] Could be the LFE output -- I'm note sure which way round these usually
are. Treated as an ordinary stereo out, I only get audio from the right
speaker of the pair.

I'll attach the register values which got the above, and see if I can get
any further later on. cheers, Phil

----------------------------------------------------------------------
 jdthood - 04-09-05 16:37 
----------------------------------------------------------------------
So far as I can make out, the remaining problem was: 

> Output    Output heard
> Front R   Front L
> Front L   Front R
> Rear R    Center[*]
> Rear L    Center[*]
> Center    (Nothing)
> LFE       (Nothing)

This was reported in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=537
so I am marking this report a duplicate of that
one.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-22-04 22:48 pharm          New Issue                                    
09-22-04 22:48 pharm          Distribution              => Debian unstable 
09-22-04 22:48 pharm          Kernel Version            => 2.4.27-1-k7 with alsa
1.0.6a (1.0.7rc1 doesn't work either)
09-23-04 18:25 tiwai          Note Added: 0001829                          
09-23-04 18:26 tiwai          File Added: cm9761-add.dif                    
09-23-04 22:09 pharm          Note Added: 0001851                          
09-24-04 09:28 pharm          Issue Monitored: pharm                       
09-24-04 12:03 tiwai          Note Added: 0001869                          
09-24-04 12:28 pharm          Note Added: 0001877                          
09-24-04 13:34 pharm          Note Added: 0001882                          
09-24-04 14:33 tiwai          Note Added: 0001886                          
09-24-04 15:29 tiwai          Note Added: 0001890                          
09-24-04 15:29 tiwai          File Added: cm9761-add-take2.dif                  
 
09-24-04 15:57 pharm          Note Added: 0001892                          
09-24-04 16:05 tiwai          Note Added: 0001893                          
09-24-04 16:05 tiwai          File Added: cm9761-add-take3.dif                  
 
09-24-04 16:31 pharm          Note Added: 0001894                          
09-24-04 16:43 pharm          Note Added: 0001895                          
09-24-04 17:08 tiwai          Note Added: 0001896                          
09-24-04 17:08 tiwai          File Added: cm9761-add-take4.dif                  
 
09-24-04 17:23 pharm          File Added: 1.0.7rc1-ac97#0-0                    
09-24-04 17:24 pharm          File Added: 1.0.7rc1-ac97#0-0+regs                
   
09-24-04 17:32 pharm          File Added: take4-ac97#0-0                    
09-24-04 17:32 pharm          File Added: take4-ac97#0-0+regs                   

09-24-04 17:33 pharm          Note Added: 0001897                          
09-24-04 17:39 tiwai          Note Added: 0001898                          
09-24-04 17:41 pharm          Note Added: 0001899                          
09-24-04 17:45 tiwai          Note Added: 0001900                          
09-24-04 17:58 pharm          Note Added: 0001901                          
09-24-04 18:06 tiwai          Note Added: 0001902                          
09-27-04 09:56 pharm          Note Added: 0001933                          
09-27-04 15:16 tiwai          Note Added: 0001939                          
09-27-04 15:17 tiwai          File Added: cm9761-add-take5.dif                  
 
10-12-04 14:59 tiwai          Note Added: 0002102                          
10-12-04 15:10 pharm          Note Added: 0002105                          
10-13-04 23:46 pharm          Note Added: 0002135                          
10-14-04 12:46 tiwai          Note Added: 0002142                          
10-21-04 15:14 pharm          Note Added: 0002220                          
10-21-04 15:25 pharm          Note Added: 0002221                          
10-21-04 15:29 pharm          Note Added: 0002222                          
10-21-04 15:30 pharm          File Added: partially-working-reg                 
  
04-09-05 16:37 jdthood        Note Added: 0004413                          
04-09-05 16:39 jdthood        Relationship added       duplicate of 0000537
04-09-05 16:39 jdthood        Status                   new => closed       
04-09-05 16:39 jdthood        Resolution               open => fixed       
04-09-05 16:39 jdthood        Description Updated                          
04-09-05 16:39 jdthood        Additional Information Updated                    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
