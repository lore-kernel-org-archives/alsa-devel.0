From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH 0/2] ASoC: codecs: add support for TAS5720
	digital amplifier
Date: Fri, 18 Mar 2016 18:27:56 -0500
Message-ID: <1458343678-4086-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 29921261560
 for <alsa-devel@alsa-project.org>; Sat, 19 Mar 2016 00:28:08 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>, Andreas Dannenberg <dannenberg@ti.com>
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

--
Andreas Dannenberg
Texas Instruments Inc

Andreas Dannenberg (2):
  ASoC: codecs: add TA5720 digital amplifier DT bindings
  ASoC: codecs: add support for TAS5720 digital amplifier

 .../devicetree/bindings/sound/tas5720.txt          |  37 ++
 sound/soc/codecs/Kconfig                           |  10 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas5720.c                         | 733 +++++++++++++++++++++
 sound/soc/codecs/tas5720.h                         |  90 +++
 5 files changed, 872 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas5720.txt
 create mode 100644 sound/soc/codecs/tas5720.c
 create mode 100644 sound/soc/codecs/tas5720.h

-- 
2.6.4
