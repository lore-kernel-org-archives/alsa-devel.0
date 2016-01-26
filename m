From: Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [RFC V2 0/2] ASoC: img: Add Pistachio card support
Date: Tue, 26 Jan 2016 14:34:25 +0000
Message-ID: <1453818867-16322-1-git-send-email-Damien.Horsley@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by alsa0.perex.cz (Postfix) with ESMTP id 35EC3260412
 for <alsa-devel@alsa-project.org>; Tue, 26 Jan 2016 15:36:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>, "Damien.Horsley" <Damien.Horsley@imgtec.com>, James Hartley <james.hartley@imgtec.com>
List-Id: alsa-devel@alsa-project.org

From: "Damien.Horsley" <Damien.Horsley@imgtec.com>

This patch set provides an initial implementation of a card driver suitable
for all boards that use of the Pistachio SoC

The Pistachio SoC contains the following audio components:
Controllers - SPDIF out, SPDIF in, parallel out, I2S out, I2S in
Codecs - Internal DAC (connected to parallel out)
Clocks - Audio PLL, dividers, gates, codec system clocks

There are a number of boards that use the Pistachio SoC. The following
can vary from board to board:
- Which audio interfaces are usable on the board
- The I2S codecs used (including multicodec paths on some boards)
- The use of the two system clocks by the I2S codecs
- Other external audio components present on the board
- I2S clock loopback
- I2S formats
- Sample rates

For some boards, a single system clock is used by components on both the
I2S out and I2S in paths. This creates two dependacy issues that require
further review as follows:

- The information required to control the system clock rate(s)
in response to a sample rate change cannot be specified as a single
frequency, or as a single fs-ratio. Instead, the Pistachio card driver must
store sufficient information to derive acceptable system clock rate(s)
for any usable combination of {I2S out sample rate, I2S in sample rate}

In this revision, the information is specified as a per-codec list of fs-rates,
accompanied by min/max frequencies. This specification is sufficient for the
codecs used so far, but this likely needs to change to support a greater range
of codecs.

- In order for the Pistachio card driver to establish usable system clock
rate(s) for a given combination of {I2S out sample rate, I2S in sample rate},
the card driver must be made aware of both of the sample rate requirements in
advance of either of the streams starting, as system clock rates cannot
typically be changed when a codec is actively playing/recording.

For this revision of the Pistachio card driver, a control has been used
to specify these rates in advance. Calls to hw_params that require a system
clock to change rate when another stream is already using the clock fail
with -EBUSY.

Changes in V2:
- Added COMMON_CLK dependancy in Kconfig

Damien.Horsley (2):
  ASoC: img: Add binding document for Pistachio audio card
  ASoC: img: Add driver for Pistachio audio card

 .../bindings/sound/img,pistachio-audio.txt         |  308 +++
 include/dt-bindings/sound/pistachio-audio.h        |    7 +
 sound/soc/img/Kconfig                              |   11 +
 sound/soc/img/Makefile                             |    1 +
 sound/soc/img/pistachio.c                          | 2249 ++++++++++++++++++++
 5 files changed, 2576 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/img,pistachio-audio.txt
 create mode 100644 include/dt-bindings/sound/pistachio-audio.h
 create mode 100644 sound/soc/img/pistachio.c

-- 
2.1.4
