From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000410]: Cannot listen to line-in and aux at the same time
Date: Fri,  1 Oct 2004 09:15:35 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041001071535.3DF0B2A001@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id B0938246
	for <alsa-devel@alsa-project.org>; Fri,  1 Oct 2004 09:15:35 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000410
======================================================================
Reported By:                skamp
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     410
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     feedback
Distribution:               LFS 5.1.1, BLFS 5.1
Kernel Version:             2.4.26
======================================================================
Date Submitted:             07-27-2004 18:48 CEST
Last Modified:              10-01-2004 09:15 CEST
======================================================================
Summary:                    Cannot listen to line-in and aux at the same time
Description: 
I cannot listen to sound coming from line-in and aux at the same time,
since I have to switch between either one of them with the "capture"
switch.
I can't listen to both line-in or aux and pcm, for that matter, since I
have to switch H/W and H/W 1 from PCM Out to H/W In 0 and vice versa.

I have my TV plugged to line-in, and my DXR3 MPEG2 decoder plugged to aux,
and I found it convenient with my former sound card (Sound Blaster Live!
with OSS drivers) to be able to listen to either source (TV, DVD or PCM)
without unplugging my headphones or triggering any switch.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-30-2004 16:51 CEST 
----------------------------------------------------------------------
Isn't it a hardware limitation?

----------------------------------------------------------------------
 skamp - 08-01-2004 14:29 CEST 
----------------------------------------------------------------------
How would I know? I can't believe a €80+ sound card wouldn't provide this
feature anyway - if that's the case, then I've been really screwed...

----------------------------------------------------------------------
 skamp - 08-01-2004 18:00 CEST 
----------------------------------------------------------------------
OK, I just installed Windows Server 2003 in order to test Terratec's
official drivers, and I found out what I expected: the drivers and control
panel allow me to listen to as well as record from all sources (pcm,
line-in, aux...), either each one separately or all of them
simultaneously. I can actually select exactly which source(s) I want to
listen to or record from. This is the expected feature set, and it works
right out of the box.

I would like to know what is needed for bringing full support of this
sound card to linux (via alsa, I guess): documentation from the
manufacturer? time? motivation? money? more developers? user feedback?
testing?

----------------------------------------------------------------------
 tiwai - 08-02-2004 18:21 CEST 
----------------------------------------------------------------------
AFAIK, some inputs are just a connection from AC97 codec.
You can try to adjust Line, Aux, etc playback volumes and
choose 'Mix' as the capture source, so that the mixed playback
(passthru) signals on that ac97 chip is routed back to the
capture.

----------------------------------------------------------------------
 ungod - 09-28-2004 22:37 CEST 
----------------------------------------------------------------------
This is fixed in the latest CVS (See bugnote 0000510 for details)

----------------------------------------------------------------------
 tiwai - 09-28-2004 23:15 CEST 
----------------------------------------------------------------------
Ok, then close this bug now.

----------------------------------------------------------------------
 skamp - 09-29-2004 02:14 CEST 
