From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002005]: problems with make
Date: Wed, 5 Jul 2006 23:48:29 +0200
Message-ID: <83f35d7590955a1d65dd3e0b4c0b2a5f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C5ACC259
	for <alsa-devel@alsa-project.org>;
	Wed,  5 Jul 2006 23:48:29 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2005> 
======================================================================
Reported By:                mramirez
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2005
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Fedora Core 5
Kernel Version:             2.6.15-1.2054_FC5smp
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             04-05-2006 19:59 CEST
Last Modified:              07-05-2006 23:48 CEST
======================================================================
Summary:                    problems with make
Description: 
I've dowload the cvs version of alsa, and try install on my laptop, but the
make process exit whit a bad status.
======================================================================

----------------------------------------------------------------------
 Raymond - 04-06-06 09:01 
----------------------------------------------------------------------
Please install the package with full kernel sources for your distribution
or use --with-kernel=dir option to specify another directory with kernel
sources (default is /lib/modules/2.6.15-1.2054_FC5smp/source).

After you installed the kernel source

Compilation from CVS sources
============================

You need GNU packages autoconf and automake installed in your system
to compile CVS sources of alsa-driver package.

For compilation you can use these commands:

	make ALSAKERNELDIR=../alsa-kernel all-deps
		(if the alsa-kernel-dir is really there)
	aclocal
	autoconf
	./configure
	make dep
	make

The included cvscompile script does this job for you.



Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-05-06 19:59 mramirez       New Issue                                    
04-05-06 19:59 mramirez       Distribution              => Fedora Core 5   
04-05-06 19:59 mramirez       Kernel Version            => 2.6.15-1.2054_FC5smp
04-06-06 08:59 Raymond        Note Added: 0009123                          
04-06-06 09:01 Raymond        Note Edited: 0009123                         
07-05-06 23:48 Adrian Bunk    Status                   assigned => closed  
07-05-06 23:48 Adrian Bunk    Resolution               open => not an issue
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
