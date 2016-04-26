From: Andreas Dannenberg <dannenberg@ti.com>
Subject: [PATCH v4 0/2] ASoC: codecs: add support for TAS5720 digital amplifier
Date: Tue, 26 Apr 2016 17:15:55 -0500
Message-ID: <1461708957-7616-1-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Andreas Dannenberg <dannenberg@ti.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Minor update to driver for TI's TAS5720L/M digital audio amplifiers
incorporating previous feedback (thanks Mark Brown and Andrew F Davis),
see below change log for details. Also re-tested different aspects of
the driver to make sure it still builds/works.

--

Andreas Dannenberg
Texas Instruments Inc


Changes since v3:
- Rework fault condition reporting to use dev_crit() to pay justice to
  the severity of the issues, also shorten the error string for more
  clarity/brevity
- Fix Kconfig help entry to no longer mention the interrupt signal that
  was used previously
- Simplify hw_params checks as the driver in its current form only
  supports left-justified audio formats and the codec is tolerant
  regarding the number of bits that are actually received.
- Clarify DT bindings to make the power supply properties required
- Remove .owner assignment from I2C driver struct as it is no longer
  needed (taken care off by the Kernel)

Changes since v2:
- Switched fault handling from using interrupts to polling mode
- Remove interrupt related description from DT bindings doc
- Remove unlikely() to simplify an expression
- Remove unnesseary tas5720_set_dai_sysclk() function stub

Changes since v1:
- Simplified DT interrupt documentation (Thanks Rob Herring)
- Fixed potential race condition during codec probe where deferred work
  that's used by the threaded IRQ handler was setup after the IRQ was
  initialized (would lead to an issue when the TAS5720 was already throwing
  interrupts at the time of probe)

Andreas Dannenberg (2):
  ASoC: codecs: add TA5720 digital amplifier DT bindings
  ASoC: codecs: add support for TAS5720 digital amplifier

 .../devicetree/bindings/sound/tas5720.txt          |  25 +
 sound/soc/codecs/Kconfig                           |   8 +
 sound/soc/codecs/Makefile                          |   2 +
 sound/soc/codecs/tas5720.c                         | 620 +++++++++++++++++++++
 sound/soc/codecs/tas5720.h                         |  90 +++
 5 files changed, 745 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/tas5720.txt
 create mode 100644 sound/soc/codecs/tas5720.c
 create mode 100644 sound/soc/codecs/tas5720.h

-- 
2.6.4
