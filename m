From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001013]: Sound is not working on the MacMini
Date: Thu, 24 Mar 2005 19:27:03 +0100
Message-ID: <9639aad928475477dcf768c54d680ee7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 3BD6325D
	for <alsa-devel@alsa-project.org>; Thu, 24 Mar 2005 19:27:03 +0100 (MET)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1013> 
======================================================================
Reported By:                timing
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1013
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             2.6.11.5
======================================================================
Date Submitted:             03-24-2005 19:27 CET
Last Modified:              03-24-2005 19:27 CET
======================================================================
Summary:                    Sound is not working on the MacMini
Description: 
Sound is not working on the MacMini. When loading the dmasound_pmac i get
the following error:

FATAL: Error inserting dmasound_pmac
(/lib/modules/2.6.11.5/kernel/sound/oss/dmasound/dmasound_pmac.ko): No
such device

When trying to play music i get an "maybe your device is busy?" error.

I've found a solution on the ubuntuforums(
http://www.ubuntuforums.org/showthread.php?t=12748 )

it says:

To manually apply the patch (just as easy in this case),
just open the file linux/sound/ppc/pmac.c in an editor,
and search for OAKeylargo.
Where it says SNAPPER right below, you change to SCREAMER (in uppercase).
(In kernel 2.6.10 it's at line 967). 

this solution is very minimal, the alsamixer is slow, and my computer
hangs for a couple of seconds before the start of every new process (when
opening a new window in gnome etc.). When i edit pmac.c in the old way my
system runs normal again.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-05 19:27 timing         New Issue                                    
03-24-05 19:27 timing         Distribution              => Ubuntu          
03-24-05 19:27 timing         Kernel Version            => 2.6.11.5        
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
