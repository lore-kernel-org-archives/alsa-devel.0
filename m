From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000214]: ac3 passthrough not working
Date: Tue, 12 Oct 2004 12:55:46 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20041012105546.97C7E18009@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id BB6A529F
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2004 12:57:08 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000214
======================================================================
Reported By:                m_stolle
Assigned To:                
======================================================================
Project:                    ALSA - driver
Bug ID:                     214
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.4.25
======================================================================
Date Submitted:             04-16-2004 05:06 CEST
Last Modified:              10-12-2004 12:55 CEST
======================================================================
Summary:                    ac3 passthrough not working
Description: 
I have a Dell Inspiron 8200 with an Intel ICH3/Cirrus Logic CS4205 sound
card.  Unfortunately, the hardware AC3 passthrough does not work. 
Instead, I only get a high-pitched funny noise.

The symptoms are the same in mplayer as well as in xine.  Verbose output
of mplayer provided below:
======================================================================

----------------------------------------------------------------------
 m_stolle - 09-11-2004 05:25 CEST 
----------------------------------------------------------------------
This bug is still present in 2.6.8.1  Am I the only one with this bug?

----------------------------------------------------------------------
 tiwai - 09-13-2004 15:41 CEST 
----------------------------------------------------------------------
How about ALSA-1.0.7rc1?  2.6.8.1 includes the older version.

----------------------------------------------------------------------
 m_stolle - 09-17-2004 05:05 CEST 
----------------------------------------------------------------------
I just recompiled alsa 1.0.7rc1

still same problem 8-(

----------------------------------------------------------------------
 stoffel - 09-17-2004 10:45 CEST 
----------------------------------------------------------------------
I have the same notebook and the same problem with SuSE 9.0 and alsa 1.06a
(kernel 2.4.27). So, any solution for that problem ?

 The 5.1 sound works without passthrough with following entry in
.xine/config

audio.alsa_a52_device:iec958:AES0=0x4,AES1=0x82,AES2=0x0,AES3=0x2.

First I start mplayer with

#mplayer -ao alsa1x:spdif dvd://
.

After that I could start xine and my 5.1 Soundsystem works (without
passthrough !!!)
 
I don't know how I get the information for the xine entry. I still probe
many tools for alsa & co and so I've got the information. Where ? I don't
know, sorry.

edited on: 09-17-04 10:43

edited on: 09-17-04 10:45

----------------------------------------------------------------------
 m_stolle - 09-17-2004 14:12 CEST 
----------------------------------------------------------------------
I have tried recreating those steps, but it still doesn't work.  I first
start mplayer with exactly the options you describe (no sound though?). 
Then I edited .xine/config, started xine, switched to 5.1 surround
(instead of stereo 2.0), restart xine, no more sound.  Redid the mplayer
command, started xine again, still no sound.

Which version of xine/mplayer are you using?  AFAIK, the alsa1x driver for
mplayer is not used anymore, it's just alsa ?  My Xine version is 0.99.1,
my mplayer version is   1.0pre5-3.3.4.

Thanks,
  Martin

----------------------------------------------------------------------
 stoffel - 09-18-2004 16:55 CEST 
----------------------------------------------------------------------
Hello m_stolle,

my mplayer version is  1.0pre4-3.3.1 and it works fine with mplayer and
the alsa1x:spdif option. With xine (since version 0.98, I beleave) I must
probe something. Most of the time it will be work, sometime it doesn*t
;-(. But anytime with mplayer. 
The 5.1 output by the laptop is on the left side (video and audio -> av
adapter ). This output I connect with a 5.1 System (loudspeaker with an
internal 5.1 decoder). Because the passthrough don't work, the 5.1 system
play the 5.1 sound from the laptop (notebook). The internal decoder of the
5.1 system will not be use.

Sorry, for the bad english. I need a new course in english.I hope you
understand me ;-).

stefan

edited on: 09-18-04 16:54

edited on: 09-18-04 16:55

----------------------------------------------------------------------
 m_stolle - 09-18-2004 17:50 CEST 
----------------------------------------------------------------------
I think I understand you, but I am not sure what you mean.  The Inspiron
8.2k does not have a 5.1 output, only a digital S/PDIF output (via dongle
on the left side).  In general, when playing a DVD using software, there
are two ways the sound can get out of the computer:  Either a Software
surround (AC3/DTS) decoder is used and the decoded sound is to a sound
card with multiple discrete analog outputs (not possible on I8.2k, because
no such sound card), OR, the digital sound is "passed-through" to the
S/PDIF and decoded by an external decoder.  I am assuming your speakers
have a built-in digital decoder and use the S/PDIF output via the dongle. 
Hence, you _ARE_ using pass-through.  Pass-through means bypassing the
software decoder and using an external decoder.

Maybe we should take this discussion off this bug-trackign system, can you
eMail me at mstoll@sus.mcgill.ca ? (In case you are German, you can eMail
me in German, as I am German, too)

----------------------------------------------------------------------
 tiwai - 09-20-2004 17:44 CEST 
----------------------------------------------------------------------
As tests, try ac3dec included in alsa-utils package.
(Run with -C option.)

This eliminates an ambiguous factor (the difference of apps).

----------------------------------------------------------------------
 stoffel - 09-20-2004 19:55 CEST 
----------------------------------------------------------------------
Maybe you are right ;-). The internal decoder is by mplayer or xine. I
don't know why, but I've got 5.1 Sound over the left output (av - adapter;
in the middle a yellow plug for video and on the side a same plug for
audio) without passthrough !!! Our Laptop is a dell inspiron 8200. If I
switch on passthrough I've got the same ugly noise like you get.
Sorry is the only thing I can tell you.

