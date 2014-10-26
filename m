From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC][PATCH 00/15 v4] OXFW driver,
 a succesor to firewire-speakers
Date: Sun, 26 Oct 2014 13:00:32 +0100
Message-ID: <20141026130032.593f268a@kant>
References: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 907FA2606A6
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 13:00:39 +0100 (CET)
In-Reply-To: <1399991272-5807-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>, alsa-devel@alsa-project.org
Cc: fenlason@redhat.com, linux1394-devel@lists.sourceforge.net, clemens@ladisch.de, ffado-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

On May 13 Takashi Sakamoto wrote:
[...]
> Currently, in ALSA, 'firewire-speakers' driver supports OXFW970/971 chipset
> which Oxford Semiconductor produced. But this driver has some restrictions:
>  - Don't support MIDI substreams
>  - Don't support substreams for PCM/MIDI capturing
> There are several devices which are based on OXFW970/971. Especially, devices
> which Behringer and Mackie produced support playback/capture PCM samples/MIDI
> messages. So firewire-speakers needs re-work to support these devices.
> 
> This patchset renames 'firewire-speakers' to 'oxfw'. Maintainers already
> agreed to rename firewire-speakers to suitable name, in my first RFC in Jan
> 2014.
> 
> 
> == Supported devices
> Currently these devices are supported:
>  * Griffin Firewave
>  * LaCie Firewire Speakers
>  * Behringer F-Control Audio 202
>  * Mackie(Loud) Onyx-i series (former models)
>  * Mackie(Loud) Onyx Satellite
>  * Mackie(Loud) Tapco Link.Firewire
[...]
> == Features
>  - Capturing/Playbacking PCM samples/MIDI messages at supported sampling
>    rates via ALSA PCM/MIDI interfaces
>  - Retrieving firewire node information via ALSA hwdep interface
>  - Locking/Unlocking kernel streaming via ALSA hwdep interface
>  - Receiving notification at starting/stopping kernel streaming via ALSA
>    hwdep interface
[...]

Hi,

here is a test report with the devices
  - LaCie FireWire Speakers,
  - Griffin FireWave
and the software
  - alsamixer,
  - audacious (using ALSA backend or Jack backend),
  - mplayer   (using ALSA backend or Jack backend),
  - jack
on top of kernel 3.17(.1).  I tested playback of stereo audio only (44.1 kHz
PCM sources; a few symphonic, rock, and electronic music pieces; stereo only).
I did not test pulseaudio, as I do not have it yet installed on my test box.
So far I ran jack only with 44.1 kHz sample rate.  The FireWave was connected
to L/R line-in of a stereo amplifier.  To test the upper channels of the
FireWave, I simply replugged the cable between FireWave's L/R, C/S, and LS/RS
ports.

First I re-tested with stock 3.17.1 because I haven't used these two devices
in a while.  After that, I pulled the following patches from
https://github.com/takaswie/sound master branch, applied them on top of 3.17.1,
and repeated the tests.
    f7c9bc4c15ea ALSA: oxfw: Add hwdep interface
    787e571d3197 ALSA: oxfw: Add support for capture/playback MIDI messages
    1868471597e6 ALSA: oxfw: Add support AMDTP in-stream and PCM capture
    42483f846ff5 ALSA: oxfw: Add support for Behringer/Mackie devices
    51fadf6db12e ALSA: oxfw: Change the way to start stream
    54a1b23d6eba ALSA: oxfw: Add proc interface for debugging purpose
    f56001836575 ALSA: oxfw: Change the way to make PCM rules/constraints
    2d07cd88a870 ALSA: oxfw: Add support for AV/C stream format command to get/set supported stream formation
    b213d30cd408 ALSA: oxfw: Change the way to name card
    4255f0663f83 ALSA: oxfw: Split control functionality to a new file
    ed98704ccad7 ALSA: oxfw: Split PCM functionality to a new file
    646b7c0dfedd ALSA: oxfw: Split stream functionality to a new file and add a header file
    b09fa32b4063 ALSA: oxfw: Move to its own directory
    3479e7136ccb ALSA: speakers: Rename to oxfw and rename some members
