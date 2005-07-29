From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001291]: random system crash afer 1h-4h of sound playing
Date: Fri, 29 Jul 2005 19:47:04 +0200
Message-ID: <5e3ba4bce3b28cb8a9bca726954de85a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 971F2197
	for <alsa-devel@alsa-project.org>; Fri, 29 Jul 2005 19:47:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1291> 
======================================================================
Reported By:                bubbleguuum
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1291
Category:                   PCI - hda-intel
Reproducibility:            random
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               PCLinuxOS  P9.1
Kernel Version:             2.6.11-oci12
======================================================================
Date Submitted:             07-29-2005 19:41 CEST
Last Modified:              07-29-2005 19:47 CEST
======================================================================
Summary:                    random system crash afer 1h-4h of sound playing
Description: 
Playing mp3 files in either amaroK using artsd or xmms using the alsa-xmms
plugin crashes consistently the system (sound is looping), no recovery
possible (machine is not pingable). No crash if there is no sound
playing.

The chipset is Realtek ALC260.
Kernel is a custom patched kernel used by PCLinuxOS P9.1 (2.6.11-oci12)

changelog of patches applied  : 
http://www.pclinuxfiles.com/ocilent1/kernel/2.6.X-oci-kernel-changelog

Another strange potential symptom: sometimes artsd takes 100% CPU usage
and kills itself after displaying a popup. It can happend 5min after boot
or never and after relaunching it, it never takes up 100% again.

As you can see this is quite annoying as it prevent me from using this
distro fulltime. I may add than I had this module working perfectly with
Ubuntu Hoary which is using kernel 2.6.10 

If I can offer other details, just tell me


======================================================================

----------------------------------------------------------------------
 bubbleguuum - 07-29-05 19:45 
----------------------------------------------------------------------
link to changelog is bad, here's the good one:

"http://www.pclinuxfiles.com/ocilent1/kernel/2.6.X-oci-kernel-changelog"

----------------------------------------------------------------------
 bubbleguuum - 07-29-05 19:47 
----------------------------------------------------------------------
well concat this two strings for the correct URL !

www.pclinuxfiles.com/ocilent1/kernel/2.6.    X-oci-kernel-changelog

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-05 19:41 bubbleguuum    New Issue                                    
07-29-05 19:41 bubbleguuum    Distribution              => PCLinuxOS  P9.1 
07-29-05 19:41 bubbleguuum    Kernel Version            => 2.6.11-oci12    
07-29-05 19:45 bubbleguuum    Note Added: 0005586                          
07-29-05 19:47 bubbleguuum    Note Added: 0005587                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