----------------------------------------------------------------------
 m_stolle - 09-20-2004 20:18 CEST 
----------------------------------------------------------------------
I should clarify:  in general my S/PDIF works.  When I play mp3s, I get
2-channel PCM output just fine.  Also, when I watch a DVD with
xine's/mplayer's _SOFTWARE AC3 DECODER_, I get sound out of S/PDIF.  But
it is _NOT_ 5.1 surround sound.  It is in fact 2-channel PCM stereo,
downmixed to 2.0 from the decoded 5.1 output by the software decoder.

Depending on Stoffel's stereo system, this sound might still come out of
all 5 speakers, but it is NOT 5 discrete channels, but rather 2 discrete
channels output over multiple speakers.

I don't know how ac3dec is going to help at all... ac3dec is a software
ac3 decoder.  I do NOT want to decode the AC3 stream, since the sound card
cannot output multiple channels.  It can only PASS-THOUGH that AC3 sound
on the DVD over the S/PDIF output.  (For example, it is entirely
impossible to play a game with surround sound on the I8.2k, since it
cannot output multiple streams, and encoding multiple streams as AC3 and
outputting over the S/PDIF is too CPU intensive to be done in realtime...
and no game has support for this.)

So, while I can output a downmixed 2.0 PCM Stereo mix over the S/PDIF, I
cannot output a full 5.1 AC3 surround signal over S/PDIF. (and I highly
doubt Stoffel can, either!)

MST

----------------------------------------------------------------------
 tiwai - 09-21-2004 11:55 CEST 
----------------------------------------------------------------------
ac3dec in alsa-utils does ac3-passthru when the relevant option is given.

----------------------------------------------------------------------
 m_stolle - 09-21-2004 14:44 CEST 
----------------------------------------------------------------------
So I ran a series of text with AC3DEC, unforunately not very promising:

======================================================================
mstoll@martin1:/mnt/cdrom/Movies$ extract_ac3 thx_tex2.vob | ac3dec -4
5.1 Mode 48.0 KHz 384 kbps Complete Main Audio Service
Using PCM device 'plug:surround40'

