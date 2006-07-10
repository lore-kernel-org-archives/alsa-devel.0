From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000026]: Noises when playing sound on
	VT8237+ALC655
Date: Mon, 10 Jul 2006 17:59:18 +0200
Message-ID: <2e7b463679b4fe116627f7fcb71a17b6@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1D727244
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Jul 2006 17:59:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=26> 
======================================================================
Reported By:                xram
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   26
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             02-02-2004 06:22 CET
Last Modified:              07-10-2006 17:59 CEST
======================================================================
Summary:                    Noises when playing sound on VT8237+ALC655
Description: 
I have noisy crackles when playing sound. I tried to set dxs_support=1, 2,
3 and 4. Best result - dxs_support=4 (minimum crackles). I upgraded my
system bios, but it didn't solve my problem. My system:
M/B: Epox 8KRAI
South Bridge: VIA VT8237
Codec: Realtek ALC 655

PS.(Sorry for my english :)
======================================================================

----------------------------------------------------------------------
 tiwai - 03-01-04 19:21 
----------------------------------------------------------------------
the bugs with ALC655/658 should have been fixed with the recent version.
try 1.0.3.

----------------------------------------------------------------------
 perex - 06-08-05 18:07 
----------------------------------------------------------------------
Ok, just ping, does this problem persist with the latest ALSA driver?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-02-04 06:22 xram           New Issue                                    
02-02-04 15:16 tiwai          Note Added: 0000106                          
02-02-04 15:16 tiwai          Status                   new => assigned     
02-02-04 15:16 tiwai          Assigned To               => tiwai           
02-03-04 17:37 chb            Note Added: 0000138                          
03-01-04 19:21 tiwai          Note Added: 0000420                          
06-08-05 18:07 perex          Note Added: 0004968                          
07-10-06 17:59 Adrian Bunk    Status                   assigned => resolved
07-10-06 17:59 Adrian Bunk    Resolution               open => fixed       
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
