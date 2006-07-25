From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001823]: surround40 memory leak
Date: Tue, 25 Jul 2006 10:18:18 +0200
Message-ID: <62c2b50db0838bdaf0975c450aaa6be4@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 38AB2230
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Jul 2006 10:18:19 +0200 (MEST)
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
Last Modified:              07-25-2006 10:18 CEST
======================================================================
Summary:                    surround40 memory leak
Description: 
It seems that surround40 has a memory leak or somthing similar, playing a
game in surround40 mode the game result unplayable after some minutes. 
And there is a problem in CS46xx.conf file, i need to remove the hook on
the rear pcm to permit multiple surround40 subdevices to be opened.
======================================================================

----------------------------------------------------------------------
 Raymond - 07-25-06 05:47 
----------------------------------------------------------------------
I am just a reporter and do not have any cs46xx card too.

Whether cs46xx support multiple instances of multi-channels seem depend on
DSP firmware 

Can you run multiple instances of surround40 and surround51 concurrently
(speaker-test or 5.1 movie) by removing the lock in CS46xx.conf


I want to find out a feasible solution (period_size, period and
buffer_size calculation by snd_pcm_set_params() ) for my au8830 sound card
in https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724 by comparing
au8830 (device 0 support 1, 2, 4 channels) with
cs46xx (multi pluginn of device front, rear and center_lfe).

Can you try alsa-lib example (i.e. alsa-lib/test/pcm_min.c) ? 

I upload set_params_test.c in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1724 which test different
devices (hw:0,
front, surround40, surround51) with  1, 2, 4, 6 channels, rates(8000,
44100, 48000) , formats U8/S16_LE in snd_pcm_set_params() and print out
the values of period_size and buffer_size returned by
snd_pcm_get_params()

BTW, you forget to call snd_pcm_info(pcm, obj) in your program



----------------------------------------------------------------------
 darkbrain - 07-25-06 10:18 
----------------------------------------------------------------------
Well the problem is difficult to resolve. For hooks read better the
description of the bug.
Anyway i talked to Benny Sjostrand about these problems and he explained
me a bit the logic of this dsp, and how this driver was made: throght
reverse engineering! 
The only thing i've found is this: in file dsp_spos.c replace
"REAR_CODECOUT_SCB_ADDR,codec_in_scb" with
"REAR_CODECOUT_SCB_ADDR,codec_out_scb" at about line 1364. With this
"patch" you should be able to use the quad pcm (route device) without the
out of sync problem. Anyway the problem isn't solved! It maybe a delay in
some SCB or it may be an application problem caused by the cut of
available devices that is halved. Btw without documentation is not
possible to work on it.

bye,
   DarkBrain

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
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
