From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000408]: Volume control is chaotic
Date: Tue, 19 Oct 2004 16:30:34 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041019143034.B5AD211030@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 0F9A4311
	for <alsa-devel@alsa-project.org>; Tue, 19 Oct 2004 16:30:34 +0200 (MEST)
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


The following bug has been RESOLVED.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000408
======================================================================
Reported By:                skamp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     408
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               LFS 5.1.1, BLFS 5.1
Kernel Version:             2.4.26
Resolution:                 fixed
======================================================================
Date Submitted:             07-27-2004 18:40 CEST
Last Modified:              10-19-2004 16:30 CEST
======================================================================
Summary:                    Volume control is chaotic
Description: 
Volume control doesn't work properly, with alsa-mixer as well as with
gnome-volume-control. As I figured out that line-out volume was controled
with DAC and DAC1 (how intuitive), I noticed that while sliding the
controls up and down increased and decreased the volume as expected,
modifying the master volume control afterwards made the volume jump to a
much lower level than expected: increasing or decreasing the master volume
even just a little bit makes the overall volume drop, even though it is
not mirrored by the controls.

Thus, setting DAC and DAC1 to 100% while Master was set to 82% resulted in
a quite high volume, but modifying the master volume to 84% or 80%
resulted in the drop. Setting master volume to 60% made the sound very
low, and setting it to 40% made it almost inaudible, until I changed DAC
and DAC1 by 2%.
======================================================================

----------------------------------------------------------------------
 skamp - 08-17-2004 04:33 CEST 
----------------------------------------------------------------------
Fixed with alsa-* 1.0.6, although the Master control is weird: you only get
full sound when you set Master to 0. Increasing Master decreases overall
volume very fast. This control is basically unusable.

----------------------------------------------------------------------
 tiwai - 08-18-2004 13:47 CEST 
----------------------------------------------------------------------
Could you try the attached patch?

----------------------------------------------------------------------
 skamp - 08-18-2004 15:20 CEST 
----------------------------------------------------------------------
patching file pci/ice1712/aureon.c
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000001 FAILED at 273.
Hunk https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000002 FAILED at 305.
2 out of 2 hunks FAILED -- saving rejects to file
pci/ice1712/aureon.c.rej

I installed version 1.0.6 when it got out.

----------------------------------------------------------------------
 tiwai - 08-18-2004 15:32 CEST 
----------------------------------------------------------------------
It's a patch to alsa-kernel tree (in alsa-driver).  You'll likely
need to pass an appropriate -p option.

----------------------------------------------------------------------
 skamp - 08-18-2004 15:36 CEST 
----------------------------------------------------------------------
Oops, I issued patch -Np1 instead of patch -Np0. My bad.
The patch solves the issue, but Master still has to be set to 100%, so the
overall volume is way too low for that value. If I set Front to the
maximum as well, the volume is still quite bearable, and the sound to
noise ratio is very *low*. I know this card could blow my ears away, and
I'm far from being deaf ;-)

edited on: 08-18-04 15:36

----------------------------------------------------------------------
 tiwai - 08-18-2004 15:41 CEST 
----------------------------------------------------------------------
The problem of sensitivty is that the volume is defined in a wide
range.  In the second patch I changed the master volume to -64dB
from -128dB, but it's still fairly big.  If you choose 50%, it means
-32dB.  (Moreover, surround volumes are up to -101dB.)

This problem will be solved when we introduce the dB control.
For kernel OSS emulation, the problem will remain, though...

Anyway, I'll apply the patch then.  Thanks for testing.

----------------------------------------------------------------------
 ungod - 10-06-2004 22:10 CEST 
