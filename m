From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000913]: subwoofer not working
Date: Thu, 14 Jul 2005 01:28:43 +0200
Message-ID: <4b535b6053447384520b3809cc594b17@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B02F51DE
	for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2005 01:28:43 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=913> 
======================================================================
Reported By:                matteo
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   913
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               debian/sarge
Kernel Version:             2.6.11-rc4
======================================================================
Date Submitted:             02-16-2005 19:39 CET
Last Modified:              07-14-2005 01:28 CEST
======================================================================
Summary:                    subwoofer not working
Description: 
hi, i got a ASUS W1000 laptop, sound's working now after the latest patch
but i still can't get the subwoofer channel working, any suggestion ?
I can hear it if i play a cd, but not from the pcm!

thx in advance

Matteo

======================================================================

----------------------------------------------------------------------
 matteo - 02-17-05 22:47 
----------------------------------------------------------------------
it works from the speakers, but not from the subwoofer :\
another thing in the alsamixer i got the "master mono" as integer and
"master" as boolean, is it normal ?
thx in advance!

Matteo

----------------------------------------------------------------------
 scoutme - 07-14-05 01:28 
----------------------------------------------------------------------
same problem here.

I heard we should redirect and mix stereo output to the center; actually,
we need some guru's help, since it's not easy at all

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-05 19:39 matteo         New Issue                                    
02-16-05 19:39 matteo         File Added: ac97registers                    
02-16-05 19:39 matteo         Distribution              => debian/sarge    
02-16-05 19:39 matteo         Kernel Version            => 2.6.11-rc4      
02-17-05 20:31 tiwai          Note Added: 0003637                          
02-17-05 22:47 matteo         Note Added: 0003645                          
07-14-05 01:28 scoutme        Note Added: 0005467                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
