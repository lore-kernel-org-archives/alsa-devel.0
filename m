From: Simran Rai <simran.rai@broadcom.com>
Subject: [PATCH v7 0/3] ASoC: cygnus: Add audio support for
	Broadcom Cygnus SoC
Date: Tue, 17 May 2016 17:01:06 -0700
Message-ID: <1463529669-25022-1-git-send-email-simran.rai@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f172.google.com (mail-pf0-f172.google.com
 [209.85.192.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 1548B2604A9
 for <alsa-devel@alsa-project.org>; Wed, 18 May 2016 02:01:40 +0200 (CEST)
Received: by mail-pf0-f172.google.com with SMTP id c189so12106847pfb.3
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 17:01:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lori Hikichi <lhikichi@broadcom.com>, Simran Rai <simran.rai@broadcom.com>, linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, Arun Parameswaran <arunp@broadcom.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Hi,

This patchset contains audio support for Broadcom's Cygnus SoC.
It contains DT bindings and core audio driver. The audio driver supports
both capture and playback of Audio PCM samples over I2S/TDM interface and
provides playback support over SPDIF interface.

This patchset is derived from a previously submitted patchset:
http://lkml.iu.edu/hypermail/linux/kernel/1503.3/05434.html

This patchset has been tested on Cygnus wireless audio bcm958305K board.
It is based on v4.6-rc1 and is available from github:

repo: https://github.com/Broadcom/cygnus-linux/tree/cygnus-sound-v7

Changes from v6:
- DT bindings acknowledged by Rob Herring
Changes from v5:
- Fix code style, e.g. change "if" statements to "switch" statements
- Fix SPDIF output enable register field
- Set BUFFER_PAIR_ENABLE for both mono, stereo and TDM modes
- Reflect PCM bit formats for SPDIF, SSP and TDM as supported by
hardware
Changes from v4:
- Fix power suspend function and add power resume function
- Move clock initialization code from audio driver to clock framework
Changes from v3:
- Fix the subject lines to match the style for the subsystem
Changes from v2:
- Split patchset 2/2 from v2 into patchsets 2/3 and 3/3.
- Remove SND_SOC_CYGNUS_DIAG. Diagnostics can be performed using
standard kernel trace infrastructure.
- Fix interrupt handler. Acknowledge only those interrupts that are
handledby ISR.
- Modify configure_vco() and the pll_macro_entry() struct to make it
better readable. The functionality did not change.
- Remove casts on macros
- Remove surround sound channel grouping from the driver.
Changes from v1:
- Address code review comments. Fix print format of type size_t and
pointer.

Simran Rai (3):
  ASoC: cygnus: Add DT bindings for Broadcom Cygnus audio
  ASoC: cygnus: Add Cygnus audio DAI driver
  ASoC: cygnus: Add Cygnus audio DMA driver

 .../bindings/sound/brcm,cygnus-audio.txt           |   67 +
 sound/soc/bcm/Kconfig                              |    9 +
 sound/soc/bcm/Makefile                             |    5 +
 sound/soc/bcm/cygnus-pcm.c                         |  861 +++++++++++
 sound/soc/bcm/cygnus-ssp.c                         | 1529 ++++++++++++++++++++
 sound/soc/bcm/cygnus-ssp.h                         |  139 ++
 6 files changed, 2610 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/brcm,cygnus-audio.txt
 create mode 100644 sound/soc/bcm/cygnus-pcm.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.c
 create mode 100644 sound/soc/bcm/cygnus-ssp.h

-- 
1.9.1
