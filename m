From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000711]: Sound still bad with alsa on sb audigyls / ca0106
Date: Tue, 7 Dec 2004 18:12:15 +0100
Message-ID: <dafb7630ac241491afa783fd8fcaae7f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 609303AE
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2004 18:12:15 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=711> 
======================================================================
Reported By:                scorpion77
Assigned To:                jcdutton
======================================================================
Project:                    ALSA - driver
Issue ID:                   711
Category:                   PCI - audigyls
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Fedora Core 2
Kernel Version:             2.6.9-1.6_FC2custom
======================================================================
Date Submitted:             12-07-2004 18:12 CET
Last Modified:              12-07-2004 18:12 CET
======================================================================
Summary:                    Sound still bad with alsa on sb audigyls / ca0106
Description: 
Sound is choppy and at wrong speed with both the snd-audigyls from alsa
1.0.7 and snd-ca0106 from alsa CVS. CVS seems worse, which bugs me since
last bug report was closed woth a "Use snd-ca0106 from CVS remark"!
Workaround seems to select (Threaded)OSS as artsd backend instead of Alsa.
Esd as artsd backend only works / fixes things in 1.0.7, it crashes when
the CVS version is used.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-07-04 18:12 scorpion77     New Issue                                    
12-07-04 18:12 scorpion77     Distribution              => Fedora Core 2   
12-07-04 18:12 scorpion77     Kernel Version            => 2.6.9-1.6_FC2custom
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
