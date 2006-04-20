From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002040]: Compilation breaks on hpimod.c
Date: Thu, 20 Apr 2006 13:09:38 +0200
Message-ID: <72f102b12047383da464f518817368ad@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E3789174
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 13:09:38 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2040> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2040
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
Date Submitted:             04-19-2006 21:44 CEST
Last Modified:              04-20-2006 13:09 CEST
======================================================================
Summary:                    Compilation breaks on hpimod.c
Description: 
I know, this one doesn't work on x86_64 at all, but the compiler gives
these warnings and stop compiling:

/pci/asihpi/hpimod.c:95: error: syntax error before string constant
/pci/asihpi/hpimod.c:95: warning: type defaults to &#8216;int&#8217; in
declaration of &#8216;MODULE_PARM&#8217;
/pci/asihpi/hpimod.c:95: warning: function declaration isn&#8217;t a
prototype
/pci/asihpi/hpimod.c:95: warning: data definition has no type or storage
class
/pci/asihpi/hpimod.c:97: error: syntax error before string constant
/pci/asihpi/hpimod.c:97: warning: type defaults to &#8216;int&#8217; in
declaration of &#8216;MODULE_PARM&#8217;
/pci/asihpi/hpimod.c:97: warning: function declaration isn&#8217;t a
prototype
/pci/asihpi/hpimod.c:97: warning: data definition has no type or storage
class
/pci/asihpi/hpimod.c:101: error: syntax error before string constant
/pci/asihpi/hpimod.c:101: warning: type defaults to &#8216;int&#8217; in
declaration of &#8216;MODULE_PARM&#8217;
/pci/asihpi/hpimod.c:101: warning: function declaration isn&#8217;t a
prototype
/pci/asihpi/hpimod.c:101: warning: data definition has no type or storage
class
/pci/asihpi/hpimod.c: In function &#8216;hpi_ioctl&#8217;:
/pci/asihpi/hpimod.c:260: warning: cast to pointer from integer of
different size
/pci/asihpi/hpimod.c:266: warning: cast from pointer to integer of
different size

======================================================================

----------------------------------------------------------------------
 tiwai - 04-20-06 13:09 
----------------------------------------------------------------------
Fixed the compile errors.

Also mod-deps program was fixed so that the driver won't be compiled on
x86-64, too.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-06 21:44 Henne          New Issue                                    
04-19-06 21:44 Henne          Kernel Version            => 2.6.17-rc2      
04-20-06 13:09 tiwai          Status                   assigned => resolved
04-20-06 13:09 tiwai          Resolution               open => fixed       
04-20-06 13:09 tiwai          Note Added: 0009370                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
