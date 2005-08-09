From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001224]: artsd-like style
Date: Wed, 10 Aug 2005 00:49:03 +0200
Message-ID: <6e3c3eff9fdfeacb48204c82cf1f4137@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E78721F1
	for <alsa-devel@alsa-project.org>; Wed, 10 Aug 2005 00:49:03 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
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


The issue 0001228 has been set as DUPLICATE OF the following issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1224> 
======================================================================
Reported By:                Hetfield
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1224
Category:                   PCI - ens1370
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             2.6.x
======================================================================
Date Submitted:             07-01-2005 14:49 CEST
Last Modified:              08-01-2005 10:20 CEST
======================================================================
Summary:                    artsd-like style
Description: 
i'd like to know if that's a roadmap to let alsa drivers have a artsd (or
windows) style, i mean, multiple streams at once.

that could be very important for example using skype voip and listening
music at the same time.
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
has duplicate       0001228 Skype Does not work with aoss
======================================================================

----------------------------------------------------------------------
 Hetfield - 07-01-05 20:16 
----------------------------------------------------------------------
maybe i'd better to explain better.

i know we can use dmix plugin, but old oss apps need aoss, and this
creates some problems to applications like skype (that seg fault)

i meant: can alsa drivers manage all /dev/dsp without aoss proxy?

----------------------------------------------------------------------
 rlrevell - 07-01-05 20:33 
----------------------------------------------------------------------
dmix works with aoss.  If skype crashes, it's a bug in skype.  Please ask
them to fix it, or support ALSA properly.

----------------------------------------------------------------------
 Hetfield - 07-01-05 22:56 
----------------------------------------------------------------------
from a point of view you're right, but, from the other, you're not.

if it crashes with aoss this means aoss is not fully transparent for an
application.
that's why i asked for a driver low-level management.

----------------------------------------------------------------------
 pzad - 07-02-05 18:53 
----------------------------------------------------------------------
In aoss is bug. I found one (skype doesn't crash), but still can not get it
work - there is probably another one.

----------------------------------------------------------------------
 Hetfield - 07-02-05 20:11 
----------------------------------------------------------------------
very good, i was sure of aoss/ dmix system bug.

can i get your fixes in order to check here?

----------------------------------------------------------------------
 pzad - 07-02-05 21:47 
----------------------------------------------------------------------
With this patch skype works with aoss, but for now not with dmix (it can
work dirrectly with hw or plughw - this is not usefull for now).

----------------------------------------------------------------------
 Hetfield - 07-03-05 09:25 
----------------------------------------------------------------------
i tested your patch.

it doesn't crash skype, nor i get "error with audio device" as before

but i can't hear nothing, as you said..

ready to test new fixes :)

----------------------------------------------------------------------
 pzad - 07-03-05 14:09 
----------------------------------------------------------------------
I can make skype work with dmix (but only if dmix is mono). In this mode it
works ok. Problem is skype doesn't check return value (channel count and
assume mono is supported, but this is not case when dmix is used in stereo
mode).

----------------------------------------------------------------------
 Hetfield - 07-03-05 15:57 
----------------------------------------------------------------------
i haven't undestood if the problem (only in mono) is fixed with another
patch (and so, please submit here) or if it already works actually.

how to check the dmix mono setting?

however i submitted a skype ticket linking this thread, as soon as i got
an answer i'll post here, hoping to fix this problem as soon as
possibile.

the question is: shouldn't skype have the same problem with pure oss
driver? i mean..if it assume mono and not stereo without checks, what's
the difference with dmix?

this is what i thought when i opened this bug, dmix is not fully
transparent to applications, or, apart the init bug, it should let apps
work as pure oss access.
i'm not an alsa expert, never read the code, i may fail of course, but
this is my suspect.

good work.

----------------------------------------------------------------------
 pzad - 07-04-05 11:53 
----------------------------------------------------------------------
aoss.patch - this will make skype work in mono mode. You need to put
channels 1 to dmix.conf and dsnoop.conf.

