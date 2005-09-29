From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001468]: Revolution7+1,module loaded, no proc info, no sound
Date: Thu, 29 Sep 2005 21:37:41 +0200
Message-ID: <a07d31a0becfcfcd3be893c673ab215d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 33F5115D
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 21:37:41 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1468> 
======================================================================
Reported By:                goldenfish
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1468
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian testing
Kernel Version:             2.6.13-rc6
======================================================================
Date Submitted:             09-29-2005 21:34 CEST
Last Modified:              09-29-2005 21:37 CEST
======================================================================
Summary:                    Revolution7+1,module loaded, no proc info, no sound
Description: 
I was purchased today M-Audio Revolution 7+1 card. I compiled kernel. I
loaded module
with modprobe snd-ice1724. by lsmod command module loaded.

But in /proc/asound/cards no card. alsaconf not found this card. No sound
from card.

thanks for help with this card.
======================================================================

----------------------------------------------------------------------
 goldenfish - 09-29-05 21:37 
----------------------------------------------------------------------
aditionall info: in the kernel.log no messages about this card.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-29-05 21:34 goldenfish     New Issue                                    
09-29-05 21:34 goldenfish     File Added: lsmod_0                          
09-29-05 21:34 goldenfish     Distribution              => Debian testing  
09-29-05 21:34 goldenfish     Kernel Version            => 2.6.13-rc6      
09-29-05 21:37 goldenfish     Note Added: 0006423                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
