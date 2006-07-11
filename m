From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000255]: CM9739 does not sound
Date: Tue, 11 Jul 2006 12:43:55 +0200
Message-ID: <9715cf1e821a46c8afabded2c7498413@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 84779223
	for <alsa-devel@alsa-project.org>;
	Tue, 11 Jul 2006 12:43:55 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=255> 
======================================================================
Reported By:                qeldroma
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   255
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     closed
Distribution:               Gentoo 2004.1
Kernel Version:             2.6.5
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             05-06-2004 13:06 CEST
Last Modified:              07-11-2006 12:43 CEST
======================================================================
Summary:                    CM9739 does not sound
Description: 
I've got the Epox 8RDA3+ Board with this onboard-sound-chip.
The intel8x0 driver is loading without errors, i can adjust the mixers,
but there's definetely no sound.
Under WinXP all is ok.
I googled and found out, that there are several people with this problem.
However, i can give you no hint, where in detail the problem is, perhaps
the CM9739 isn't fully supported right now?
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
duplicate of        0000225 No PCM-mixer on Epox 8RDA3I and no sound
======================================================================

----------------------------------------------------------------------
 jdthood - 03-23-05 16:07 
----------------------------------------------------------------------
Please send the output of

   lsmod
   uname -a
   lspci
   cat /proc/asound/version
   cat /proc/asound/cards

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-04 13:06 qeldroma       New Issue                                    
05-06-04 13:06 qeldroma       Distribution              => Gentoo 2004.1   
05-06-04 13:06 qeldroma       Kernel Version            => 2.6.5           
03-23-05 15:45 jdthood        Relationship added       duplicate of 0000225
03-23-05 16:07 jdthood        Note Added: 0004173                          
07-11-06 12:43 Adrian Bunk    Status                   new => closed       
07-11-06 12:43 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
