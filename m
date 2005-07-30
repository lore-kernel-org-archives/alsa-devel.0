From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001274]: alc655: low volume
Date: Sat, 30 Jul 2005 09:11:34 +0200
Message-ID: <2f6180bf019158651f4f915fc3cbd2a2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 876271AD
	for <alsa-devel@alsa-project.org>; Sat, 30 Jul 2005 09:11:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1274> 
======================================================================
Reported By:                vitja
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1274
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             07-22-2005 10:46 CEST
Last Modified:              07-30-2005 09:11 CEST
======================================================================
Summary:                    alc655: low volume
Description: 
I have ATI IXP400 sound in my notebook. codec is realtek's alc655. The
problem is I couldn't hear anything from internal speaker. When I plug
earphones in I hear very-very low music signal, so driver actually works
but. By the way under xp with realtek's drivers thats all right.. Is there
a way to see dump of ac97's registers under xp? May be XP driver uses some
proprietary features of alc655?
======================================================================

----------------------------------------------------------------------
 tiwai - 07-29-05 18:01 
----------------------------------------------------------------------
What do you mean "temporarily solution"?  Does the command sequence above
solve your problem?

----------------------------------------------------------------------
 vitja - 07-30-05 09:11 
----------------------------------------------------------------------
yeah... just before restoring alsa mixer levels I write this values to
acl655...and it works I don't know why...These values are acl655 registers
before audio modules is completly loaded..."temporarily solution" because
it is not right way to make things work...

else one: modem(sb400) doesn't work, module loads ok, slmodem ok...but
when I run minicom and ttry to call system hangs(

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 10:46 vitja          New Issue                                    
07-22-05 20:32 vitja          File Added: codec                            
07-24-05 22:19 vitja          Note Added: 0005560                          
07-29-05 18:01 tiwai          Note Added: 0005583                          
07-30-05 09:11 vitja          Note Added: 0005591                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
