From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000936]: AM_PATH_ALSA does not set prefix properly
Date: Sat, 26 Feb 2005 03:28:11 +0100
Message-ID: <760e61c5c1c67fae49b802a925e04ca7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BE424243
	for <alsa-devel@alsa-project.org>; Sat, 26 Feb 2005 03:28:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=936> 
======================================================================
Reported By:                starling
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   936
Category:                   aconnect
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             02-23-2005 22:39 CET
Last Modified:              02-26-2005 03:28 CET
======================================================================
Summary:                    AM_PATH_ALSA does not set prefix properly
Description: 
When configure calls AM_PATH_ALSA, it wrongly assumes that
--with-alsa-prefix specifies the location of the library, not the prefix
of alsa.  In addition, --with-alsa-inc-prefix does not properly modify
CFLAGS.  The result is that every configure where alsa-lib is installed
outside the hardcoded include/lib paths fails unconditionally.
======================================================================

----------------------------------------------------------------------
 tiwai - 02-24-05 22:02 
----------------------------------------------------------------------
I'm afraid it's too late to fix this since the macro is being used widely
now.  Your patch will result in the incompatible configure option  and
break e.g. for 64bit lib path.

----------------------------------------------------------------------
 starling - 02-26-05 03:28 
----------------------------------------------------------------------
I'm not sure how the number of bits per character would break my patch.  As
for it being an incompatible configure option, I don't see how the current
configure can work at all.  With the current (unpatched) alsa.m4, any
installation outside of /usr, of alsa-utils will fail.  With the patch
applied it changes the interface, but installations into /usr (or
/usr/local depending on your compiler) will not fail because they are
checked regardless of which -I/-L flag is passed to the compiler. So the
only configurations that would not be backwards compatible, and would
become 'broken', are the configurations that do not work in the first
place (for no good reason).  Nothing to worry about.

Unless you know something I don't, which is likely.  64-bit whosamawhudda?
 You mean like Unicode paths?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-23-05 22:39 starling       New Issue                                    
02-23-05 22:39 starling       File Added: alsa.diff                        
02-24-05 22:02 tiwai          Note Added: 0003726                          
02-26-05 03:28 starling       Note Added: 0003738                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
