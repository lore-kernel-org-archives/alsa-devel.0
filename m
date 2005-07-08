From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001235]: ESI ESP 1010 partialy supportet
Date: Fri, 8 Jul 2005 12:10:15 +0200
Message-ID: <96f1e3b3da43fb17596ef36df9e3de1e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3270A193
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 12:10:16 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1235> 
======================================================================
Reported By:                metasymbol
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1235
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE 9.2/9.3, Debian.
Kernel Version:             2.6.xx
======================================================================
Date Submitted:             07-06-2005 10:16 CEST
Last Modified:              07-08-2005 12:10 CEST
======================================================================
Summary:                    ESI ESP 1010 partialy supportet
Description: 
The ESI ESP1010 is a 10CH I/0 Audiosystem with 2 midi I/O.
The base features are supportet:
Midi I/O and 8 CH Analog

not supportet:
The digital I/O
the virtual headphone mixing
the virtual preampflifer mixing (by design of the Envy24control)

======================================================================

----------------------------------------------------------------------
 tiwai - 07-08-05 12:10 
----------------------------------------------------------------------
Try another board model via model option in case that your device is
compatible with another one?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-06-05 10:16 metasymbol     New Issue                                    
07-06-05 10:16 metasymbol     Distribution              => SuSE 9.2/9.3, Debian.
07-06-05 10:16 metasymbol     Kernel Version            => 2.6.xx          
07-08-05 12:10 tiwai          Note Added: 0005415                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
