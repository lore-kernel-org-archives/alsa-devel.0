From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002318]: absolutely no sound,
	whatever you try
Date: Mon, 31 Jul 2006 00:04:27 +0200
Message-ID: <bd864b1cb1401e5c024aa6d7a875b49e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id AA13E199
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 00:04:27 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2318> 
======================================================================
Reported By:                alien999999999
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2318
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Mandriva 2006
Kernel Version:             2.6.12-24mdv
======================================================================
Date Submitted:             07-30-2006 23:38 CEST
Last Modified:              07-31-2006 00:04 CEST
======================================================================
Summary:                    absolutely no sound, whatever you try
Description: 
no sound, tried everything...
======================================================================

----------------------------------------------------------------------
 alien999999999 - 07-31-06 00:04 
----------------------------------------------------------------------
read about this jacksense stuff and i notice that i don't have those stuff
in alsamixer.

so i read more about how this is somehow related to very specific
combinations in alsamixer and it's related to surround...

so while i'm speaker testing, i'm spreading front to surround, setting
4ch, downmixing to 2, enabling shared jack, external amp, switching
front/surround jack, enabling all surround mixers and the 3D mixer control
becomes master somehow

well, this workaround seems to work...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-30-06 23:38 alien999999999 New Issue                                    
07-30-06 23:38 alien999999999 Distribution              => Mandriva 2006   
07-30-06 23:38 alien999999999 Kernel Version            => 2.6.12-24mdv    
07-31-06 00:04 alien999999999 Note Added: 0011334                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
