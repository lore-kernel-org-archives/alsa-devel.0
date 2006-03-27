From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001966]: Mislabeled items in mixer
Date: Mon, 27 Mar 2006 04:32:10 +0200
Message-ID: <914d4e148e1c9a9e9b2c6d45a6481722@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E2BF81E3
	for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2006 04:32:10 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1966> 
======================================================================
Reported By:                zeug
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1966
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian
Kernel Version:             2.6.14
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-27-2006 00:31 CEST
Last Modified:              03-27-2006 04:32 CEST
======================================================================
Summary:                    Mislabeled items in mixer
Description: 
output of /proc/asound/cards:

 0 [Audigy         ]: Audigy - Audigy 1 [SB0090]
                      Audigy 1 [SB0090] (rev.3, serial:0x511102) at
0xe000, irq 20

In the playback and capture controls, "Analog M" controls the volume to
the line input on the sound card. The "Line" slider controls the volume of
"Analog M" going to the speakers. There is no "Line" slider in the capture
controls, but a "Line2" slider. Appears to be mainly cosmetic.
======================================================================

----------------------------------------------------------------------
 rlrevell - 03-27-06 04:32 
----------------------------------------------------------------------
Not a bug, this is by design.  The various capture sources are all mixed
together and Analog Mix controls their playback volume.

See Documentation/sound/alsa/Audigy-mixer.txt

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-27-06 00:31 zeug           New Issue                                    
03-27-06 00:31 zeug           Distribution              => Debian          
03-27-06 00:31 zeug           Kernel Version            => 2.6.14          
03-27-06 04:32 rlrevell       Status                   new => closed       
03-27-06 04:32 rlrevell       Note Added: 0008985                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
