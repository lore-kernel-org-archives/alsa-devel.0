From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002041]: Two little compiler warnings
Date: Thu, 20 Apr 2006 12:43:14 +0200
Message-ID: <10a93c963ed081478a179a9c8f7c0880@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A422116C
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2006 12:43:14 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2041> 
======================================================================
Reported By:                Henne
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2041
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   tweak
Priority:                   normal
Status:                     resolved
Distribution:               Suse 10.0 x86_64
Kernel Version:             2.6.17-rc2
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-19-2006 22:10 CEST
Last Modified:              04-20-2006 12:43 CEST
======================================================================
Summary:                    Two little compiler warnings
Description: 
The first one:

In file included from /pci/pcxhr/pcxhr_hwdep.c:9:
/pci/pcxhr/../../alsa-kernel/pci/pcxhr/pcxhr_hwdep.c: In function
&#8216;pcxhr_hwdep_dsp_load&#8217;:
/pci/pcxhr/../../alsa-kernel/pci/pcxhr/pcxhr_hwdep.c:388: warning: format
&#8216;%d&#8217; expects type &#8216;int&#8217;, but argument 4 has type
&#8216;size_t&#8217;

It's just a portability issue, since size_t on i386 has 4 bytes and on
x86_64 8 bytes.

WARNING: /home/henne/alsa/alsa-driver-1.0.11/pci/pdplus/snd-pdplus.o -
Section mismatch: reference to .exit.text:pdplus_sweep from
.text.pdplus_probe after 'pdplus_probe' (at offset 0xbe)

after the prototype of pdplus_sweep on line 1405 is an __exit.
I deleted it and the warning disappeared.
======================================================================

----------------------------------------------------------------------
 Henne - 04-19-06 22:51 
----------------------------------------------------------------------
Here's a patch for pcxhr.

----------------------------------------------------------------------
 tiwai - 04-20-06 12:43 
----------------------------------------------------------------------
Thanks, both fixed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-19-06 22:10 Henne          New Issue                                    
04-19-06 22:10 Henne          Distribution              => Suse 10.0 x86_64
04-19-06 22:10 Henne          Kernel Version            => 2.6.17-rc2      
04-19-06 22:51 Henne          File Added: pcxhr_format.diff                    
04-19-06 22:51 Henne          Note Added: 0009360                          
04-20-06 12:43 tiwai          Status                   assigned => resolved
04-20-06 12:43 tiwai          Resolution               open => fixed       
04-20-06 12:43 tiwai          Note Added: 0009369                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
