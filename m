From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001948]: configure.in:2229: error: possibly undefined macro: AS_HELP_STRING
Date: Tue, 21 Mar 2006 17:18:18 +0100
Message-ID: <edfc55fbf9966c538feb41d4e8b7cc14@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D02CD1E7
	for <alsa-devel@alsa-project.org>; Tue, 21 Mar 2006 17:18:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1948> 
======================================================================
Reported By:                Raymond
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1948
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Distribution:               Fedora Core 1
Kernel Version:             2.4.22-1.2199.nptl
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             03-21-2006 02:14 CET
Last Modified:              03-21-2006 17:18 CET
======================================================================
Summary:                    configure.in:2229: error: possibly undefined macro:
AS_HELP_STRING
Description: 
./cvscompile --with-cards=intel8x0
make: Nothing to be done for `all-deps'.
configure.in:2229: error: possibly undefined macro: AS_HELP_STRING
      If this token and others are legitimate, please use
m4_pattern_allow.
      See the Autoconf documentation.

======================================================================

----------------------------------------------------------------------
 Raymond - 03-21-06 02:17 
----------------------------------------------------------------------
alsa-driver product version should be CVS instead of 1.0.11rc3

----------------------------------------------------------------------
 tiwai - 03-21-06 17:18 
----------------------------------------------------------------------
Your autoconf looks too old.  autoconf-2.59 is working well.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-21-06 02:14 Raymond        New Issue                                    
03-21-06 02:14 Raymond        Distribution              => Fedora Core 1   
03-21-06 02:14 Raymond        Kernel Version            => 2.4.22-1.2199.nptl
03-21-06 02:17 Raymond        Note Added: 0008735                          
03-21-06 17:18 tiwai          Status                   assigned => resolved
03-21-06 17:18 tiwai          Resolution               open => fixed       
03-21-06 17:18 tiwai          Note Added: 0008746                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
