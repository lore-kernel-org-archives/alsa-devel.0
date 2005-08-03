From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001302]: Clicking noise when using kphone with the ALSA AD1816A sound driver
Date: Wed, 3 Aug 2005 12:10:44 +0200
Message-ID: <7f18b07aff3cd0ffd8756a06da48cdc9@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2F4DC195
	for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2005 12:10:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1302> 
======================================================================
Reported By:                tek01
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1302
Category:                   ISA - ad1816a
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             vanilla 2.6.11.12, vanilla 2.6.10, Debians 2.6.8-2
======================================================================
Date Submitted:             08-02-2005 17:29 CEST
Last Modified:              08-03-2005 12:10 CEST
======================================================================
Summary:                    Clicking noise when using kphone with the ALSA
AD1816A sound driver
Description: 
Using kphone (VoIP softphone) with the ALSA native API and the AD1816A
sound driver a continuous clicking noise is heard approximately 3 times
per second. Using the OSS AD1816 with kphone(OSS API) sound driver on the
same system and kernel audio is crystal clear. Also audio latency is much
higher (0.3-0.5s guessed) compared to the OSS AD1816 (<0.1s, also guessed)
sound driver.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0001300 modprobe goes into D-state when inserti...
======================================================================

----------------------------------------------------------------------
 tiwai - 08-03-05 12:09 
----------------------------------------------------------------------
This might be a bug of oss-emulation rather than the ad1816a.
Can you test another sound card on the same system?

----------------------------------------------------------------------
 tiwai - 08-03-05 12:10 
----------------------------------------------------------------------
Blah, a wrong bug issue.  Sorry.

But anyway, it's worthy to try another sound card to sort out whether it's
ad1816a-specific or not.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-02-05 17:29 tek01          New Issue                                    
08-02-05 17:29 tek01          Distribution              => Debian Sarge    
08-02-05 17:29 tek01          Kernel Version            => vanilla 2.6.11.12,
vanilla 2.6.10, Debians 2.6.8-2
08-02-05 18:27 Adrian Bunk    Issue Monitored: Adrian Bunk                    
08-03-05 10:11 perex          Relationship added       related to 0001300  
08-03-05 10:20 perex          Note Added: 0005613                          
08-03-05 12:09 tiwai          Note Added: 0005618                          
08-03-05 12:10 tiwai          Note Added: 0005619                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
