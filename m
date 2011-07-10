From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: HP-path handling on VIA codecs
Date: Sun, 10 Jul 2011 16:55:45 +0200
Message-ID: <CAPzVeymVP9yHBRXFfhtJpeXpnZ3e0Ad9n1Y13Z9wEzCnaPgCVA@mail.gmail.com>
References: <s5h39ih46a7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id BD3732441E
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jul 2011 14:27:18 +0200 (CEST)
Received: by wyh21 with SMTP id 21so2790671wyh.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2011 05:27:18 -0700 (PDT)
In-Reply-To: <s5h39ih46a7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, lydiawang@viatech.com.cn
List-Id: alsa-devel@alsa-project.org

2011/7/8 Takashi Iwai <tiwai@suse.de>:
> Hi,
>
> while testing with the gathered alsa-info.sh outputs, now I'm
> considering how to improve the handling of the headphone (and speaker)
> output paths.
>
> On VIA codecs, it looks like that the loopback mixer always contains
> the input from the front DAC, and the front DAC is the only DAC that
> can be mixed with loopback. =A0(It might be not always, but on many
> codecs, at least).
>
> I mean, some codecs of other vendors have a connection like:
> =A0 Input-pin(s) -> Mix1 -> Mix2 -> Output1
> =A0 DAC1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -> Mix2 -> Output1
> =A0 Input-pin(s) -> Mix3 -> Mix4 -> Output2
> =A0 DAC2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -> Mix4 -> Output2
> =A0 ....
> For such devices, you can use DAC as the volume control of each output
> channel (HP, line-out, speaker, etc). =A0So I started implementing in
> that way for VIA, too. =A0It's found as two parsed output paths,
> spec->hp_out, and spec->hp_dep_out,
>
> But later I found that VIA has only
> =A0 Input-pin(s) -> Mix1 -> Output1
> =A0 DAC1 =A0 =A0 =A0 =A0 -> Mix1 -> Output1
> =A0 =A0 =A0 =A0or
> =A0 DAC1 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -> Output1
>
> =A0 Input-pin(s) -> Mix1 -> Output1
> =A0 DAC1 =A0 =A0 =A0 =A0 -> Mix1 -> Output2
> =A0 =A0 =A0 or
> =A0 DAC2 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 -> Output2
> =A0 ...
>
> Suppose the output2 is HP, it means that you can't have an individual
> volume control via DAC2 if you want to mix the loopback.
> Now we face a dilemma: usually an individual volume control is really
> nice. =A0But, if we take the individual control, it looses the loopback,
> as these are mutual-exclusive for HP (or speaker) outputs.
>
> Thus we need to decide a policy: either
>
> A. HP has no volume unless independent mode
>
> B. Don't mix loopback to HP or others (but front-out)
>
> C. Allow to turn on/off aa-loopback mode; when loopback is enabled,
> =A0 switch the path to hp_dep without volume control (only for front).
> =A0 When loopback is disabled, switch to the direct DAC path.
>
> A is the old driver behavior, I guess. =A0B is somewhat similar to now.
> C would be smart, but need more implementation and add yet another
> mixer element.
>
> What do you think?
>
>
> thanks,
>
> Takashi
>

Personally, if I'm not misunderstanding it, I'd vote for C. I had
tried something similar for old implementation, and can tell it worked
and was easy enough to implement, AFAICT (I can resend the code if
found of any interest, since it seems to me my first mail about it
went lost, at least that's not in this mailing list archives, though
that's based on the old code, and could be useful only to exchange
ideas).

