From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000981]: I don't get any sound on nforce 3 (AMD64 plataform).
Date: Wed, 23 Mar 2005 16:00:45 +0100
Message-ID: <f63eb66fe7ec0d8baadc54588aeb883e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 5F562211
	for <alsa-devel@alsa-project.org>; Wed, 23 Mar 2005 16:00:45 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=981> 
======================================================================
Reported By:                soulhunter
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   981
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian and Gentoo.
Kernel Version:             2.6.11
======================================================================
Date Submitted:             03-12-2005 01:48 CET
Last Modified:              03-23-2005 16:00 CET
======================================================================
Summary:                    I don't get any sound on nforce 3 (AMD64 plataform).
Description: 
>From kernel version 2.6.9 and up I don't get any sound.  I currently use
2.6.8.1 (where the sound works just fine).

I even tried to compile 2.6.11 with only snd_intel8x0 as module: nothing.

I have no idea what is going on, yes I looked at the volume settings, and
unmuted the master and pcm channels.  The sound application seems to be
"playing", but I get no sound.

My motherboard is a Chaintech VNF250.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-16-05 13:03 
----------------------------------------------------------------------
Please attach /etc/asound.state and the contents of
/proc/asound/card0/codec97#0/* files (please use attachments).

----------------------------------------------------------------------
 jdthood - 03-23-05 16:00 
----------------------------------------------------------------------
This could have something to do with the index numbers assigned to the
drivers.  Please send the output of /proc/asound/cards.  Are you sure you
are directing sound output to the right card?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-12-05 01:48 soulhunter     New Issue                                    
03-12-05 01:48 soulhunter     Distribution              => Debian and Gentoo.
03-12-05 01:48 soulhunter     Kernel Version            => 2.6.11          
03-16-05 13:03 tiwai          Note Added: 0003953                          
03-23-05 16:00 jdthood        Note Added: 0004168                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
