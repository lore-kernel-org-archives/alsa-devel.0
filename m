From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001572]: Simultaneous sound from speakers and headphone
Date: Wed, 15 Mar 2006 15:36:59 +0100
Message-ID: <53aad5870651a7f1e9c768f9e056ec3b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 775E820A
	for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2006 15:36:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1572> 
======================================================================
Reported By:                mjsb
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1572
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux
Kernel Version:             2.1.13-gentoo-r3
======================================================================
Date Submitted:             11-17-2005 16:31 CET
Last Modified:              03-15-2006 15:36 CET
======================================================================
Summary:                    Simultaneous sound from speakers and headphone
Description: 
I cannot ear headphones without having sound from front speakers
simultaneously.
Volume of headphones is adjusted by front speakers and when muting front
speakers also mutes headphones.
(in MS Windows, inserting headphones automatically disables sound from
front speakers)

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001663 LW20 bugs with headphone input, realtek...
======================================================================

----------------------------------------------------------------------
 mjsb - 02-16-06 13:49 
----------------------------------------------------------------------
This bug was submited 3 months ago. It would be nice to have some feedback
on its status.
If there are no plans to fix this, please provide an easy way or
documentation on building a custom model for ALC880.


----------------------------------------------------------------------
 tiwai - 03-15-06 15:36 
----------------------------------------------------------------------
Try the CVS version with "model=lg" option.
I fixed for LG m1 express dual laptop.  Hopefully it's the same for yours.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-17-05 16:31 mjsb           New Issue                                    
11-17-05 16:31 mjsb           Distribution              => Gentoo Linux    
11-17-05 16:31 mjsb           Kernel Version            => 2.1.13-gentoo-r3
11-17-05 16:33 mjsb           Issue Monitored: mjsb                        
12-08-05 21:23 mjsb           Note Added: 0006962                          
01-16-06 11:19 mjsb           Note Added: 0007685                          
01-19-06 18:27 rlrevell       Relationship added       has duplicate 0001663
01-21-06 03:24 mjsb           Note Added: 0007730                          
01-21-06 03:25 mjsb           File Added: HPoff-speakeron                    
01-21-06 03:25 mjsb           File Added: HPon-speakeroff                    
01-21-06 03:30 mjsb           Note Edited: 0007730                         
01-25-06 11:47 blackr2d       Issue Monitored: blackr2d                    
01-25-06 11:56 blackr2d       Note Added: 0007778                          
01-25-06 11:59 blackr2d       Note Edited: 0007778                         
01-25-06 12:00 blackr2d       Note Edited: 0007778                         
01-25-06 12:36 blackr2d       Note Edited: 0007778                         
02-14-06 05:36 richardfish    Issue Monitored: richardfish                    
02-14-06 05:37 richardfish    Note Added: 0008069                          
02-16-06 13:49 mjsb           Note Added: 0008096                          
03-01-06 18:00 mpt            Issue Monitored: mpt                         
03-15-06 15:36 tiwai          Note Added: 0008552                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
