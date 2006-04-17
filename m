From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002022]: No midi hardware detected
Date: Mon, 17 Apr 2006 06:56:12 +0200
Message-ID: <ddb5c77559d787264f21196f6dbcfd50@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DC4A31A8
	for <alsa-devel@alsa-project.org>; Mon, 17 Apr 2006 06:56:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2022> 
======================================================================
Reported By:                jmstevens
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2022
Category:                   CORE - sequencer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             04-16-2006 08:24 CEST
Last Modified:              04-17-2006 06:56 CEST
======================================================================
Summary:                    No midi hardware detected
Description: 
I want to get hardware MIDI operating with my system. the problem is that
alsa can't seem to detect the hardware. I am running an onboard C-Media
9761 chipset. In alsamixer I have no MIDI related devices at all showing
although everything else runs flawlessly.My modules.conf file is attached.
======================================================================

----------------------------------------------------------------------
 rlrevell - 04-17-06 06:56 
----------------------------------------------------------------------
Load snd-mpu401 to enable the MIDI port.

If by "hardware MIDI" you mean some kind of wavetable synth, it's not
supported by ALSA

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-16-06 08:24 jmstevens      New Issue                                    
04-16-06 08:24 jmstevens      File Added: modules.conf                     
04-17-06 06:56 rlrevell       Status                   new => closed       
04-17-06 06:56 rlrevell       Note Added: 0009300                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
