From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000977]: Unplug playing USB audio device: normal keyboard dies.
Date: Wed, 9 Mar 2005 22:22:21 +0100
Message-ID: <d0248141de996b838fb37f51cfdc43dd@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 68A0E1A8
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2005 22:22:21 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=977> 
======================================================================
Reported By:                jhje00
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   977
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Debian.
Kernel Version:             2.6.10 + 2.6.11.
======================================================================
Date Submitted:             03-09-2005 22:22 CET
Last Modified:              03-09-2005 22:22 CET
======================================================================
Summary:                    Unplug playing USB audio device: normal keyboard
dies.
Description: 
Using an EgoSys U2A USB audio device I have observed that when unplugging
the device while it is in use by e.g. xmms or jackd a slew of error
messages appear. After that, local keyboard is unusable. Mouse and X
works, remote login is still functional, but I am unable to regain local
keyboard.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-09-05 22:22 jhje00         New Issue                                    
03-09-05 22:22 jhje00         Distribution              => Debian.         
03-09-05 22:22 jhje00         Kernel Version            => 2.6.10 + 2.6.11.
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
