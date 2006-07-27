From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002306]: No sound output
Date: Thu, 27 Jul 2006 22:34:12 +0200
Message-ID: <01573beb7746ea6e917cc8a1a8bc96de@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C882F23D
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 22:34:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2306> 
======================================================================
Reported By:                mpetermann
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2306
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian Linux Etch Testing
Kernel Version:             2.6.16
======================================================================
Date Submitted:             07-26-2006 23:16 CEST
Last Modified:              07-27-2006 22:34 CEST
======================================================================
Summary:                    No sound output
Description: 
I have a HP compaq nx7010 laptop and currently a major problem with sound
output. To be exactly: I get no sound anymore on my system.

I did a number of changes and tests (see Additional Information) without
success.  I can deliver further information on request.
======================================================================

----------------------------------------------------------------------
 mpetermann - 07-27-06 22:34 
----------------------------------------------------------------------
The problem is fixed. In order to activate the sound output the channels
"Headphone Jack Sense" and "Line Jack Sense" must be muted.

Case can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-26-06 23:16 mpetermann     New Issue                                    
07-26-06 23:16 mpetermann     Distribution              => Debian Linux Etch
Testing
07-26-06 23:16 mpetermann     Kernel Version            => 2.6.16          
07-27-06 22:34 mpetermann     Note Added: 0011279                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
