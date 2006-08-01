From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001823]: surround40 memory leak
Date: Tue, 1 Aug 2006 03:52:51 +0200
Message-ID: <e3e6aba3dec459a044051abedea6a7c2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 87004139
	for <alsa-devel@alsa-project.org>;
	Tue,  1 Aug 2006 03:52:51 +0200 (MEST)
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
Last Modified:              08-01-2006 03:52 CEST
======================================================================
Summary:                    surround40 memory leak
Description: 
It seems that surround40 has a memory leak or somthing similar, playing a
game in surround40 mode the game result unplayable after some minutes. 
And there is a problem in CS46xx.conf file, i need to remove the hook on
the rear pcm to permit multiple surround40 subdevices to be opened.
======================================================================

----------------------------------------------------------------------
 Raymond - 08-01-06 02:53 
----------------------------------------------------------------------
1.0.9 is too old, you should try 1.0.12rc1

How do KMix or alsamixer handle the two capture source ? 
Do both of these controls can be used or one is dummy ?

control.16 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 2
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		value.0 CD
		value.1 Mic
	}

control.44 {
		comment.access 'read write'
		comment.type ENUMERATED
		comment.count 2
		comment.item.0 Mic
		comment.item.1 CD
		comment.item.2 Video
		comment.item.3 Aux
		comment.item.4 Line
		comment.item.5 Mix
		comment.item.6 'Mix Mono'
		comment.item.7 Phone
		iface MIXER
		name 'Capture Source'
		index 1
		value.0 'Mix Mono'
		value.1 Mic
	}



----------------------------------------------------------------------
 Raymond - 08-01-06 03:52 
----------------------------------------------------------------------
>> No, the 'DAC Playback Volume' only works on Front (aka Master) and Rear.
It does not have any effect on Center and LFE.

It is because only the list of master_mix_scb and rear_mix_scb were
changed in cs46xx_dsp_set_dac_volume 

	/* main output */
	scb = ins->master_mix_scb->sub_list_ptr;
	while (scb != ins->the_null_scb) {
		cs46xx_dsp_scb_set_volume (chip,scb,left,right);
		scb = scb->next_scb_ptr;
	}

	/* rear output */
	scb = ins->rear_mix_scb->sub_list_ptr;
	while (scb != ins->the_null_scb) {
		cs46xx_dsp_scb_set_volume (chip,scb,left,right);
		scb = scb->next_scb_ptr;
	}

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
07-30-06 03:33 Raymond        Note Added: 0011314                          
07-30-06 03:39 Raymond        Note Edited: 0011314                         
07-30-06 03:41 Raymond        Note Edited: 0011314                         
07-30-06 11:52 darkbrain      Note Added: 0011317                          
07-31-06 05:39 Raymond        Note Added: 0011336                          
07-31-06 05:40 Raymond        Note Edited: 0011336                         
07-31-06 05:43 Raymond        Note Edited: 0011336                         
07-31-06 05:45 Raymond        Note Edited: 0011336                         
07-31-06 05:47 Raymond        Note Edited: 0011336                         
07-31-06 06:36 Raymond        Note Edited: 0011336                         
07-31-06 08:40 Raymond        Note Edited: 0011336                         
07-31-06 09:51 Raymond        Note Edited: 0011336                         
07-31-06 09:56 Raymond        Note Edited: 0011336                         
07-31-06 09:59 Raymond        Note Edited: 0011336                         
07-31-06 10:06 Raymond        Note Edited: 0011336                         
07-31-06 10:11 Raymond        Note Edited: 0011336                         
07-31-06 22:42 bitmage2       Note Added: 0011350                          
07-31-06 22:52 bitmage2       Note Added: 0011352                          
08-01-06 02:48 Raymond        Note Added: 0011363                          
08-01-06 02:53 Raymond        Note Edited: 0011363                         
08-01-06 03:52 Raymond        Note Added: 0011366                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
