From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000725]: intel8x0, chip  CMI9761A - no volume control, sound mixer broken
Date: Thu, 13 Jan 2005 17:20:37 +0100
Message-ID: <2cb7f799fb06541ea33b5a3130482ae0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id C2311309
	for <alsa-devel@alsa-project.org>; Thu, 13 Jan 2005 17:20:37 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=725> 
======================================================================
Reported By:                atiounkine
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   725
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               RXART
Kernel Version:             2.6.9
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-13-2004 21:44 CET
Last Modified:              01-13-2005 17:20 CET
======================================================================
Summary:                    intel8x0, chip  CMI9761A - no volume control, sound
mixer broken
Description: 
Hello
 We have a problem  with sound mixer with Intel AC97 interface and 
CMI9761A in motherboard PC-Chips 909G version 1.0 with Linux.
  The problem is: sound mixer is not working at all,
   the sound level by default is high.

  The new kernel was downloaded from this address:
http://http.us.debian.org/debian/pool/main/k/kernel-image-2.6.9-i386/
kernel-image-2.6.9-1-686_2.6.9-2_i386.deb

  Sound system is ALSA and driver used is "snd_intel8x0" .
If you have information how resolve this problem please send me it.

  Thank you.
    Iouri

======================================================================

----------------------------------------------------------------------
 rlrevell - 12-14-04 22:19 
----------------------------------------------------------------------
This is not a bug.  Your device probably does not have a hardware volume
control.  To reduce the volume, decrease the output level in the
application.

----------------------------------------------------------------------
 tiwai - 01-13-05 17:20 
----------------------------------------------------------------------
ALSA 1.0.8 includes the softvol plugin.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-13-04 21:44 atiounkine     New Issue                                    
12-13-04 21:44 atiounkine     Distribution              => RXART           
12-13-04 21:44 atiounkine     Kernel Version            => 2.6.9           
12-14-04 22:19 rlrevell       Note Added: 0002823                          
01-13-05 17:20 tiwai          Status                   new => resolved     
01-13-05 17:20 tiwai          Resolution               open => fixed       
01-13-05 17:20 tiwai          Assigned To               => tiwai           
01-13-05 17:20 tiwai          Note Added: 0003190                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
