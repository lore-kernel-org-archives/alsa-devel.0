From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000523]: Unable to get SPDIF output on Biostar IDEQ minipc
Date: Wed, 13 Oct 2004 23:46:50 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041013214650.B22DD1B00B@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 52F9D301
	for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2004 23:46:51 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000523
======================================================================
Reported By:                pharm
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     523
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Debian unstable
Kernel Version:             2.4.27-1-k7 with alsa 1.0.6a (1.0.7rc1 doesn't work either)
======================================================================
Date Submitted:             09-22-2004 22:48 CEST
Last Modified:              10-13-2004 23:46 CEST
======================================================================
Summary:                    Unable to get SPDIF output on Biostar IDEQ minipc
Description: 
I have a Biostar IDEQ 210V minipc. As well as 6 channel analog out (which
appears to work, at least stereo analog out does for certain) there are
two digital (optical) SPDIF outputs. Unfortunately I can't get anything to
recognise these -- mplayer complains about the lack of IEC958 mixer
entries if I try to use the hwac3 output, and if I point the 
alsa output at any of the list of hardware outputs I get nothing from the
digital amp -- it doesn't appear to get any signal.

Assuming I'm not doing something dumb, is there anything else I should
try? I've tried all the ac97_quirk options.
======================================================================

----------------------------------------------------------------------
 tiwai - 09-23-2004 18:25 CEST 
----------------------------------------------------------------------
Could you try the attached patch?
(Note that it's totally untested.)

----------------------------------------------------------------------
 pharm - 09-23-2004 22:09 CEST 
----------------------------------------------------------------------
What am I looking for? It seems to detect OK:
/proc/asound/card0/codec97#0/ac97#0-0 contains the new ID string.

but there's no sound output :( (unless I've fouled up the mixer -- will
check again)

Is there stuff I can twiddle to see what works? I'll have a spelunk
through the patch, but I'm not familiar with the alsa internals
unfortunately...

----------------------------------------------------------------------
 tiwai - 09-24-2004 12:03 CEST 
----------------------------------------------------------------------
What about th spdif output with the patch?
(make sure to use 1.0.7rc, not 1.0.6a)

----------------------------------------------------------------------
 pharm - 09-24-2004 12:28 CEST 
----------------------------------------------------------------------
Ah. Think I may have applied it to 1.0.6a. Will retest!

----------------------------------------------------------------------
 pharm - 09-24-2004 13:34 CEST 
----------------------------------------------------------------------
Ah ha. With patch applied to 1.0.7rc1 the rear SPDIF now lights up.
Still no sound out of analogue or digital outputs as far as I can hear
though.

cheers, Phil

----------------------------------------------------------------------
 tiwai - 09-24-2004 14:33 CEST 
----------------------------------------------------------------------
Can you try ac3dec in alsa-utils package for testing SPDIF output?
Run with -C option so that it works in the ac3 passthru mode.

----------------------------------------------------------------------
 tiwai - 09-24-2004 15:29 CEST 
----------------------------------------------------------------------
Could you try the second patch?  Revert the last patch before applying the
new one.
Reboot your machine after installing the new driver to be sure.

Also, if this still doesn't work, try to remove lines in
alsa-kernel/pci/ac97/ac97_patch.c:1910,

	/* FIXME: set up GPIO */
	snd_ac97_write_cache(ac97, 0x70, 0x0100);
	snd_ac97_write_cache(ac97, 0x72, 0x0020);

----------------------------------------------------------------------
 pharm - 09-24-2004 15:57 CEST 
----------------------------------------------------------------------
$ ./tools/extract_ac3 dolby-aurora.vob | ./ac3dec -C
Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
ALSA lib setup.c:548:(add_elem) Cannot obtain info for CTL elem
(MIXER,'IEC958 Playback AC97-SPSA',0,0,0): No such file or directory
snd_pcm_open: No such file or directory
Output open failed

$ ./tools/extract_ac3 dolby-aurora.vob | ./ac3dec -C -D hw:0,0
Using PCM device 'hw:0,0'
AC3 Stream 48.0 KHz 448 kbps

but no sound from the latter with either hw:0,0 or hw:0,1

----------------------------------------------------------------------
 tiwai - 09-24-2004 16:05 CEST 
----------------------------------------------------------------------
Let's try take3 patch.

----------------------------------------------------------------------
 pharm - 09-24-2004 16:31 CEST 
----------------------------------------------------------------------
with or without the GPIO lines? (Currently compiling with)

----------------------------------------------------------------------
 pharm - 09-24-2004 16:43 CEST 
----------------------------------------------------------------------
OK. No joy :( -- precisely the same results as before. There's no IEC958
mixer entry, so -C fails, while using -C -D hw:0,1 or hw:0,0 gets no
audible output.

Incidentally, with your patches, should I be expecting analogue audio to
work? I can switch back to the 1.0.6a modules & analogue audio works, but
I get no analogue audio out with any of the patches so far.

cheers, Phil

----------------------------------------------------------------------
 tiwai - 09-24-2004 17:08 CEST 
----------------------------------------------------------------------
Looks like this codec doesn't set extended ID register properly
for SPDIF.  Ok, I added a workaround.  Try take4 patch.

Did you get analog outs on 1.0.7rc1 without patches?
If so, keep using 1.0.7.  

The GPIO section might affect the analog outputs, too.
I have no clue what they do.

Anyway, please attach /proc/asound/card0/codec97#0/* files
and /etc/asound.state after "alsactl store" for both
with and without the patch (i.e. analog working and not working).

----------------------------------------------------------------------
 pharm - 09-24-2004 17:33 CEST 
----------------------------------------------------------------------
Success! take4 gives me digital out with ac3dec -C

Analogue out is still broken -- I've attached the register details as
requested.

cheers, Phil

----------------------------------------------------------------------
 tiwai - 09-24-2004 17:39 CEST 
----------------------------------------------------------------------
If you compiled the drver with debug option (CONFIG_SND_DEBUG=y), you
can change the AC97 register value directly by writing to the proc
file.

Try the following (as root):

    echo 64 3038 > /proc/asound/card0/codec97#0/ac97#0-0+regs

If this solves the analog-out problem, we need to figure out which
bit affects it...

----------------------------------------------------------------------
 pharm - 09-24-2004 17:41 CEST 
----------------------------------------------------------------------
Analogue out isn't being echoed to the SPDIF either -- only AC3 output is
working at this point. cheers, Phil

----------------------------------------------------------------------
 tiwai - 09-24-2004 17:45 CEST 
----------------------------------------------------------------------
Did you try like the following?

   % aplay -Dplug:spdif foo.wav

----------------------------------------------------------------------
 pharm - 09-24-2004 17:58 CEST 
----------------------------------------------------------------------
Ah, no: I thought the sound would be mirrored automatically.

Success all round then! With aplay -Dplug:spdif sound.wav I get sound out
from
the SPDIF and having done the echo to the ac97 registers I get analogue
audio out from aplay sound.wav

Any specific bits I should be twiddling in the ac97 registers?

----------------------------------------------------------------------
 tiwai - 09-24-2004 18:06 CEST 
----------------------------------------------------------------------
Could you try each bit on/off and check which bit affects the
behavior?
I guess it's either bit 9 (0200) or bit 5 (0020).

Also, try 'Line-In As Surround' and 'Mic-As-Center' on/off
with 4.0/5.1 analog outputs.  You can use ac3dec like

    % ac3dec -4 foo.ac3
    % ac3dec -6 foo.ac3

for 4.0 and 5.1 analog outputs, respectively.

----------------------------------------------------------------------
 pharm - 09-27-2004 09:56 CEST 
----------------------------------------------------------------------
I'll give it a go when I get some time this week. Last I checked, 4 channel
sound worked, but 6 (ie Mic-as-center) didn't seem to. Will check again to
confirm.

----------------------------------------------------------------------
 tiwai - 09-27-2004 15:16 CEST 
----------------------------------------------------------------------
To make sure, I uploaded my lastest patch (take5).

----------------------------------------------------------------------
 tiwai - 10-12-2004 14:59 CEST 
----------------------------------------------------------------------
Did you try the latest one?  Nevertheless, alsa-driver-1.0.7rc2 already
includes the patch.  You can try it instead.

----------------------------------------------------------------------
 pharm - 10-12-2004 15:10 CEST 
----------------------------------------------------------------------
Apologies -- busy during last week. It's all compiled up, but I haven't had
time to actually test it :( Should have a spare few minutes tomorrow
hopefully.

cheers, Phil

----------------------------------------------------------------------
 pharm - 10-13-2004 23:46 CEST 
----------------------------------------------------------------------
OK. I must have been confused before. After going through all the options,
it appears that analogue audio still doesn't work with any of the 1.0.7
patches so far. 1.0.6a works, but not for 6 channel surround -- 4 channels
appears to work ok, but when decoding 5.1, nothing is heard on the extra 2
audio channels (this is with one of the Dolby DTS sample files). Apologies
for the misleading info. I must have switched back to the original modules
at some point :(

So the only remaining option is presumably a binary chop of the
differences between the ac93 register values for 1.0.6a and 1.0.7rc2. Not
something I have time for tonight -- maybe at the weekend.

Incidentally, an additional extra -- this box actually has 2 SPDIF in/out
ports (front and back). The current working one is the rear SPDIF. Just
FYI.

thanks again for the coding efforts, Phil

Bug History
Date Modified  Username       Field                    Change              
======================================================================
09-22-04 22:48 pharm          New Bug                                      
09-22-04 22:48 pharm          Distribution              => Debian unstable 
09-22-04 22:48 pharm          Kernel Version            => 2.4.27-1-k7 with alsa 1.0.6a (1.0.7rc1 doesn't work either)
09-23-04 18:25 tiwai          Bugnote Added: 0001829                       
09-23-04 18:26 tiwai          File Added: cm9761-add.dif                    
09-23-04 22:09 pharm          Bugnote Added: 0001851                       
09-24-04 09:28 pharm          Bug Monitored: pharm                         
09-24-04 12:03 tiwai          Bugnote Added: 0001869                       
09-24-04 12:28 pharm          Bugnote Added: 0001877                       
09-24-04 13:34 pharm          Bugnote Added: 0001882                       
09-24-04 14:33 tiwai          Bugnote Added: 0001886                       
09-24-04 15:29 tiwai          Bugnote Added: 0001890                       
09-24-04 15:29 tiwai          File Added: cm9761-add-take2.dif                    
09-24-04 15:57 pharm          Bugnote Added: 0001892                       
09-24-04 16:05 tiwai          Bugnote Added: 0001893                       
09-24-04 16:05 tiwai          File Added: cm9761-add-take3.dif                    
09-24-04 16:31 pharm          Bugnote Added: 0001894                       
09-24-04 16:43 pharm          Bugnote Added: 0001895                       
09-24-04 17:08 tiwai          Bugnote Added: 0001896                       
09-24-04 17:08 tiwai          File Added: cm9761-add-take4.dif                    
09-24-04 17:23 pharm          File Added: 1.0.7rc1-ac97#0-0                    
09-24-04 17:24 pharm          File Added: 1.0.7rc1-ac97#0-0+regs                    
09-24-04 17:32 pharm          File Added: take4-ac97#0-0                    
09-24-04 17:32 pharm          File Added: take4-ac97#0-0+regs                    
09-24-04 17:33 pharm          Bugnote Added: 0001897                       
09-24-04 17:39 tiwai          Bugnote Added: 0001898                       
09-24-04 17:41 pharm          Bugnote Added: 0001899                       
09-24-04 17:45 tiwai          Bugnote Added: 0001900                       
09-24-04 17:58 pharm          Bugnote Added: 0001901                       
09-24-04 18:06 tiwai          Bugnote Added: 0001902                       
09-27-04 09:56 pharm          Bugnote Added: 0001933                       
09-27-04 15:16 tiwai          Bugnote Added: 0001939                       
09-27-04 15:17 tiwai          File Added: cm9761-add-take5.dif                    
10-12-04 14:59 tiwai          Bugnote Added: 0002102                       
10-12-04 15:10 pharm          Bugnote Added: 0002105                       
10-13-04 23:46 pharm          Bugnote Added: 0002135                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