In pure oss mode skype ask for mono 48000 kHz and it got this. In dmix it
got 48000 but stereo.

----------------------------------------------------------------------
 Hetfield - 07-04-05 14:02 
----------------------------------------------------------------------
i'm sorry, i searched the web for a while but didn't got that mono config.

however, if i have understood well, i would have mono for all apps and not
only skype, and that's not good.

i'm still waiting for skype support response..i'll keep you updated.

----------------------------------------------------------------------
 tiwai - 07-08-05 12:16 
----------------------------------------------------------------------
Doesn't plug layer work for mono conversion?

----------------------------------------------------------------------
 Hetfield - 07-08-05 12:27 
----------------------------------------------------------------------
i think i configured that in a wrong way.

but i don't want mono sound, that's why i didn't search a lot.

----------------------------------------------------------------------
 Hetfield - 07-17-05 10:25 
----------------------------------------------------------------------
another problem found:

kiax ( http://kiax.sf.net ), another voip client, doesn't work with aoss.
it uses portaudio library ( oss support only).

when i start with "aoss kiax" program starts, but show nothing, cpu usage
is 100%.
seems an endless loop.
i waited some mins, nothing change.

another issue with aoss so :(

----------------------------------------------------------------------
 rlrevell - 07-17-05 10:29 
----------------------------------------------------------------------
PortAudio can use ALSA too.  Otherwise it would not be very portable...

----------------------------------------------------------------------
 rlrevell - 07-17-05 10:46 
----------------------------------------------------------------------
Actually this might be useful, if it's the same problem affecting skype.

What does strace -p PID show you, where PID is the kiax PID?

----------------------------------------------------------------------
 Hetfield - 07-17-05 11:10 
----------------------------------------------------------------------
rlrevell, for alsa/portaudio:
http://sourceforge.net/forum/forum.php?thread_id=1276778&forum_id=448020

i attached a long log. please check.

however:
cat log|grep dsp
stat64("/dev/dsp697", 0xbfbcb3a0)       = -1 ENOENT (No such file or
directory)
stat64("/dev/dsp698", 0xbfbcb3a0)       = -1 ENOENT (No such file or
directory)
stat64("/dev/dsp699", 0xbfbcb3a0)       = -1 ENOENT (No such file or
directory)
stat64("/dev/dsp700", 0xbfbcb3a0)       = -1 ENOENT (No such file or
directory)
stat64("/dev/dsp701", 0xbfbcb3a0)       = -1 ENOENT (No such file or
directory)


it's abvoius it keeps searching for free dsp.
(in log you'll find it searches in proc too...)
even if dsp is unused.

----------------------------------------------------------------------
 rlrevell - 07-17-05 19:41 
----------------------------------------------------------------------
What does "file /dev/dsp" tell you?

----------------------------------------------------------------------
 Hetfield - 07-17-05 19:50 
----------------------------------------------------------------------
root@blight ~ # file /dev/dsp
/dev/dsp: symbolic link to `sound/dsp'
root@blight ~ # file /dev/s
Display all 137 possibilities? (y or n)
root@blight ~ # file /dev/sound/dsp
/dev/sound/dsp: character special (14/3)
root@blight ~ #              

alsa 1.0.9 kernel 2.6.13-rc3

----------------------------------------------------------------------
 rlrevell - 07-17-05 19:51 
----------------------------------------------------------------------
OK, try to use strace to capture what happens when it tries to open
/dev/dsp.

----------------------------------------------------------------------
 Hetfield - 07-17-05 20:21 
----------------------------------------------------------------------
sorry, bu i already attached a log file.

check log.tar.gz

what else do you need?

----------------------------------------------------------------------
 rlrevell - 07-17-05 21:14 
----------------------------------------------------------------------
That log starts at /dev/dsp697.  Presumably it tried to open 0 through 696
before this.  So you need to get an strace of when the process first
starts up.

----------------------------------------------------------------------
 Hetfield - 07-17-05 21:23 
----------------------------------------------------------------------
added new strace output. 600k...i hope you can find something interesting

----------------------------------------------------------------------
 rlrevell - 07-17-05 22:21 
----------------------------------------------------------------------
Something (either in alsa-lib or the app) does not seem to be handling a
timer correctly.

After opening /dev/dsp, it tries to open some type of timer:

open("/dev/snd/timer", O_RDONLY|O_NONBLOCK) = 9
ioctl(9, 0x80045400, 0xbf822ecc)        = 0
ioctl(9, TIOCSPGRP, 0xbf822ed0)         = 0
ioctl(9, 0x80045400, 0xbf8232fc)        = 0

Then the ioctl to start the timer returns -EBUSY:

ioctl(9, SNDCTL_TMR_START or TCSETS, 0x82676e8) = -1 EBUSY (Device or
resource busy)

Then it does some more ioctls on the timer:

ioctl(9, TIOCSTI, 0xbf8234d0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf8235f0)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, TIOCSTI, 0xbf823630)           = 0
ioctl(9, 0x54a1, 0xb729aa08)            = 0
read(9, "\0\0\0\0\0\0\0\0", 8)          = 8

Then we get EAGAIN trying to read the timer, which causes it to give up
and try /dev/dsp1, and so on.

read(9, 0xbf8239c0, 8)                  = -1 EAGAIN (Resource temporarily
unavailable)
close(9)                                = 0

But this also fails because it performs the exact same sequence of
operations on the timer.

I suspect that the return value of the ioctl to start the timer was not
checked, so the app just assumes the timer was started.

Of course it's also completely broken for the app to keep opening
non-existent /dev/dsp* in a loop like that.

----------------------------------------------------------------------
 Hetfield - 07-17-05 23:28 
----------------------------------------------------------------------
ok ok, but maybe you missed my point:
why it work perfectly with plain oss and not with aoss?

that's the same issue for skype..aoss is not a FULLY transparent bridge
between apps and driver translation.

apart some fatal bugs (seg fault fixed in this thread) there seems to be
some hidden little holes to fill.

i'll be happy to test any patch or fix

----------------------------------------------------------------------
 rlrevell - 07-17-05 23:43 
----------------------------------------------------------------------
Well, it's not a bug-for-bug compatible emulation.  There are always areas
in any API that are ambiguous or implementation dependent.  The fact that
it works with another OSS implementation does not rule out an application
bug.

Most of the cases we have seen so far where aoss breaks something involve
buggy apps, that just happen to work with OSS or the in kernel emulation. 
They are just as likely to fail under a different OSS implementation.  For
example skype assumes it gets 48KHz stereo, even though the stream is
mono.  Although this particular case is due to a quirk of dmix, it would
also fail if the hardware only supported 48Khz mono.  They just didn't
bother to test it under an OSS implementation where this can happen.

----------------------------------------------------------------------
 rlrevell - 07-18-05 03:33 
----------------------------------------------------------------------
That being said, after looking at the code a bit this is almost certainly a
dmix bug.

It would be nice to know what all those ioctls are.  Any idea why strace
can't resolve them?

----------------------------------------------------------------------
 rlrevell - 07-18-05 06:04 
----------------------------------------------------------------------
I was not able to reproduce the bug; even when I had enabled dmix, the
emu10k1 driver allocated separate voices for esd and kiax.

But, I did find that the sound is terribly choppy with aoss, which did not
happen with the in kernel OSS emulation.

Also, I had to apply the alsa-oss patches from this bug report, otherwise
kiax crashed on startup.  These should be applied to CVS ASAP.

----------------------------------------------------------------------
 rlrevell - 07-18-05 07:33 
----------------------------------------------------------------------
Maybe this is related (from the dmix docs).  Do you have an .asoundrc or
/etc/asound.conf?

For using the dmix plugin for OSS emulation device, you have to set
the period and the buffer sizes in power of two.  For example,
\code
pcm.dmixoss {
        type dmix
        ipc_key 321456  # any unique value
        ipc_key_add_uid true
        slave {
                pcm "hw:0"
                period_time 0
                period_size 1024  # must be power of 2
                buffer_size 8192  # ditto
        }
}

----------------------------------------------------------------------
 Hetfield - 07-18-05 09:23 
----------------------------------------------------------------------
you have hardware mixing, so no problem for you.

i'll attach my .asoundrc file, but i copied it from some howtos, so i
guess it's clean

----------------------------------------------------------------------
 rlrevell - 07-18-05 22:08 
----------------------------------------------------------------------
I cannot reproduce the problem as aoss + dmix does not use a timer on my
system, due to hardware mixing being present.  It actually seems to work
(the choppiness was due to running under gdb), but for some reason it
always gets 8000Hz for the sample rate, even if I comment it out of the
sapleRates table, and set "rate 48000" in dmix.conf.

Try running with ALSA_OSS_DEBUG=1 and post the output.

Also uncomment these lines and recompile to enable debug output from
kiax:

kiax-0.8.4/lib/portaudio/pa_common/pa_lib.c~:#define DBUG(x)  /* PRINT(x)
*/
kiax-0.8.4/lib/unixfuncs.c~://#define DBUG(...) fprintf(stderr,
__VA_ARGS__)

----------------------------------------------------------------------
 Hetfield - 07-21-05 19:55 
----------------------------------------------------------------------
i enabled both debug..here is result..hope you can debug it...




ALSA_OSS_DEBUG=1 aoss ../bin/kiax
gio lug 21 19:53:39 2005 Using IAXClient ver. CVS-2005/07/21-19:08
Opened PCM dsp0 for stream 0 (result = 0)
open("/dev/dsp", 2049, -1218923258) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp1 for stream 0 (result = -2)
Opened PCM default:1 for stream 0 (result = 0)
open("/dev/dsp1", 2049, 137403300) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp2 for stream 0 (result = -2)
Opened PCM default:2 for stream 0 (result = 0)
open("/dev/dsp2", 2049, 137399604) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp3 for stream 0 (result = -2)
Opened PCM default:3 for stream 0 (result = 0)
open("/dev/dsp3", 2049, 137402964) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp4 for stream 0 (result = -2)
Opened PCM default:4 for stream 0 (result = 0)
open("/dev/dsp4", 2049, 136903268) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp5 for stream 0 (result = -2)
Opened PCM default:5 for stream 0 (result = 0)
open("/dev/dsp5", 2049, 136903428) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp6 for stream 0 (result = -2)
Opened PCM default:6 for stream 0 (result = 0)
open("/dev/dsp6", 2049, 137399916) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp7 for stream 0 (result = -2)
Opened PCM default:7 for stream 0 (result = 0)
open("/dev/dsp7", 2049, 136369340) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp8 for stream 0 (result = -2)
Opened PCM default:8 for stream 0 (result = 0)
open("/dev/dsp8", 2049, 137404044) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp9 for stream 0 (result = -2)
Opened PCM default:9 for stream 0 (result = 0)
open("/dev/dsp9", 2049, 137400516) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp10 for stream 0 (result = -2)
Opened PCM default:10 for stream 0 (result = 0)
open("/dev/dsp10", 2049, 137400188) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp11 for stream 0 (result = -2)
Opened PCM default:11 for stream 0 (result = 0)
open("/dev/dsp11", 2049, 137403740) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp12 for stream 0 (result = -2)
Opened PCM default:12 for stream 0 (result = 0)
open("/dev/dsp12", 2049, 137401012) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp13 for stream 0 (result = -2)
Opened PCM default:13 for stream 0 (result = 0)
open("/dev/dsp13", 2049, 137400676) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp14 for stream 0 (result = -2)
Opened PCM default:14 for stream 0 (result = 0)
open("/dev/dsp14", 2049, 136370876) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp15 for stream 0 (result = -2)
Opened PCM default:15 for stream 0 (result = 0)
open("/dev/dsp15", 2049, 136370276) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[48000]) -> [48000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[44100]) -> [44100]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[32000]) -> [32000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[24000]) -> [24000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[22050]) -> [22050]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[16000]) -> [16000]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[11025]) -> [11025]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[8000]) -> [8000]
close(8) -> 0
Opened PCM dsp16 for stream 0 (result = -2)
Opened PCM default:16 for stream 0 (result = 0)
open("/dev/dsp16", 2049, 137340812) -> 8
ioctl(8, SNDCTL_DSP_GETFMTS, 0xbfbc244c) -> [511]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[1]) -> [1]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[2]) -> [2]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[3]) -> [3]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[4]) -> [4]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[5]) -> [5]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[6]) -> [6]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[7]) -> [7]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[8]) -> [8]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[9]) -> [9]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[10]) -> [10]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[11]) -> [11]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[12]) -> [12]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[13]) -> [13]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[14]) -> [14]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[15]) -> [15]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2448[16]) -> [16]
ioctl(8, SNDCTL_DSP_CHANNELS, 0xbfbc2440[2]) -> [2]
ioctl(8, SNDCTL_DSP_SPEED, 0xbfbc243c[96000]) -> [96000]
ioctl(8,

----------------------------------------------------------------------
 Hetfield - 07-21-05 19:56 
----------------------------------------------------------------------
without aoss

Pa_OpenStream( 0x810dd6c, 0, 1, 2, (nil), /* input */
               0, 1, 2, (nil), /* output */
               8000, 80, 0, 0x0, , (nil) )
Pa_StartStream: PaHost_StartInput returned = 0x0.
Pa_StartStream: PaHost_StartOutput returned = 0x0.
Pa_StartStream: PaHost_StartEngine returned = 0x0.
Pa_StopStream().
Pa_StopStream: PaHost_StopEngine returned = 0x0.
Pa_StopStream: PaHost_StopInput returned = 0x0.
Pa_StopStream: PaHost_StopOutput returned = 0x0.
Pa_CloseStream()
Pa_StopStream().
Pa_StopStream: PaHost_StopEngine returned = 0x0.
Pa_StopStream: PaHost_StopInput returned = 0x0.
Pa_StopStream: PaHost_StopOutput returned = 0x0.
gio lug 21 19:55:35 2005 IaxWrapper::iaxc_initialize() result = 0
gio lug 21 19:55:35 2005 IaxWrapper::start_iax_client() starting
processing thread..
gio lug 21 19:55:35 2005 IaxWrapper::iaxc_start_processing_thread() result
= 0
gio lug 21 19:55:35 2005 IaxWrapper::registerMultipleAccounts()
registering accounts..
prioboost: only superuser can use real-time priority.

----------------------------------------------------------------------
 Hetfield - 07-24-05 09:55 
----------------------------------------------------------------------
no news here? i didn't get any mail notification..maybe it's broken

----------------------------------------------------------------------
 rlrevell - 07-24-05 19:10 
----------------------------------------------------------------------
tiwai is on vacation, so this will have to wait for his return.

----------------------------------------------------------------------
 rlrevell - 07-28-05 22:40 
----------------------------------------------------------------------
Takashi-san, can you have a look at this?  I think it's a dmix issue.  I
cannot reproduce it on my system, because I only have the emu10k1 to test
with, but if you look at the logs it seems related to the use of PCM slave
timers by dmix.

It should be easy to reproduce with aoss + kiax (open source VOIP client)
over dmix with any non-hardware mixing device.

I think solving this bug could be key to resolving the aoss + skype
issues, as we now have a similar open source app with which we can
reproduce the bug.

----------------------------------------------------------------------
 tiwai - 07-29-05 17:43 
----------------------------------------------------------------------
At first, make sure that you're using the latest alsa-lib.  Some
100%-CPU-hog bugs were fixed in the recent release.

Also, remove ~/.asoundrc once.  The default configuration of dmix should
be OK for aoss in the recent version, too.

----------------------------------------------------------------------
 Hetfield - 08-01-05 10:20 
----------------------------------------------------------------------
deleting my .asoundrc file i have no more 100% cpu usage.

where the problem is? i attacched my config file.

however kiax doesn't work...
it starts but i get (debug disabled actually)

PortAudio error at opening separate input stream: Invalid device ID.
lun ago 1 10:16:06 2005 IaxWrapper::event_text() Message: Type=3
Message=Can't start audio
lun ago 1 10:16:06 2005 IaxWrapper::event_text() Message: Type=4
Message=iaxclient audio: Can't open Audio Device, we tried 5 times. 
Perhaps you do not have an input or output device?
PortAudio error at opening separate input stream: Invalid device ID.
PortAudio error at opening separate input stream: Invalid device ID.


any other idea?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-01-05 14:49 Hetfield       New Issue                                    
07-01-05 14:49 Hetfield       Kernel Version            => 2.6.x           
07-01-05 20:16 Hetfield       Note Added: 0005337                          
07-01-05 20:33 rlrevell       Note Added: 0005338                          
07-01-05 22:56 Hetfield       Note Added: 0005343                          
07-02-05 18:53 pzad           Note Added: 0005356                          
07-02-05 20:11 Hetfield       Note Added: 0005357                          
07-02-05 21:46 pzad           File Added: aoss-fcntl.patch                    
07-02-05 21:47 pzad           Note Added: 0005361                          
07-03-05 09:25 Hetfield       Note Added: 0005370                          
07-03-05 14:09 pzad           Note Added: 0005376                          
07-03-05 15:57 Hetfield       Note Added: 0005378                          
07-04-05 11:49 pzad           File Added: aoss.patch                       
07-04-05 11:53 pzad           Note Added: 0005384                          
07-04-05 14:02 Hetfield       Note Added: 0005385                          
07-08-05 12:16 tiwai          Note Added: 0005417                          
07-08-05 12:27 Hetfield       Note Added: 0005418                          
07-17-05 10:25 Hetfield       Note Added: 0005503                          
07-17-05 10:29 rlrevell       Note Added: 0005504                          
07-17-05 10:46 rlrevell       Note Added: 0005505                          
07-17-05 11:10 Hetfield       Note Added: 0005506                          
07-17-05 11:11 Hetfield       File Added: log.tar.gz                       
07-17-05 19:41 rlrevell       Note Added: 0005508                          
07-17-05 19:50 Hetfield       Note Added: 0005509                          
07-17-05 19:51 rlrevell       Note Added: 0005510                          
07-17-05 20:21 Hetfield       Note Added: 0005511                          
07-17-05 21:14 rlrevell       Note Added: 0005512                          
07-17-05 21:22 Hetfield       File Added: log2.tar.gz                      
07-17-05 21:22 Hetfield       File Added: log2                             
07-17-05 21:23 Hetfield       Note Added: 0005513                          
07-17-05 22:21 rlrevell       Note Added: 0005514                          
07-17-05 23:28 Hetfield       Note Added: 0005515                          
07-17-05 23:43 rlrevell       Note Added: 0005516                          
07-18-05 03:33 rlrevell       Note Added: 0005517                          
07-18-05 06:04 rlrevell       Note Added: 0005518                          
07-18-05 07:33 rlrevell       Note Added: 0005519                          
07-18-05 09:23 Hetfield       Note Added: 0005520                          
07-18-05 09:24 Hetfield       File Added: asoundrc                         
07-18-05 22:08 rlrevell       Note Added: 0005524                          
07-21-05 19:55 Hetfield       Note Added: 0005540                          
07-21-05 19:56 Hetfield       Note Added: 0005541                          
07-24-05 09:55 Hetfield       Note Added: 0005556                          
07-24-05 19:10 rlrevell       Note Added: 0005558                          
07-28-05 22:40 rlrevell       Note Added: 0005578                          
07-29-05 17:43 tiwai          Note Added: 0005579                          
08-01-05 10:20 Hetfield       Note Added: 0005595                          
08-10-05 00:49 rlrevell       Relationship added       has duplicate 0001228
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
