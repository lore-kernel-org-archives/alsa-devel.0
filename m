From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001823]: surround40 memory leak
Date: Sun, 30 Jul 2006 03:26:40 +0200
Message-ID: <1013e852341fb29ba4faa8a5292ef710@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B8833181
	for <alsa-devel@alsa-project.org>;
	Sun, 30 Jul 2006 03:26:40 +0200 (MEST)
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
Last Modified:              07-30-2006 03:26 CEST
======================================================================
Summary:                    surround40 memory leak
Description: 
It seems that surround40 has a memory leak or somthing similar, playing a
game in surround40 mode the game result unplayable after some minutes. 
And there is a problem in CS46xx.conf file, i need to remove the hook on
the rear pcm to permit multiple surround40 subdevices to be opened.
======================================================================

----------------------------------------------------------------------
 bitmage2 - 07-29-06 22:44 
----------------------------------------------------------------------
I don't know what game darkbrain (bug reporter) is talking about. But I can
answer your other question:
Yes! All the volume controls (front,rear,center,lfe) change the volume of
the correct channels. This is true for KMix (BTW: I am the KMix author) as
well as for alsamixer.

   Christian

----------------------------------------------------------------------
 Raymond - 07-30-06 03:26 
----------------------------------------------------------------------
How about 'DAC Playback Volume' ? It seem to be the control which change
the volume of mixer_scb(s) inside DSP. 

Does it control the volume of all the playback channels ?

If you want to implement the volume control per PCM stream (subdevice)
like emu10k1 or ymfpci, you may need to remove this control.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1318

Refer to test.state , there are some controls wrongly created by cs46xx
driver (e.g. Caller id switch and Off-hook Switch) 

cs4294 is not modem codec (MC97)

Do you know any cs46xx chips support modem ?

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
07-29-06 14:02 Raymond        Note Added: 0011302                          
07-29-06 14:12 Raymond        Note Added: 0011303                          
07-29-06 14:50 bitmage2       Note Added: 0011304                          
07-29-06 14:51 bitmage2       File Added: proc-asound-card0-codec               
    
07-29-06 15:01 bitmage2       Note Added: 0011305                          
07-29-06 15:03 bitmage2       File Added: test.state                       
07-29-06 17:23 Raymond        Note Added: 0011309                          
07-29-06 22:44 bitmage2       Note Added: 0011311                          
07-30-06 03:26 Raymond        Note Added: 0011313                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
