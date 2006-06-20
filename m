From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001946]: cs46xx in Thinkapad A21m
	after suspend/resume doesn't play
Date: Tue, 20 Jun 2006 16:25:22 +0200
Message-ID: <306d162d071f4e1bc43fa453a125f3f2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8DA3A16D
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Jun 2006 16:25:22 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1946> 
======================================================================
Reported By:                marvin
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1946
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge
Kernel Version:             2.6.16-RC6
======================================================================
Date Submitted:             03-20-2006 20:15 CET
Last Modified:              06-20-2006 16:25 CEST
======================================================================
Summary:                    cs46xx in Thinkapad A21m after suspend/resume
doesn't play
Description: 
When I suspend to Ram and resume cs46xx stop working. If I rmmod modprobe
snd_cs46xx sound start working, but If I do this often comp sometime
freeze when I try suspend to RAM.




======================================================================

----------------------------------------------------------------------
 cull - 04-23-06 02:08 
----------------------------------------------------------------------
Hi, I am struggling with the same problem for T21 on Ubuntu Breezy and now
on Dapper with Alsa 1.0.11 (see bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=305). If you have
any patch which avoids killing all sound applications, I will be glad to
try it out. This is the most annoying bug for me.

----------------------------------------------------------------------
 dottedmag - 06-20-06 16:25 
----------------------------------------------------------------------
Still fails with 1.0.11rc4 as in vanilla 2.6.17-rc2

However, it is duplicate of 536, 226 and 305

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-20-06 20:15 marvin         New Issue                                    
03-20-06 20:15 marvin         Distribution              => Debian Sarge    
03-20-06 20:15 marvin         Kernel Version            => 2.6.16-RC6      
03-22-06 00:42 marvin         Note Added: 0008765                          
03-25-06 21:03 marvin         Issue Monitored: marvin                      
03-30-06 20:43 philstopford   Note Added: 0009037                          
03-30-06 21:24 marvin         Note Added: 0009039                          
03-31-06 21:25 philstopford   Issue Monitored: philstopford                    
04-21-06 18:20 fizban         Issue Monitored: fizban                      
04-23-06 02:08 cull           Note Added: 0009439                          
06-20-06 16:25 dottedmag      Note Added: 0010337                          
======================================================================
