From: Niels Mayer <nielsmayer@gmail.com>
Subject: mudita24 1.02 -- improved envy24control mixer/router
	for ice1712-based sound-cards
Date: Sat, 7 Aug 2010 17:20:50 -0700
Message-ID: <AANLkTiksTwbb1+ZoAas9V2dROxo9x11Ee1wYVO_LrL4U@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51])
	by alsa0.perex.cz (Postfix) with ESMTP id DA104103806
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Aug 2010 02:20:54 +0200 (CEST)
Received: by qwi2 with SMTP id 2so6421352qwi.38
	for <alsa-devel@alsa-project.org>; Sat, 07 Aug 2010 17:20:54 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, "Tim E. Real" <termtech@rogers.com>, linux-audio-user <linux-audio-user@lists.linuxaudio.org>, Linux
Cc: PlanetCCRMA mailinglist <planetccrma@ccrma.stanford.edu>, fedora-music-list <fedora-music-list@redhat.com>
List-Id: alsa-devel@alsa-project.org

The "Mudita24" package is a modification of alsa-tools' envy24control:
an application controlling the digital mixer, channel gains and other
hardware settings for sound cards based on the ice1712 chipset  (
http://alsa.cybermirror.org/manuals/icensemble/envy24.pdf  ).   It
also displays a level meter for each input and output channel and
maintains peak  level indicators.  This utility is preferable to
alsamixer(1) for those with ice1712-based cards: M-Audio Delta 1010,
Delta 1010LT, Delta DiO  2496,  Delta 66, Delta 44, Delta 410 and
Audiophile 2496. TerraTec EWS 88MT, EWS 88D, EWX 24/96, DMX 6Fire,
Phase 88.  Hoontech SoundTrack DSP  24,  SoundTrack  DSP 24 Value,
SoundTrack DSP 24 Media 7.1.  Event Electronics EZ8.  Digigram VX442.
Lionstracs, Mediastaton.  Terrasoniq TS 88.   Partial support for
Roland/Edirol DA-2496.

Now available, version 1.02:
source: http://nielsmayer.com/envy24control/mudita24-1.0.2.tar.gz
binary:  http://nielsmayer.com/envy24control/mudita24-1.0.2.x86_64.tgz
patch: http://nielsmayer.com/envy24control/mudita24-envy24control-0.6-to-1.0.2.patch

'envy24control' is part of the "alsa-tools" package. For example,
under CCRMA's Fedora repos, it's part of
alsa-tools-1.0.22-1.1.fc12.ccrma.x86_64. This "mudita24" package
updates/replaces the alsa-tools /usr/bin/envy24control application.
The default "./configure ; make ; sudo make install" process on the
source-code leaves a binary in /usr/local/bin/envy24control and places
the man-page in /usr/local/man/man1/envy24control.1 . This means you
can still use the standard alsa-tools version in
/usr/bin/envy24control .

Screenshots (controlling either Terratec DMX6Fire or M-Audio Delta 66):
http://nielsmayer.com/envy24control/Mudita24-102-Monitor-Inputs.png
http://nielsmayer.com/envy24control/Mudita24-102-Monitor-Outputs.png
http://nielsmayer.com/envy24control/Mudita24-102-Patchbay+Router.png
http://nielsmayer.com/envy24control/Mudita24-102-Hardware-Settings.png
http://nielsmayer.com/envy24control/Mudita24-102-Analog-Volume.png
http://nielsmayer.com/envy24control/Mudita24-102-About.png

Changes since recent 1.0.0 and 1.0.1 releases:

* Peak-meter display is in dBFS, corresponding to displayed dBFS
peak-meter value and scale-widget dB labeling.

* Hardware mixer input attenuators provide more precise control to the
0 to -48dB range of adjustment, turning the associated input "off"
when the slider is moved to bottom of the scale. External MIDI control
of the hardware mixer via --midichannel and --midienhanced options
unaffected by this change.

* For M-Audio Delta series, add display of "Delta IEC958 Input Status"
under "Hardware Settings."

* Command line options --no_scale_mark, --channel_group_modulus affect
layout and presence of dB markings for sliders.
--channel_group_modulus allows override of Left/Right grouping of dB
labels for multichannel applications.

* Control of peak-meter coloring via --lights_color and --bg_color
options. Reasonable default colors used when these options are not
set. (1.0.1's use of Gtk skin to provide an automatic color choice
didn't work out that well on some systems.)

* Fixed command-line options --card and --device to allow valid ALSA
card and CTL device names
 ( https://bugzilla.redhat.com/show_bug.cgi?id=602900 ).

* Profiles created in ~/.envy24control and not "~/envy24control"
( http://bugtrack.alsa-project.org/alsa-bug/view.php?id=4738 ).

Summary of previous updates from envy24control 0.6.0 (GIT HEAD) to "1.0.2":

(1) Implemented "Peak Hold" functionality in meters; reimplemented
meters to do away with inefficient "faux LED" peak-meter display.
(2) Significantly reduced the number of timer interrupts generated by
this program by slowing down all updates to 10 per second --
previously meters updated 25x/second!
(3) All volumes are represented as decibels, including the 0 to -48dB
range of the hardware peak-meters, the 0 -to- -48dB&off attenuation
for all inputs to the digital mixer, the 0 -to- -63dB attenuation of
the analog DAC, and the +18 -to- -63dB attenuation/amplification of
the analog ADC.
(4) All gtk "scale" widgets have dB legends; the "PageUp" "PageDown"
keys allow rapid movement between the marked levels, and "UpArrow" and
"DownArrow" allow fine-adjustment.

Niels
http://nielsmayer.com

PS: Why "mudita24" ? An alternate name to avoid confusion with
"envy24control 0.6.0" until changes in this version propagate
upstream. See http://en.wikipedia.org/wiki/Envy#In_philosophy "In
Buddhism the third of the four divine abidings is mudita, taking joy
in the good fortune of another. This virtue is considered the antidote
to envy and the opposite of schadenfreude."
