From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001823]: surround40 memory leak
Date: Wed, 26 Jul 2006 08:34:23 +0200
Message-ID: <760b68735f24c8187e7948318a5b07aa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3EE94247
	for <alsa-devel@alsa-project.org>;
	Wed, 26 Jul 2006 08:34:23 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1823> 
======================================================================
Reported By:                darkbrain
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1823
Category:                   PCI - cs46xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             02-05-2006 22:59 CET
Last Modified:              07-26-2006 08:34 CEST
======================================================================
Summary:                    surround40 memory leak
Description: 
It seems that surround40 has a memory leak or somthing similar, playing a
game in surround40 mode the game result unplayable after some minutes. 
And there is a problem in CS46xx.conf file, i need to remove the hook on
the rear pcm to permit multiple surround40 subdevices to be opened.
======================================================================

----------------------------------------------------------------------
 Raymond - 07-26-06 02:30 
----------------------------------------------------------------------
32 * 2 > ( 64 - capture pcm )
16 * 4 > ( 64 - capture pcm )   
11 * 6 > ( 64 - capture pcm )

It depends on DSP firmware support 7.1 or not

Which model of the AC97 codecs or DACs on your card ?



----------------------------------------------------------------------
 bitmage2 - 07-26-06 08:34 
----------------------------------------------------------------------
How do I find out? Can I look it up in a log file, or do I actually look at
the text on the chips ?

The card and chip are these according to alsamixer:
Card: Sound Fusion CS46xx                                                 
                         Chip: Cirrus Logic CS4294 rev 5,Cirrus Logic
CS4294 rev 5,Cirrus Logic CS4294 rev 5                 &#9474;

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-05-06 22:59 darkbrain      New Issue                                    
02-06-06 06:32 Raymond        Note Added: 0007943                          
02-06-06 07:10 Raymond        Note Edited: 0007943                         
02-06-06 07:31 Raymond        Note Edited: 0007943                         
02-06-06 07:32 Raymond        Note Edited: 0007943                         
02-06-06 10:46 darkbrain      Note Added: 0007945                          
02-06-06 10:46 darkbrain      Note Added: 0007946                          
02-06-06 10:47 darkbrain      Note Deleted: 0007946                        
02-06-06 18:37 darkbrain      Note Added: 0007950                          
02-11-06 15:01 darkbrain      Note Added: 0008018                          
02-12-06 05:09 Raymond        Note Added: 0008025                          
02-15-06 06:21 Raymond        Note Added: 0008076                          
02-21-06 07:56 Raymond        Note Added: 0008152                          
03-27-06 04:42 Raymond        Note Added: 0008987                          
06-02-06 09:33 Raymond        Note Deleted: 0008152                        
06-02-06 09:33 Raymond        Note Deleted: 0008987                        
06-02-06 09:34 Raymond        Note Deleted: 0008076                        
07-11-06 13:28 Raymond        Note Added: 0010970                          
07-24-06 21:21 bitmage2       Note Added: 0011215                          
07-24-06 21:25 bitmage2       Note Added: 0011216                          
07-25-06 02:41 Raymond        Note Added: 0011222                          
07-25-06 05:47 Raymond        Note Edited: 0011222                         
07-25-06 10:18 darkbrain      Note Added: 0011224                          
07-25-06 16:03 Raymond        Note Added: 0011228                          
07-25-06 20:29 bitmage2       Note Added: 0011231                          
07-26-06 02:21 Raymond        Note Added: 0011236                          
07-26-06 02:26 Raymond        Note Edited: 0011236                         
07-26-06 02:30 Raymond        Note Edited: 0011236                         
07-26-06 08:34 bitmage2       Note Added: 0011244                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
