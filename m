From: Scott Branden <sbranden@broadcom.com>
Subject: [PATCH 0/2] Cygnus Audio Driver
Date: Mon, 30 Mar 2015 20:16:22 -0700
Message-ID: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gw3-out.broadcom.com (mail-gw3-out.broadcom.com
 [216.31.210.64])
 by alsa0.perex.cz (Postfix) with ESMTP id B678E260559
 for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2015 05:16:30 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark
 Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, Scott Branden <sbranden@broadcom.com>, linux-kernel@vger.kernel.org, bryeung@google.com, abrestic@google.com, bcm-kernel-feedback-list@broadcom.com, linux-arm-kernel@lists.infradead.org, pwestin@google.com, Anatol Pomazao <anatol@google.com>, olofj@google.com, Dmitry Torokhov <dtor@google.com>, linux-rpi-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Please provide comments on the initial version of this driver.

This patchset contains the devicetree bindings and core audio driver
for the Cygnus SoC.

There is an open question on how to fit this driver into the clock
framework (if at all).

The audio PLL is embedded in the audio block and only used
by the audio block. The audio PLL registers are also in the middle of 
the audio register map.

In addition, the audio PLL is adjustable to less than 1 Hz.
The existing clock driver framework does not provide a mechanism to take
advantage of the resolution of the hardware.

Can the audio PLL remain within the audio driver and/or any modifications
required?

Lori Hikichi (2):
  ASoC: cygnus-audio: adding device tree bindings
  ASoC: add core audio driver for Broadcom Cygnus SOC.

 .../bindings/sound/brcm,cygnus-audio.txt           |   68 +
 sound/soc/bcm/Kconfig                              |   11 +
 sound/soc/bcm/Makefile                             |    5 +-
 sound/soc/bcm/cygnus-pcm.c                         |  918 +++++++++++
 sound/soc/bcm/cygnus-pcm.h                         |   45 +
 sound/soc/bcm/cygnus-ssp.c                         | 1613 ++++++++++++++++++++
 sound/soc/bcm/cygnus-ssp.h                         |   84 +
 7 files changed, 2743 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
 create mode 100644 sound/soc/bcm/cygnus-pcm.c
 create mode 100644 sound/soc/bcm/cygnus-pcm.h
 create mode 100644 sound/soc/bcm/cygnus-ssp.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.h

-- 
2.3.3
