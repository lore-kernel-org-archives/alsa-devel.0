From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Master Plan on rewinding
Date: Sun, 07 Sep 2014 21:16:48 +0600
Message-ID: <540C76E0.9050808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f47.google.com (mail-la0-f47.google.com
 [209.85.215.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 04A8D265119
 for <alsa-devel@alsa-project.org>; Sun,  7 Sep 2014 17:16:51 +0200 (CEST)
Received: by mail-la0-f47.google.com with SMTP id el20so7723449lab.34
 for <alsa-devel@alsa-project.org>; Sun, 07 Sep 2014 08:16:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, David Henningsson <david.henningsson@canonical.com>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
List-Id: alsa-devel@alsa-project.org

Hello.

(TL;DR: nothing really new except the strawman proposal about threads 
and the note about interaction of variable sample rate with rewindability)

As Takashi Iwai told me that the audio miniconference is for discussion 
only, and not for presentation of anything, I guess that I need to 
present the plans and options now. That's why this e-mail. The goal 
here, besides merely presenting the plan, is to identify points that 
everyone agrees upon, so that they are not discussed pointlessly at the 
miniconference. Also, this e-mail serves as a justification for the 
pending seemingly-destructive work.

First, the status quo. If anyone disagrees with the facts below, please 
complain loudly, before I make any conclusions!

1. PulseAudio does not call snd_pcm_rewindable(), because for some ALSA 
plugins it crashed. This crash is completely fixed in alsa-lib 1.0.28, 
but in some cases snd_pcm_rewindable() still returns wrong results.

2. PulseAudio blindly assumes that it can rewind up to hwbuf_frames - 
(snd_pcm_avail() + rewind_safeguard) frames. The rewind safeguard is 
needed due to reasons that I don't completely understand, but one of 
them is imprecise reporting of the hardware pointer, and another one is 
that the hardware transfers several bytes at a time, and the bytes we 
need to overwrite may be already cached by the hardware.

3. On the hw plugin, I could demonstrate two other bugs regarding 
snd_pcm_rewindable(): stale data and bogus negative return values.

4. There are ALSA plugins like "a52" or the "bluetooth" plugin from old 
version of bluez that return non-zero for snd_pcm_rewindable() and 
snd_pcm_rewind, but actually don't rewind, and where rewinding is almost 
impossible to implement (e.g. because this would seemingly involve 
unsending of already-sent bluetooth packets). See below why "almost", 
you need to search for "Alternative strawman proposal".

5. PulseAudio contains a workaround for non-rewindability of the a52 
plugin that also happens to apply to other ioplug-based plugins. 
However, this workaround does not match extplug-based plugins (including 
"dca"), and my patch extending the workaround has been rejected with the 
argument that this has to be fixed in ALSA.

6. The rate plugin has been made non-rewindable in alsa-lib 1.0.28 
because the old implementation was wrong and no simple fix exists.

7. Issues regarding rewindability of PulseAudio internals such as 
virtual sinks will be discussed separately.

And now the topics for discussion.

My immediate plan is to fix (3) and, if anyone replies to the rewind 
safeguard proposal, maybe start fixing (2) from the alsa-lib side.

For all proposals below, unless I say otherwise, I intend to write the 
required alsa-lib code myself if the proposal is accepted.

=== On the rewind safeguard ===

The consensus is that rewind_safeguard is a workaround for an ALSA bug. 
This information should come from snd_pcm_rewindable() from the hw 
plugin. I.e., on a hw device, it should not be equal to 
snd_pcm_mmap_hw_avail(). While the method of dealing with stale data and 
negative returns is obvious to me, I am not completely sure about the 
safeguard. Where should this value come from?

Proposal (credit goes to Raymond Yau): the safeguard should be ideally 
equal to the granularity of hardware pointer updates. However, we don't 
know this granularity a priori, and cannot know this because nobody will 
find out this information for old cards. Since we can't get this, let's 
instead use the upper bound: the minimum possible period size for the 
given sample rate, sample format and the number of channels.

On my desktop PC, on snd-hda-intel with analog outputs for S16LE stereo, 
the granularity is 32 bytes (= 8 samples), and I get the pointer 
granularity of 64 bytes (=16 samples) over HDMI. The minimum period size 
is 32 samples in both cases. Thus Raymond's method will overestimate the 
required safeguard on my cards, but it is still better than no safeguard 
at all, and less than the hard-coded value in PulseAudio.

On ymfpci, the pointer granularity is 5 ms, thus the value currently 
hard-coded in PA is insufficient. If I understand the card's limitations 
correctly, Raymond's method will yield the spot-on result for this card.

For the allegedly existing cards where the pointer granularity is always 
the same as the period size, Raymond's method will not work. However, I 
don't know any concrete example of such card (I didn't look at 
snd-firewire in detail, though). And in any case, my opinion is that 
this "pointer granularity = period size" limitation on such cards can be 
treated as a driver bug that needs to be fixed (by someone who knows the 
driver, not by me). On cards where pointer updates happen only on 
interrupts, the driver should not configure the card in such a way that 
one period visible to the userspace corresponds to one interrupt. 
Instead, it should always configure the card for the minimum possible 
period size, and report only part of the period interrupts to 
period_elapsed(). I.e.: userspace asked for 2 periods 64 ms each, but 
let's configure the card for, say, 64 periods 2 ms each, and use the 
"extra" interrupts only for updating the pointer.

Hopefully, the above heuristic and driver fix will also let PulseAudio 
get rid of special treatment of the "batch" cards, simply because they 
(in the "pointer granularity = period size" definition which is 
currently used in PulseAudio) will no longer exist.

If the heuristic (or something else) is accepted, then the question 
remains how to enable the use of snd_pcm_rewindable in PulseAudio. The 
problem is compatibility with older ALSA versions that, let me remind 
you, crash if snd_pcm_rewindable is called. I don't have proposals or 
opinions here. The obvious options are: compile-time alsa-lib version 
check with fallback to old code on buggy versions, run-time alsa-lib 
version check with the same fallback, add a (both compile-time and 
run-time) hard requirement of a fully-fixed alsa-lib version, or do 
nothing at all.

Possible discussion: alternative heuristics and, as mentioned, migration 
path in PulseAudio.

=== On non-rewindability of the rate plugin ===

I intend to write a rewindable resampler eventually, but don't have time 
now. I understand that it is an important task, but issues below (and 
the dayjob which you can change by offering me a new one) have higher 
priority for me. However, I want everyone to understand the following 
point now:

"The resampler has to be written from scratch for the reasons explained 
in http://permalink.gmane.org/gmane.linux.alsa.devel/122179 , and 
similar arguments apply to all other kinds of sound processing code that 
needs history."

For PulseAudio, it is also needed to figure out the desired interaction 
between variable rate and rewindability. Should rewinding other than 
"discard everything completely" be allowed at all on variable rate 
streams when the rewind crosses the sample rate change point? I.e., 
write 100 samples, change rate, write 50 samples, rewind 100 samples, 
what should be the resulting rate? Should we special-case small changes 
vs big ones?

Slightly off-topic, but still a discussion point.

=== On possibly-incomplete rewindability of the file plugin ===

The file plugin has quite hairy code involving the use of the write 
buffer. I have not verified its correctness or studied the code in 
detail. Anyway, it looks like it allows rewinding over that buffer only, 
even though its slave may allow rewinding further. If true, this would 
make the apparent rewindability useless, as the applications depend on 
being able to rewind almost everything, and won't like the 
apparently-random limitation (random because it depends on some obscure 
"wbuf" implementation detail).

I think that the plugin has to be changed to avoid this limitation if it 
really exists (which I still need to verify). Namely, I propose keeping 
a shadow copy of the slave's buffer, and, at the beginning of each API 
call, querying the slave about its hardware pointer. Only the part of 
the shadow buffer that corresponds to the distance covered by the 
slave's hardware pointer since the last call has to be written to the file.

The same applies to recording. As the code is much simpler there, it is 
obvious that the problem exists: if one rewinds in order to look at the 
past recorded samples again, the plugin will read further samples from 
the file instead of supplying the already-looked-at samples. The same 
solution with the slave hardware pointer should be applicable.

The possible discussion here amounts to suggesting alternative proposals.

=== On bogus rewindability of ladspa and extplug plugins ===

For ioplug, see below, because the situation is different enough.

Neither LADSPA nor snd_pcm_extplug_t have an API that allows to tell the 
corresponding plugin to forget the last N samples. We cannot fix LADSPA, 
as it is beyond our control. And we cannot really fix extplug, because 
this just means moving the problem down one level. External libraries 
(which are depended upon by the extplug-based plugins) are almost 
universally not rewindable, are beyond our control, and will not be made 
rewindable, because rewindability is hard and is not needed by anyone 
except ALSA and PulseAudio. Still, neither .rewindable not .rewind 
currently return 0.

So, I'd argue that the only correct result from snd_pcm_rewindable() is 
0 for ladspa and extplug plugins. However, right now, they forward the 
result from the slave. This needs to be fixed, and I have a patch.

With snd_pcm_rewind(), the situation is a bit different. It, obviously, 
does nothing to tell the LADSPA or extplug plugin that the rewind 
happened (because it can't). It also performs a rewind on the slave. So, 
assuming that the rewind succeeds and the DSP algorithm in the plugin 
uses N samples from the past, we'll end up with the output of the 
correct duration but with N corrupted samples. Not ideal. But if we 
don't perform the rewind at all and return 0, we'll end up with 
regressing PulseAudio: huge latency when applying software volume 
changes or starting new streams. By setting up the large buffer size, it 
essentially assumes that any rewind will succeed.

So, my hackish proposal is: make the .rewindable callbacks on ladspa and 
extplug return 0, keep the current implementation of the .rewind 
callback for compatibility with the current versions of PulseAudio, 
document this hack. I already have patch for this, will send out if we 
agree that the proposal is good.

An alternative proposal (that I would implement if the proposal above is 
rejected and someone actively confirms this one - but I don't like it) 
would be to keep the current versions of the .rewindable and .rewind 
callbacks and add new versions of them (and new user-visible ALSA API) 
for the situation when imperfect results are unacceptable.

A completely strawman proposal would be to introduce a low-latency 
thread, see below in the ioplug section.

Same for .forwardable and .forward.

Any other alternatives that I missed?

=== On bogus rewindability of some ioplug-based plugins ===

Ioplug-based plugins currently report rewindability according to the 
same "appl.ptr - hw.ptr" rule that is used by the hw plugin. However, 
this is incorrect.

In fact, there are two types of ioplug-based plugins. The jack plugin 
does not even have a .transfer callback, and does all the work of 
irrevocably submitting samples to the JACK server in a thread. So, it is 
almost completely rewindable (with that "almost" being equal to JACK 
buffer size). Proposal: keep this logic for all plugins without the 
.transfer callback. Expose the JACK buffer size as the minimum period 
size. Then the same rule proposed in the section about the hw plugin 
will work for .rewindable.

Other plugins do their irrevocable work in the .transfer callback and 
thus are not really rewindable. Proposal: return 0 from .rewindable and 
rewind ioplug callbacks for all plugins with a .transfer callback (but 
see the next section for an amendment). Document that the best practice 
is to have no .transfer callback.

Alternative strawman proposal (speculative): if a .transfer callback 
exists, call it from an alsa-lib-created thread (not from 
snd_pcm_writei!) at the last possible moment, using the least possible 
amount of data (that truly cannot be rewound) in the mmap-style buffer. 
The new mantra is: .transfer is the thing that moves the hardware 
pointer. This way, previously non-rewindable plugins could become 
rewindable. Not sure if this is possible without changing the ABI or 
possible at all, though - it essentially forces all plugins to declare 
mmap support. Also not sure what to do with the .pointer callback.

For the strawman proposal, the benefit is a possibility to have dmix on 
top of a52 (because freewheeling will now work), the downside is that 
all programs (not only those intending to do rewinds) now pay the cost 
of the background low-latency thread. Can we avoid this (e.g. with a new 
flag for snd_pcm_open), so that only programs that intend to do rewinds 
pay the price? Can this new flag apply to the batch hw drivers? Won't 
that inflate the test matrix for plugin code?

For discussion: do we implement the first proposal or try the strawman 
proposal? Any other suggestions regarding ioplug internals? Anyone else 
has a problem with two completely different interfaces (with and without 
.transfer) being exposed under the same ioplug framework?

=== On the pulse plugin ===

PulseAudio natively supports rewinding on the wire. However, the 
ioplug-based plugin doesn't. It pretends that it rewound something, but 
always passes 0, 0 as the last two parameters to pa_stream_write(). 
That's bad.

It looks possible (but I haven't checked) to figure out the correct 
arguments (i.e. to detect the rewinds done before the call to 
snd_pcm_writei) by looking at the application pointer. This way, it 
looks possible to support rewinds, but does not look possible to get the 
correct result (and not the result implied by the circular-buffer model) 
from the snd_pcm_rewindable() function.

Also, we apply proposals from the previous section, we'll either end up 
with a plugin that is truly non-rewindable and doesn't pretend to be 
rewindable, or (with a strawman proposal) a rewindable plugin that 
forces low latency on the PulseAudio side and causes a lot of wakeups. 
Both situations are suboptimal.

So, I see no way around adding the .rewind and .rewindable callbacks to 
snd_pcm_ioplug_callback, and treating the plugins with them as 
rewindable. I guess .forward and .forwardable should be added, too.

For discussion: do we do the above or declare that ioplug is not really 
a suitable infrastructure for the pulse plugin? What other alternatives 
can be proposed?

=== On communication of non-rewindability to the program ===

PulseAudio attempts to use timer-based scheduling and rewinds. It makes 
a big hardware buffer in expectation that it will be able to rewind - 
with the exception of a workaround for ioplug-based plugins. It should 
not set big latency for non-rewindable plugins, but currently has no 
idea how to get this bit of information. See 
http://lists.freedesktop.org/archives/pulseaudio-discuss/2014-April/020457.html 
for the initial problem statement.

If all of the proposals above are implemented, then we'll be at a point 
where each ALSA plugin is either almost fully rewindable, or not 
rewindable at all. So, contrary to the end of 
http://permalink.gmane.org/gmane.linux.alsa.devel/122191 , I think we 
need just snd_pcm_hw_params_is_seekable() (or rename it if you wish) 
with an essentially boolean result.

For discussion:

1. Decide, finally, on this bit of API, so that I can start working.

2. Decide what to do with old alsa-lib versions in PulseAudio. I.e. 
transition plan.

=== On the programmer expectations ===

(social issue)

Some people, including at least Andrew Eikum and Clemens Ladisch, at 
least once in the past expressed the opinion that amounts to "any plugin 
that does not allow random access is, as far as the ALSA API is 
concerned, buggy" (quoting 
http://permalink.gmane.org/gmane.linux.alsa.devel/122159 ), i.e. they 
are maybe asking for the impossible. We need to do something about that. 
Choices:

1. Document clearly that there exist non-rewindable plugins, and that it 
is not a bug until someone implements a working time machine.

2. Implement a strawman proposal with the background low-latency thread 
if it is doable (and I am not sure that it is doable).

3. Remove ioplug, extplug and ladspa as unfixable, fix the rate and 
adpcm plugins (or remove adpcm). Do something about pulse and jack 
because they rely on the to-be-removed ioplug infrastructure. Then all 
remaining plugins will indeed be fully rewindable.

4. Something else?

Sorry for the negative tone here, I know I am bad at formulating and 
resolving social issues.

=== Conclusion ===

When all the proposals are implemented, we'll have correct 
implementations of the rewind operation in all plugins (where "return 0" 
counts as correct), and "return 0" only where it is truly unavoidable. 
PulseAudio will be able to use all of that, and avoid doing rewinds on 
non-rewindable plugins. On this positive note, I'd like to finish 
writing this long e-mail.

-- 
Alexander E. Patrakov
