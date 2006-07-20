From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002291]: AD1986A produces a high
	fequency noise
Date: Thu, 20 Jul 2006 06:47:07 +0200
Message-ID: <67c65d76c0f7f820cb8be33af78930dc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 589ABE2
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 06:47:08 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2291> 
======================================================================
Reported By:                michaeleekk
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2291
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.17-1.2145_FC5
======================================================================
Date Submitted:             07-18-2006 07:12 CEST
Last Modified:              07-20-2006 06:47 CEST
======================================================================
Summary:                    AD1986A produces a high fequency noise
Description: 
Some noise, just like "weeeeee", produced when playing a sound files or
music files.
No exception. It always produced.
======================================================================

----------------------------------------------------------------------
 michaeleekk - 07-20-06 05:12 
----------------------------------------------------------------------
I'm sorry.

But I found that I set the model to auto.

After I set model=3stack, everything goes well.

Thank you .

----------------------------------------------------------------------
 tiwai - 07-20-06 06:47 
----------------------------------------------------------------------
Good to hear.  Then please inform the name of your machine (product name of
laptop, mobo or whatever), together with the output of "lspci -nv" (only
for class 0403) so that the driver will work without extra option.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-18-06 07:12 michaeleekk    New Issue                                    
07-18-06 07:12 michaeleekk    Kernel Version            => 2.6.17-1.2145_FC5
07-18-06 11:50 Adrian Bunk    Category                 0_compilation problem_!!!
=> PCI - hda-intel
07-19-06 20:18 tiwai          Note Added: 0011095                          
07-20-06 05:07 michaeleekk    Note Added: 0011108                          
07-20-06 05:12 michaeleekk    Note Added: 0011109                          
07-20-06 06:47 tiwai          Note Added: 0011110                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
