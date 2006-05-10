From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002099]: System hangs while booting, and i get flooded by azx_get_response timeout message
Date: Wed, 10 May 2006 23:59:07 +0200
Message-ID: <df0dbda11efbcb803e2834be4dda3d4e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id F11A31A3
	for <alsa-devel@alsa-project.org>; Wed, 10 May 2006 23:59:07 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2099> 
======================================================================
Reported By:                bugmenot
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2099
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.16.11
======================================================================
Date Submitted:             05-06-2006 15:24 CEST
Last Modified:              05-10-2006 23:59 CEST
======================================================================
Summary:                    System hangs while booting, and i get flooded by
azx_get_response timeout message
Description: 
While booting, and after loading alsa, the screen gets flooded with
azx_get_response timeout messages, and my system wont continue to boot. I
than can only restart.

I have read that this is a known error, and it should  be fixed in the cvs
version  of alsa, but i included the cvs version (cvs copy from the
5.5.2006) into my kernel and i still get the error.

This only happens when i inlcude the intel_hda driver into the kernel
(build into or as modules, its the same)

without it alsa just claims to find no soundcard, but my system works
well.

I have a ibm thinkpad x60s and a hdc7 sound/model card?
======================================================================

----------------------------------------------------------------------
 tiwai - 05-10-06 16:42 
----------------------------------------------------------------------
The CVS is dead.  Try HG version.

There is a known BIOS problem of X60.  Try to update your BIOS.

----------------------------------------------------------------------
 bugmenot - 05-10-06 23:59 
----------------------------------------------------------------------
Upgrading my bios could get tricky, cause i removed windows completely, and
the X60 has no cddrive, but i would like to try the HG Version.

and thats my problem.
i downloaded the aktual hg tree, with hg clone http....

cause there was no ./configure file, i did a automake, so got the
./configure file
but when i try to build the alsa, i get some error messages about missing
direcotries, and missing build rules.

is there some guide explainging how to build alsa from hg source?

thx for your help

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-06-06 15:24 bugmenot       New Issue                                    
05-06-06 15:24 bugmenot       Distribution              => Debian          
05-06-06 15:24 bugmenot       Kernel Version            => 2.6.16.11       
05-06-06 18:35 bugmenot       Note Added: 0009637                          
05-08-06 09:43 bugmenot       Note Added: 0009644                          
05-10-06 16:42 tiwai          Note Added: 0009726                          
05-10-06 23:59 bugmenot       Note Added: 0009753                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
