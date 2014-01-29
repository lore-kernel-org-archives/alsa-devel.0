From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Regression due to 6169b673618b "ALSA: hda - Always
 turn on pins for HDMI/DP"
Date: Wed, 29 Jan 2014 16:34:11 -0700
Message-ID: <52E98FF3.80707@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from avon.wwwdotorg.org (avon.wwwdotorg.org [70.85.31.133])
 by alsa0.perex.cz (Postfix) with ESMTP id AA5AC2652A2
 for <alsa-devel@alsa-project.org>; Thu, 30 Jan 2014 00:34:15 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi,

It looks like commit 6169b673618b "ALSA: hda - Always turn on pins for
HDMI/DP" has caused a regression on NVIDIA graphics cards. It's been
reported to us by at least two separate users.

On NVIDIA GPUs, it appears that if multiple pin complex widgets have
their input mux set to the same audio output widget and PIN_OUT, then
only one of the pin complex widgets will actually receive the audio.
That's the reason we need to dynamically toggle PIN_OUT on and off, so
that only actually active pin complex widgets are enabled. Without this,
audio will be routed to the same pin complex all the time, rather than
the user-selected device. I'm not sure if this is the way HDA CODECs are
meant to work, but it certainly is how they do work:-)

So, I'd like to basically revert 6169b673618b "ALSA: hda - Always turn
on pins for HDMI/DP", and return the code to the state it was after
commit 384a48d71520 "ALSA: hda: HDMI: Support codecs with fewer cvts
than pins". However, I obviously don't want to re-introduce the
regression that your commit solved. I think we should solve this by
including the code for both behaviours in the kernel, and having either
a flag in struct hdmi_spec, or some extra ops in struct hdmi_ops, select
between the two paths. Does that seem reasonable?

If so, the only remaining question is: which behaviour should be default
a/k/a should I blacklist the problematic GM965 (mentioned in
https://bugzilla.kernel.org/show_bug.cgi?id=51421) against having the
dynamic PIN_OUT behaviour, or whitelist NVIDIA GPUs as requiring the
dynamic PIN_OUT behaviour? I know that my patch worked fine on my wife's
Intel chipset, but I have no idea if the dynamic PIN_OUT behaviour was
actually needed there, or simply tolerated, and I have no way to test
much aside from NVIDIA GPUs. That all said, the dynamic PIN_OUT
behaviour seems to make most sense to me, or some systems may end up
with audio being sent to multiple outputs when only one was expected.
