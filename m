From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001291]: random system crash afer 1h-4h of sound playing
Date: Wed, 1 Mar 2006 01:31:20 +0100
Message-ID: <e52f9ea697cc4ffe7e2e40e52d5849f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D25FC170
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 01:31:20 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               PCLinuxOS  P9.1
Kernel Version:             2.6.11-oci12
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-29-2005 19:41 CEST
Last Modified:              03-01-2006 01:31 CET
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
 bubbleguuum - 07-30-05 09:02 
----------------------------------------------------------------------
Did some further test without sound and my notebook crashed, so it's not an
alsa issue as I believed. YOu can close this bug

----------------------------------------------------------------------
 rlrevell - 03-01-06 01:31 
----------------------------------------------------------------------
Closed per user request

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-29-05 19:41 bubbleguuum    New Issue                                    
07-29-05 19:41 bubbleguuum    Distribution              => PCLinuxOS  P9.1 
07-29-05 19:41 bubbleguuum    Kernel Version            => 2.6.11-oci12    
07-29-05 19:45 bubbleguuum    Note Added: 0005586                          
07-29-05 19:47 bubbleguuum    Note Added: 0005587                          
07-30-05 09:02 bubbleguuum    Note Added: 0005589                          
03-01-06 01:31 rlrevell       Status                   assigned => closed  
03-01-06 01:31 rlrevell       Note Added: 0008259                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
