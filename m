From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002036]: Missing PCI subsystem vendor and device in /proc/asound/../codec97#0/ac97#0-0 for some pci sound card drivers
Date: Wed, 19 Apr 2006 17:17:41 +0200
Message-ID: <43079a93faafbfba14a197f0bcf20e76@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EA3B018A
	for <alsa-devel@alsa-project.org>; Wed, 19 Apr 2006 17:17:41 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2036> 
======================================================================
Reported By:                Raymond
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2036
Category:                   1_OTHERS
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             04-19-2006 17:17 CEST
Last Modified:              04-19-2006 17:17 CEST
======================================================================
Summary:                    Missing PCI subsystem vendor and device in
/proc/asound/../codec97#0/ac97#0-0 for some pci sound card drivers
Description: 
Only a few of pci sound card drivers have initialised 'ac97.pci'.

ad1889.c:       ac97.pci = chip->pci;
atiixp.c:               ac97.pci = chip->pci;
atiixp_modem.c:         ac97.pci = chip->pci;
cs5535audio/cs5535audio.c:      ac97.pci = cs5535au->pci;
intel8x0.c:     ac97.pci = chip->pci;
intel8x0m.c:    ac97.pci = chip->pci;
riptide/riptide.c:      ac97.pci = chip->pci;
via82xx.c:      ac97.pci = chip->pci;
via82xx_modem.c:        ac97.pci = chip->pci;

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-06 17:17 Raymond        New Issue                                    
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
