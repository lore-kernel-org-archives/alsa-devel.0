From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001652]: ASUS P5AD2E-Premium CMI 9880 with HDA_INTEL driver output and input entry missing
Date: Thu, 13 Apr 2006 19:00:34 +0200
Message-ID: <7230952dfbc08547858527ddef1ad0b8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B4D1A10F
	for <alsa-devel@alsa-project.org>; Thu, 13 Apr 2006 19:00:34 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1652> 
======================================================================
Reported By:                dschaefer79
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1652
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo Linux 2005.1 X86_64
Kernel Version:             2.6.14
======================================================================
Date Submitted:             12-15-2005 18:40 CET
Last Modified:              04-13-2006 19:00 CEST
======================================================================
Summary:                    ASUS P5AD2E-Premium CMI 9880 with HDA_INTEL driver
output and input entry missing
Description: 
Hi,

My onboard soundcard works great with linux but I don't have a Master
Output nor microphone ,cd, aux input under my linux. I try to use my tv
sound with input but it doesn't work.

Is it possible to add this ??
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-13-06 17:12 
----------------------------------------------------------------------
Try passing "model=asus" (see ALSA-Configuration.txt)

----------------------------------------------------------------------
 Grazy - 04-13-06 19:00 
----------------------------------------------------------------------
Some precision about CMI 9880 (I have a ASUS P5AD2 Premium (without the
"E")):
The available model for CMI 9880 are :
- minimal
- min_fp
- full
- full_dig
- allout
- auto

There is no volume control on the chip so you need a recent alsalib with
softvol pluggin and you will have a PCM mixer.
There is no passthrow for CD, microphone and AUX. You need to record and
replay it (try "arecord -f CD |aplay" for test). There is two record
device : hw:0,0,0 and hw:0,0,1 and you can select the source for each
capture device with "Input Source" (see alsamixer)
I hope this can help.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-15-05 18:40 dschaefer79    New Issue                                    
12-15-05 18:40 dschaefer79    Distribution              => Gentoo Linux 2005.1
X86_64
12-15-05 18:40 dschaefer79    Kernel Version            => 2.6.14          
12-15-05 19:14 dschaefer79    Issue Monitored: dschaefer79                    
04-12-06 23:35 bduc           Note Added: 0009251                          
04-12-06 23:35 bduc           Issue Monitored: bduc                        
04-13-06 00:00 rlrevell       Note Added: 0009252                          
04-13-06 08:56 bduc           Note Added: 0009254                          
04-13-06 17:12 rlrevell       Note Added: 0009262                          
04-13-06 19:00 Grazy          Note Added: 0009267                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
