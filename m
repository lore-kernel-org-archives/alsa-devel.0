From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0001979]: Missing symbols in oss mixer
	code
Date: Sat, 1 Jul 2006 17:31:12 +0200
Message-ID: <2ff671717daad5ca5f5cc18ddc38b419@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 940ED243
	for <alsa-devel@alsa-project.org>;
	Sat,  1 Jul 2006 17:31:12 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1979> 
======================================================================
Reported By:                zx80user
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   1979
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             03-29-2006 23:03 CEST
Last Modified:              07-01-2006 17:31 CEST
======================================================================
Summary:                    Missing symbols in oss mixer code
Description: 
Attempting to load the snd-pcm-oss module and the snd-pcm-mixer modules
fails due to missing symbols.


======================================================================

----------------------------------------------------------------------
 Adrian Bunk - 07-01-06 17:20 
----------------------------------------------------------------------
Did you complie and install the kernel, and added the module to your kernel
configuration later?

In this case, your problem is expected since adding this module requires
loading the rebuilt snd module or (if ALSA is compiled statically into the
kernel) booting into the rebuilt kernel.

----------------------------------------------------------------------
 rlrevell - 07-01-06 17:31 
----------------------------------------------------------------------
This is certainly a local issue and not a bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-29-06 23:03 zx80user       New Issue                                    
03-29-06 23:04 zx80user       Issue Monitored: zx80user                    
03-29-06 23:05 zx80user       Note Added: 0009019                          
03-30-06 10:00 Raymond        Note Added: 0009024                          
04-01-06 17:20 Raymond        Note Added: 0009056                          
04-02-06 05:16 Raymond        Note Added: 0009057                          
04-02-06 05:26 Raymond        Note Edited: 0009057                         
04-03-06 08:46 Raymond        Note Added: 0009088                          
06-10-06 14:08 Raymond        Note Deleted: 0009088                        
06-10-06 14:08 Raymond        Note Deleted: 0009057                        
06-10-06 14:09 Raymond        Note Deleted: 0009024                        
06-10-06 14:10 Raymond        Note Deleted: 0009056                        
07-01-06 17:20 Adrian Bunk    Note Added: 0010762                          
07-01-06 17:21 Adrian Bunk    Issue Monitored: Adrian Bunk                    
07-01-06 17:31 rlrevell       Status                   new => closed       
07-01-06 17:31 rlrevell       Note Added: 0010764                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
