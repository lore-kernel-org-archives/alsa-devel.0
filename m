From: noreply@alsa-project.org
Subject: [ALSA - driver 0000097]: dmix not working for Epox 8rda+ nforce2 chipset
Date: Fri, 16 Jul 2004 14:32:41 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123241.8C4FD2C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1878D1B6
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:32:42 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000097
======================================================================
Reported By:                hollywoodb
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     97
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   trivial
Priority:                   normal
Status:                     closed
Distribution:               Gentoo
Kernel Version:             2.6.3-mm
======================================================================
Date Submitted:             02-28-2004 18:44 CET
Last Modified:              07-16-2004 14:32 CEST
======================================================================
Summary:                    dmix not working for Epox 8rda+ nforce2 chipset
Description: 
myself and many other users have been unable to play multiple sources using
dmix and the intel8x0 driver on nforce2 chipset.  to the best of my
knowledge this is limited to the Epox 8rda+ motherboard. 
======================================================================

----------------------------------------------------------------------
 perex - 02-29-2004 20:18 CET 
----------------------------------------------------------------------
The dmix plugin should work with all hardware. Can you try the latest
packages
(1.0.3) and report exact errors (test the dmix plugin with aplay).

----------------------------------------------------------------------
 hollywoodb - 03-01-2004 02:12 CET 
----------------------------------------------------------------------
it will work with aplay, although a 2nd aplay instance takes several
seconds to init... madplay, mpg123, xmms, and so on and so forth will wait
for the 1st instance to stop before a 2nd instance will start playing. no
errors though, just waiting.  i can play aplay and another source at once
also.

edited on: 03-01-04 02:12

----------------------------------------------------------------------
 perex - 03-01-2004 09:46 CET 
----------------------------------------------------------------------
It appears like a wrong configuration. Can you show me your .asoundrc file
and
exact aplay commands?

----------------------------------------------------------------------
 hollywoodb - 03-05-2004 02:22 CET 
----------------------------------------------------------------------
my 8rda+ just bit the dust, bad capacitors... I'm running a DFI nforce2
Ultra Infinity now, same scenario though.

.asoundrc:
pcm.nforce-hw {
type hw
card 0
}

pcm.!default {
type plug
slave.pcm "nforce"
}

