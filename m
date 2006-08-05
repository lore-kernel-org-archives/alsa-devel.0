From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002234]: ISA sscape driver does not
	find Soundscape Elite
Date: Sat, 5 Aug 2006 13:36:37 +0200
Message-ID: <fc8d462539728091d13ea2c697dc097a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id A7A9F153
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 13:36:37 +0200 (MEST)
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
Last Modified:              08-05-2006 13:36 CEST
======================================================================
Summary:                    ISA sscape driver does not find Soundscape Elite
Description: 
The ALSA driver builds fine, both as a module and built-in but
the driver does not find the Soundscape Elite card.
======================================================================

----------------------------------------------------------------------
 tjallen - 08-03-06 01:40 
----------------------------------------------------------------------
Progress, perhaps.  I changed the port=0x330 in modules.conf 
and in modprobe.conf and got the following messages:

 Enter snd_sscape_probe
 Enter detect_GA
 Exit detect_GA
 Exit detect_sscape
sscape: GA hardware detected at 0x330, using IRQ 5, DMA 0
sscape: No AD1845 device at 0x338, IRQ 5

----------------------------------------------------------------------
 rankincj - 08-05-06 13:36 
----------------------------------------------------------------------
This new patch replaces the original sscape.diff patch for the
alsa-sscape.c file. As well as all the contents of that patch, it adds a
new parameter to the snd-sscape.ko module called "codec_port":

So for a non-PnP SoundScape, you would use e.g. "port=0x330
codec_port=0x534"

"codec_port" should be optional for a PnP model because we should already
know where to find the codec port for those.

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
07-30-06 21:45 tjallen        Note Added: 0011330                          
07-30-06 23:14 rankincj       File Added: sscape.diff                      
07-30-06 23:17 rankincj       Note Added: 0011332                          
07-31-06 16:59 tjallen        Note Added: 0011343                          
08-03-06 00:47 rankincj       Note Added: 0011391                          
08-03-06 01:40 tjallen        Note Added: 0011392                          
08-05-06 13:31 rankincj       File Added: codec-io.diff                    
08-05-06 13:36 rankincj       Note Added: 0011429                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
