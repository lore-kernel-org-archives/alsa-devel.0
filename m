From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001823]: surround40 memory leak
Date: Mon, 31 Jul 2006 22:42:29 +0200
Message-ID: <e5252b5be04363740ed2bacfc679d37b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 1000B185
	for <alsa-devel@alsa-project.org>;
	Mon, 31 Jul 2006 22:42:29 +0200 (MEST)
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
Last Modified:              07-31-2006 22:42 CEST
======================================================================
Summary:                    surround40 memory leak
Description: 
It seems that surround40 has a memory leak or somthing similar, playing a
game in surround40 mode the game result unplayable after some minutes. 
And there is a problem in CS46xx.conf file, i need to remove the hook on
the rear pcm to permit multiple surround40 subdevices to be opened.
======================================================================

----------------------------------------------------------------------
 Raymond - 07-31-06 10:11 
----------------------------------------------------------------------
>> Yes! All the volume controls (front,rear,center,lfe) change the volume
of the correct channels. This is true for KMix

Do you mean KMix can handle those duplicate controls ( created by TWO AC97
) ?


        control.1 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		value true
	}
	control.2 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		value.0 57
		value.1 57
	}
control.14 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		value false
	}
	control.15 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		value.0 20
		value.1 20
	}
control.25 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Master Playback Switch'
		index 1
		value false
	}
	control.26 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 63'
		iface MIXER
		name 'Master Playback Volume'
		index 1
		value.0 45
		value.1 42
	}
	control.27 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'Center Playback Switch'
		index 1
		value true
	}
	control.28 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 63'
		iface MIXER
		name 'Center Playback Volume'
		index 1
		value 59
	}
	control.29 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'LFE Playback Switch'
		index 1
		value true
	}
	control.30 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 1
		comment.range '0 - 63'
		iface MIXER
		name 'LFE Playback Volume'
		index 1
		value 63
	}
	control.31 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 2
		iface MIXER
		name 'Surround Playback Switch'
		index 1
		value.0 true
		value.1 true
	}
	control.32 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 63'
		iface MIXER
		name 'Surround Playback Volume'
		index 1
		value.0 60
		value.1 60
	}

	control.42 {
		comment.access 'read write'
		comment.type BOOLEAN
		comment.count 1
		iface MIXER
		name 'PCM Playback Switch'
		index 1
		value true
	}
	control.43 {
		comment.access 'read write'
		comment.type INTEGER
		comment.count 2
		comment.range '0 - 31'
		iface MIXER
		name 'PCM Playback Volume'
		index 1
		value.0 27
		value.1 27
	}
most likey those controls with 'index 1' is created by the secondary ac97

but it contradict the definition of index control , since there is only
one 'Center Playback Volume' and 'LFE Playback Volume'

http://www.alsa-project.org/~iwai/writing-an-alsa-driver/x851.htm

The index field holds the index number of this control. If there are
several different controls with the same name, they can be distinguished
by the index number. This is the case when several codecs exist on the
card. If the index is zero, you can omit the definition above.

cs4294 is 4 channels codec, each codec only control the volume of 4
playback channels in surround51 or surround71

Can any of you post the output of 'alsa-lib/test/timer -list' to
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2257
?



----------------------------------------------------------------------
 bitmage2 - 07-31-06 22:42 
----------------------------------------------------------------------
Raymond, this is about your question "Do you mean KMix can handle those
duplicate controls ( created by TWO AC97 ) ?".
I presume youre talking about those controls with index 1 (opposed to
index 0), right?
Honestly, I have no idea when those duplicate controls are uses. The only
thing I can say is this: I got all those duplicated devices (like PCM.0,
PCM.1 and Master.0, Master.1). And when I change the device state (volume,
capture ore playback switch) the change is reflected in alsamixer (and
vice versa).

For testing I tried to play back more than 32 channels via speaker-test .
I did  this for checking whether channels 33 and above would go on the
second AC97. But ...
1) The channels above 32 just produce nonsense sounds (short, looping
sounds)
2) The volume of the nonsense soundss could not be controlled (not by
KMix, and also not by alsamixer)

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
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
