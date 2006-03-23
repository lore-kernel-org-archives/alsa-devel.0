From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001953]: Onboard Soundcard (STAC9221) records only noise
Date: Thu, 23 Mar 2006 16:08:16 +0100
Message-ID: <2fb7679640a975a383ec96cb8b8f11f6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C2A7F1BB
	for <alsa-devel@alsa-project.org>; Thu, 23 Mar 2006 16:08:16 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1953> 
======================================================================
Reported By:                derquader
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1953
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Opensuse 10.0
Kernel Version:             2.6.13-15.8
======================================================================
Date Submitted:             03-22-2006 08:04 CET
Last Modified:              03-23-2006 16:08 CET
======================================================================
Summary:                    Onboard Soundcard (STAC9221) records only noise
Description: 
I am using a Intel 945GCZ board with an integrated Sigmatel STAC9221
soundcard.

When I try to record sound from my microphone I only get noise (and if I
listen very closely there is my voice very quiet in the background).

I have tried to set the amplification to maxium which gives me loud noise
but does not make my voice sound any better :-/

(Recording works well with WinXP)
======================================================================

----------------------------------------------------------------------
 derquader - 03-22-06 21:37 
----------------------------------------------------------------------
okay, I guess I have to believe you about that vaio thing ;-)

um, I am not a programmer have never used the patch command before, but I
think I got it...

YES, this patch works indeed! *cheer* thank you a lot :-)

----------------------------------------------------------------------
 tiwai - 03-23-06 16:08 
----------------------------------------------------------------------
Good to hear.  Could you try the second patch instead?  It's a bit
imrpvoed.
If it works, I'll commit it to CVS tree.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-22-06 08:04 derquader      New Issue                                    
03-22-06 08:04 derquader      Distribution              => Opensuse 10.0   
03-22-06 08:04 derquader      Kernel Version            => 2.6.13-15.8     
03-22-06 08:13 rlrevell       Note Added: 0008848                          
03-22-06 20:57 derquader      Note Added: 0008869                          
03-22-06 20:57 derquader      Issue Monitored: derquader                    
03-22-06 21:10 derquader      Note Added: 0008871                          
03-22-06 21:11 tiwai          Note Added: 0008872                          
03-22-06 21:11 tiwai          File Added: stac92xx-auto-vref.diff               
    
03-22-06 21:12 tiwai          Note Added: 0008873                          
03-22-06 21:37 derquader      Note Added: 0008874                          
03-22-06 21:37 derquader      Issue End Monitor: derquader                    
03-23-06 16:08 tiwai          Note Added: 0008884                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
