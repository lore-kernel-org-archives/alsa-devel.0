From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001863]: Roland ua-20 stops working
Date: Wed, 8 Mar 2006 18:48:50 +0100
Message-ID: <e5e01e10a5d479468d201a349a9b623c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9594F1E0
	for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2006 18:48:50 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1863> 
======================================================================
Reported By:                ldk_linux
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1863
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               Debian Sarge, SUSE Linux OSS
Kernel Version:             2.6.15
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-21-2006 13:25 CET
Last Modified:              03-08-2006 18:48 CET
======================================================================
Summary:                    Roland ua-20 stops working
Description: 
With the usb-audio alsa driver shipped with kernel 2.6.15 this unit (Roland
ua-20 audio & midi interface) stops working. Under a standard vanilla
kernel alsa clients (xmms, alsaplayer, jack) reports "unable to set hw
parameters" and quit. Under the kernel from the jacklab project
(http://jacklab.net/) no error message is visualized, all seems to work
but there is no audio output.

I've tested the unit with 2.6.12 and 2.6.13 kernels and it works
perfectly.
======================================================================

----------------------------------------------------------------------
 ldk_linux - 03-08-06 13:26 
----------------------------------------------------------------------
I've experimented with a standard vanilla 2.6.15.5 kernel on Debian Sarge
and this time it seems to work. No need to upgrade to the latest drivers.
Additionally, the alsa version shipped with this kernel (1.0.10rc3)
appears to be the same that gave problems previously... However, note that
the other time I was using kernel 2.6.15.1.
So... have there been some changes in the alsa sources between 2.6.15.1
and 2.6.15.5 not followed by changes in version number?

----------------------------------------------------------------------
 rlrevell - 03-08-06 18:48 
----------------------------------------------------------------------
Yes, USB audio was broken in kernel 2.6.15.1 and fixed in a later stable
release.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-21-06 13:25 ldk_linux      New Issue                                    
02-21-06 13:25 ldk_linux      Distribution              => Debian Sarge, SUSE
Linux OSS
02-21-06 13:25 ldk_linux      Kernel Version            => 2.6.15          
02-22-06 15:33 ldk_linux      Note Added: 0008158                          
02-22-06 15:36 ldk_linux      Note Edited: 0008158                         
02-22-06 16:06 lemeur         Note Added: 0008159                          
02-24-06 17:17 ldk_linux      Note Added: 0008180                          
03-08-06 13:26 ldk_linux      Note Added: 0008380                          
03-08-06 18:48 rlrevell       Note Added: 0008383                          
03-08-06 18:48 rlrevell       Status                   assigned => resolved
03-08-06 18:48 rlrevell       Resolution               open => fixed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
