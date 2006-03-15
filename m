From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001678]: nForce (10de:026c) left channel squeals, right channel mostly okay
Date: Wed, 15 Mar 2006 15:47:41 +0100
Message-ID: <ffcd2fe29a50d5af9f0d33863b975ba1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5757120A
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 15:47:41 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1678> 
======================================================================
Reported By:                kees
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1678
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Ubuntu Breezy
Kernel Version:             2.6.15-rc6-git4
Resolution:                 duplicate
Duplicate:                  1596
Fixed in Version:           
======================================================================
Date Submitted:             12-25-2005 02:29 CET
Last Modified:              03-15-2006 15:47 CET
======================================================================
Summary:                    nForce (10de:026c) left channel squeals, right
channel mostly okay
Description: 
This is an integrated chipset on an ASUS A8N-VM-UAYGZ mobo.  Marketing info
is this is an "nForce410" board, with "6-channel HD audio".

Both the ALSA in 2.6.15-rc6-git4 and the 1.0.11rc1 ALSA driver for
snd-hda-intel load fine, but during playback, the left channel squeals,
while the right seems to play things okay.

I'm happy to dig around and try whatever needs trying to get this fixed. 
Thanks!
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001596 No sound or High pitched noise, dissape...
======================================================================

----------------------------------------------------------------------
 Xbalanque - 01-31-06 21:43 
----------------------------------------------------------------------
Same problem described by kees with alsa 1.0.11rc3. Just to let you all
know.

----------------------------------------------------------------------
 tiwai - 03-15-06 15:47 
----------------------------------------------------------------------
It's dup of #1596.  Follow the instruction there, and provide the requested
information if it works.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-25-05 02:29 kees           New Issue                                    
12-25-05 02:29 kees           Distribution              => Ubuntu Breezy   
12-25-05 02:29 kees           Kernel Version            => 2.6.15-rc6-git4 
12-26-05 11:02 kees           Note Added: 0007149                          
12-30-05 23:43 morgoth666     Issue Monitored: morgoth666                    
12-30-05 23:43 morgoth666     Issue End Monitor: morgoth666                    
12-30-05 23:44 morgoth666     Issue Monitored: morgoth666                    
12-30-05 23:50 morgoth666     Note Added: 0007300                          
12-31-05 05:47 Dr Hotdog      Issue Monitored: Dr Hotdog                    
12-31-05 10:16 kees           Note Added: 0007355                          
12-31-05 17:12 Dr Hotdog      Note Added: 0007357                          
12-31-05 17:30 Dr Hotdog      Note Edited: 0007357                         
01-04-06 17:40 tiwai          Note Added: 0007446                          
01-04-06 17:56 kees           Note Added: 0007449                          
01-06-06 18:14 adel           Note Added: 0007490                          
01-06-06 19:22 kees           Note Added: 0007494                          
01-12-06 09:57 moreloci       Note Added: 0007583                          
01-25-06 20:52 Ka-Ka          Issue Monitored: Ka-Ka                       
01-31-06 21:43 Xbalanque      Note Added: 0007854                          
02-05-06 06:30 gerick         Issue Monitored: gerick                      
02-06-06 22:39 rbenech        Issue Monitored: rbenech                     
02-08-06 13:06 simonckenyon   Issue Monitored: simonckenyon                    
02-13-06 12:07 beenleigh      Issue Monitored: beenleigh                    
03-06-06 06:12 stevenellis    Issue Monitored: stevenellis                    
03-15-06 15:47 tiwai          Relationship added       duplicate of 0001596
03-15-06 15:47 tiwai          Duplicate ID             0 => 1596           
03-15-06 15:47 tiwai          Status                   assigned => resolved
03-15-06 15:47 tiwai          Resolution               open => duplicate   
03-15-06 15:47 tiwai          Note Added: 0008556                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
