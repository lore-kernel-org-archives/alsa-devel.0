From: Stephen Warren <swarren@nvidia.com>
Subject: Strange control interactions on Tegra Harmony
Date: Thu, 27 Jan 2011 10:20:22 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8DD47@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate03.nvidia.com (hqemgate03.nvidia.com [216.228.121.140])
	by alsa0.perex.cz (Postfix) with ESMTP id D4B91103806
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 19:20:32 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: "Mark Brown (broonie@opensource.wolfsonmicro.com)" <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Mark,

I performed some testing on the patch to enable Harmony's internal speaker
that I recently posted, and found a few strange interactions between the
mixer controls.

The relevant controls that appear are in alsamixer are:

Headphone (mute + volume) [default: unmuted, high volume]

Speaker   (mute + volume) [default: unmuted, high volume]

Left/Right Speaker Mixer DACL/DACR/Left Bypass/Right Bypass
(switch, default muted/off)

Now, if I start playing something, and go enable Right Speaker Mixer DACR, I
hear the sound on the speaker. Muting this control turns off the speaker.
However, unmuting again doesn't turn the speaker back on.

This exact same behavior is seen for Right Speaker Mixer DACL/Left Bypass. For
Left Bypass at least, that's odd, since the ADC path shouldn't be active to
Capture anything and bypass it back, and there's no mic attached.

The Right Speaker Right Bypass control works the first and all subsequent
times. Perhaps that's something to do with it being the last entry in
wm8903.c's right_speaker_mixer[] array?

Finally, the muting either the Headphone and Speaker controls actually affects
both the headphone and speaker outputs in all cases, rather than just the
output the control is named for.

I briefly started to debug this, and notice that the SND_SOC_DAPM_SPK event
function isn't being called at all in the cases where muting doesn't toggle
as expected.

I didn't manage to trace the code through the entire ASoc code-base yet, but
initial indications were that some register writes for the speaker mixer
routing setup weren't sticking - i.e. I'd toggle a control to unmuted, exit
alsamixer, restart alsamixer, and the control wouldn't be in the state I'd
placed it.

Can you comment on this? I can certainly continue to debug it, but I figured
it might be immediately obvious to you what the problem was e.g. if the same
thing had happened on other platforms/codecs.

Thanks.

-- 
nvpublic
