From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001094]: nforce4 - optical spdif out not working
Date: Mon, 9 May 2005 09:56:49 +0200
Message-ID: <bfe4758452e11cd85c60cc3b702c9c5b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 111C417C
	for <alsa-devel@alsa-project.org>; Mon,  9 May 2005 09:56:50 +0200 (MEST)
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
Last Modified:              05-09-2005 09:56 CEST
======================================================================
Summary:                    nforce4 - optical spdif out not working
Description: 
A 48K PCM optical signal is getting sent out to my receiver, however I
can't get anything to play.  I saw in the "intel8x0.c" that there is no
NFORCE4 callouts.  Does the code fully support the nforce4 yet?
======================================================================

----------------------------------------------------------------------
 eklarson - 05-07-05 23:44 
----------------------------------------------------------------------
Followed the instruction on
"http://www.alsa-project.org/alsa-doc/doc-php/template.php?module=intel8x0"
and had no luck getting the optical out to work.  There is also a forum
thread on this topic as well at
"http://www.nforcershq.com/forum/viewtopic.php?t=58251"



----------------------------------------------------------------------
 gergap - 05-09-05 09:56 
----------------------------------------------------------------------
I've the same problem with
INTEL865G ICH-5 (AOpen XC Cube)
SuSE 9.2, kernel 2.6.8-24.14
ALSA 1.0.7rc1

I also compiled the newer version ALSA 1.0.8 but also didn't work.
I can activate IEC958 in the mixer and the light of the optical out goes
on,
but I can't hear anything when connected to my receiver.

I can retest it when the problem is solved to verify it.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-07-05 11:36 eklarson       New Issue                                    
05-07-05 11:36 eklarson       Distribution              => Fedora Core 3   
05-07-05 11:36 eklarson       Kernel Version            => 2.6.11-1.14_FC3 
05-07-05 11:41 eklarson       Note Added: 0004604                          
05-07-05 23:44 eklarson       Note Edited: 0004604                         
05-09-05 09:56 gergap         Note Added: 0004622                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
