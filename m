From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000402]: No Wavetable-MIDI with snd-emu10k1 compiled static in kernel
Date: Wed, 29 Mar 2006 17:40:13 +0200
Message-ID: <6532370f2d74365271a0e9025c6eb3f6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 53DF2181
	for <alsa-devel@alsa-project.org>; Wed, 29 Mar 2006 17:40:13 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=402> 
======================================================================
Reported By:                frankpoole
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   402
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-21-2004 21:13 CEST
Last Modified:              03-29-2006 17:40 CEST
======================================================================
Summary:                    No Wavetable-MIDI with snd-emu10k1 compiled static
in kernel
Description: 
ALSA does not detect the Wavetable capabilities of the card (tested on SB
Live 5.1 and Audigy2) when loading snd-emu10k1-synth with snd-emu10k1
built inside the kernel. I'm forced to build everything as modules to get
it working.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-21-04 21:13 frankpoole     New Issue                                    
07-21-04 21:13 frankpoole     Kernel Version            => 2.6.7           
07-21-04 21:17 frankpoole     Note Added: 0001464                          
07-21-04 21:18 frankpoole     Note Deleted: 0001464                        
07-21-04 21:19 frankpoole     Issue Monitored: frankpoole                    
03-29-06 17:40 perex          Note Added: 0008993                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