----------------------------------------------------------------------
I noticed somewhat the same thing with the Aureon 7.1 Space (Naturally as
they're quite identical). I supposed that the reason why the sound behaves
as it does is that the volume control is linear although sound amplitude
behaves logarithm.
Personally I've found other problems with the volume control. There is no
PCM volume control, the master volume only operates on digital sound etc.
So I've made a patch (for the CVS) which does a few changes in this
section (uploaded as aureon-volfix4.diff). It may need some changes here
and there though (no mute for LFE/Center):

Summary: Misc. volume fixes

 - Added mono mute function to Front/Rear/Side
 - Master volume is artificially made in software
 - Added PCM volume control (basically what was the master volume)
 - Front/Read/Side/LFE/Center is now logarithmic (and computed as <volume>
* <master volume> / <maximum volume>)

Signed-off-by: Peter Christensen <peter@developers.dk>

----------------------------------------------------------------------
 ungod - 10-07-2004 09:52 CEST 
----------------------------------------------------------------------
Did a few changes, so that the mutes actually operated on the analogue
sound too. aureon-volfix4.1.diff relaces aureon-volfix4.diff

Summary: Misc. volume fixes

 - Added mute function to Master/Front/Rear/Side/LFE/CEnter
 - Master volume is artificially made in software
 - Added PCM volume control (basically what was the master volume)
 - Front/Read/Side/LFE/Center is now logarithmic (and computed as <volume>
* <master volume> / <maximum volume>)

Signed-off-by: Peter Christensen <peter@developers.dk>

----------------------------------------------------------------------
 tiwai - 10-07-2004 14:43 CEST 
----------------------------------------------------------------------
Thanks for the patch.  It looks almost fine.

I changed the patch as attached (4.2.diff).

- fold and simplified too long lines
- small optimization for dac loop
- removed debug printk
- fixed a typo (% 1).

I'll apply it after you confirm that it works.

----------------------------------------------------------------------
 ungod - 10-07-2004 18:03 CEST 
----------------------------------------------------------------------
Well, I'm not perfect (especially not at certain times of the day). I'm not
supprised that I overlooked one of the debug messages and the silly %1.
Anyway it all work properly on my Space, and I am convinced that it also
works on the Sky and Universe, but that is up to skamp to figure out.

----------------------------------------------------------------------
 skamp - 10-07-2004 21:26 CEST 
----------------------------------------------------------------------
Volume seems to work fine now (I've tested it for about 20 minutes),
although I didn't test 5.1 output (I don't have a 5.1 system). PCM output
with headphone amp. on is great, but only if you mute line-in. Otherwise,
you can clearly hear static. BTW, switching headphone amp. on and off
produces a distinct "click" coming from the soundcard (I mean I can hear
*without* the headphones plugged in): is it *actually* turning a physical
switch on and off ??

One small bug: I get the following message when calling alsactl restore:
/usr/sbin/alsactl: set_control:757: missing control.30.value
"Control 30" is the capture switch. The /etc/asound.state file in fact
misses a "value" line for this control.

Otherwise, volume control seems to work fine now.

----------------------------------------------------------------------
 ungod - 10-08-2004 04:01 CEST 
----------------------------------------------------------------------
The click you hear is perfectly normal and is caused by the relay which
drives the headphone amp. You can see it on the card as a large white
box.

I believe the problem with mixer restoration is that the mixer now have
more mixer controls than previous, so the first time you attempt to
restore the mixer settings, it will do so based on the number of mixer
controls in the previous driver. I believe that calling "alsactl store"
should do the trick.

----------------------------------------------------------------------
 skamp - 10-08-2004 09:31 CEST 
----------------------------------------------------------------------
Since I was testing it, I obviously loaded/unloaded the modules several
times, thus called alsactl store / restore as well. It doesn't solve the
problem.

----------------------------------------------------------------------
 tiwai - 10-08-2004 12:24 CEST 
----------------------------------------------------------------------
Oh, capture switch is wrongly implemented.  It shouldn't work :)
Peter, was it intentional to replace wm_adc_mute_* callbacks?

----------------------------------------------------------------------
 ungod - 10-09-2004 01:21 CEST 
----------------------------------------------------------------------
Oh. Woups. It is the result of me attempting to apply mute control for the
WM8770 outputs, and since you could do some muting for the ADC's and DAC's
in the same register, I made one common mute function. However, when I
noticed that it had no effect on the analogue audio mixed with the DAC's,
I turned to the software implemented mute. The private_value indicated
thae bit 5 toggled mute on/off. Anyway this kind of mute is mono, so
naturally the old mute function was the best.

----------------------------------------------------------------------
 ungod - 10-09-2004 02:05 CEST 
----------------------------------------------------------------------
Well, here is another revision (4.3) of the patch with adc_mute restored
(strangely enought the patch is smaller - I've lost control of my alsa
directory, so I only hope that the patch correspond to the CVS).
Besides, I took the liberty to fix a bug in the wm_adc_mute_put, which
caused that only the left record channel could be muted.

----------------------------------------------------------------------
 tiwai - 10-11-2004 12:16 CEST 
----------------------------------------------------------------------
Thanks for fix, applied to CVS now.

----------------------------------------------------------------------
 tiwai - 10-12-2004 14:37 CEST 
----------------------------------------------------------------------
Shall I close this bug?

----------------------------------------------------------------------
 ungod - 10-13-2004 18:51 CEST 
----------------------------------------------------------------------
Well, it is my belief that the problem i solved, but I suppose skamp is the
only one who can rightfully tell whether the problem i solved.

----------------------------------------------------------------------
 skamp - 10-14-2004 21:08 CEST 
----------------------------------------------------------------------
Problem solved, as far as I'm concerned. Thanks a lot!

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-27-04 18:40 skamp          New Bug                                      
07-27-04 18:40 skamp          File Added: aadebug                          
07-27-04 18:40 skamp          Distribution              => LFS 5.1.1, BLFS 5.1
07-27-04 18:40 skamp          Kernel Version            => 2.4.26          
07-27-04 18:52 skamp          Bug Monitored: skamp                         
08-17-04 04:33 skamp          Bugnote Added: 0001571                       
08-18-04 13:47 tiwai          Assigned To               => tiwai           
08-18-04 13:47 tiwai          Status                   new => assigned     
08-18-04 13:47 tiwai          Bugnote Added: 0001578                       
08-18-04 13:48 tiwai          File Added: aureon-volfix3.dif                    
08-18-04 15:20 skamp          Bugnote Added: 0001579                       
08-18-04 15:32 tiwai          Bugnote Added: 0001580                       
08-18-04 15:34 skamp          Bugnote Added: 0001581                       
08-18-04 15:36 skamp          Bugnote Edited: 0001581                      
08-18-04 15:41 tiwai          Bugnote Added: 0001583                       
10-06-04 22:10 ungod          Bugnote Added: 0002026                       
10-06-04 22:10 ungod          File Added: aureon-volfix4.diff                    
10-07-04 09:50 ungod          File Added: aureon-volfix4.1.diff                    
10-07-04 09:52 ungod          Bugnote Added: 0002028                       
10-07-04 14:43 tiwai          Bugnote Added: 0002032                       
10-07-04 14:44 tiwai          File Added: aureon-volfix4.2.diff                    
10-07-04 18:03 ungod          Bugnote Added: 0002035                       
10-07-04 21:26 skamp          Bugnote Added: 0002039                       
10-08-04 04:01 ungod          Bugnote Added: 0002042                       
10-08-04 09:31 skamp          Bugnote Added: 0002044                       
10-08-04 12:24 tiwai          Bugnote Added: 0002047                       
10-09-04 01:21 ungod          Bugnote Added: 0002059                       
10-09-04 02:00 ungod          File Added: aureon-volfix4.3.diff                    
10-09-04 02:05 ungod          Bugnote Added: 0002060                       
10-11-04 12:16 tiwai          Bugnote Added: 0002075                       
10-12-04 14:37 tiwai          Bugnote Added: 0002094                       
10-13-04 18:51 ungod          Bugnote Added: 0002132                       
10-14-04 21:08 skamp          Bugnote Added: 0002159                       
10-19-04 16:30 tiwai          Resolution               open => fixed       
10-19-04 16:30 tiwai          Status                   assigned => resolved
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
