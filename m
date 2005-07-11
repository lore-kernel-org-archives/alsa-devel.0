From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001250]: Emagic a62m - only one mic-capture recognized
Date: Mon, 11 Jul 2005 14:32:07 +0200
Message-ID: <74c8b0357c4efbd5c66bbadadd2a2b83@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7CB8190
	for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2005 14:32:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1250> 
======================================================================
Reported By:                Robert_Schulze
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1250
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               my own
Kernel Version:             2.6.12.2
======================================================================
Date Submitted:             07-11-2005 14:32 CEST
Last Modified:              07-11-2005 14:32 CEST
======================================================================
Summary:                    Emagic a62m - only one mic-capture recognized
Description: 
Alsamixer shows up only one stereo-capture-channel, although the
audio-interface has got 6 mono-ins. 
When using amixer, you can see that the rest of the channels is shown up
as rear-left, rear-right, center and subwoofer, which is not OK.

It would be better, if alsamixer would show up 6 independent mono-capture
channels, if that is not possible, it should at least show up controls for
rear-left, rear-right, center, subwoofer - although those names are not
reasonable in the context of this audiointerface.


======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-11-05 14:32 Robert_Schulze New Issue                                    
07-11-05 14:32 Robert_Schulze Distribution              => my own          
07-11-05 14:32 Robert_Schulze Kernel Version            => 2.6.12.2        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