----------------------------------------------------------------------
I just installed alsa-* from CVS: the bug is NOT fixed. I still can't
listen to both line-in AND sound coming from applications (line-out - I'm
not talking about optical-out). Besides, line-in is now monophonic,
although I can hear the sound in both speakers of my headphones.
"amixer cset numid=24 on,off" (that's the "Capture switch") returns
"values=off,on", and so does "amixer cset numid=24 off,off".
The mixer (or driver, I don't know) is also very buggy (as you predicted);
it took me about 15 minutes just to figure out how to hear sound coming
from line-in at a reasonable volume.

----------------------------------------------------------------------
 ungod - 09-29-2004 04:33 CEST 
----------------------------------------------------------------------
Weird.

As far as I know, the Sky, Space and Universe cards ought to be identical
at that point. In the latest CVS, the aureon driver should give you mixer
control to Line/CD/AUX/Mic/AC97 (AC97 being line/CD/AUX/Mic mixed
together) and a Mic boost.
In order to get both line, aux and wave sound; line, aux, ac97 and front
should be unmuted and volumes set accordingly, and the H/W and H/W 1
should be PCM Out.

At least on my Space I can hear it all, and the line in sound is perfectly
stereo.

But I see that it is actually not possible with the current drivers, to
record the AC97 mixed sound without also hearing it on the front channels
(the recorded sound should however only be the AC97 sound), but I probably
change the way at which the AC97 is muted, so that only playback sound is
muted (currently the AC97 chip itself is muted)

----------------------------------------------------------------------
 ungod - 09-29-2004 05:05 CEST 
----------------------------------------------------------------------
Well, I've made some changes, so that you may record while not listening.
Strangely however, the capture volume for left and right are not
identical, although the mixer claims so.

Well, I've uploaded a patch for the AC'97 mute, although I can't imagine
this would solve you problem, if indeed it is a driver problem.

Patch description:

Summary: Fix AC97 master mute

Instead of muting the AC97 chip and thus eliminating the possibility of
recording, muting is done by setting front playback to DAC only instead of
DAC+AUX.

Signed-off-by: Peter Christensen <ungod@developers.dk>

----------------------------------------------------------------------
 skamp - 09-29-2004 05:47 CEST 
----------------------------------------------------------------------
Still no luck. I've uploaded an updated version of aadebug's output, since
I've moved to LFS-6.0 SVN since my first bugnote.

----------------------------------------------------------------------
 ungod - 09-29-2004 07:05 CEST 
----------------------------------------------------------------------
Strange. I suppose that the mixer actually gives you the possibility of
setting the volume for Line in and AC97 etc.?! (you never know what goes
wrong)

Maybe the Space and Sky ones just different on the AC97 point.

----------------------------------------------------------------------
 skamp - 09-29-2004 07:20 CEST 
----------------------------------------------------------------------
Yes, but with no effect.

----------------------------------------------------------------------
 ungod - 09-29-2004 07:40 CEST 
----------------------------------------------------------------------
Hmmm... Have you tried the commercial drivers from 4Front
(http://www.opensound.com/) - I base lots of my knowledge on how their
drivers behave.
Anyway, they set a pin high on the board, I don't know what does, however,
just for testing, you may wish to try the following tiny patch:


--- alsa-kernel.old/pci/ice1712/aureon.c        2004-09-29
07:36:38.000000000 +0200
+++ alsa-kernel.new/pci/ice1712/aureon.c        2004-09-29
07:37:17.000000000 +0200
@@ -186,6 +186,10 @@
        snd_ice1712_gpio_write(ice, tmp);
        udelay(3);
 
+       tmp |= (1 << 13);       /* Set GPIO13 - just for testing */
+       snd_ice1712_gpio_write(ice, tmp);
+       udelay(3);
+
        memset(&ice->spec.stac9744, 0, sizeof(ice->spec.stac9744));
        for (i=0; ac97_defaults[i] != (unsigned short)-1; i+=2)
                ice->spec.stac9744[(ac97_defaults[i]) >> 1] =
ac97_defaults[i+1];

edited on: 09-29-04 07:40

----------------------------------------------------------------------
 tiwai - 09-29-2004 17:56 CEST 
----------------------------------------------------------------------
FYI: aureon-ac97mute.diff was applied to CVS.

----------------------------------------------------------------------
 skamp - 09-30-2004 05:00 CEST 
----------------------------------------------------------------------
I have tried 4Front's drivers indeed, and they work fine. I can listen to
all inputs at the same time with them.
I have applied your latest patch, with no effect.

I've found something out though: I get stereo line-in by setting H/W to
"H/W In 0" and H/W 1 to "H/W In 1". Previously I used to set them both to
"H/W In 0". I realize I've always had monophonic sound before, I just
didn't notice. The thing is, the line-in input is fed by my TV, and my
building has had quite a bad reception since a few months - I just thought
the sound was bad because of it :-/ Coincidentally, it is *after* I
started experiencing bad TV reception that I bought my new soundcard and
switched to ALSA. I re-installed ALSA 1.0.5a to check (it's the version I
had when I filled this bug report), and it had that issue indeed.

So, at least there's an improvement here, although stereo is the least I
could expect from a sound card. For crying out loud, pleaaaaase do
something to get it work right out of the box. I shouldn't have to *find
out* about the right setting just to get stereophonic sound. I have no
idea about what "H/W n" stands for (besides the fact that H/W probably
stands for "hardware"), and I don't really care.

As to knowing what introduced stereophonic line-in (which patch /
version), I can't tell, except that it's not that last patch. I'm just
wondering here: would it help if you had an Aureon 5.1 SKY at your
disposal?

----------------------------------------------------------------------
 ungod - 09-30-2004 07:55 CEST 
----------------------------------------------------------------------
Yea, naturally having the card by my side would help alot, however the 7.1
Space (the one I got) and 5.1 Sky, I am told, are almost identical. The
only thing different is that one the Sky version, only the 6 channels are
connected, though the Digital-to-analog converter still have the
capability of converting 8 channels.

Anyway, to explain you how it all ought to work. The card have one master
chip, the ice1724 as you probably know. This chip is responsible of
communicating with all other chips and the PCI bus. The chip itself
however is not capable of much more than playing back 5 sets of stereo
channels and recording 2 sets of stereo channel. Internally however, it
can route so that the two record channels (H/W 0/1 and IEC958 In L/R) are
played back on the output.

Anyway, in order to playback the computer sound this must be set to DMA.

Located on the card is another chip which does the volume settings and
mixing of all the analogue channels. Until late there has been no support
for that chip, due to a chip in-between which noone but Terratec know
entirely how works. However by looking at the 4Front drivers in work, I
figured it out.

Anyway, the final mixing of digital and analogue audio is done my the chip
with the Digital-to-analog converter. This chip has 8 analogue stereo
inputs out of which only one may be selected at a time. This is passed
through an analoge-to-digital converter and into the ice1724 (the H/W 0
and H/W 1 inputs). Besides it have 3 so called AUX channels where the
mixed analogue audio (AC97) is placed (it is also placed on the ordinary
analogue input so that you may actually record the sound too). Well, on
each output channel there is an analogue mixer which can optionally mix
the converted digital audio with an AUX channel and the selected analogue
input.
As of now, it is configured so that the front channel will mix the digital
audio with the 1st AUX input (AC97) and the rest of the channels will play
only digital audio.
I used this simple diagram myself when I needed to get an idear of the
whole: http://ungod.developers.dk/aureon.png

Things which may go wrong:
 * Due to Terratecs design choice, the access to the AC97 chip (the one
that did mixing of all analogue inputs) is purely write-only, and thus it
is impossible to know in software whether you are actually communicating
with the chip.
 * It may be so that the sky card is using the 2nd, 3rd and 4th
Digital-to-analogue converters, leaving the 1st which is by now the only
output doing analogue mixing).

I can, if you like, later when I have the time (that would be around 20.00
CEST), add so that you can manually select what to mix on the outputs in
the ALSA mixer. (used that approach myself to identify where the AC97 was
connected).

----------------------------------------------------------------------
 skamp - 09-30-2004 09:18 CEST 
----------------------------------------------------------------------
Send me an email to gcocatre at gmail.com and leave me your postal address,
I'll send you an Aureon 5.1 Sky. Want a gmail address? I have lots of
invitations left.

----------------------------------------------------------------------
 ungod - 09-30-2004 16:00 CEST 
----------------------------------------------------------------------
Although I appreciate your willingness in assisting the driver development,
I think it is quite an expensive solution to the problem. Especially
considering that I am not an official ALSA developer, but merely an eager
bug reporter with knowledge in hardware and software. At least in Denmark,
where I come from, it is quite expensive sending packages outside EU, and
in the end it would probably be cheaper just to buy the card here in
Denmark myself.

I suppose that tiwai would be the ideal person to send such things to as I
suppose he is the official developer on the ice1712/ice1724 driver.

Anyway, at least try the patch I will make tonight.

----------------------------------------------------------------------
 ungod - 09-30-2004 22:37 CEST 
----------------------------------------------------------------------
Here is the patch for you, as I promised. It gives you four new controls in
the mixer. VOUT1 Mix, VOUT2 Mix, VOUT3 Mix, and VOUT4 Mix. Here you can
select which three analogue sources you wish to mix together.

ADC = Sound from computer
AUX = Devices connected to the previously mentioned AUX channel. The AUX
on VOUT1-3 are 3 different AUX channels. On the space model only the AUX
on VOUT1 is connected (to the AC97 chip)
AIN = Selected record input channel (Line/CD/AUX/Mic/AC97)

If you would try all settings (should be sufficient just to use the VOUT1
which represents the front channel) while playing back some computer sound
and some sound on either the line or aux channel, and tell me what the
result is, we might fix or at least narrow the problem down.

----------------------------------------------------------------------
 ungod - 09-30-2004 22:40 CEST 
----------------------------------------------------------------------
Please not the initial settings too. It should be:

VOUT1 = DAC+AUX
VOUT2 = DAC
VOUT3 = DAC
VOUT4 = DAC (or maybe None)

----------------------------------------------------------------------
 ungod - 10-01-2004 01:28 CEST 
----------------------------------------------------------------------
Btw. - just wondering. Did the driver work any different if you removed the
"options snd-ice1724 model=aureon51" from the modprobe.conf?

----------------------------------------------------------------------
 ungod - 10-01-2004 01:43 CEST 
----------------------------------------------------------------------
Oh oh oh. Silly me. The problem never was in my own code, but in the
initialization string unique to the Sky. Since the init for space and sky
should differ in only one register, I didn't notice that the entire init
sequence was different. On the sky ALL GPIO pins are read-only, and thus
naturally, it is impossible to do anything with the pins.
I don't know what the original intention was, wether the whole idear
simply was to  make all unused GPIO pins read-only and then only upon
usage, should they be write-enabled, and afterwards read-only again. At
least none of the code I added did so. But since the prodigy 7.1 and
aureon 7.1 inits both make the pins write-enabled from the start, I find
it logical to do the same for the sky init, so here's the patch (you
should remove the two experimental patches as they have no purpose now):

Summary: GPIO mask fix for Aureon 5.1 Sky

Make GPIO pins write-enabled by default on Aureon 5.1 Sky

Signed-off-by: Peter Christensen <peter@developers.dk>

--- alsa-kernel.old/pci/ice1712/aureon.c	2004-09-29 07:36:38.000000000
+0200
+++ alsa-kernel.new/pci/ice1712/aureon.c	2004-10-01 01:36:21.000000000
+0200
@@ -1242,9 +1242,9 @@
 	0xff,	/* GPIO_DIR */
 	0xff,	/* GPIO_DIR1 */
 	0x5f,	/* GPIO_DIR2 */
-	0xff,	/* GPIO_MASK */
-	0xff,	/* GPIO_MASK1 */
-	0xff,	/* GPIO_MASK2 */
+	0x00,	/* GPIO_MASK */
+	0x00,	/* GPIO_MASK1 */
+	0x00,	/* GPIO_MASK2 */
 	0x00,	/* GPIO_STATE */
 	0x00,	/* GPIO_STATE1 */
 	0x00,	/* GPIO_STATE2 */

edited on: 10-01-04 01:43

----------------------------------------------------------------------
 ungod - 10-01-2004 01:55 CEST 
----------------------------------------------------------------------
Oh - let us expand that patch.
The init sequence forgot to set the "support 192kHz" bit, so here is a new
patch attached as aureon-init.diff (which also does the sky thingy)

Summary: Fix Aureon CCS init sequence

- Fix Aureon 5.1 Sky GPIO write mask bits
- Fix 192kHz bit

Signed-off-by: Peter Christensen <peter@developers.dk>

----------------------------------------------------------------------
 skamp - 10-01-2004 09:15 CEST 
----------------------------------------------------------------------
Seems like you nailed it! I can now hear both line-in (in stereo) and
line-out at the same time, after unmuting Master, Line-In and increasing
Front volume :-)
The only problem at that point, is that I can't play back sound with xmms,
I get the following message:
"** WARNING **: alsa_setup(): Sample format not available for playback:
Invalid argument"
I managed to play back movies with MPlayer, but only with the option
"-format 4096". I'm sure it can be fixed easily.

