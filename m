From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001013]: Sound is not working on the MacMini
Date: Sun, 3 Apr 2005 13:44:54 +0200
Message-ID: <7c931a9606cc67c09223384e4c3ff2cf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6F6C01F8
	for <alsa-devel@alsa-project.org>; Sun,  3 Apr 2005 13:44:54 +0200 (MEST)
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
Last Modified:              04-03-2005 13:44 CEST
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

----------------------------------------------------------------------
 perchrh - 03-25-05 21:50 
----------------------------------------------------------------------
no, it's not a screamer. It's an awacs, I am running a kernel with the
change above, but set to AWACS, and sound works perfectly.

Patch against 2.6.11.5:

--- sound/ppc/pmac.c    2005-03-19 07:35:05.000000000 +0100
+++ /usr/src/linux/sound/ppc/pmac.c     2005-03-20 12:04:06.000000000
+0100
@@ -964,7 +964,7 @@
        if (device_is_compatible(sound, "AOAKeylargo")) {
                /* Seems to support the stock AWACS frequencies, but has
                   a snapper mixer */
-               chip->model = PMAC_SNAPPER;
+               chip->model = PMAC_AWACS;
                // chip->can_byte_swap = 0; /* FIXME: check this */
                chip->control_mask = MASK_IEPC | 0x11; /* disable IEE */
        }
makes the mac mini sound work perfectly, but probably breaks some other
pmac soundcard, so it's no good for the kernel as above.



----------------------------------------------------------------------
 perchrh - 04-03-05 13:44 
----------------------------------------------------------------------
I'm testing things now, and

device_is_comatible(sound, "screamer") returns false.
device_is_comatible(sound, "awacs") return false

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-24-05 19:27 timing         New Issue                                    
03-24-05 19:27 timing         Distribution              => Ubuntu          
03-24-05 19:27 timing         Kernel Version            => 2.6.11.5        
03-24-05 19:32 timing         Note Added: 0004194                          
03-24-05 19:35 timing         Issue Monitored: timing                      
03-24-05 19:48 tiwai          Note Added: 0004197                          
03-24-05 21:35 timing         Note Added: 0004202                          
03-25-05 21:44 perchrh        Note Added: 0004212                          
03-25-05 21:50 perchrh        Note Edited: 0004212                         
03-25-05 21:52 perchrh        Issue Monitored: perchrh                     
03-25-05 22:57 timing         Note Edited: 0004202                         
03-25-05 23:27 timing         Note Edited: 0004202                         
04-03-05 13:44 perchrh        Note Added: 0004309                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
