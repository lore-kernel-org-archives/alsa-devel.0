From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001950]: got error related to kde in console
Date: Tue, 21 Mar 2006 19:40:03 +0100
Message-ID: <d300662faaa5315160025dacaa081877@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 813DC1E7
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 19:40:03 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1950> 
======================================================================
Reported By:                zebul666
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1950
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               slackware
Kernel Version:             2.6.15.6
======================================================================
Date Submitted:             03-21-2006 17:05 CET
Last Modified:              03-21-2006 19:40 CET
======================================================================
Summary:                    got error related to kde in console
Description: 
when i run something like (kde not running)
mpg321 somefile.mp3 
or ogg123 somefile.ogg

i got 
create link /home/stef/.kde/socket-titan
can't create mcop directory 

and no sound. 
titan is my hostname
why this kde stuff while i use a console application ?!!!!!

if kde is running there is no error and there is some sound. 

it seems it happens with alsa 1.0.11rc3 but not with alsa 1.0.10 with a
kernel 2.6.15.6 


======================================================================

----------------------------------------------------------------------
 zebul666 - 03-21-06 19:34 
----------------------------------------------------------------------
humm may be 
but which configuration ? 
if it works with alsa 1.0.10 and not with 1.0.11rc3 
so it is alsa configuration ?

----------------------------------------------------------------------
 tiwai - 03-21-06 19:40 
----------------------------------------------------------------------
I don't know, it's your system.  Anyway, try to downgrade to alsa-lib
1.0.10 whether this really doesn't happen with 1.0.10.

Also, you'd better to try ALSA CVS version (or wait for 1.0.11rc4).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-06 17:05 zebul666       New Issue                                    
03-21-06 17:05 zebul666       Distribution              => slackware       
03-21-06 17:05 zebul666       Kernel Version            => 2.6.15.6        
03-21-06 17:10 tiwai          Note Added: 0008744                          
03-21-06 19:34 zebul666       Note Added: 0008757                          
03-21-06 19:40 tiwai          Note Added: 0008758                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
