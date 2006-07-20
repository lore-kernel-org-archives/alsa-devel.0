From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001456]: some Realtek ALC861 hda-intel
	problems
Date: Thu, 20 Jul 2006 10:48:21 +0200
Message-ID: <100bc4c8ba9d4c477b1e914fa871e8cc@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64C0A226
	for <alsa-devel@alsa-project.org>;
	Thu, 20 Jul 2006 10:48:21 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1456> 
======================================================================
Reported By:                kaloian
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1456
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.13
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             09-25-2005 12:35 CEST
Last Modified:              07-20-2006 10:48 CEST
======================================================================
Summary:                    some Realtek ALC861 hda-intel problems
Description: 
First I'm not sure that chip 861 is suported?...Alsa rekognize it like
880....and therfore there are some unusable sliders at mixer control -
like 3 input controls instead one...and Master volume is missing. Also
have problem with straching sound reported already here but it's not big
problem while work fine with OSS. Other big problem for me is that when
start Linux from system halt alsa dont work at all - alsamixer shows only
1 or two controls - front or pcm but they dont realy work...even I try
remove and load module hda-intel but..... To resolve this I need to start
first windows(XP) and then reboot(not halt) system - now alsa work. I'm
not sure where to look for problem - alsa or bios. 

Motherboard is ASUS  P5RD1-V Deluxe with ATI  XPRESS NBridge and Uli 1573
SBridge with integrated sound - Realtek ALC861. Bios is newest version -
0802. Kernel 2.6.13, alsa-driver 1.0.9b.


======================================================================

----------------------------------------------------------------------
 rlrevell - 12-19-05 02:29 
----------------------------------------------------------------------
Please try the 1.0.11-rc1 release, we got a patch from Realtek that should
fix many of these problems.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-25-05 12:35 kaloian        New Issue                                    
09-25-05 12:35 kaloian        Kernel Version            => 2.6.13          
12-19-05 02:29 rlrevell       Note Added: 0007084                          
07-20-06 10:48 Adrian Bunk    Status                   assigned => resolved
07-20-06 10:48 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
