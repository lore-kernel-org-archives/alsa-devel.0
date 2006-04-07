From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002008]: No Sound with snd-hda-intel driver Asus P5VDC-MX
Date: Fri, 7 Apr 2006 06:38:04 +0200
Message-ID: <e2ffb10dc1c57499a82dad190c2f51d7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B6B74144
	for <alsa-devel@alsa-project.org>; Fri,  7 Apr 2006 06:38:04 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2008> 
======================================================================
Reported By:                mborsick
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2008
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Redhat/Fedora
Kernel Version:             2.6.16-1.2080 and with Xen
======================================================================
Date Submitted:             04-07-2006 00:43 CEST
Last Modified:              04-07-2006 06:38 CEST
======================================================================
Summary:                    No Sound with snd-hda-intel driver Asus P5VDC-MX
Description: 
Kernel is up-to-date Xen kernel.

Initial install did not recognize the sound on an ASUS P5VDC-MX
motherboard.
Motherboard has southbridge VIA VT8251. CODEC is Realtek ACL653 AC'97 6
channel
Audio. Tried the updated drivers in 002404, but was unsuccessful. Also
tried
drivers on VIA site and Realltek site. The last couple of tries show no
errors
in compiling, make, etc. However, as I am just above novice in
understanding
everything about Linux, this has thrown me for a loop.

======================================================================

----------------------------------------------------------------------
 rlrevell - 04-07-06 02:35 
----------------------------------------------------------------------
Try adding { .subvendor = 0x1043, .subdevice = 0x81b9, .action =
VIA_DXS_SRC    } to the PCI ids in via82xx.c for the first device.

As for the "VIA high definition audio controller", I think that's a new
device that isn't supported yet.  tiwai?

----------------------------------------------------------------------
 mborsick - 04-07-06 06:38 
----------------------------------------------------------------------
As I am a step above novice when it comes to Linux, where exactly do I find
via82xx.c file? I am assuming the kernel, but at this point, you have
me...

<G>

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-07-06 00:43 mborsick       New Issue                                    
04-07-06 00:43 mborsick       Distribution              => Redhat/Fedora   
04-07-06 00:43 mborsick       Kernel Version            => 2.6.16-1.2080 and
with Xen
04-07-06 01:07 rlrevell       Note Added: 0009129                          
04-07-06 02:13 mborsick       Note Added: 0009130                          
04-07-06 02:35 rlrevell       Note Added: 0009131                          
04-07-06 06:38 mborsick       Note Added: 0009135                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