That's fabulous work Peter, thanks a lot. Now someone has to fix the
issues involving OSS and that "mmap" stuff preventing games like Quake 3
and plugins like Flash from outputing sound, but I guess this has more to
do with alsa-oss than with the driver. When all issues are sorted out with
the driver, it would be nice to make the mixer less confusing. We
certainly don't need that many sliders to tweak.

To reply to your question about the module option: no, it didn't change
anything.

BTW, I'm french and I live in Paris, so we're both in the EU.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-27-04 18:48 skamp          New Bug                                      
07-27-04 18:48 skamp          File Added: aadebug                          
07-27-04 18:48 skamp          Distribution              => LFS 5.1.1, BLFS 5.1
07-27-04 18:48 skamp          Kernel Version            => 2.4.26          
07-30-04 16:51 tiwai          Bugnote Added: 0001491                       
08-01-04 14:29 skamp          Bugnote Added: 0001515                       
08-01-04 18:00 skamp          Bugnote Added: 0001516                       
08-02-04 18:21 tiwai          Bugnote Added: 0001523                       
09-28-04 22:37 ungod          Bugnote Added: 0001958                       
09-28-04 23:15 tiwai          Bugnote Added: 0001959                       
09-28-04 23:15 tiwai          Assigned To               => tiwai           
09-28-04 23:15 tiwai          Resolution               open => fixed       
09-28-04 23:15 tiwai          Status                   new => resolved     
09-29-04 02:14 skamp          Bugnote Added: 0001963                       
09-29-04 02:14 skamp          Resolution               fixed => reopened   
09-29-04 02:14 skamp          Status                   resolved => feedback
09-29-04 02:15 skamp          Bug Monitored: skamp                         
09-29-04 04:33 ungod          Bugnote Added: 0001964                       
09-29-04 05:05 ungod          Bugnote Added: 0001965                       
09-29-04 05:05 ungod          File Added: aureon-ac97mute.diff                    
09-29-04 05:45 skamp          File Added: aadebug                          
09-29-04 05:47 skamp          Bugnote Added: 0001967                       
09-29-04 07:05 ungod          Bugnote Added: 0001968                       
09-29-04 07:20 skamp          Bugnote Added: 0001969                       
09-29-04 07:39 ungod          Bugnote Added: 0001970                       
09-29-04 07:40 ungod          Bugnote Edited: 0001970                      
09-29-04 17:56 tiwai          Bugnote Added: 0001973                       
09-30-04 05:00 skamp          Bugnote Added: 0001981                       
09-30-04 07:55 ungod          Bugnote Added: 0001982                       
09-30-04 09:18 skamp          Bugnote Added: 0001983                       
09-30-04 16:00 ungod          Bugnote Added: 0001984                       
09-30-04 22:31 ungod          File Added: aureon-vout.diff                    
09-30-04 22:37 ungod          Bugnote Added: 0001986                       
09-30-04 22:40 ungod          Bugnote Added: 0001987                       
10-01-04 01:28 ungod          Bugnote Added: 0001992                       
10-01-04 01:42 ungod          Bugnote Added: 0001993                       
10-01-04 01:43 ungod          Bugnote Edited: 0001993                      
10-01-04 01:55 ungod          Bugnote Added: 0001994                       
10-01-04 01:55 ungod          File Added: aureon-init.diff                    
10-01-04 09:15 skamp          Bugnote Added: 0001995                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
