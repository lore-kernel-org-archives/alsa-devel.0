From: Niels Mayer <nielsmayer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [LAD] announcing envy24control, mudita (*) edition.
Date: Sun, 25 Jul 2010 12:10:44 -0700
Message-ID: <AANLkTikX07nHbBsBSG04r54LEp3R+CRC9dC--aB_h2gQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <http://lists.linuxaudio.org/options/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxaudio.org/pipermail/linux-audio-dev>
List-Post: <mailto:linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>
List-Help: <mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linuxaudio.org/listinfo/linux-audio-dev>,
	<mailto:linux-audio-dev-request-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
Errors-To: linux-audio-dev-bounces-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org
To: Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Linux Audio Developers <linux-audio-dev-cunTk1MwBs/CEJeg2xFRV2D2FQJk+8+b@public.gmane.org>, linux-audio-announce@list
Cc: PlanetCCRMA mailinglist <planetccrma-l0SEpsmuUtBegcJQxxnBRDe48wsgrGvP@public.gmane.org>, fedora-music-list <fedora-music-list-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

Summary of updates from envy24control 0.6.0 (GIT HEAD) to "1.0.0":

(0) After a decade, incremented version to 1.0.0 (**)
(1) Implemented missing "Peak Hold" functionality in meters and
reimplemented meters for increased efficiency and lower X resource
usage. (see http://www.linuxaudio.org/mailarchive/lad/2010/7/12/171535
& https://bugzilla.redhat.com/show_bug.cgi?id=602903 )
(2) All volumes are represented as decibels, including the 0 to -48dB
range of the hardware peak-meters, the 0 -to- -144dB attenuation for
all inputs to the digital mixer, the 0 -to- -63dB attenuation of the
analog DAC, and the +18 -to- -63dB attenuation/amplification of the
analog ADC.
(3) All gtk "scale" widgets have dB legends; the "PageUp" "PageDown"
keys allow rapid movement between the marked levels.
(4) Got rid of myriad compile warnings and other minor fixes across codebase.

Some screenshots:
http://nielsmayer.com/envy24control/Screenshot-Envy24Control-AnalogVolume.png
http://nielsmayer.com/envy24control/Screenshot-Envy24Control-MonitorInputs.png
http://nielsmayer.com/envy24control/Screenshot-Envy24Control-MonitorPCM.png

------------

To the ALSA project: please consider this patch to alsa-tools'
envy24control (**):
http://nielsmayer.com/envy24control/envy24control-0.6-to-1.0.patch
(patch to 'envy24control' from GIT trunk/head of alsa-tools)
http://nielsmayer.com/envy24control/envy24control-1.0.README
(summary of changes from 0.6.0 to 1.0.0)

------------

Those wanting to compile directly, or run a 64 bit linux binary I've built:

http://nielsmayer.com/envy24control/envy24control-1.0.tar.gz
(full directory, just follow README directions to build/install)
http://nielsmayer.com/envy24control/envy24control-1.0-fc12-x86_64.tar.gz
(x86_64 binary that should work on fedora12 and equivalent OpenSuse release)

I'd appreciate any testing results or comments on this "1.0.0"
release. In particular, I'd like some assurance that the dB markings
on sliders in "Analog Volume" panel are correct (compared to values
reported by 'alsamixer'). I'm looking for testing with following
devices (as I think my testing covers code for M-Audio Delta 44 &
Delta 66, Terratec Dmx6fire & EWX2496) specifically:
  M-Audio Delta 1010, M-Audio Audiophile 2496, M-Audio Delta 1010LT
  TerraTec EWS 88MT, TerraTec EWS 88D, TerraTec Phase 88,
  Hoontech SoundTrack DSP 24 (all variants).

Thanks,

Niels
http://nielsmayer.com

PS:
(*) http://en.wikipedia.org/wiki/Envy#In_philosophy :: "mudita, taking
joy in the good fortune of another. This virtue is considered the
antidote to envy and the opposite of schadenfreude."

(**) http://git.alsa-project.org/?p=alsa-tools.git;a=tree;f=envy24control;h=d5a56728048135649314456191fe8559c4f68118;hb=HEAD
