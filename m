From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000545]: midi note off ignored?! (i'm not sure that this is driver problem - correct me if wrong)
Date: Wed, 10 Nov 2004 14:05:13 +0100
Message-ID: <0a0c86e2a153bcf61d592be01ec0ecac@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 69EEC24A
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2004 14:05:13 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=545> 
======================================================================
Reported By:                vlajsa
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   545
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.9-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-26-2004 17:34 CEST
Last Modified:              11-10-2004 14:05 CET
======================================================================
Summary:                    midi note off ignored?! (i'm not sure that this is
driver problem - correct me if wrong)
Description: 
Using sequencer application (tested with rosegarden) and vkeybd produce
some strange sustain-like channel-lock effect. With rosegarden midi note
is played only once (only first that appeared in midi track) and others
are corrctly sent to alsa but not audiable. That first note is pitch and
velocity correct. With vkeybd this is some kind wierder - Every played
note is audiable as it should, but effect is more like deep reverb on most
instuments piano), and sustan like on looping instruments (organs)!
======================================================================

----------------------------------------------------------------------
 vlajsa - 10-20-04 18:22 
----------------------------------------------------------------------
Please close this one! I've upgraded to 1.0.7rc2 and all seems to be fine

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-26-04 17:34 vlajsa         New Issue                                    
09-26-04 17:34 vlajsa         Kernel Version            => 2.6.9-rc2       
10-20-04 18:22 vlajsa         Note Added: 0002217                          
11-10-04 14:05 tiwai          Status                   assigned => resolved
11-10-04 14:05 tiwai          Resolution               open => fixed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
