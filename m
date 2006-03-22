From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001663]: LW20 bugs with headphone input, realtek.com.tw has a fix, please intergrate it!
Date: Wed, 22 Mar 2006 13:26:50 +0100
Message-ID: <b3e40ee3caae87f557fe3975d0165556@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19F4E1A3
	for <alsa-devel@alsa-project.org>; Wed, 22 Mar 2006 13:26:50 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1663> 
======================================================================
Reported By:                mikael
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1663
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Archlinux
Kernel Version:             2.4.13.4
======================================================================
Date Submitted:             12-20-2005 19:11 CET
Last Modified:              03-22-2006 13:26 CET
======================================================================
Summary:                    LW20 bugs with headphone input, realtek.com.tw has a
fix, please intergrate it!
Description: 
My new laptop has a HDA Intel (Realtek ALC880) soundcard. 

It though for some reason do not turn off the main speaker when you insert
headphones. On the site
http://www.realtek.com.tw/downloads/dlhd-2.aspx?lineid=2004052&famid=2004052&series=2004061&Software=True
there is a patched alsa package available which fixes this issue by adding
a "Headphone" mixer which you can turn on/off and also gives you the
availability to mute the main speakers without (as in 1.0.10/11-rc1)
muting the headphones aswell.

Can you please intergrate this? I struggled trying to intergrate this
properly but their alsa is built on 1.0.9 and I suppose I am not the
sharpest of programers either for the job.

Greets,
  Mikael
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0001572 Simultaneous sound from speakers and he...
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-22-06 01:47 
----------------------------------------------------------------------
Is this fixed with the latest ALSA CVS sources?

----------------------------------------------------------------------
 mikael - 03-22-06 13:26 
----------------------------------------------------------------------
Not sure. I sold the laptop and bought a new one. :)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-20-05 19:11 mikael         New Issue                                    
12-20-05 19:11 mikael         Distribution              => Archlinux       
12-20-05 19:11 mikael         Kernel Version            => 2.4.13.4        
01-16-06 16:22 mikael         Note Added: 0007688                          
01-16-06 19:24 rlrevell       Note Added: 0007691                          
01-17-06 00:05 mikael         Note Added: 0007693                          
01-19-06 14:05 mjsb           Note Added: 0007720                          
01-19-06 14:31 mjsb           Issue Monitored: mjsb                        
01-19-06 18:27 rlrevell       Relationship added       duplicate of 0001572
03-01-06 18:00 mpt            Issue Monitored: mpt                         
03-22-06 01:47 rlrevell       Note Added: 0008771                          
03-22-06 13:26 mikael         Note Added: 0008854                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