pcm.nforce {
type dmix
ipc_key 1234
slave {
pcm "hw:0,0"
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


for aplay I'm just running aplay <file>

----------------------------------------------------------------------
 hollywoodb - 03-06-2004 22:46 CET 
----------------------------------------------------------------------
I just upgraded to alsa-libs and alsa-utils 1.0.3, hoping to fix the
problem.

aplay now segfaults when I run aplay <file>
XMMS also segfaults when I use 'default' as output, I have to now use
hw:0,0

I can play XMMS through hw:0,2 and another source (madplay) at once,
however playing through the IEC958 (spelling?) sounds awful and I seem to
have to use software volume control through hw:0,2 also.

edited on: 03-05-04 20:16

edited on: 03-06-04 22:46

----------------------------------------------------------------------
 perex - 03-09-2004 13:46 CET 
----------------------------------------------------------------------
Please, provide more information where aplay segfaults. Use:

gdb --args aplay <add your aplay parameters here>

The type 'r<Enter>' and when the segfault is catched, type 'bt<Enter>'.

Send the output here.

----------------------------------------------------------------------
 perex - 03-13-2004 16:24 CET 
----------------------------------------------------------------------
This bug is same as https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000117. Get the latest library - 1.0.3b.

----------------------------------------------------------------------
 hollywoodb - 03-14-2004 23:30 CET 
----------------------------------------------------------------------
segfaulting is fixed, but the reason for the bug in the first place is
inability to play 2 sources at once using dmix on nforce2 with intel8x0...
which I still am unable to do.

----------------------------------------------------------------------
 hollywoodb - 03-14-2004 23:31 CET 
----------------------------------------------------------------------
segfaulting is fixed, however I'm still unable to play 2 sources at once
using the .asoundrc above

----------------------------------------------------------------------
 perex - 03-15-2004 12:13 CET 
----------------------------------------------------------------------
What shows the command 'aplay -v <somefile>'?

----------------------------------------------------------------------
 hollywoodb - 03-15-2004 23:32 CET 
----------------------------------------------------------------------
Playing WAVE
'/usr/share/games/freedroidrpg/sound/effects/bot_sounds/First_Contact_So
und_0.wav' : Unsigned 8 bit, Rate 8000 Hz, Mono
Plug PCM: Rate conversion PCM (44100, sformat=U8)
Its setup is:
stream       : PLAYBACK
access       : RW_INTERLEAVED
format       : U8
subformat    : STD
channels     : 1
rate         : 8000
exact rate   : 8000 (8000/1)
msbits       : 8
buffer_size  : 743
period_size  : 185
period_time  : 23219
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 185
xfer_align   : 185
start_threshold  : 740
stop_threshold   : 743
silence_threshold: 0
silence_size : 0
boundary     : 194772992
Slave: Route conversion PCM (sformat=S16_LE)
Transformation table:
0 <- 0
1 <- 0
Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : U8
subformat    : STD
channels     : 1
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 8
buffer_size  : 4096
period_size  : 1024
period_time  : 23219
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1024
start_threshold  : 4096
stop_threshold   : 4096
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Slave: Direct Stream Mixing PCM

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 4096
period_size  : 1024
period_time  : 23219
tick_time    : 0
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1024
start_threshold  : 4096
stop_threshold   : 4096
silence_threshold: 0
silence_size : 0
boundary     : 1073741824
Hardware PCM card 0 'NVidia nForce2' device 0 subdevice 0

Its setup is:
stream       : PLAYBACK
access       : MMAP_INTERLEAVED
format       : S16_LE
subformat    : STD
channels     : 2
rate         : 44100
exact rate   : 44100 (44100/1)
msbits       : 16
buffer_size  : 4096
period_size  : 1024
period_time  : 23219
tick_time    : 1000
tstamp_mode  : NONE
period_step  : 1
sleep_min    : 0
avail_min    : 1024
xfer_align   : 1024
start_threshold  : 1
stop_threshold   : 1073741824
silence_threshold: 0
silence_size : 1073741824
boundary     : 1073741824

----------------------------------------------------------------------
 perex - 03-16-2004 16:07 CET 
----------------------------------------------------------------------
It looks good. What's behaviour when you run two 'aplay' commands on
two consoles?

----------------------------------------------------------------------
 hollywoodb - 03-16-2004 22:31 CET 
----------------------------------------------------------------------
I can play two files simultaneously using aplay in different consoles,
however I cannot play any combination of 2 other sources, I cannot play
aplay & madplay, aplay & xmms, madplay & xmms, for example.... this is no
matter what output I select for those apps.

----------------------------------------------------------------------
 perex - 03-17-2004 09:12 CET 
----------------------------------------------------------------------
It's rather support request than a bug report. Ask on alsa-user mailing
list
and look to wiki pages for the proper dmix configuration.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-28-04 18:44 hollywoodb     New Bug                                      
02-29-04 11:19 perex          Assigned To               => perex           
02-29-04 11:19 perex          Status                   new => assigned     
02-29-04 20:18 perex          Bugnote Added: 0000395                       
03-01-04 02:06 hollywoodb     Bugnote Added: 0000397                       
03-01-04 02:12 hollywoodb     Bugnote Edited: 0000397                      
03-01-04 09:46 perex          Bugnote Added: 0000399                       
03-05-04 02:22 hollywoodb     Bugnote Added: 0000495                       
03-05-04 17:35 hollywoodb     Bugnote Added: 0000505                       
03-05-04 20:16 hollywoodb     Bugnote Edited: 0000505                      
03-06-04 22:46 hollywoodb     Bugnote Edited: 0000505                      
03-09-04 13:46 perex          Bugnote Added: 0000542                       
03-12-04 13:22 perex          File Added: dmix_asm.diff                    
03-12-04 13:47 perex          File Deleted: dmix_asm.diff                    
03-13-04 16:24 perex          Bugnote Added: 0000594                       
03-13-04 16:24 perex          duplicate_id             0 => 117            
03-13-04 16:24 perex          Resolution               open => duplicate   
03-13-04 16:24 perex          Status                   assigned => resolved
03-14-04 23:30 hollywoodb     Bugnote Added: 0000605                       
03-14-04 23:30 hollywoodb     Resolution               duplicate => reopened
03-14-04 23:30 hollywoodb     Status                   resolved => feedback
03-14-04 23:31 hollywoodb     Bugnote Added: 0000606                       
03-14-04 23:51 hollywoodb     Bug Monitored: hollywoodb                    
03-15-04 12:13 perex          Bugnote Added: 0000609                       
03-15-04 12:13 perex          Status                   feedback => assigned
03-15-04 23:32 hollywoodb     Bugnote Added: 0000623                       
03-16-04 16:07 perex          Bugnote Added: 0000627                       
03-16-04 22:31 hollywoodb     Bugnote Added: 0000632                       
03-17-04 09:12 perex          Bugnote Added: 0000633                       
03-17-04 09:12 perex          duplicate_id             117 => 0            
03-17-04 09:12 perex          Resolution               reopened => not a bug
03-17-04 09:12 perex          Status                   assigned => resolved
07-16-04 14:32 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
