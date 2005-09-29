From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000101]: SiS7012 LineIn low loudness
Date: Thu, 29 Sep 2005 12:05:31 +0200
Message-ID: <10db5d3865bfab75efa9c0574bb3badd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C5A8B11D
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 12:05:31 +0200 (MEST)
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


The following issue has been set as RELATED TO issue 0001092.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=101> 
======================================================================
Reported By:                goldenfish
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   101
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian testing
Kernel Version:             2.6.4-rc1
======================================================================
Date Submitted:             02-29-2004 11:43 CET
Last Modified:              09-07-2005 16:32 CEST
======================================================================
Summary:                    SiS7012 LineIn low loudness
Description: 
i have SiS7012 integrated on motherboard. if i listen radio from linein
from headphones, maximal loudnes is very low(60% maximal loudness of
SBlive). loudness is in alsamixer is at maximum value(Line In, Master).

======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001092 Low volume output with snd-i8x0
======================================================================

----------------------------------------------------------------------
 jdthood - 03-19-05 09:26 
----------------------------------------------------------------------
Submitter: Is this still a problem?  Do you have better success if you
use gamix to control the mixer levels?

----------------------------------------------------------------------
 Visionary - 03-31-05 15:48 
----------------------------------------------------------------------
I suffer from a similar problem:

When trying to play any sound through SiS7012 PCI Audio Accelerator you
cannot
hear it through the built-in speakers (it's in a Medion SIM 2000 Laptop)
and only very quietly through headphones.  All volumes in kmix, aumix and
alsamixer etc. are at 100%.

----------------------------------------------------------------------
 goldenfish - 09-07-05 16:00 
----------------------------------------------------------------------
Sorry, i don't have already this hardware for testing.

----------------------------------------------------------------------
 Visionary - 09-07-05 16:32 
----------------------------------------------------------------------
Is there anything I can do to test my hardware for you?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-29-04 11:43 goldenfish     New Issue                                    
02-29-04 11:43 goldenfish     File Added: sis7012.tar.bz2                    
03-19-05 09:26 jdthood        Note Added: 0004017                          
03-31-05 15:48 Visionary      Note Added: 0004281                          
09-07-05 16:00 goldenfish     Note Added: 0006057                          
09-07-05 16:32 Visionary      Note Added: 0006058                          
09-29-05 12:05 jdthood        Relationship added       related to 0001092  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