It was quite simple: I used a few new fields in struct via_spec and
two input mux controls, one for hp and one for front (to have a fine
grained control and disable/enable aa path independently for those
lines - and test if it could work this way), called "Direct Output"
and "HP Direct Output" (I chose names thinking about the sound coming
straight from analog inputs and going to analog outputs through the AA
mixer, but could be, for instance, "({Front, HP}) Output Mode" (or
"Output Source") with items labeled "Mixed with input" (or "Stereo
mixer") and "Playback only", or the like). Corresponding controls
callbacks worked on the mixer connected to each output jack and
getting input from a dac (through an audio selector) and from the aa
mixer,  choosing the right mixer basing on the control they were
invoked for, and the corresponding values in via_spec new fields:
.get() returned the (negated) value of the mute bit of aa mixer
connection in the chosen mixer connection list, and .put()
muted/un-muted such a connection if in a different state (a better
behavior would be to alternatively mute/unmute the connection to the
dac and the connection to the loopback mixer, taking care of hp state
(working on aa mixer connection only for hp mixer while in independent
mode), and, of course, there could be a single switch/mux control to
enable/disable the aa path globally).

My reason to test such a solution was some noise I constantly got (and
still get with newer code, but for Independent HP in latest version)
from my headset microphone to each such line out (front and hp), but I
can think, for instance, of someone wishing to listen to something
while recording something else from line-in and not aiming to mix both
sounds in output.

But I guess some problems could arise in actual implementation, unless
I'm overvaluing/misunderstanding them.

First of all, now there's a pair of PCM Playback controls (switch and
volume) attached to aa mixer and I'm not sure if muting connections to
it could affect those controls (specially the volume). In such a case,
they could be moved to the front dac, but this problem, if existing,
could be re-raised for hp path in independent mode (in which case
front dac and attached controls would be out of the game). An
alternative could be leaving those controls where they're now, but
reimplementing callbacks so that they could use a different nid (and
work on more than one nid at a time). This way:

- the .put callback for turning aa-loopback on/off for a certain nid
(or all affected nids at once, if only one such control existed) would
be responsible: 1. to record somewhere (accessible by via_spec) the
nid(s) to work on (quite easy with separate controls attached to each
affected mixer: the nid to gather would be just the actual one being
unmuted in the two-entries connection list of passed-in kcontrol nid
or the non loopback connection for hp mixer in independent mode), 2.
to set the right volume (not just un-muting) for the non-loopback
path(s) when switching to it (basing on pcm volume setting) and
muting/unmuting the connection(s) to aa mixer as needed;

- the .put callback for adjusting pcm volume setting would work as now
for aa mixer nid (both to let it work as expected when used as source
for output and to gather correct values from it, but also for correct
handling of capture from stereo mixer), while performing same
operations for each alternative nid, gathered from a proper list and
being non-null and different from aa mixer nid;

- the .get callback for "PCM Playback Volume" could be left untouched
(to always gather infos from the 'base' nid the control is attacthed
to).

Similar considerations could/should be done for the pcm switch, that
(now, in my case) has the effect to mute/unmute front output (only).

However, I might be missing the point since I'm not sure how those
controls are expected to work properly. Previously, with old code, I
had no PCM Playback Switch and a "standalone" PCM Playback Volume,
detached from any nid, and such seemed to work for all outputs, as far
as I remember (I should re-install old implementation to make a test);
alsa-info.sh reported following output for alsactl:


	control.31 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 255
		value.1 255
		comment {
			access 'read write user'
			type INTEGER
			count 2
			range '0 - 255'
			tlv '0000000100000008ffffec1400000014'
			dbmin -5100
			dbmax 0
			dbvalue.0 0
			dbvalue.1 0
		}
	}


Now I have both controls attached to 0x21, they seem to have effect on
front path only (throughout aa mixer - previously its connection to
front dac, for my codec, was just un-muted with an initialization
verb) and alsa-info.sh reports:


	control.9 {
		iface MIXER
		name 'PCM Playback Volume'
		value.0 22
		value.1 22
		comment {
			access 'read write'
			type INTEGER
			count 2
			range '0 - 31'
			dbmin -3450
			dbmax 1200
			dbvalue.0 -150
			dbvalue.1 -150
		}
	}
	control.10 {
		iface MIXER
		name 'PCM Playback Switch'
		value.0 true
		value.1 true
		comment {
			access 'read write'
			type BOOLEAN
			count 2
		}
	}


Similar concerns could be raised for Master Playback controls, given
some codecs (but not mine - vt2020) holds them via their aa mixer nid.

Another, possibly minor, problem, as pointed out in Lydia's answer,
could be the somewhat inconsistence introduced between newer codecs
supporting solution C and older ones unable to mute their aa mixer
without loosing their front dac (because their aa mixer is just
between their front dac and their rear green jack, but also between
front dac and hp jack when in redirected mode). Such could be simply
disregarded, taken as a consequence of a different set of supported
features; therefore, it should be possible to choose automatically
whether to create the proper control(s) for turning on/off aa-loopback
or not while parsing output paths, looking at the connection lists of
nids in a certain path, starting from an output jack and moving
towards a dac, and looking if an element (a mixer or the jack nid
itself) is found with at least two connections, one of which should be
the aa mixer nid and the other one either the front dac nid, or an
audio selector connected to it. For hp path the non-loopback
connection shouldn't be hp dac directly (not passing through a
selector), or the implementation would conflict with redirected output
if such a dac were shared, which is the case for several codecs,
specially older ones (newer ones seem to use an audio selector,
instead, for front and hp), though I'm not sure if that's the same for
all such codecs - hp_indep_shared could tell that, so that a few older
codecs could support solution C for hp only, but in such a case
solution C would behave mostly as B in current implementation, but for
redirected mode, given front stream would be 'cloned' for hp dac if
not shared, so hp could get loopback mixed in or not at whim, even if
such would be inconsistent with front being always mixed with
loopback).

Regards,

Alex
