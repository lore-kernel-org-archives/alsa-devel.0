From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001037]: No volume control with SIS7012 on SIS 755 Athlon64 system
Date: Tue, 5 Apr 2005 23:39:44 +0200
Message-ID: <51690f5f10e9af983549c8ba63f47202@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 95424244
	for <alsa-devel@alsa-project.org>; Tue,  5 Apr 2005 23:39:44 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1037> 
======================================================================
Reported By:                pharm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1037
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.6.10-9-amd64-k8
======================================================================
Date Submitted:             04-05-2005 17:25 CEST
Last Modified:              04-05-2005 23:39 CEST
======================================================================
Summary:                    No volume control with SIS7012 on SIS 755 Athlon64
system
Description: 
I can't get any volume control on this system. The volume mixer makes no
difference to the output, which is only affected by the PCM mixer which
appears to either be 100% or nothing. (ie, if I set it to 0 then the sound
is muted, but any other setting results in maximum volume). I've tried
setting ac97_quirk to values up to 13 and none of them made any
difference.

cheers, Phil
======================================================================

----------------------------------------------------------------------
 badibugle - 04-05-05 23:39 
----------------------------------------------------------------------
I've got exactly the same problem with the SI701 - The master maximum value
is 0 and there is no way to have a sound even if the installation seems
OK.
I've upload an aadebug.log file to give the conf.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-05-05 17:25 pharm          New Issue                                    
04-05-05 17:25 pharm          Distribution              => Debian unstable 
04-05-05 17:25 pharm          Kernel Version            => 2.6.10-9-amd64-k8
04-05-05 23:37 badibugle      File Added: aadebug.log                      
04-05-05 23:39 badibugle      Note Added: 0004343                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
