From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002234]: ISA sscape driver does not
	find Soundscape Elite
Date: Sun, 23 Jul 2006 02:25:57 +0200
Message-ID: <d539f47b36f9285dbe4066f1c8f67c3d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DFF8C24A
	for <alsa-devel@alsa-project.org>;
	Sun, 23 Jul 2006 02:25:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2234> 
======================================================================
Reported By:                tjallen
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2234
Category:                   ISA - sscape
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Slackware 10.2
Kernel Version:             2.6.17.1
======================================================================
Date Submitted:             06-26-2006 15:52 CEST
Last Modified:              07-23-2006 02:25 CEST
======================================================================
Summary:                    ISA sscape driver does not find Soundscape Elite
Description: 
The ALSA driver builds fine, both as a module and built-in but
the driver does not find the Soundscape Elite card.
======================================================================

----------------------------------------------------------------------
 tjallen - 07-02-06 03:19 
----------------------------------------------------------------------
I compiled the module and uploaded (all?) the relevant lines from dmesg.
If you'd like me to, I can do the same for other Soundscape cards besides
the Elite.  I think I have at least one of the VIVOs somewhere.

----------------------------------------------------------------------
 rankincj - 07-23-06 02:25 
----------------------------------------------------------------------
I have added preliminary support for detecting non-PnP SoundScape cards to
the ALSA driver. (All copied from the OSS driver, of course ;-).) I have
checked that the module compiles under Linux 2.6.17.6 with gcc 4.1.1, but
that's all. In fact, I can't even check whether I've broken the PnP
support at the moment.

Would anyone with the relevant hardware care to test-drive this module,
please?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-26-06 15:52 tjallen        New Issue                                    
06-26-06 15:52 tjallen        Distribution              => Slackware 10.2  
06-26-06 15:52 tjallen        Kernel Version            => 2.6.17.1        
06-26-06 22:57 Adrian Bunk    Issue Monitored: Adrian Bunk                    
06-28-06 23:25 rankincj       Note Added: 0010628                          
06-29-06 00:40 tjallen        Note Added: 0010630                          
06-29-06 17:57 tiwai          Note Added: 0010679                          
06-29-06 20:30 tjallen        Note Added: 0010701                          
06-29-06 23:14 rankincj       Note Added: 0010703                          
06-29-06 23:17 rankincj       Note Added: 0010704                          
06-30-06 01:45 tjallen        Note Added: 0010708                          
06-30-06 02:10 rankincj       Note Added: 0010710                          
06-30-06 14:46 tjallen        Note Added: 0010735                          
06-30-06 22:38 rankincj       Note Added: 0010752                          
06-30-06 22:47 Adrian Bunk    Note Added: 0010753                          
07-02-06 01:39 rankincj       File Added: sscape.c                         
07-02-06 01:41 rankincj       Note Added: 0010767                          
07-02-06 03:15 tjallen        File Added: sscape.dmesg                     
07-02-06 03:19 tjallen        Note Added: 0010768                          
07-23-06 02:23 rankincj       File Added: alsa-sscape.c                    
07-23-06 02:25 rankincj       Note Added: 0011178                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
