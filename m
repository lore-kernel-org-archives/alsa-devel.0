From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Digital IO and SPDIF format
Date: Tue, 01 Feb 2011 16:03:58 +0100
Message-ID: <12de1c06449.-3167568757226561582.4620295999935056878@zoho.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id 365CD2448E
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 16:04:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

I'm currenty trying to make digital IO working for snd-usb-6fire. I figured out what the card does but I don't know how things (especially input) should be handled in alsa. Unfortunately it is relatively hard to find documentation on that topic so that I decided to ask the pros.

The card can receive the whole spdif subframe with all bits (BMW + at least channel status bit and parity bit, but I guess also the other two).
It also does receive two spdif-frames per frame (making it possible to receive f.ex. 96kHz digital audio if 6fire's sample rate is set to 48kHz)
This also leads to the fact that the 6fire does not drop spdif frames if playback device's sample rate is not very much higher than 6fire's. If the playback device's clock is a bit quicker (up to twice the speed) than the 6fire's one, the 6fire simply captures a frame (when neccesary) that contains two spdif frames.

My question is (concerning capturing):
How should I handle:
- if 6fire's clock and playback device's clock differ, should I use playback device's clock (no interpolation of samples but capturing tool might have invalid sample rate information) or the 6fire's clock (samples need to be interpolated somehow)?
- if the 6fire's clock should be used, are small clock drifts acceptable without interpolation?
- in case of interpolation: how?
- should I receive a whole spdif block (usually 192 spdif frames) and use the information I got from the block (f.ex. left/right channel bits) before copying it to alsa or should I directly copy every frame to alsa?

Concerning (also output):
Am I correct in assuming that SNDRV_PCM_FORMAT_IEC958_SUBFRAME_XX samples are formatted like in the specification (4 bit preamble, 24 bit audio data, VUCP flags)? If you know of any tool that is able to handle this format, please let me know so that I have a basis to test the whole stuff.

Thanks,
Torsten
