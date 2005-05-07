From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001094]: nforce4 - optical spdif out not working
Date: Sat, 7 May 2005 11:41:28 +0200
Message-ID: <2fa2a1cf406923e6b7d05c7024e2ad22@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D737022E
	for <alsa-devel@alsa-project.org>; Sat,  7 May 2005 11:41:28 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1094> 
======================================================================
Reported By:                eklarson
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1094
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Fedora Core 3
Kernel Version:             2.6.11-1.14_FC3
======================================================================
Date Submitted:             05-07-2005 11:36 CEST
Last Modified:              05-07-2005 11:41 CEST
======================================================================
Summary:                    nforce4 - optical spdif out not working
Description: 
A 48K PCM optical signal is getting sent out to my receiver, however I
can't get anything to play.  I saw in the "intel8x0.c" that there is no
NFORCE4 callouts.  Does the code fully support the nforce4 yet?
======================================================================

----------------------------------------------------------------------
 eklarson - 05-07-05 11:41 
----------------------------------------------------------------------
Followed the instruction on
"http://www.alsa-project.org/alsa-doc/doc-php/template.php?module=intel8x0"
and had no luck getting the optical out to work.  There is also a forum
thread on this topic as well at
"http://www.nforcershq.com/forum/viewtopic.php?t=58251"

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-05 11:36 eklarson       New Issue                                    
05-07-05 11:36 eklarson       Distribution              => Fedora Core 3   
05-07-05 11:36 eklarson       Kernel Version            => 2.6.11-1.14_FC3 
05-07-05 11:41 eklarson       Note Added: 0004604                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