Later I also switched back and forth between drivers without and with the
patches, with consistent results as described below.


Results with LaCie FireWire Speakers:
-------------------------------------

The only difference in behavior between 3.17.1 and 3.17.1 plus patches is
that alsamixer displays the speakers' card and chip name differently.
Stock, i.e. snd-firewire-speakers:     Patched, i.e. snd-oxfw:
    Card: FireWire Speakers                Card: FWSpeakers
    Chip: OXFW970                          Chip: FWSpeakers
I am not familiar enough with ALSA and its applications to tell whether
this change is good or bad or immaterial; for me it does not matter.

Otherwise, I noticed no difference between stock and patched; i.e.
alsamixer shows the same single PCM volume control, the two playback
applications times two backends behave the same, and the sound files sound
the same.


Results with Griffin FireWave:
------------------------------

With snd-firewire-speakers, only the blue "FireWire" LED lights up.
With snd-oxfw, the blue LED lights up, and as soon as the card is opened by
audacious' or mplayer's ALSA backend for the first time, the red "Dolby D+PL
II" LED lights up too and stays lit until power-off or until jackd is
started.

Alsamixer displays different chip names.
Stock, i.e. snd-firewire-speakers:     Patched, i.e. snd-oxfw:
    Card: FireWave                         Card: FireWave
    Chip: OXFW970                          Chip: FireWave

Playback with snd-firewire-speakers, using ALSA:

    Channel 1 (L) is subjectively correct.

    There is distortion on channel 2 (R) channel.  The type of distortion
    depends on the audio which is played back.  It can be pops, buzzing,
    or a high continuous hissing tone (I guess a 22.05 kHz tone).   This is
    the same behavior as I remember it from the time when
    snd-firewire-speakers was merged into the mainline in 2.6.39.

    Channels 3..6 (C, S, LS, RS) are mute.
    (As mentioned above, I only tested stereo sound sources.)

Playback with snd-oxfw, using ALSA:

    Subjectively correct stereo sound on channels 1-2 (L, R), mute on
    channel 3 (C), quiet bass sound on channel 4 (S), mute on channels 5-6
    (LS, RS).

    In other words, the patches fix ALSA stereo playback on FireWave.

Playback with snd-firewire-speakers, using Jack on the first 2 channels only
(i.e. I connected out_0 with playback 1, out_1 with playback_2, and left
playback_[3-6] unconnected):

    Subjectively correct stereo sound on channels 1-2 (L, R), mute on
    channel 3 (C), quiet bass sound on channel 4 (S), mute on channels 5-6
    (LS, RS).

Playback with snd-oxfw, Jack on the first 2 channels only:

   Same as snd-firewire-speakers.

Playback with snd-firewire-speakers, using Jack on all channels (I connected
out_0 to playback_[1,3,5] and out_1 with playback_[2,4,6]):

   The first three channels (L, R, C) are alright, the next channel (S) is
   distorted in the same manner as was channel 2 (R) with ALSA 2-channel
   playback, and the last channels (LS, RS) are alright.

Playback with snd-oxfw, using Jack on all channels:

   Same as snd-firewire-speakers.


Conclusion:
-----------

In my tests, the patch set does not regress with LaCie FireWire Speakers,
does not regress with Griffin FireWave + Jack, and it fixes FireWave for
stereo playback through ALSA client applications.  Therefore and for the
much extended device support and features (which I could not test myself
due to lack of hardware), I would be glad if these patches were to be
queued up for mainline merge and am offering a

Tested-by: Stefan Richter <stefanr@s5r6.in-berlin.de> (Speakers, FireWave)

tag. Thank you,
-- 
Stefan Richter
-=====-====- =-=- ==-=-
http://arcgraph.de/sr/
