From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001272]: sys_open symbol not known
Date: Thu, 3 Aug 2006 13:54:08 +0200
Message-ID: <24f7455e32a2158cacfdb897ff79363f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 751D6224
	for <alsa-devel@alsa-project.org>;
	Thu,  3 Aug 2006 13:54:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1272> 
======================================================================
Reported By:                arturl
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1272
Category:                   ISA - wavefront
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Fedora 4
Kernel Version:             2.6.12
======================================================================
Date Submitted:             07-22-2005 10:06 CEST
Last Modified:              08-03-2006 13:54 CEST
======================================================================
Summary:                    sys_open symbol not known
Description: 
The wavefront driver uses sys_open from kernel and this symbol is for
unknown reason not exported. As a consequence module cannot be loaded.
The sys_open function lack of export directive and after adding it all
works OK.
In fact this is not ALSA bug but...

======================================================================

----------------------------------------------------------------------
 Adrian Bunk - 08-03-06 13:54 
----------------------------------------------------------------------
sys_open() is exported by the kernel (I checked both 2.6.12 and 2.6.17).

Please send the exact error messages you see.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-22-05 10:06 arturl         New Issue                                    
07-22-05 10:06 arturl         Distribution              => Fedora 4        
07-22-05 10:06 arturl         Kernel Version            => 2.6.12          
08-09-05 08:34 arturl         Issue Monitored: arturl                      
08-03-06 13:54 Adrian Bunk    Note Added: 0011399                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
