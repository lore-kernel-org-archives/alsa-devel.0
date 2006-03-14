From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001890]: Only the PCM channel in alsa mixer, unmuted, no sound at all
Date: Tue, 14 Mar 2006 15:21:28 +0100
Message-ID: <7d699e5b28b78ca1f416eccde08e7775@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CFE941BB
	for <alsa-devel@alsa-project.org>; Tue, 14 Mar 2006 15:21:28 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1890> 
======================================================================
Reported By:                arielo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1890
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             Linux haifa 2.6.15-16-686 #1 SMP PREEMPT Mon Feb 20
17:26:04 UTC 2006 i686 GNU/Linux
======================================================================
Date Submitted:             03-04-2006 18:19 CET
Last Modified:              03-14-2006 15:21 CET
======================================================================
Summary:                    Only the PCM channel in alsa mixer, unmuted, no
sound at all
Description: 
Alsamixer shows only one channel called PCM. It's unmuted, and the volume
at its maximum. There is no sound at all, even though there is no error
reported by the system.


======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001921 Unsupported Sound Card
======================================================================

----------------------------------------------------------------------
 sk0rp10 - 03-14-06 15:16 
----------------------------------------------------------------------
now sound output works, also with headphones,great work. Here is the
alsamixer status:

Playback : Master , PCM
Capture: PCM (disabled) , CD , Mic (disabled) , Capture , HP ("L R CAPTUR"
written in red on top of  disabled control) , Unknown (disabled)

Mic volume  Control  is disabled, so I can't test capture.

----------------------------------------------------------------------
 tiwai - 03-14-06 15:21 
----------------------------------------------------------------------
Push space on 'Mic' in capture view to select as the source.  I'm not sure
whether it's a mic jack or whether any internal mic is equipped on this
laptop.

It's better to show the content of /etc/asound.state after running
"alsactl store", though.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-04-06 18:19 arielo         New Issue                                    
03-04-06 18:19 arielo         Distribution              => Ubuntu          
03-04-06 18:19 arielo         Kernel Version            => Linux haifa
2.6.15-16-686 #1 SMP PREEMPT Mon Feb 20 17:26:04 UTC 2006 i686 GNU/Linux
03-14-06 00:25 sk0rp10        Note Added: 0008471                          
03-14-06 14:55 tiwai          Note Added: 0008475                          
03-14-06 14:56 tiwai          File Added: vaio-stac7661-test3.diff              
     
03-14-06 14:57 tiwai          Relationship added       has duplicate 0001921
03-14-06 15:16 sk0rp10        Note Added: 0008479                          
03-14-06 15:21 tiwai          Note Added: 0008480                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
