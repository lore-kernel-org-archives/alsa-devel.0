From: Miguel Freitas <mfreitas@gmail.com>
Subject: Investigating ALC662 3stack noise
Date: Sun, 14 Aug 2011 18:30:51 -0300
Message-ID: <CAJq5o=s3Gk_EqgWD6GaYgqssa1TaRPs7OUVnp9WMJEExkNZhKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51]) by alsa0.perex.cz (Postfix) with ESMTP id F2E66249C3
	for <alsa-devel@alsa-project.org>;
	Sun, 14 Aug 2011 23:31:13 +0200 (CEST)
Received: by yib12 with SMTP id 12so2952568yib.38
	for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2011 14:31:11 -0700 (PDT)
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

Hi developers,

I'm trying to fix an annoying noise i get from my D945GCLF2D Intel
Motherboard, but only from Surround/clfe outputs, not from Front jack. Since
i'm running out of ideas i thought people here might be able to suggest some
pointers.

The problem is: whenever I change from 2ch to 6ch Channel Mode in mixer I
get the background noise in my speakers. In 2ch mode there is no noise but
that doesn't help at all since I want that pin as output.

I fail to admit Intel or Realtek would do such a horrible engineering job
(Intel is happy to say in their datasheet the motherboard has 95dB S/N
ratio). It's more like we did connect something wrong is our driver, or
failed to change some required settings, i don't know.

What I've tried so far:

1) I removed the cable to front case connectors guessing noise might be
coming from there. Nothing.

2) The motherboard/ALC662 assembly is obviously 3stack kind. I
double-checked all settings in patch_realtek.c against ALC662 datasheet.
Changing NID 0x1A from input to output, unmuting and connecting it to idx
0x01 (surround) seems like the right thing to me, afterall, I do get sound
as expected from this port.

3) To eliminate the possibility that the noise was coming from the ALC662
itself (but from a different port) I changed NID 0x0d (surround) to mute idx
01, which is the connection from NID 0x0b (that big mixer with Mic, Line,
Beeper, CD etc). The leaves just DAC PCM-2 connected and the noise is still
there.

4) Muting/lowering volume for Surround (DAC PCM-2 / NID 0x03) also has no
effect on noise.

5) Thinking that some external amplifier on motherboard might need to be
disabled I've played with EAPD and GPIOs 0,1. I can clearly see at least
GPIO 1 is routed on the motherboard, although no idea if it is just ends in
a testpoint pad or that could be a via to some internal layer. Different
settings of EAPD/GPIOs pins made no difference to noise.

So that is pretty much the point i'm now. I'm starting to consider soldering
another jack to unused Port-A (surround) pins... but that would be kind of
rude, don't you think so? :-)

Any ideas are very welcomed...

regards,

Miguel
