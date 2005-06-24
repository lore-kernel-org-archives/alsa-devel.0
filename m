From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001069]: Scratchy sound through AC3 passthrough with userspace version 1.0.9rc2
Date: Fri, 24 Jun 2005 17:58:01 +0200
Message-ID: <d384219b7d66f5246b4b81f41c62cab0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7B8023E
	for <alsa-devel@alsa-project.org>; Fri, 24 Jun 2005 17:58:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1069> 
======================================================================
Reported By:                Creideiki
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1069
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             04-21-2005 21:46 CEST
Last Modified:              06-24-2005 17:58 CEST
======================================================================
Summary:                    Scratchy sound through AC3 passthrough with
userspace version 1.0.9rc2
Description: 
I have an Audigy 2 ZS sound card connected via S/PDIF to a Logitech Z-680
decoder/speaker system. After upgrading ALSA userspace (alsa-headers,
alsa-lib) to 1.0.9rc2, with no configuration changes, all I got when
trying to play DVD:s using AC3 passthrough was scratchy noises, and the
external decoder indicated that it did not think it was getting AC3 data.
Software decoding worked, but not hardware passthrough. Both Xine and
MPlayer had this problem. I am not running aRts, or any other sound
server, and have no ~/.asoundrc file.

Downgrading to userspace version 1.0.8 made it work again.

I have no idea how to debug ALSA problems, so please let me know how to
generate any extra information you might require.

By the way, the "Product Version" field in Mantis doesn't let me select
any version higher than 1.0.8.
======================================================================

----------------------------------------------------------------------
 Creideiki - 06-24-05 17:58 
----------------------------------------------------------------------
This issue still exists in version 1.0.9 final.

I've uploaded the results of `iecset` and `cat
/proc/asound/Audigy2/codec97#0/ac97#0-0+regs`, which are identical for
versions 1.0.7 and 1.0.9, and for playing PCM or AC3 passthrough.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-05 21:46 Creideiki      New Issue                                    
04-22-05 02:06 eradicator     Issue Monitored: eradicator                    
04-29-05 09:14 mandreiana     Issue Monitored: mandreiana                    
06-24-05 17:54 Creideiki      File Added: iecset                           
06-24-05 17:54 Creideiki      File Added: ac97#0-0+regs                    
06-24-05 17:58 Creideiki      Note Added: 0005244                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
