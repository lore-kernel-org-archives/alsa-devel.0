From: Matt Flax <flatmax@flatmax.org>
Subject: [PATCH 0/3] ASoC: Enable a new IC master mode:
	bcm2835<=>IC<=>cs42xx8
Date: Sat, 25 Feb 2017 16:03:11 +1100
Message-ID: <cover.1487997974.git.flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsstlmta10p.bpe.bigpond.com (nsstlmta10p.bpe.bigpond.com
 [203.38.21.10]) by alsa0.perex.cz (Postfix) with ESMTP id 5BDC72668C0
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 06:04:00 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: flatmax@flatmax.org
Cc: hias@horus.com, alsa-devel@alsa-project.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, phil@raspberrypi.org, Liam Girdwood <lgirdwood@gmail.com>, Eric Anholt <eric@anholt.net>, florian.kauer@koalo.de, broonie@kernel.org, Florian Meier <florian.meier@koalo.de>, linux-rpi-kernel@lists.infradead.org, ckeepax@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch set lets the ASoC system specify that an IC between the SoC and codec
is master. This is intended to put both the SoC and Codec into slave modes.

By default un-patched SoC and Codec drivers will return -EINVAL if they aren't
enabled and tested for this mode.

soc-dia.h has the new SND_SOC_DAIFMT_IBM_IFM definition set as :
#define SND_SOC_DAIFMT_IBM_IFM		(5 << 12) /* IC clk & FRM master */

The cs42xx8 codec driver is enabled for this mode and so too is the BCM2835
SoC driver. This forms a chain : bcm2835<=>IC<=>cs42xx8
where the IC is bit and frame master.

Matt Flax (3):
  ASoC : Add an IC bit and frame master mode (SoC and Codec slave).
  ASoC: cs42xx8: allow IC master mode.
  ASoC: bcm2835: Add mutichannel mode in DSP and IC master modes.

 include/sound/soc-dai.h     |  9 ++++++---
 sound/soc/bcm/bcm2835-i2s.c | 21 ++++++++++++++++++++-
 sound/soc/codecs/cs42xx8.c  |  1 +
 3 files changed, 27 insertions(+), 4 deletions(-)

-- 
2.7.4