External Decoder says: "PCM"
Output from Speakers: Stereo
(I guess expected, since I don't have 4 channel analog output)

======================================================================
mstoll@martin1:/mnt/cdrom/Movies$ extract_ac3 thx_tex2.vob | ac3dec -6
5.1 Mode 48.0 KHz 384 kbps Complete Main Audio Service
Using PCM device 'plug:surround51'
ALSA lib pcm_params.c:2096:(snd_pcm_hw_refine_slave) Slave PCM not usable
Broken configuration for this PCM: no configurations availableOutput open
failed

No sound output (d'oh)

======================================================================
mstoll@martin1:/mnt/cdrom/Movies$ extract_ac3 thx_tex2.vob | ac3dec -C
Using PCM device 'plug:iec958:{AES0 0x2 AES1 0x82 AES2 0x0 AES3 0x2}'
AC3 Stream 48.0 KHz 384 kbps

External Decoder says: "PCM"
Output from Speakers: High pitched funny noise (like from DVD)

======================================================================
mstoll@martin1:/mnt/cdrom/Movies$ extract_ac3 thx_tex2.vob | ac3dec -P
Using PCM device 'plug:iec958:{AES0 0x87 AES1 0x0 AES2 0x0 AES3 0x0}'
AC3 Stream 48.0 KHz 384 kbps

External Decoder says: "PCM"
Output from Speakers: High pitched funny noise (like from DVD)

======================================================================
mstoll@martin1:/mnt/cdrom/Movies$ extract_ac3 thx_tex2.vob | ac3dec -R
5.1 Mode 48.0 KHz 384 kbps Complete Main Audio Service
Using PCM device 'plug:iec958:{AES0 0x0 AES1 0x82 AES2 0x0 AES3 0x2}'

External Decoder says: "PCM"
Output from Speakers: Stereo

======================================================================

So I guess the results from ac3dec confirm the results from the media
players... ac3-passthrough doesn't work.  The digital output only output
sound in PCM stereo, but not in compressed Surround Sound.

Martin

----------------------------------------------------------------------
 m_stolle - 09-21-2004 14:47 CEST 
----------------------------------------------------------------------
I should clarify "Decoder says:"  My external digital decoder displays what
kind of audio it is receiving on the digital input.  Most of the time it's
"PCM" and I only have Stereo output.  However, when playing a DVD in
Windows, using the S/PDIF passthrough option in WinDVD, the external
decoder says "Dolby Digital" or "DTS" depending on the DVD, and I get full
5.1 surround sound.

Martin

----------------------------------------------------------------------
 m_stolle - 09-21-2004 14:53 CEST 
----------------------------------------------------------------------
Oh, another observation (sorry for not condensing it into one eMail, I
guess I am not very organized):

In AlsaMixer, I have an IEC958  mixer control. I can't set the volume on
that, but I can "mute".  In that case, no more sound comes out of my
external speakers and the Digital Decoder says "Unknown".  However, when I
instruct mplayer to use passthrough, or use ac3dec -C, then I again get a
high-pitched noise and the display on the external decoder says "PCM". 
This means, I guess, that the AC3 pass-through part of the ALSA driver
overrides the IEC958 control in alsamixer.  In some sense, this is the
correct thing to happen, since when using AC3 passthrough, the regular PCM
sound (which is controlled through that IEC958 mixer) cannot come out of
the S/PDIF at the same time.  However, somehow when doing AC3 passthrough,
the right flags/registers/whatevers are not set on the sound card, so that
it doesn't identify the digital stream as AC3.  As a result, the external
decoder tries to decode the AC3 stream as PCM.  (At least that's my theory
about what's going on)

Martin

----------------------------------------------------------------------
 tiwai - 09-21-2004 15:07 CEST 
----------------------------------------------------------------------
Well, you seem confused indeed :)
There is no volume control for IEC958, of course.  That's digital.

Usually this kind of bug happens when the IEC958 status bits are not
transferred
correctly to the receiver even if the proper data signal is sent.  Some
receivers
check the signature bytes and detect the AC3 signals regardless of IEC958
setting.  But some recevers don't.
Another possibility is that the signal is modified via SRC, but this is
not
the case on ICH chip, which itself doesn't do SRC.

Please check /proc/asound/card0/codec97#0/ac97#0-0+regs file during
playing AC3
via ac3dec -C.  Also, run iecset during it, too.  They will show whether
the IEC958 status bits are set correctly by "iec958" (alias "spdif") PCM
interface.

Also, attach /proc/asound/card0/codec97#0/ac97#0-0 and /etc/asound.state,
too,
for more information.

----------------------------------------------------------------------
 m_stolle - 09-21-2004 16:01 CEST 
----------------------------------------------------------------------
I have uploaded the files with the contents of the commands you were
looking for.  I hope they help.  I am not sure if "non-audio" is the
correct thing... maybe it is, in which case the problem would be somewhere
deeper down?

----------------------------------------------------------------------
 m_stolle - 10-12-2004 06:23 CEST 
----------------------------------------------------------------------
This bug report has become quiet.  Any progress?  Anything I should try?

Thanks,
  Martin

----------------------------------------------------------------------
 tiwai - 10-12-2004 12:55 CEST 
----------------------------------------------------------------------
I don't see problems in the registers, but this might be a CS42xx
specific issue.

Please try the following (as root):

  # echo 2a 0208 > /proc/asound/card0/codec97#0/ac97#0-0+regs

This is possible only when you compiled with CONFIG_SND_DEBUG
(--with-debug=full in configure script).

Then play 48k AC3 via ac3dec -C.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
04-16-04 05:06 m_stolle       New Bug                                      
04-16-04 05:06 m_stolle       Distribution              => Debian          
04-16-04 05:06 m_stolle       Kernel Version            => 2.4.25          
09-11-04 05:25 m_stolle       Bugnote Added: 0001744                       
09-13-04 15:41 tiwai          Bugnote Added: 0001747                       
09-17-04 05:05 m_stolle       Bugnote Added: 0001775                       
09-17-04 10:21 stoffel        Bugnote Added: 0001776                       
09-17-04 10:42 stoffel        Bugnote Added: 0001778                       
09-17-04 10:43 stoffel        Bugnote Edited: 0001776                      
09-17-04 10:43 stoffel        Bugnote Deleted: 0001778                     
09-17-04 10:45 stoffel        Bugnote Edited: 0001776                      
09-17-04 14:12 m_stolle       Bugnote Added: 0001779                       
09-18-04 16:52 stoffel        Bugnote Added: 0001782                       
09-18-04 16:54 stoffel        Bugnote Edited: 0001782                      
09-18-04 16:55 stoffel        Bugnote Edited: 0001782                      
09-18-04 17:50 m_stolle       Bugnote Added: 0001783                       
09-20-04 17:44 tiwai          Bugnote Added: 0001791                       
09-20-04 19:55 stoffel        Bugnote Added: 0001793                       
09-20-04 20:18 m_stolle       Bugnote Added: 0001794                       
09-21-04 11:55 tiwai          Bugnote Added: 0001797                       
09-21-04 14:44 m_stolle       Bugnote Added: 0001803                       
09-21-04 14:47 m_stolle       Bugnote Added: 0001804                       
09-21-04 14:53 m_stolle       Bugnote Added: 0001805                       
09-21-04 15:07 tiwai          Bugnote Added: 0001806                       
09-21-04 15:54 m_stolle       File Added: ac97                             
09-21-04 15:56 m_stolle       File Added: ac97+regs                        
09-21-04 15:56 m_stolle       File Added: iecset                           
09-21-04 15:56 m_stolle       File Added: asound.state                     
09-21-04 16:01 m_stolle       Bugnote Added: 0001807                       
10-12-04 06:23 m_stolle       Bugnote Added: 0002087                       
10-12-04 12:55 tiwai          Bugnote Added: 0002089                       
======================================================================


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
