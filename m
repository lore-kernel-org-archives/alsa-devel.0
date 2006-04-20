From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002039]: Compilation breaks on serialmidi.c
Date: Thu, 20 Apr 2006 15:25:08 +0200
Message-ID: <acdfbec9958762a4dcada7c5f25101d3@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 56E00223
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 15:25:08 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2039> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2039
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             2.6.17-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-19-2006 21:17 CEST
Last Modified:              04-20-2006 15:25 CEST
======================================================================
Summary:                    Compilation breaks on serialmidi.c
Description: 
Hello,

today I upgraded to kernel-2.6.17-rc2 and wanted to try out the new
alsa-driver.

drivers/serialmidi.c:317: error: &#8216;struct tty_struct&#8217; has no
member named &#8216;atomic_write      &#8217;
drivers/serialmidi.c:322: error: &#8216;struct tty_struct&#8217; has no
member named &#8216;atomic_write      &#8217;
drivers/serialmidi.c:339: error: &#8216;struct tty_struct&#8217; has no
member named &#8216;atomic_write      &#8217;


======================================================================

----------------------------------------------------------------------
 tiwai - 04-20-06 13:11 
----------------------------------------------------------------------
The snd-serialmidi driver is anyway broken with the recent 2.6 kernels, so
I think it's better to be killed...

----------------------------------------------------------------------
 tiwai - 04-20-06 15:25 
----------------------------------------------------------------------
Disabled serialmidi driver in Kconfig to prevent a build.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-06 21:17 Henne          New Issue                                    
04-19-06 21:17 Henne          Kernel Version            => 2.6.17-rc2      
04-19-06 21:26 Henne          Note Added: 0009355                          
04-20-06 13:11 tiwai          Note Added: 0009371                          
04-20-06 15:25 tiwai          Status                   assigned => resolved
04-20-06 15:25 tiwai          Resolution               open => fixed       
04-20-06 15:25 tiwai          Note Added: 0009383                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
