From: noreply@alsa-project.org
Subject: [ALSA - lib 0000137]: using artsd 1.2.1 with dmix
Date: Fri, 16 Jul 2004 12:49:07 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716104907.E7AD026009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2DB98255
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:49:08 +0200 (MEST)
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000137
======================================================================
Reported By:                Meeuw
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Bug ID:                     137
Category:                   pcm - digital audio
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             03-15-2004 13:22 CET
Last Modified:              07-16-2004 12:49 CEST
======================================================================
Summary:                    using artsd 1.2.1 with dmix
Description: 
I want to use artsd using asound (native alsa) and dmix.

When I try to do this I get a:
artsd: pcm.c:5899: snd_pcm_mmap_commit: Assertion `frames <=
snd_pcm_mmap_avail(pcm)' failed.
======================================================================

----------------------------------------------------------------------
 perex - 03-15-2004 17:38 CET 
----------------------------------------------------------------------
arts does not follow ALSA API, so even if the commit bug is fixed, it won't
work.

See http://bugs.kde.org/show_bug.cgi?id=76413 for more details.

----------------------------------------------------------------------
 Stephan Wurm - 03-22-2004 00:14 CET 
----------------------------------------------------------------------
I can confirm this problem, but it isn't a problem regarding to artsd!

I get exactly the same error using the dsnoop-plugin with arecord on my
intel8x0-soundcard.

$ arecord -Dplug:dsnoop -f cd -d 10 test.raw -B 4096
Recording WAVE 'test.raw' : Signed 16 bit Little Endian, Rate 44100 Hz,
Stereo
arecord: pcm.c:5899: snd_pcm_mmap_commit: Assertion `frames <=
snd_pcm_mmap_avail(pcm)' failed.
Aborted by signal Aborted...
Speicherzugriffsfehler

Meeuw, you should be able to use the artsd without full duplex, can you
confirm that?

Here's my ~/.asoundrc:
pcm.!default {
	type plug
	slave.pcm "duplex"
}

pcm.duplex {
	type asym
	playback.pcm "dmixer"
	capture.pcm "mixin"
}

pcm.dsp0 {
	type plug
	slave.pcm "duplex"
}

pcm.dmixer {
	type dmix
	ipc_key 1024
	ipc_key_add_uid yes
	slave {
		pcm "hw:0,0"
		period_time 0
		period_size 1024
		buffer_size 4096 
		rate 48000
	}
	bindings {
		0 0
		1 1
	}
}

pcm.mixin {
	type dsnoop
	ipc_key 1024 
	ipc_key_add_uid yes
	slave {
		pcm "hw:0,0"
		channels 2
		period_size 1024
		buffer_size 4096
		rate 48000
		periods 0
		period_time 0
	}
	bindings {
		0 0
		0 1
	}
}

ctl.dmixer {
	type hw
	card 0
}

ctl.mixin {
	type hw
	card 0
}

ctl.duplex {
	type hw
	card 0
}

ctl.mixer0 {
	type hw
	card 0
}

ctl.dsp0 {
	type hw
	card 0
}

----------------------------------------------------------------------
 Meeuw - 03-22-2004 10:18 CET 
----------------------------------------------------------------------
aRTsd seems to start, and I can even play a wave file using artsplay. But I
can't hear anything... strange

----------------------------------------------------------------------
 perex - 03-23-2004 15:50 CET 
----------------------------------------------------------------------
The attached rate-capture.patch will solve your problem. Thanks for
reporting.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-15-04 13:22 Meeuw          New Bug                                      
03-15-04 13:32 Meeuw          Bug Monitored: Meeuw                         
03-15-04 17:38 perex          Bugnote Added: 0000616                       
03-15-04 17:38 perex          Assigned To               => perex           
03-15-04 17:38 perex          Status                   new => assigned     
03-22-04 00:14 Stephan Wurm   Bugnote Added: 0000652                       
03-22-04 00:15 Stephan Wurm   Bug Monitored: Stephan Wurm                    
03-22-04 10:18 Meeuw          Bugnote Added: 0000653                       
03-23-04 15:50 perex          File Added: rate-capture.patch                    
03-23-04 15:50 perex          Category                 general => pcm - digital audio
03-23-04 15:50 perex          Bugnote Added: 0000659                       
03-23-04 15:50 perex          Resolution               open => fixed       
03-23-04 15:50 perex          Status                   assigned => resolved
03-24-04 21:15 Stephan Wurm   Bug End Monitor: Stephan Wurm                    
07-16-04 12:49 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
