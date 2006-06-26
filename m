From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002223]: there no sound in pc speakers
	and in headphone sound disapear after few minutes
Date: Mon, 26 Jun 2006 16:13:50 +0200
Message-ID: <e978372ed7b3d8d16908fbe604ac9a50@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 527DB1A8
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Jun 2006 16:13:50 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2223> 
======================================================================
Reported By:                gleboo
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2223
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               RedHat
Kernel Version:             2.6.16-1.2133_FC5smp
======================================================================
Date Submitted:             06-22-2006 13:35 CEST
Last Modified:              06-26-2006 16:13 CEST
======================================================================
Summary:                    there no sound in pc speakers and in headphone sound
disapear after few minutes
Description: 
sound work only few minutes after clean restart and on headphone only.
aslamixer all up
removed and installed againg all drivers from your site
updated kernel after clean FC5 installation and once (to 2.6.16-2111) it
work perfectely - after another installation and updating to more newer
kernel (on 2.6.16-2022 or current) its never worked on .

hardware - Lenovo 3000 N100 1.66Ghz Dual Core,1gb memory
======================================================================

----------------------------------------------------------------------
 rlrevell - 06-25-06 00:33 
----------------------------------------------------------------------
I think this bug might also be fixed in ALSA 1.0.12-rc1.

You should not need single_cmd=1 - model=laptop_eapd should be sufficient

----------------------------------------------------------------------
 tiwai - 06-26-06 16:13 
----------------------------------------------------------------------
The latest version needs even no model option.  Lenovo 3000 N100-07684JU is
already listed in the driver code.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-22-06 13:35 gleboo         New Issue                                    
06-22-06 13:35 gleboo         Distribution              => RedHat          
06-22-06 13:35 gleboo         Kernel Version            => 2.6.16-1.2133_FC5smp
06-24-06 18:17 gleboo         Note Added: 0010481                          
06-25-06 00:26 gleboo         Note Added: 0010494                          
06-25-06 00:33 rlrevell       Note Added: 0010495                          
06-26-06 16:13 tiwai          Note Added: 0010544                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
