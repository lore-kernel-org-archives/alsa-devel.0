From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001898]: no sound from headphones or speakers on asus a6km laptop
Date: Thu, 23 Mar 2006 13:57:01 +0100
Message-ID: <a143b7595654d8cd15709046ec6cf57a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BAC7F1B9
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 13:57:01 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1898> 
======================================================================
Reported By:                kiwi
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1898
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 5 test3
Kernel Version:             2.6.15-1.2009.4.2_FC5
======================================================================
Date Submitted:             03-09-2006 00:30 CET
Last Modified:              03-23-2006 13:56 CET
======================================================================
Summary:                    no sound from headphones or speakers on asus a6km
laptop
Description: 
The headphone port and the speakers just don't work. Seems like there is
some control hidden in the mixer which is muted. 
By setting the master and pcm volume at 100% I can hear just some static
on song beats only on headphones. Speakers always stay mute.
I can only get sound by attaching the headphones to line-in and enabling
"shared" surround mode.

Same issues with a knoppix 4.0.2.

======================================================================

----------------------------------------------------------------------
 lbenini - 03-13-06 23:59 
----------------------------------------------------------------------
Identical problem....
Duplicate of https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1896
(more info in place)

----------------------------------------------------------------------
 lbenini - 03-23-06 13:56 
----------------------------------------------------------------------
This works for me:

"With alsamixer, select "Duplicate front", unmute Surround 3D and use it
if it were the Master Control. Bring the Channels to 4 or 6 and then plug
your headphones in line-in. It worked for me, even if I am still not able
to hear any sound from the built-in speakers. "

Copied from
http://forum.hardware.fr/hardwarefr/MiniPCPortablesPDA/Asus-A6K-MT30-Install-Win-Nux-cours-sujet-17894-4.htm

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-09-06 00:30 kiwi           New Issue                                    
03-09-06 00:30 kiwi           Distribution              => Fedora Core 5 test3
03-09-06 00:30 kiwi           Kernel Version            => 2.6.15-1.2009.4.2_FC5
03-09-06 16:26 kiwi           Issue Monitored: kiwi                        
03-09-06 16:41 kiwi           Note Added: 0008391                          
03-09-06 20:09 michele26x1    Note Added: 0008396                          
03-09-06 21:02 kiwi           Note Added: 0008397                          
03-11-06 14:35 hongqn         Issue Monitored: hongqn                      
03-12-06 15:49 kiwi           Note Added: 0008432                          
03-12-06 16:40 Rollsappletree Note Added: 0008433                          
03-13-06 10:10 u238           Note Added: 0008439                          
03-13-06 10:11 u238           Note Edited: 0008439                         
03-13-06 10:12 u238           Note Edited: 0008439                         
03-13-06 23:59 lbenini        Note Added: 0008469                          
03-23-06 13:56 lbenini        Note Added: 0008881                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
