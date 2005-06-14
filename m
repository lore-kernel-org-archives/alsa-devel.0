From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001190]: amixer non-linearity (causes unwanted panning) for Soundblaster mp3+
Date: Tue, 14 Jun 2005 04:05:48 +0200
Message-ID: <5581fc2d2ecf7b1fb32017ce16a0f251@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3C99F1C1
	for <alsa-devel@alsa-project.org>; Tue, 14 Jun 2005 04:05:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1190> 
======================================================================
Reported By:                RichardNeill
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1190
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Mandrake
Kernel Version:             2.6.11-6
======================================================================
Date Submitted:             06-14-2005 04:05 CEST
Last Modified:              06-14-2005 04:05 CEST
======================================================================
Summary:                    amixer non-linearity (causes unwanted panning) for
Soundblaster mp3+
Description: 
I have a Soundblaster mp3+ USB-audio device. 

I find that when using amixer to control it, the card pans to the right
when the volume is decreased. This unwanted panning does not occur when I
use the same command, but for the motherboard's inbuilt sound, nor does it
occur when I am increasing the volume.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-14-05 04:05 RichardNeill   New Issue                                    
06-14-05 04:05 RichardNeill   Distribution              => Mandrake        
06-14-05 04:05 RichardNeill   Kernel Version            => 2.6.11-6        
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
