From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001672]: openal not working
Date: Tue, 1 Aug 2006 00:32:57 +0200
Message-ID: <229f6494e837ba58c38e5a69fe0bba50@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C8BC5166
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 00:32:57 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1672> 
======================================================================
Reported By:                ilikejam
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   1672
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 4
Kernel Version:             2.6.14.x (hand rolled)
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-22-2005 03:13 CET
Last Modified:              08-01-2006 00:32 CEST
======================================================================
Summary:                    openal not working
Description: 
The version of ALSA in the latest (2.6.14) kernel doesn't output sound from
openal. There are no errors (from Unreal Tournament 2004, and from the
openal-test utilities in the fedora openal-test package), but no sound is
output.

Rolling back the kernel to 2.6.11 solves the problem - sound works fine
with that kernel version.
======================================================================

----------------------------------------------------------------------
 Clemens Ladisch - 12-22-05 10:06 
----------------------------------------------------------------------
The USB audio driver shipped with 2.6.14 is known to be buggy.
Update the kernel to 2.6.15-rc?, or update ALSA.

----------------------------------------------------------------------
 ilikejam - 12-23-05 03:27 
----------------------------------------------------------------------
Everything works fine with 2.6.15-rc6.

Cheers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-22-05 03:13 ilikejam       New Issue                                    
12-22-05 03:13 ilikejam       Distribution              => Fedora Core 4   
12-22-05 03:13 ilikejam       Kernel Version            => 2.6.14.x (hand
rolled)
12-22-05 10:06 Clemens LadischNote Added: 0007121                          
12-23-05 03:27 ilikejam       Note Added: 0007131                          
08-01-06 00:32 Adrian Bunk    Status                   assigned => resolved
08-01-06 00:32 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
