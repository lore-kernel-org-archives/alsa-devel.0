From: noreply@alsa-project.org
Subject: [ALSA - driver 0000211]: Modern Sound Blaster Live! totally blocked - here is basic patch
Date: Fri, 16 Jul 2004 12:53:25 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716105325.7530E26008@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D4AF4200
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 12:53:25 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000211
======================================================================
Reported By:                Voluspa
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     211
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               homebrew
Kernel Version:             2.6.5
======================================================================
Date Submitted:             04-15-2004 20:32 CEST
Last Modified:              07-16-2004 12:53 CEST
======================================================================
Summary:                    Modern Sound Blaster Live! totally blocked - here is basic patch
Description: 
Card: Sound Blaster Live!
Chip: SigmaTel STAC9758/59

Tired of the limitations exhibited by my motherboard soundchips I went out
and bought a bulk (not boxed) "Sound Blaster Live! 5.1 Digital". /proc/pci
has it tagged as Creative Labs SB Live! EMU10k1 (rev 10).

Not aware of the fact that ALSA only supports _old_ sblive cards I
experienced the usual disgust/disbelief when the card remained mute under
a 2.5.6 kernel.

Sigh. Time to read up on things - again... Luckily there are people on
this planet with similar problems, and some have the knowledge to correct
them. Peter Zubaj is such a guy and I saw him on the archived alsa-devel
mailing list from ca two weeks ago.

The information he provided in:

http://www.mail-archive.com/alsa-devel%40lists.sourceforge.net/msg12166.html

gave another fellow basic sound; "Ya thanks I get back the Front L/R and
Center/Subwoofer output now". I can confirm the Front L/R part (don't own
any woofers) and the sound is really nice.

So, I'm uploading Peters information as a regular patch against a 2.5.6
kernel, kalled sblive-2003-ac97_codec.patch

To get 5.1 sound, apparently much more has to be done due to the lack of a
specific "channel DAC" on these new boards. Peter talks about using the
AC97 chip instead:

http://www.mail-archive.com/alsa-devel%40lists.sourceforge.net/msg12230.html

He adds a scary looking "Warning, I don't know if this will harm the
hardware or not, try at your own risk" to the first information pertaining
to emufx.c, and then talks about additional fiddling with bits in
emu10k1_main.c

I'm uploading a sblive-2003-emufx.patch and point back at Peters warning.
If I ever get a 5.1 speaker system I'll try it out myself and post the
results.

Mvh
Mats Johannesson

======================================================================

----------------------------------------------------------------------
 tiwai - 04-16-2004 11:42 CEST 
----------------------------------------------------------------------
sigh, again the big minor change of creative board...

the patch will break other boards with STAC codec and other versions
of emu10k1 boards, so they can't be accepted straightforwardly.

we'll need to detect this certain sb live board.
the revision number can be likely used for this purpose.

----------------------------------------------------------------------
 Voluspa - 04-16-2004 21:26 CEST 
----------------------------------------------------------------------
Yes, I understood about the breakage. The patch was more intended for
people like myself - on information hunt. If you need anything else
regarding revision numbers etc, just ping me.

Instead of a 'light night on town' I bought a Creative Inspire P580 5.1
speaker system today. The basic sblive-2003-ac97_codec.patch gives
(excellent) sound from Front Left, Centre and Front Right, as well as from
the so called Subwoofer. Rear Left and Rear Right are mute, but I'm not
sure about having any sound files capable of using those extras. Will
investigate the technique.

Tried the sblive-2003-emufx.patch, which didn't kill the card, but no
change in sound output. Peter is on some kind of track though... did an
occular examination of the card, and the "Philips UDA1334 2 channel DAC
used for rear channel" is not present. Only 2 chips there. The big
enchilada (SBLive) and the SigmaTel thing.

----------------------------------------------------------------------
 pzad - 04-19-2004 08:13 CEST 
----------------------------------------------------------------------
sblive-2003-emufx.patch is safe - it will not kill the card
What is (maybe) not safe is fiddling with bits in emu10k1_main.c.

sblive-2003-emufx.patch - this only copy rear output to all output
register. Maybe rear output is on other output.

fiddling with bits in emu10k1_main.c:
there is one register - AC97SLOT

for SB Live 5.1 - there are bits to enable center/lfe channels (these
channels uses AC97) and maybe there are bits to enable rear channels on
new SB Live (without rear dac).

/* 5.1: Enable the additional AC97 Slots. If the emu10k1 version
   does not support this, it shouldn't do any harm */
   snd_emu10k1_ptr_write(emu, AC97SLOT, 0, AC97SLOT_CNTR|AC97SLOT_LFE);

If you want play with it then aply sblive-2003-emufx.patch and togle bits
in this register

Audigy uses this register too and sets it to 0x03 - if you wait I will
test if this disable AC97 on Audigy (front channels).

----------------------------------------------------------------------
 pzad - 04-21-2004 08:20 CEST 
----------------------------------------------------------------------
On Audigy this register has no effect on playback through AC97.

----------------------------------------------------------------------
 Voluspa - 04-22-2004 17:49 CEST 
----------------------------------------------------------------------
The total silence has been fixed in ALSA CVS:

http://www.mail-archive.com/alsa-cvslog%40lists.sourceforge.net/msg04613.html

Perhaps this bug should be closed and another opened with the remaining
issue,
rear speaker silence.

sblive-2003-emufx.patch does not give any rear output on my card. Neither
does
a manual stepping through of all the possible values. Also, I really don't
like fiddling with bits without proper documentation. Is AC97SLOT really
0x5f on this modern card? If so, how the h... am I to guess the other
values pertaining to
CNTR/LFE or REAR_L/R?

Might as well do a horoscope to determine some values (I want
documentation!)

----------------------------------------------------------------------
 Voluspa - 05-04-2004 06:48 CEST 
----------------------------------------------------------------------
FeverybodiesI:

As of 2004-05-03 alsa cvs contains a full fix for 6 channel analog sound
(at least on my system). AC3 is really, really nice.

Great work!

----------------------------------------------------------------------
 perex - 05-04-2004 12:17 CEST 
----------------------------------------------------------------------
CVS contains updated code for latest SB Live cards.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-15-04 20:32 Voluspa        New Bug                                      
04-15-04 20:32 Voluspa        File Added: sblive-2003-ac97_codec.patch                    
04-15-04 20:32 Voluspa        Distribution              => homebrew        
04-15-04 20:32 Voluspa        Kernel Version            => 2.6.5           
04-15-04 20:33 Voluspa        File Added: sblive-2003-emufx.patch                    
04-16-04 11:42 tiwai          Bugnote Added: 0000829                       
04-16-04 16:37 pzad           Bug Monitored: pzad                          
04-16-04 21:26 Voluspa        Bugnote Added: 0000844                       
04-19-04 08:13 pzad           Bugnote Added: 0000853                       
04-21-04 08:20 pzad           Bugnote Added: 0000890                       
04-22-04 17:49 Voluspa        Bugnote Added: 0000895                       
05-04-04 06:48 Voluspa        Bugnote Added: 0001035                       
05-04-04 12:17 perex          Bugnote Added: 0001042                       
05-04-04 12:17 perex          Assigned To               => perex           
05-04-04 12:17 perex          Resolution               open => fixed       
05-04-04 12:17 perex          Status                   new => resolved     
07-16-04 12:53 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
