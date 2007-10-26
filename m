From: "Sean McNamara" <smcnam@gmail.com>
Subject: [PATCH] Fix for assertion in pulse plugin when calling
	hw_params on a prepared stream
Date: Fri, 26 Oct 2007 12:04:05 -0400
Message-ID: <74eb1fe20710260904w61553248v1e76c470c6bf81c2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 0EC8A24341
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 18:04:08 +0200 (CEST)
Received: by nf-out-0910.google.com with SMTP id b21so723336nfd
	for <alsa-devel@alsa-project.org>; Fri, 26 Oct 2007 09:04:07 -0700 (PDT)
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,

I have opened a bug and recently submitted a patch for it on bugtrack:
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3470

All the details are there. But here is a 5-minute summary for you:

--The Problem--
(1) All plugins implementing the PCM interface, that I've tested so far,
allow calling snd_*_hw_params on a stream when snd_*_state returns
SND_PCM_STATE_PREPARED.
(2) Applications have used this fact to their advantage, and sometimes
employ lazy initialization of the hw params (initialize it once, get to
another path in code, oh no wait! we need to initialize them differently...)

(3) Per the spec, calling snd_*_hw_params also makes the stream PREPARED, so
calling snd_*_hw_params on a stream that has _either_ been explicitly
prepared, _or_ had its hw_params previously set, will trigger this problem.
(4) The ALSA<->PulseAudio plugin is an exception to (1) above; i.e., it
triggers an assertion when exercising this functionality, as if to say, "I
can't do that!"
(5) Indeed, the PulseAudio client API forbids re-initialization of the
parameters in question on a PulseAudio stream, after instantiation.

--The Solution--
Only perform the assertion if snd_pcm_state(io->pcm) !=
SND_PCM_STATE_PREPARED.
The assertion is still useful for cases where the stream is mysteriously
non-NULL and the stream has not already been prepared; I can't think of a
valid case where:
(1) The state is not SND_PCM_STATE_PREPARED, and
(2) The underlying PulseAudio stream (pcm->stream) is non-NULL, and
(3) snd_pcm_hw_params would be expected to do anything meaningful or
correct.
For this reason, I kept the assertion in, rather than just removing it
(which by itself "fixes" the problem with alsaplayer and my test case, which
is submitted with the patch.)

--Why It Works--
(1) This assertion might be a throwback from before ioplug was so smart; but
apparently, ioplug will now call pulse_prepare, which reinitializes the
underlying pulseaudio stream, after pulse_hw_params.
(2) There is nothing in pulse_hw_params that actually requires any
particular state out of pcm->stream. The underlying pulse stream is simply
not used in this call.
(3) ioplug catches the fact that the hw_params have been changed, and calls
back to pulse_prepare to handle the underlying stream teardown and
reinitialization (which pulse_prepare does correctly).

--Impact--
(1) At least one open source application, alsaplayer, can now play through
the ALSA<->PulseAudio plugin, where it could never do so before.
(2) The ALSA<->PulseAudio plugin is now more tightly compatible with the
other alsa-lib and alsa-plugin backends (dmix, hw, asym, oss, jack, ...)
(3) Older versions of sox might have also suffered from this bug, according
to information here: http://www.pulseaudio.org/ticket/120 (although the
Ubuntu 7.10 version of sox does not exhibit this behavior).

--Notes--
(1) I submitted a first-attempt patch that fixed the problem, but it was
inefficient: it needlessly called pulse_prepare _prior_ to the main
pulse_hw_params function body. This was a result of my lack of understanding
of how ioplug was actually saving me from disaster in the background. Be
sure to grab 2_pcm_pulse.c.patch rather than pcm_pulse.c.patch.
(2) I tested both positive and negative cases; the ALSA<->PulseAudio plugin
works with applications that hit the modified code, as well as applications
that don't. I've tested both branches of the conditional I added.

Thanks,

Sean
