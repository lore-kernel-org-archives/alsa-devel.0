From: noreply@alsa-project.org
Subject: [ALSA - driver 0000110]: 1.0.3, cmi9739, "mic as center/lfe" dissappeared
Date: Fri, 16 Jul 2004 14:39:11 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123911.414022C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 92EFC244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:39:11 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000110
======================================================================
Reported By:                norbert
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     110
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             03-03-2004 08:20 CET
Last Modified:              07-16-2004 14:39 CEST
======================================================================
Summary:                    1.0.3, cmi9739, "mic as center/lfe" dissappeared
Description: 
Advanced Linux Sound Architecture Driver Version 1.0.3

if I run alsamixer, no "mic as center/lfe" can be found anymore.

Norbert
======================================================================

----------------------------------------------------------------------
 tiwai - 03-03-2004 15:31 CET 
----------------------------------------------------------------------
it was removed because it's not in the datasheet really.

----------------------------------------------------------------------
 perex - 03-23-2004 18:34 CET 
----------------------------------------------------------------------
Not a bug but hardware constraint.

----------------------------------------------------------------------
 norbert - 03-24-2004 10:35 CET 
----------------------------------------------------------------------
What a pity,
it's the onboard sound of my son's maschine. If he runs redmond-os he can
use the 3 connectors (mic,line-in,line-out) for output without problems.
Mainboard is a ASRock K7S8X R3.0 Chipsatz SIS746FX I think, alsa is
up-to-date (1.0.3(a)(b)).
First settings came from alsaconf.
Maybe you can find some additional specs...?
If I can do same testing, I would.
Norbert

----------------------------------------------------------------------
 perex - 03-24-2004 11:23 CET 
----------------------------------------------------------------------
Nortbert, did the "mic as center/lfe" switch worked for you with previous
ALSA versions?

----------------------------------------------------------------------
 norbert - 03-30-2004 13:35 CEST 
----------------------------------------------------------------------
I tried it yesterday with 0.9.7, but unfortunately no "mic as center/lfe"
switch appeared.

In redmond-os you can easely choose if you want 2, 4 or 6 speakers. If you
choose "4" the remaining connector is for mic, if you choose only "2" the
next free connector is for line-in.

So it has to be possible to switch this by software.

codec: cmi9739A
Audiocontroller: sis7012

----------------------------------------------------------------------
 perex - 03-30-2004 14:36 CEST 
----------------------------------------------------------------------
I know, but the drivers for W$ are usually from hardware vendors
producing hardware. We have only generic datasheet for this chip
and it appears that this feature is not documented there (probably
hardware specific).

----------------------------------------------------------------------
 norbert - 03-30-2004 16:15 CEST 
----------------------------------------------------------------------
Yes, I know about that but I was not sure if you know that it works that
way.

I looked around a little, maybe you can find some useful information from

http://driver.sis.com/linux/7012/sis701-2.4.x.tar

(or maybe not because of binary lib ...)

----------------------------------------------------------------------
 LP - 04-01-2004 00:33 CEST 
----------------------------------------------------------------------
Hi guys,

I think I might be able to help you guys a bit :-) I got a working oss
driver for this chip, which works with kernel 2.6 has 5.1 channel support
and allows channel switching. Cmedia send me some experimental code, I
then fixed some of their code and it is working now, I have only tested it
on my board so far, which is a ASROCK K7S8XE+, SIS 7012 CMEDIA 9739.

Here you are!

Grüße Richard Schneidt, Email: richard.schneidt@fh-ingolstadt.de

----------------------------------------------------------------------
 LP - 04-01-2004 01:05 CEST 
----------------------------------------------------------------------
Just some extra info, the original authors of the driver are:

Min-Chih Feng : min_chih@cmedia.com.tw
C.L. Tien: cltien@cmedia.com.tw

They are very helpful in case you may have questions.

----------------------------------------------------------------------
 tiwai - 04-16-2004 19:26 CEST 
----------------------------------------------------------------------
could you try the attached patch?

----------------------------------------------------------------------
 norbert - 04-20-2004 14:14 CEST 
----------------------------------------------------------------------
patch against 1.0.4:

patching file ac97_patch.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 succeeded at 1358 (offset -4 lines).
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 succeeded at 1420 (offset -4 lines).

cvscompile stops with:

gcc -D__KERNEL__ -DMODULE=1
-I/home/norbert/DL/SW/alsa/alsa-driver-1.0.4/include                      
                     -I/lib/modules/2.4.26/build/include -O2
