From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001061]: can't test audio with aplay using 16-bit signed LE format; 1.0.7 however works
Date: Mon, 18 Apr 2005 03:24:55 +0200
Message-ID: <9ba8a39fec3325d6e39789be95be2048@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 12C3A24B
	for <alsa-devel@alsa-project.org>; Mon, 18 Apr 2005 03:24:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1061> 
======================================================================
Reported By:                ukr
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1061
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             Linux 2.6.11
======================================================================
Date Submitted:             04-18-2005 03:24 CEST
Last Modified:              04-18-2005 03:24 CEST
======================================================================
Summary:                    can't test audio with aplay using 16-bit signed LE
format; 1.0.7 however works
Description: 
I usually test my speakers with aplay using

aplay -t raw -f S16_LE -c 6 -r 48000 -Dsurround51

With 1.0.8, when I do this, nothing goes to any of the speakers. However,
when I revert to alsa-driver 1.0.7, it works correctly. I have Intel ICH5
audio with Realtek ALC650F chip with 5.1 channel audio.

Thanks,
            Uday.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-18-05 03:24 ukr            New Issue                                    
04-18-05 03:24 ukr            Distribution              => Fedora Core 3   
04-18-05 03:24 ukr            Kernel Version            => Linux 2.6.11    
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
