From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000398]: aplay produces no sound on short wav files through dmix
Date: Tue, 7 Dec 2004 03:58:59 +0100
Message-ID: <f0e608a1c0b5b93857b25622fb137de5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 99B4137D
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 03:58:59 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=398> 
======================================================================
Reported By:                raveng
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   398
Category:                   aplay/arecord
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-19-2004 16:21 CEST
Last Modified:              12-07-2004 03:58 CET
======================================================================
Summary:                    aplay produces no sound on short wav files through
dmix
Description: 
Wav files shorter than about 0.157 seconds produce no sound under aplay and
dmix. No error message is given, and it looks like it should be working.
If I add silence to the file to make the duration longer, it plays fine.
Also, if I direct aplay to use the hardware directly, it plays the
original file just fine.  Tested on both ens1371 and i810 audio.

Other media players (xmms, mplayer, and artsplay) all play the same file
correctly with dmix. It is only the ALSA-provided aplay that seems to have
difficulty.
======================================================================

----------------------------------------------------------------------
 lesieur - 07-28-04 02:08 
----------------------------------------------------------------------
using aplay -R125000 pop.wav works

----------------------------------------------------------------------
 leahcim - 12-07-04 03:58 
----------------------------------------------------------------------
Reducing buffer_size in asound.conf to some small value (eg. 2K for
/usr/share/sounds/pop.wav, and 1K for /usr/share/sounds/KDE_Click.wav)
made the sounds audible again.

Obviously this will make things underrunny, so I instead opted to increase
the length of the sound files. I have a useful shell script that consists
of the line:

   (sox -p "$@" -t raw -r 44100 -w -s -c2 -;dd if=/dev/zero bs=1024
count=40 2>/dev/null)|aplay -M -N -q - -f cd &

...and point the KDE system notification external player at the script (I
don't use artsd).

The number 40 above isn't an exact figure; there might still be -really-
short sounds that still won't play.

The 'aplay -R125000' hack didn't make a difference for me until I used
smaller numbers. Hmm, perhaps that will be a nicer alternative to my dd
hack...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-19-04 16:21 raveng         New Issue                                    
07-28-04 02:08 lesieur        Note Added: 0001478                          
12-07-04 03:24 leahcim        Issue Monitored: leahcim                     
12-07-04 03:58 leahcim        Note Added: 0002745                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
