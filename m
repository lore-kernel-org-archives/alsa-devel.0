From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0001241]: alsaconf missing in the package alsa-utils
Date: Fri, 8 Jul 2005 11:46:29 +0200
Message-ID: <2783de9a33d5f322b5e134f84e1272a0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 16050185
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 11:46:30 +0200 (MEST)
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


The following issue has been SUBMITTED.
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
Status:                     new
======================================================================
Date Submitted:             07-08-2005 11:46 CEST
Last Modified:              07-08-2005 11:46 CEST
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-08-05 11:46 levy           New Issue                                    
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
