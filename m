From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001241]: alsaconf missing in the package alsa-utils
Date: Sat, 20 Aug 2005 16:06:12 +0200
Message-ID: <7564b6b086abaaac8f0fd1758fdc0b5a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0100D1DB
	for <alsa-devel@alsa-project.org>; Sat, 20 Aug 2005 16:06:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1241> 
======================================================================
Reported By:                levy
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   1241
Category:                   alsaconf
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             07-08-2005 11:46 CEST
Last Modified:              08-20-2005 16:06 CEST
======================================================================
Summary:                    alsaconf missing in the package alsa-utils
Description: 
system-config-soundcard was unable to detect the sound card of the toshiba
310CDT.
This card is a Chip set Yamaha OPL3-SA3 connected to ISA BUS.

On the contrary, alsaconf was able to detect the card (module sb8) : I
give you a copy of the part of /etc/modprobe.conf produced by alsaconf :
alias sound-card-0 snd-sb8
alias sound-slot-0 snd-sb8
options snd-sb8 dma8=1 irq=9


======================================================================

----------------------------------------------------------------------
 jdthood - 08-20-05 16:06 
----------------------------------------------------------------------
This is a problem with your GNU/Linux distribution, not with ALSA per se.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-08-05 11:46 levy           New Issue                                    
08-20-05 16:06 jdthood        Status                   new => closed       
08-20-05 16:06 jdthood        Note Added: 0005879                          
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
