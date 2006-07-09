From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001483]: PCM.C errors: Using modem
	drivers.
Date: Sun, 9 Jul 2006 13:47:17 +0200
Message-ID: <a605976cf256c93b746fec6f91c828be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BC0E1277
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Jul 2006 13:47:17 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1483> 
======================================================================
Reported By:                GPLed
Assigned To:                sashak
======================================================================
Project:                    ALSA - lib
Issue ID:                   1483
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             10-18-2005 13:01 CEST
Last Modified:              07-09-2006 13:47 CEST
======================================================================
Summary:                    PCM.C errors: Using modem drivers.
Description: 
snd-intel-8x0m driver. I have successfully loaded the driver and ran
slmodemd --alsa but it gives me the following output:

error: mixer setup: attach hw:1 error: No such file or directory
ALSA lib pcm.c:1959:(snd_pcm_open_conf) Invalid type for PCM modem:1
definition (id: modem, value: cards.pcm.modem)
error: alsa setup: cannot open playback device 'modem:1': Invalid
argument
error: cannot setup device `modem:1'

Some other people also get the very same problem on FC4. Is there anything
that can be done? Please help.
======================================================================

----------------------------------------------------------------------
 sashak - 11-22-05 00:26 
----------------------------------------------------------------------
It is likely not updated configuration on FC4. Which card/driver you are
using and which version of alsa-lib?

----------------------------------------------------------------------
 sashak - 01-06-06 16:39 
----------------------------------------------------------------------
Reporter, any news with it? Does alsa-lib upgrade help?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-18-05 13:01 GPLed          New Issue                                    
11-22-05 00:24 sashak         Status                   new => assigned     
11-22-05 00:24 sashak         Assigned To               => sashak          
11-22-05 00:26 sashak         Note Added: 0006782                          
01-06-06 16:39 sashak         Note Added: 0007487                          
07-09-06 13:47 Adrian Bunk    Status                   assigned => closed  
07-09-06 13:47 Adrian Bunk    Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
