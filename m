From: Lennart Poettering <mznyfn@0pointer.de>
Subject: The new mixer logic in PA
Date: Sat, 20 Jun 2009 02:21:15 +0200
Message-ID: <20090620002114.GA21956@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from tango.0pointer.de (tango.0pointer.de [85.214.72.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 89BE22436D
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Jun 2009 02:21:40 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <jkysela@redhat.com>
List-Id: alsa-devel@alsa-project.org

Heya!

During the last weeks I have been reworking the ALSA mixer and device
enumeration handling in PA to be more flexible and support more
features of usual mixers/cards then it previously did. (Previously we
just picked one simple mixer element and used it for volume and
muting; 'Master' for output; 'Capture' for input; and the ALSA device
name list we used was hardcoded). I just landed all of this in PA, and
would like to pass this at least roughly by you folks, hoping for
comments. So here's a rough overview of what's going on:

The current ALSA mixer APIs have been criticized in the past
(including by me) for their complexity and stacking of abstraction
layers. Some folks (including me) suggested reworking the ALSA mixer
APIs to simplify the APIs. After doing my research I am not so sure
anymore that this really would be of much benefit -- at least for
software like PA.

The reason for that is simply that PA has very specific needs on the
mixer interfacing: we are only interested in a subset of the potential
functionality: a) we want to do hw volume control when supported for a
specific snd_pcm_t with good granularity and range, b) we want mute
control, and c) we want to select the output/input port for a
snd_pcm_t (i.e. line-in vs. mic/speaker vs. headset). And that's about
it.

We generally don't want to support any fancier setups even if the
hardware would provide it: we don't want simulatenous output to
multiple distinct outports, we want no hw mixing, we don't want to
support legacy input sources such as CD/Phone/PCSpk..., no "3D"
features, not even input feedback. OTOH PA can do stuff other clients
cannot do, e.g. extending in softwre the capabilities of the hw if
possible and sensible. e.g. we can extend the volume control
range/granularity in software beyond the discrete steps the hw
provides.

It has been suggested to make queryable how mixer elements relate to
each other via some mixer API, possibly using the HDA codec graph
data. While that would be nice to have I believe that this information
would be much more than PA could ever need, and also certainly not
help simplicity of an API. I am hence not asking for that, what I do
ask for however is that a couple of assumptions I make stay
valid. (see below)

Given that what PA needs and doesn't need is very different from the
needs of almost all other applications needed further abstraction can
happen in PA, and doesn't need to be done in ALSA. Which is basically
the reason why I decided to do all this mixer abstraction work inside
of PA, instead of trying to get that into ALSA.

To be able to control more than just one element, PA needs to have
some minimal clue how elements are related to each other. ALSA (as
mentioned) currently doesn't provide that info, so PA must
guess. Hardcoding assumptions about how mixer elements relate to each
other of course sucks, which is why I chose to define the list of
elements PA should control plus minimal information about how they
work together in config files that can be updated more easily and that
during runtime. I tried to encode only minimal and the most obvious
assumptions.

These config files simply list a series of (simple) mixer controls and
the way how to initialize them/expose them in PA. Switches can either
be bound to always off or on, or be used to follow PA's mute status,
or be exposed as distinct options in the UI (which however almost no
switch should do). Volumes can either be bound to the minimal values,
or to 0dB or be integrated into the volume slider PA
exposes. Enumeration values can be exposed in the UI, too, but only if
that makes sense.

The most interesting part of that is probably the volume handling: for
that we go from top to botton in the list of elements in those config
files and try to set the volume on the first element marked for it,
then divide the actual volume set from our target volume and find the
next volume element and apply the remaining volume there, and so
on. What's left we then do in attenuate software.

All this mixer handling assumes that PA is the only one in charge of
volume control. Also, I assume that while I now control a substantial
part of the available mixer controls that those I don't control will
be initialized properly by "alsactl init".

Here's an example how that looks like, for implementing a Mic path
(which is the most complex path, due to the input selection stuff)

http://git.0pointer.de/?p=pulseaudio.git;a=blob;f=src/modules/alsa/mixer/paths/analog-input-mic.conf;h=2a36f2f3ace0d56910967ff7a048c0aac399c865;hb=HEAD
http://git.0pointer.de/?p=pulseaudio.git;a=blob;f=src/modules/alsa/mixer/paths/analog-input-mic.conf.common;h=b35e7af84fc0a50576bd2eca48dc4e77df0b61d6;hb=HEAD
http://git.0pointer.de/?p=pulseaudio.git;a=blob;f=src/modules/alsa/mixer/paths/analog-input.conf.common;h=6728a6ae7e00a5c60a49ae554883b0e2b9554d37;hb=HEAD

To simplifiy these rules a bit I'd like to see some cleanups in the
names used for controls:

- Some drivers have a "Input Source Select" enumeration, others a "Input
  Source" and even others "Capture Source". These could be named the same,
  can't they? Or is there any difference in their behaviour from an apps
  PoV? (There's also a "Mic Select" enum, which however probably makes
  sense to keep seperate given that it the name suggests it is only
  useful if "Mic" is activated in a capture group)

- The options of said enums are really chaotically named. That could
  really be cleaned up, and would probably be a trivial fix.

- Since the various "boost" switches effectively control the volume
  I'd prefer if they'd be exposed as volume controls with dB info
  attached. Some Boosts encode the dB info in the name, which
  sucks.

- Some cards have an element "TV Tuner", others "Video". I think that
  could be merged.

I'll prepare a patch for at least some of these suggestions. Of course
renaming controls on a big scale will break alsactl restore. Is that a problem?

There's one assumption I am currently encoding in the files I am not
really sure about. Which is that I assume that the volume level of the
surround outputs is influenced by the following volume elements if
that they exist:

  PCM -> Master -> Front, Rear, Surround, Side, Center, LFE

while if switched to headphones I assume:

  PCM -> Master -> Headphone

May I assume that? Or is sometimes the routing PCM -> Headphones,
and 'Master' does not have influence?

There's something else I was wondering, in contrast to the usual code
that makes use of the ALSA mixer's dB data I use them to do actual
calculations while previously they were just used for "enriching" the
information shown on the screen. I wonder if this is going to
backfire? How reliable is the dB data actually? [1]

For more information on how all this really works you might find this
mail I posted to the PA ML interesting:

https://tango.0pointer.de/pipermail/pulseaudio-discuss/2009-June/004229.html

It goes more into details in things which are relevant for PA folks,
probably not so much for the ALSA folks.

I'd be very interested in opinions on all of this!

Thanks,

Lennart

[1] To verify and measure the dB data I actually wrote a little tool
    that can measure the data, which seemed to yield quite correct
    information on my HDA chip:

    http://git.0pointer.de/?p=dbmeasure.git;a=tree
    http://git.0pointer.de/?p=dbmeasure.git;a=blob;f=README

-- 
Lennart Poettering                        Red Hat, Inc.
lennart [at] poettering [dot] net
http://0pointer.net/lennart/           GnuPG 0x1A015CC4
