From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001083]: NVIDIA CK8 ALC655 SPDIF passthrough
Date: Mon, 30 May 2005 13:21:26 +0200
Message-ID: <f87fe1f9e80f7824de6b83bbf497e810@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 47BE71C7
	for <alsa-devel@alsa-project.org>; Mon, 30 May 2005 13:21:26 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1083> 
======================================================================
Reported By:                vedran
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1083
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian sid
Kernel Version:             2.6.10-ac12
======================================================================
Date Submitted:             04-29-2005 15:33 CEST
Last Modified:              05-30-2005 13:21 CEST
======================================================================
Summary:                    NVIDIA CK8 ALC655 SPDIF passthrough
Description: 
We're using a motherboard with nVidia nforce2IGP chipset, and the sound
device on this board is NVidia CK8, Realtek ALC655 rev 0. The motherboard
is MSI K7N2GM2, and SPDIF passthrough works fine on Windows XP with stock
realtek drivers.

On Linux, I'm using the latest ALSA CVS (29.04.2005.) on a 2.6.10-ac12
kernel.

I've been able to make a 2 channel  pre-decoded SPDIF output work by using
the hw:0,2 device. If I use the default device, there is no sound on
SPDIF, regardless of the SPDIF related controls in mixer. The controls in
the mixer are:

However, I'm having trouble with AC3 passthrough, I'm using ac3dec -C from
alsa-tools CVS, and I get no sound.

I'm attaching the archive with the output of iecset and
/proc/asound/card0/codec97#0/* files during the ac3dec run, and when
idle.

Maybe the fact that decoded SPDIF output is not working until I pass it
through the hw:0,2 has something to do with this, how can I make ac3dec -C
use hw:0,2?
======================================================================

----------------------------------------------------------------------
 vedran - 05-30-05 13:21 
----------------------------------------------------------------------
Has anybody looked at this bug? What's the status?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-29-05 15:33 vedran         New Issue                                    
04-29-05 15:33 vedran         File Added: spdif_passthrough.tar.gz              
     
04-29-05 15:33 vedran         Distribution              => Debian sid      
04-29-05 15:33 vedran         Kernel Version            => 2.6.10-ac12     
05-30-05 13:21 vedran         Note Added: 0004809                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
