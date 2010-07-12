From: Niels Mayer <nielsmayer@gmail.com>
Subject: FIxed alsa-tools' envy24control missing peak level
	meters and "Reset Peaks"
Date: Mon, 12 Jul 2010 15:41:15 -0700
Message-ID: <AANLkTimVnkZjBLxxhx4I8OtFiu9oOH0cPpX4V9wNimIa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 03A26103825
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 00:41:17 +0200 (CEST)
Received: by vws9 with SMTP id 9so4926841vws.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2010 15:41:15 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Linux Audio Developers <linux-audio-dev@lists.linuxaudio.org>
Cc: PlanetCCRMA mailinglist <planetccrma@ccrma.stanford.edu>, fedora-music-list <fedora-music-list@redhat.com>
List-Id: alsa-devel@alsa-project.org

I've been long annoyed by alsa-tools' envy24control (*) lack of
peak-level indication in it's metering, and the non-implementation of
its "Reset Peaks" button:
https://bugzilla.redhat.com/show_bug.cgi?id=602903

I've fixed that annoyance. Now, a small white line appears above the
highest level on each meter, and can be reset via "Reset Peaks"
button.

Original source:
http://git.alsa-project.org/?p=alsa-tools.git;a=blob_plain;f=envy24control/levelmeters.c;hb=HEAD
Patch:
http://nielsmayer.com/npm/602903.patch

To run this version of envy24control grab the most recent stable release (
ftp://ftp.alsa-project.org/pub/tools/alsa-tools-1.0.23.tar.bz2 ) or git pull
from trunk of the "alsa-tools" project (
http://alsa-project.org/main/index.php/GIT_Server ).

After unpacking and assuming you've got the patch in ~/602903.patch do:
>> cd alsa-tools-1.0.23
>> cat ~/602903.patch | patch -p1

it should give message "patching file envy24control/levelmeters.c" ...
follow the directions to compile alsa-tools....

Can whoever's in charge of these things commit this change "upstream"
and get it to propagate to the distros?
Alternately, give me commit access and I'll do it myself, if people
agree this patch is worth having.

Next steps:

(1) Think about building-in meter ballistics from Fons Adriaensen's
jkmeter ( http://www.kokkinizita.net/linuxaudio/downloads/jkmeter-0.4.0.tar.bz2
). Which helps implent Bob Katz' "K System" (
http://www.digido.com/level-practices-part-2-includes-the-k-system.html
). Although it probably most makes sense to implement such metering on
the main "digital mixer" meter of envy24control, if it's not too
inefficient, I'd want it available on all meters, despite the warning
from Fons ( http://old.nabble.com/First-release-of-jkmeter-td18798950.html
).
> This is the type of meter you want for live recording,
> mixing and mastering. It probably makes no sense to
> use it on all tracks of a DAW, where keeping digital
> level within limits is the main purpose of metering.

(2) Fix https://bugzilla.redhat.com/show_bug.cgi?id=602900 which
causes 'envy24control' to crash when given "-D" argument.
and behave incorrectly when given a correct non-numeric name for an
audio device: e.g.
>> envy24control  --card M66
>> invalid card type (driver is USB-Audio)
>> envy24control --card M66 --device M66
>> Segmentation fault (core dumped)

(3) Apply more reasonable defaults and automatically size to correct
dimensions. I use, for example:
>> envy24control --card 2 --outputs 4 --input 4 --pcm_output 8 --view_spdif_playback --midichannel 1 --midienhanced --window_width 1275 --tall_eq_mixer_heights 1 &

(4) Add midi output, in addition to midi input, which would monitor
the hardware peak metering from the ice1712
("amixer -c M66 cget iface=PCM,name='Multi Track Peak',numid=45")
and output a MIDI note-on on the corresponding MIDI channel whenever a
specified threshold value was exceeded. This could be used to
implement "automatic gain control" in association with the
midi-controllable ADC gain provided by envy24control.

Niels
http://nielsmayer.com

PS: (*)  http://alsa.opensrc.org/index.php/Envy24control
Cards supported by this fix:
                       *  M Audio Delta 1010
                       *  M Audio Delta 1010LT
                       *  M Audio Delta DiO 2496
                       *  M Audio Delta 66
                       *  M Audio Delta 44
                       *  M Audio Delta 410
                       *  M Audio Audiophile 2496
                       * TerraTec EWS 88MT
                       * TerraTec EWS 88D
                       * TerraTec EWX 24/96
                       * TerraTec DMX 6Fire
                       * TerraTec Phase 88
                       * Hoontech SoundTrack DSP 24
                       * Hoontech SoundTrack DSP 24 Value
                       * Hoontech SoundTrack DSP 24 Media 7.1
                       * Event Electronics, EZ8
                       * Digigram VX442
                       * Lionstracs, Mediastaton
                       * Terrasoniq TS 88
