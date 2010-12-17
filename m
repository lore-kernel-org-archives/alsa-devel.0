From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: [GIT PULL] ASoC updates for 2.6.38
Date: Fri, 17 Dec 2010 13:55:12 +0000
Message-ID: <1292594112.10257.3.camel@odin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id D25AF1038C7
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 14:55:18 +0100 (CET)
Received: by wwi18 with SMTP id 18so515337wwi.2
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 05:55:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org


More updates for 2.6.38, mainly wrt TI CODECs.

Thanks

Liam

---


The following changes since commit 649e5fb033bbadbfa78aba5e2711f1faf2affaf0:

  Merge branch 'for-2.6.37' into for-2.6.38 (2010-11-29 18:33:47 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lrg/asoc-2.6.git for-2.6.38

Axel Lin (1):
      ASoC: Remove unused aic3x_i2c_init and aic3x_i2c_exit functions

Francois Mazard (1):
      ASoC: twl6040: Fix analog Mic L & R mux controls

Jorge Eduardo Candelaria (6):
      ASoC: sdp4430: Enable FM stereo pins
      ASoC: twl6040: Add jack support for headset and handset
      ASoC: sdp4430: Add Jack support
      ASoC: twl6040: Add headset and handset mux controls
      ASoC: twl6040: Clear interrupt status at boot time
      ASoC: twl6040: Increase timeout for power up

Margarita Olaya Cabrera (1):
      ASoC: twl6040: Add ramp up/down volume for HS and HF

Misael Lopez Cruz (2):
      ASoC: twl6040: Enable plug detection interrupts
      ASoC: twl6040: Use correct offset for LineInAmp Right

Olaya, Margarita (8):
      ASoC: twl6040: Update twl IO macro
      ASoC: twl6040: Modify the IRQ handler
      ASoC: twl6040: Restore bias level at resume
      ASoC: twl6040: Fix PCM error handling ops
      ASoC: twl6040: Support other sample rates.
      ASoC: twl6040: Enable automatic power for phoenix 1.1
      ASoC: twl6040: Fix TLV dB step values for gains
      ASoC: twl6040: Set default gains to minimun value

Peter Ujfalusi (12):
      ASoC: tlv320dac33: Do not enable the codec in init_chip
      ASoC: tlv320dac33: Avoid multiple soft power up
      ASoC: tpa6130a2: Simplify power state management
      ASoC: tpa6130a2: Defer SW enable from power enable
      ASoC: tpa6130a2: Use one event handler for PGA_E
      ASoC: tpa6130a2: Add stereo DAPM path
      ASoC: tpa6130a2: Replace DAPM code with direct interface
      ASoC: tlv320dac33: Rename outpup amplifier widget
      ASoC: tlv320dac33: Move DAC LR power on to a supply widget
      ASoC: tlv320dac33: Fix compillation error
      ASoC: tlv320dac33: Power down digital parts, when not needed
      ASoC: TWL4030: Fix 24bit support

 sound/soc/codecs/tlv320aic3x.c |   15 -
 sound/soc/codecs/tlv320dac33.c |   57 ++-
 sound/soc/codecs/tpa6130a2.c   |   92 +----
 sound/soc/codecs/tpa6130a2.h   |    1 +
 sound/soc/codecs/twl4030.c     |    5 +-
 sound/soc/codecs/twl6040.c     |  842 ++++++++++++++++++++++++++++++++++------
 sound/soc/codecs/twl6040.h     |    8 +
 sound/soc/omap/sdp4430.c       |   43 ++-
 8 files changed, 844 insertions(+), 219 deletions(-)
