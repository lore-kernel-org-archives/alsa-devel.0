From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001908]: Stereo channels swapped using
	Midiman Audiophile 24/96
Date: Tue, 18 Jul 2006 14:55:39 +0200
Message-ID: <d54acb3d24c77f33de08b14133ff027d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8625E196
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 14:55:39 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1908> 
======================================================================
Reported By:                sebastian_ml
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1908
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.15.6
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             03-11-2006 09:34 CET
Last Modified:              07-18-2006 14:55 CEST
======================================================================
Summary:                    Stereo channels swapped using Midiman Audiophile
24/96
Description: 
Hi all,

the stereo channels (L/R) are swapped. Say you patch PCM0 to HW Out 0 and
do the same with PCM1 and HW Out 1 then the channel order is wrong.
For now I use the Digital Mixer to make it right.

I discovered this by accident when I had both my mp3 player and my 2496
connected to the same amp playing the same song. They sounded different. I
swapped L/R and all was fine.

When booting Windows the L/R order is accurate.

I'll upload some pictures of envy24control in a few.

Thanks

Sebastian
======================================================================

----------------------------------------------------------------------
 sebastian_ml - 04-20-06 20:56 
----------------------------------------------------------------------
Sorry, my fault. It wasn't the driver, it was a wrongly marked cable (red
and white were swapped.

Mea culpa :D

Sebastian

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-11-06 09:34 sebastian_ml   New Issue                                    
03-11-06 09:34 sebastian_ml   Distribution              => Gentoo          
03-11-06 09:34 sebastian_ml   Kernel Version            => 2.6.15.6        
03-11-06 10:17 sebastian_ml   File Added: patchbay-pcm.png                    
03-11-06 10:24 sebastian_ml   Note Added: 0008415                          
03-11-06 10:24 sebastian_ml   File Added: monitor-reversed.png                  
 
03-11-06 10:25 sebastian_ml   File Added: monitor-accurate.png                  
 
04-20-06 20:56 sebastian_ml   Note Added: 0009399                          
04-20-06 20:59 sebastian_ml   Note Deleted: 0008415                        
07-18-06 14:55 Adrian Bunk    Status                   new => closed       
07-18-06 14:55 Adrian Bunk    Resolution               open => not an issue
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
