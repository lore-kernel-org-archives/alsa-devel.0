From: noreply@alsa-project.org
Subject: [ALSA - driver 0000145]: Nforce2 Audio - Bacon Fry ssZzZZZZzzle
Date: Thu, 22 Jul 2004 05:44:37 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040722034437.02A7D30006@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 70A981E5
	for <alsa-devel@alsa-project.org>; Thu, 22 Jul 2004 05:44:38 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000145
======================================================================
Reported By:                onemaN
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     145
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               slackware!
Kernel Version:             2.6.4
======================================================================
Date Submitted:             03-18-2004 09:07 CET
Last Modified:              07-22-2004 05:44 CEST
======================================================================
Summary:                    Nforce2 Audio - Bacon Fry ssZzZZZZzzle
Description: 
Im using 2.6.4 with an abit nf7-s 2.0. Bacon fry is apparent on both analog
and spdif output (exactly the same effect). When playing music the pitch
is correct (with 2.6.2 everything was speeded up 20% it seemed) 

It does this every time when I play mp3 or flac files with xmms or any
other player. 

OK so when I got on this bug system I saw there was allready many bugs
listed simaler to this. The reason im making effort here, is because Im
willing to be contacted and work with you guys to get this one right, I
want of course to use this linux box as a half terabyte flac jukebox, and
I cant do that if the sound is anything less than perfect. ;P 

Let me know! I will do what I can to help debug!

-David 
david@wdtp.com
======================================================================

----------------------------------------------------------------------
 onemaN - 03-18-2004 09:11 CET 
----------------------------------------------------------------------
also 'analog to spdif' doesnt seem to do a thing :[] ....

----------------------------------------------------------------------
 perex - 03-23-2004 16:20 CET 
----------------------------------------------------------------------
Try to find 'IEC958 Input Monitor' control in alsamixer and turn it off (or
use amixer).

----------------------------------------------------------------------
 onemaN - 03-23-2004 18:15 CET 
----------------------------------------------------------------------
Its allways been off..

----------------------------------------------------------------------
 perex - 03-23-2004 18:42 CET 
----------------------------------------------------------------------
Could you try to test latest 2.6.5-rc kernel?

----------------------------------------------------------------------
 onemaN - 03-23-2004 19:16 CET 
----------------------------------------------------------------------
Im still on 2.6.4, when 2.6.5 comes I will be there. I installed all the
103b componets (besides the driver witch is compiled into my kernel) 

Then I set up a .asoundrc file, and now if i use alsaplayer or aplay I can
get distortion free output from spdif!

.asoundrc file: 

cm.nforce-hw {
type hw
card 0
}

pcm.!default {
type plug
slave.pcm "nforce"
}

https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000000,0 is analog out and 0,2 is spdif out.

pcm.nforce {
type dmix
ipc_key 1234
slave {
pcm "hw:0,2"
period_time 0
period_size 1024
buffer_size 4096
rate 44100
}
}

ctl.nforce-hw {
type hw
card 0
}


XMMS and everything else still frys etc from spdif... future looking good
tho

----------------------------------------------------------------------
 onemaN - 03-23-2004 19:26 CET 
----------------------------------------------------------------------
Still some crackling when i for example use the volume slider on
alsaplayer, and once or twice its skipped for unknown reason..

----------------------------------------------------------------------
 cosmix - 07-22-2004 05:44 CEST 
----------------------------------------------------------------------
This persists with kernel 2.6.7 and ALSA versions 1.0.4 (incl. in 2.6.7),
1.0.5, 1.0.5a and current CVS (at the time of writing). It practically
renders the onboard audio on nforce2 motherboards useless with ALSA :(

Note that on a nforce2 equipped motherboard, disabling the 'Disconnect on
STPGNT' bit on the board, the problem goes away almost completely. This
may provide a clue as to why this happens.

Hope this helps.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-18-04 09:07 onemaN         New Bug                                      
03-18-04 09:07 onemaN         Distribution              => slackware!      
03-18-04 09:07 onemaN         Kernel Version            => 2.6.4           
03-18-04 09:11 onemaN         Bugnote Added: 0000640                       
03-18-04 09:36 onemaN         Bug Monitored: onemaN                        
03-23-04 16:20 perex          Bugnote Added: 0000666                       
03-23-04 18:15 onemaN         Bugnote Added: 0000674                       
03-23-04 18:42 perex          Bugnote Added: 0000686                       
03-23-04 19:16 onemaN         Bugnote Added: 0000691                       
03-23-04 19:26 onemaN         Bugnote Added: 0000692                       
07-22-04 05:44 cosmix         Bugnote Added: 0001466                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
