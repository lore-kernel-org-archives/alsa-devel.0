From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000671]: ALSA sound cuts out w/ message: ALSA sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last valid pointer
Date: Wed, 24 Nov 2004 06:47:42 +0100
Message-ID: <b51f4ed729db91704c9a6b861ca992a4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2956628D
	for <alsa-devel@alsa-project.org>; Wed, 24 Nov 2004 06:47:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=671> 
======================================================================
Reported By:                brentcfisher
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   671
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.8.1
======================================================================
Date Submitted:             11-24-2004 06:36 CET
Last Modified:              11-24-2004 06:47 CET
======================================================================
Summary:                    ALSA sound cuts out w/ message: ALSA
sound/pci/via82xx.c:737: invalid via82xx_cur_ptr, using last valid pointer
Description: 
Particularily noticeable when watching a DVD via xine using AC3 Pass
Through.  Sound will cut out momentarily (usually for no more than a
second).  The skip is always accompanied by multiples of this message in
the /var/log/messages file:

Nov 23 22:33:06 hostname ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer
Nov 23 22:33:06 hostname ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer
Nov 23 22:33:06 hostname ALSA sound/pci/via82xx.c:737: invalid
via82xx_cur_ptr, using last valid pointer

These messages appear in the log file once or twice a minute although the
sound only noticable cuts out every few minutes .  Very annoying on an
HTPC.
======================================================================

----------------------------------------------------------------------
 brentcfisher - 11-24-04 06:47 
----------------------------------------------------------------------
Forgot to mention: This is using the SPDIF output on a Via Epia M10000.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-24-04 06:36 brentcfisher   New Issue                                    
11-24-04 06:36 brentcfisher   Distribution              => Gentoo          
11-24-04 06:36 brentcfisher   Kernel Version            => 2.6.8.1         
11-24-04 06:47 brentcfisher   Note Added: 0002541                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
