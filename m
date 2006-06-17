From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002159]: ac3 passthrough not working
	on recent versions
Date: Sat, 17 Jun 2006 11:02:54 +0200
Message-ID: <172c200b2632dddf5d16d22edf836b54@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DDA0C192
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Jun 2006 11:02:54 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2159> 
======================================================================
Reported By:                nikke
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2159
Category:                   PCI - ymfpci
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.15
======================================================================
Date Submitted:             05-24-2006 23:44 CEST
Last Modified:              06-17-2006 11:02 CEST
======================================================================
Summary:                    ac3 passthrough not working on recent versions
Description: 
Using the following AC3 passthrough with mplayer works:
Linux 2.4.31
alsa-driver 1.0.8-7 (debian stable packaged)

Using Linux 2.6.15 (both with alsa-driver 1.10rc3 that ships with the
kernel and
alsa-driver 1.0.11) it doesn't work. The reciever just says "unlock" and
stays quiet.

The only change is booting with different kernels, no other config or
hardware is touched, so this must be a driver regression.

The card is YMF-754 based, connected with coax spdif to my HK reciever.

If you need more info, just tell me and I'll dig it up.
======================================================================

----------------------------------------------------------------------
 Raymond - 06-17-06 10:24 
----------------------------------------------------------------------
Which application change those undocumented registers of STAC9708 ?

0:68 = 0000
 0:6a = 0000
 0:6c = 0000
-0:6e = 0004
+0:6e = 0008
 0:70 = 0000
-0:72 = 8000
+0:72 = ffef
 0:74 = 0380
 0:76 = abba
 0:78 = 9381

Are all channels correct when you run speaker-test -Dsurround40 -c 4 -t
wav ?



----------------------------------------------------------------------
 Raymond - 06-17-06 11:02 
----------------------------------------------------------------------
Mimosius

There is a patch which supposed to fix AC3 output

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=fac92b1b0699;style=gitweb

Do this patch fix the problem ?

However there is another patch which add an module parameter

MODULE_PARM_DESC(rear_swap, "Swap rear channels (must be enabled for
correct IEC958 (S/PDIF)) output");

http://hg-mirror.alsa-project.org/alsa-kernel?cmd=changeset;node=2e21f4940a0f;style=gitweb

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-24-06 23:44 nikke          New Issue                                    
05-24-06 23:44 nikke          Distribution              => Debian          
05-24-06 23:44 nikke          Kernel Version            => 2.6.15          
05-24-06 23:47 nikke          Issue Monitored: nikke                       
06-02-06 04:23 Raymond        Note Added: 0010045                          
06-02-06 04:25 Raymond        Note Edited: 0010045                         
06-12-06 13:14 Mimosius       Issue Monitored: Mimosius                    
06-14-06 22:32 nikke          Note Added: 0010216                          
06-15-06 02:18 Raymond        Note Added: 0010221                          
06-15-06 02:27 Raymond        Note Edited: 0010221                         
06-15-06 11:03 Mimosius       Note Added: 0010237                          
06-15-06 23:43 nikke          Note Added: 0010246                          
06-16-06 13:01 Mimosius       Note Added: 0010250                          
06-16-06 13:16 Mimosius       Note Edited: 0010250                         
06-16-06 13:26 Raymond        Note Added: 0010251                          
06-16-06 13:31 Raymond        Note Edited: 0010251                         
06-16-06 13:37 Mimosius       Note Added: 0010252                          
06-16-06 16:25 Raymond        Note Added: 0010255                          
06-17-06 01:17 nikke          Note Added: 0010262                          
06-17-06 02:43 Raymond        Note Edited: 0010251                         
06-17-06 10:21 Raymond        Note Added: 0010266                          
06-17-06 10:24 Raymond        Note Edited: 0010266                         
06-17-06 11:02 Raymond        Note Added: 0010267                          
======================================================================
