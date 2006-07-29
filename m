From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001823]: surround40 memory leak
Date: Sat, 29 Jul 2006 12:23:48 +0200
Message-ID: <da0687f3cc8303440bce63ed87004fa7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D18B9186
	for <alsa-devel@alsa-project.org>;
	Sat, 29 Jul 2006 12:23:48 +0200 (MEST)
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
Last Modified:              07-29-2006 12:23 CEST
======================================================================
Summary:                    surround40 memory leak
Description: 
It seems that surround40 has a memory leak or somthing similar, playing a
game in surround40 mode the game result unplayable after some minutes. 
And there is a problem in CS46xx.conf file, i need to remove the hook on
the rear pcm to permit multiple surround40 subdevices to be opened.
======================================================================

----------------------------------------------------------------------
 bitmage2 - 07-29-06 12:20 
----------------------------------------------------------------------
Yes. I got 2 chips labeled "4294-J0 EP", and one labeled "CS4624-CQ".

I don't know if the windows driver really supports 7.1 (in terms of 8
*audio channels*): I don't own a 7.1 speaker set, and the
documentation/handbook is not very specific about that.
But what I know for sure is this:
1) You can connect 7.1 *speakers*. The additional 2 speakers are plugged
in the headphone jack.
2) The control software shipping with Hercules GT XP7.1 allows to set a
7.1 speaker setup.
3) The hardware and the windows driver support 5.1 (I tested that)

----------------------------------------------------------------------
 bitmage2 - 07-29-06 12:23 
----------------------------------------------------------------------
Forogt to tell in the last note: The chips labeled "4294-J0 EP" might have
48 Pins. I thought I counted 40 Pins (10 on each side), but I might have
counted wrong. If it is important, just tell me, and I will do a re-count.

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
07-26-06 09:45 Raymond        Note Added: 0011246                          
07-26-06 09:51 Raymond        Note Edited: 0011246                         
07-26-06 09:56 Raymond        Note Edited: 0011246                         
07-26-06 10:04 Raymond        Note Edited: 0011246                         
07-26-06 10:08 Raymond        Note Edited: 0011246                         
07-26-06 10:14 Raymond        Note Edited: 0011246                         
07-26-06 16:26 Raymond        Note Added: 0011249                          
07-26-06 16:28 Raymond        Note Edited: 0011249                         
07-26-06 16:31 Raymond        Note Edited: 0011249                         
07-28-06 05:03 Raymond        Note Added: 0011282                          
07-28-06 10:25 Raymond        Note Edited: 0011282                         
07-29-06 05:13 Raymond        Note Added: 0011298                          
07-29-06 09:06 Raymond        Note Deleted: 0011298                        
07-29-06 12:20 bitmage2       Note Added: 0011299                          
07-29-06 12:23 bitmage2       Note Added: 0011300                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
