From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000506]: Hercules Fortissimo II (Gamesurround 5.1 digital edition) has no sound on headphone output
Date: Sun, 19 Sep 2004 13:41:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040919114120.C72F124007@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 054A72C0
	for <alsa-devel@alsa-project.org>; Sun, 19 Sep 2004 13:41:21 +0200 (MEST)
Received: from server.perex-int.cz (server.perex-int.cz [192.168.100.2])
	by gate.perex-int.cz (Perex's E-mail Delivery System) with ESMTP id CBF3C25E78
	for <alsa-devel@alsa-project.org>; Sun, 19 Sep 2004 13:41:20 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000506
======================================================================
Reported By:                bekker
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     506
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             kernel 2.6.8-gentoo-r3.
======================================================================
Date Submitted:             09-19-2004 13:40 CEST
Last Modified:              09-19-2004 13:41 CEST
======================================================================
Summary:                    Hercules Fortissimo II (Gamesurround 5.1 digital edition) has no sound on headphone output
Description: 
the Fortissimo II card has seperate outputs for front, rear speakers and
headphone. I cannot get sound on the headphone. 

Front (HW:0,0) and rear speakers (HW:0,1) work.IEC958 (HW:0,2) is also
available but I have not tested it.

The slider marked as headphone in the mixer actually controls the rear
speaker volume. 


======================================================================

----------------------------------------------------------------------
 bekker - 09-19-2004 13:41 CEST 
----------------------------------------------------------------------
I had the same issue on Mandrake 9.2, Mandrake 10.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-19-04 13:40 bekker         New Bug                                      
09-19-04 13:40 bekker         Distribution              => Gentoo Linux    
09-19-04 13:40 bekker         Kernel Version            => kernel 2.6.8-gentoo-r3.
09-19-04 13:41 bekker         Bugnote Added: 0001784                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
