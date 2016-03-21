From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v2 0/2] ASoC: codecs: add support for TAS5720 digital amplifier
Date: Mon, 21 Mar 2016 12:08:25 -0500
Message-ID: <1458580107-4632-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Andreas Dannenberg <dannenberg@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Driver for TI's TAS5720L/M digital audio amplifiers. The driver should be
pretty standard except the optional interrupt-based fault reporting.

Some background on the fault reporting since that might be a discussion of
interest. The code should have that documented rather well but I wanted to
bring it up right away. The TAS5720 devices can report conditions such as
over-current (short), over temp, and others that can be important to know in a
real-world system. However the device lacks a way to mask the generation of
fault interrupts except by shutting it down, which can lead to cases where the
device generates SAIF-fault host interrupts every 300us! This is clearly a lot
of overhead to be thrown at the SoC (and my bench testing has demonstrated
that) so after trying different things to tame this behavior I ended up
implementing method to disable/enable the interrupts in the driver itself in
combination with rate-limiting the processing of those events.  The fact of
processing interrupts in a threaded fashion (IRQF_ONESHOT) alone was not enough
under certain conditions to prevent the SoC from not being able to get to all
interrupts even with an empty threaded handler, and it would freeze and
eventually the Kernel would disable the interrupt ("no one cared").

The scheme currently implemented seems to work reliably cycling different audio
files over hours also forcing error conditions. But if anybody has a "cleaner"
idea how to rate-limit IRQs on a very low level (currently done in the IRQ
handler function) I'm absolutely open to suggestions. This all may not be an
issue at all when using a faster/lower-latency SoC than what I'm using
(BeagleBone Black) but the fact that IRQF_ONESHOT alone was not enough to
prevent the system to be brought to its knees (again, even with an empty
threaded handler) was a bit of a surprise to me.