-mpreferred-stack-boundary=2 -march=at                                    
     hlon -DLINUX -Wall -Wstrict-prototypes -fomit-frame-pointer
-Wno-trigraphs -O2 -                                         
fno-strict-aliasing -fno-common -pipe -DALSA_BUILD -nostdinc -iwithprefix
includ                                          e 
-DKBUILD_BASENAME=ac97_patch   -c -o ac97_patch.o ac97_patch.c
In file included from ac97_patch.c:2:
../../alsa-kernel/pci/ac97/ac97_patch.c:1387: warning: implicit
declaration of f                                          unction
`AC97_SINGLE_VALUE'
../../alsa-kernel/pci/ac97/ac97_patch.c:1388: error: initializer element
is not                                           constant
../../alsa-kernel/pci/ac97/ac97_patch.c:1388: error: (near initialization
for `s                                         
nd_ac97_cm9739_controls[1].private_value')
../../alsa-kernel/pci/ac97/ac97_patch.c:1388: error: initializer element
is not                                           constant
../../alsa-kernel/pci/ac97/ac97_patch.c:1388: error: (near initialization
for `s                                         
nd_ac97_cm9739_controls[1]')
make[2]: *** [ac97_patch.o] Error 1
make[2]: Leaving directory
`/home/norbert/DL/SW/alsa/alsa-driver-1.0.4/pci/ac97'
make[1]: *** [_modsubdir_ac97] Error 2
make[1]: Leaving directory
`/home/norbert/DL/SW/alsa/alsa-driver-1.0.4/pci'
make: *** [compile] Error 1

Norbert

----------------------------------------------------------------------
 tiwai - 04-20-2004 15:12 CEST 
----------------------------------------------------------------------
then try the recent cvs version (e.g. snapshot).
it already includes the patch.

----------------------------------------------------------------------
 norbert - 05-04-2004 08:55 CEST 
----------------------------------------------------------------------
2004-05-03.tar.bz2 
build (dep config all rpms)
"cvscompile" and "make install" drivers

rpm -e installed-alsa-packages.rpm
rpm -Uhv alsa*rpm

alsasound stop
rmmod snd-page-alloc
alsasound start

box:~/speaker-test-0.0.1 # ./speaker-test -Dsurround51 -c 6
Playback device is surround51
Stream parameters are 44100Hz, S16_LE, 6 channels
Sine wave rate is 440.0000Hz
Rate doesn't match (requested 44100Hz, get 0Hz)
Setting of hwparams failed: Invalid argument

----------------------------------------------------------------------
 tiwai - 05-04-2004 17:08 CEST 
----------------------------------------------------------------------
does normal aplay work for 2 channels?

also try to update alsa-lib, too, if you update the driver.

----------------------------------------------------------------------
 norbert - 05-05-2004 08:36 CEST 
----------------------------------------------------------------------
As I remember normal aplay works.

I thought it was clear: I took complete tarball 2004-05-03.tar.bz2 and
build all rpms and installed all (rpm -Uhv alsa*rpm) after completely
removed the previous.

Afterthat I "cvscompile" and "make install" driver-tarball.

So all alsa running there was cvs-alsa (including alsa-lib) ;-))

----------------------------------------------------------------------
 tiwai - 05-05-2004 11:09 CEST 
----------------------------------------------------------------------
then try

    % aplay -Dplug:surround40 some-2ch.wav

or
    % aplay -Dplug:surround51 some-2ch.wav

----------------------------------------------------------------------
 LP - 05-14-2004 00:01 CEST 
----------------------------------------------------------------------
Hello tiwai,

I finally found some time to install the latest driver from cvs. I just
tested:

    % aplay -Dplug:surround40 some-2ch.wav

    % aplay -Dplug:surround51 some-2ch.wav

The first one gets me sound through my headset and one of my front
speakers.
The second gets me sound through one of my headset speakers and one of the
front speakers.

modules.conf is set to:

alias char-major-116 snd
alias char-major-14 soundcore
alias snd-card-0 snd-intel8x0
alias sound-slot-0 snd-card-0
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss
options snd cards_limit=1

I haven't edited any other configuration file. Do I have to create a
special config file? Volume control is still not working, right?

If I find time I'll try to look at the source and see if I can get things
working, but I haven't done any alsa coding yet, so I'm not sure how long
it will take until I understand the whole architecture.

----------------------------------------------------------------------
 tiwai - 05-14-2004 17:54 CEST 
----------------------------------------------------------------------
the fact that aplay works for surround40 and surround51 means that
4.0 and 5.1 output are basically ok.

which vidoe player doesnt' work for 5.1 output?

----------------------------------------------------------------------
 LP - 05-14-2004 20:00 CEST 
----------------------------------------------------------------------
Ahhhh, I just tried with mplayer. It does work with "mplayer --channels 6
dvd://.."

Cool!!

The biggest pain though is, that there is no volume control.

I only have some error messages while playing, mplayer outputs:

alsa-control: mixer attach  error: No such file or directoryA: 283.4 V:
283.4 A-V:  0.001 ct:  0.064  7079/7079   9% 21%  1ALSA lib
control.c:654:(snd_ctl_open_noupdate) Invalid CTL

P.S I made sure I recompiled the latest mplayer after installing alsa
lib+driver from cvs.

edited on: 05-14-04 20:00

----------------------------------------------------------------------
 tiwai - 05-14-2004 20:09 CEST 
----------------------------------------------------------------------
it sounds like an application specific problem.

----------------------------------------------------------------------
 LP - 05-15-2004 01:52 CEST 
----------------------------------------------------------------------
Yes don't worry about that.

Can you add volume control, like in the oss driver?
You have the SPEC (CMI9739 6CH Audio Codec SPEC_Ver12.pdf), right?

----------------------------------------------------------------------
 tiwai - 05-25-2004 18:40 CEST 
----------------------------------------------------------------------
no, the chip has no hardware PCM volume control (only mute).
OSS driver does volume control in software, and it's evil to do
it in the kernel driver.

----------------------------------------------------------------------
 tiwai - 05-25-2004 18:41 CEST 
----------------------------------------------------------------------
close this bug now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
03-03-04 08:20 norbert        New Bug                                      
03-03-04 15:31 tiwai          Bugnote Added: 0000464                       
03-03-04 15:31 tiwai          Assigned To               => tiwai           
03-03-04 15:31 tiwai          Resolution               open => not a bug   
03-03-04 15:31 tiwai          Status                   new => resolved     
03-23-04 18:34 perex          Bugnote Added: 0000679                       
03-23-04 18:34 perex          Status                   resolved => closed  
03-24-04 10:35 norbert        Bugnote Added: 0000698                       
03-24-04 10:35 norbert        Resolution               not a bug => reopened
03-24-04 10:35 norbert        Status                   closed => feedback  
03-24-04 11:23 perex          Bugnote Added: 0000699                       
03-30-04 13:35 norbert        Bugnote Added: 0000717                       
03-30-04 14:36 perex          Bugnote Added: 0000718                       
03-30-04 16:15 norbert        Bugnote Added: 0000721                       
04-01-04 00:33 LP             File Added: cmaudio-055.tar.bz2                    
04-01-04 00:33 LP             Bugnote Added: 0000729                       
04-01-04 00:36 LP             Bug Monitored: LP                            
04-01-04 01:05 LP             Bugnote Added: 0000730                       
04-16-04 19:26 tiwai          Bugnote Added: 0000841                       
04-16-04 19:27 tiwai          File Added: cm9739-center-mic.dif                    
04-20-04 14:14 norbert        Bugnote Added: 0000881                       
04-20-04 15:12 tiwai          Bugnote Added: 0000883                       
05-04-04 08:55 norbert        Bugnote Added: 0001039                       
05-04-04 17:08 tiwai          Bugnote Added: 0001044                       
05-05-04 08:36 norbert        Bugnote Added: 0001048                       
05-05-04 11:09 tiwai          Bugnote Added: 0001051                       
05-14-04 00:01 LP             Bugnote Added: 0001106                       
05-14-04 17:54 tiwai          Bugnote Added: 0001114                       
05-14-04 19:56 LP             Bugnote Added: 0001116                       
05-14-04 20:00 LP             Bugnote Edited: 0001116                      
05-14-04 20:09 tiwai          Bugnote Added: 0001117                       
05-15-04 01:52 LP             Bugnote Added: 0001118                       
05-25-04 18:40 tiwai          Bugnote Added: 0001226                       
05-25-04 18:41 tiwai          Bugnote Added: 0001227                       
05-25-04 18:41 tiwai          Resolution               reopened => fixed   
05-25-04 18:41 tiwai          Status                   feedback => resolved
07-16-04 14:39 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
