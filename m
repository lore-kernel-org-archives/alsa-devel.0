From: Juhana Sadeharju <kouhia@nic.funet.fi>
Subject: SB Live capture and effects
Date: Mon, 21 Oct 2002 10:54:12 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021021075412Z12568-25317+527@nic.funet.fi>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello. I tried the settings given in the following table
(and minor variations). It does not work.

name                   | capture switch | mute switch | level
-------------------------------------------------------------
PCM                    | <none>         | off         | 100
Line LiveDrive         | on             | <none>      | 0
Line LiveDrive Capture | <none>         | <none>      | 100
Capture                | off            | <none>      | 0
Mix                    | on             | <none>      | 0
AC97 Capture           | <none>         | <none>      | 0

What I should do now?

 -*-

It was said emu10k1 runs at 48000 Hz. What then happens when I record
at 44100 Hz? Who does the 48000-to-44100 Hz conversion?

I did not mean the MS Windows SB Live driver effects should be
included to Alsa distribution. Each SB Live owner would select and
extract the wanted effects from their own "windows/system/sblfx.dll"
driver file. The effects are in COM packets as described in the
documentation -- are there software to extract individual COM packets
and their subentries from dll files? As far as nobody tries to find out
how the effects works, it could not be reverse engineering at all.

Following effects are listed in "sblfx.dll":
 ac3pass, Auto Wah, Chorus, Fuzz, Panning Echo, FDNReverb-EAX2.0,
 Stereo Flanger, Freak Shifter, Parametric EQ, Peak Meter, PitchShift,
 Record Dither, RingMod, SB2Mixer, SBLTone4, SB2SpeakerSpatializer,
 SB4Mixer, SBLTone4, SB4SpeakerSpatializer, SB5Mixer, SBLTone5,
 SB5_1SpeakerSpatializer, HeadphoneSpatializer, Surround Encoder,
 SurroundSpatializer, Formant Filter.

The freeverb is Scroeder/Moorer type comb+allpass reverb, but
SB Live has Jot type FDN reverb. DAFX '01 had a paper presenting
another reverb by Creative people. I don't know if that reverb is
available in the latest driver updates. Could somebody check their
SB Live driver for the effect names? Thanks.

Best regards,

Juhana


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
