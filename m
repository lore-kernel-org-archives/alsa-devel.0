From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH 00/13] ASoC: tlv320aic32x4: Rework Clock Setting
Date: Mon, 18 Mar 2019 20:37:43 -0700
Message-ID: <20190319033756.20616-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp89.iad3a.emailsrvr.com (smtp89.iad3a.emailsrvr.com
 [173.203.187.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C009EF89693
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 04:38:07 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

The current tlv320aic32x4 code sets the various clock parameters by
looking in a static table in the kernel.  This works well enough,
but it has a few disadvantages.

1)  If the master clock doesn't match one of the precalculated values
    the driver cannot work.  This could be because the designer
    decided to use a different crystal, or because the clock comes
    from a PLL that can't quite achieve the proper frequency
    exactly.

2)  The driver only supports certain pre-calculated sample rates.
    The actual hardware can support many more.  These changes
    enable those rates.  Additionally, certain sample rates at
    certain clock rates were previously unavailable as
    combinations.

This patch dynamically calculates the various PLL and divider
values to find something that works.

Additionally, to enable much of this, the clock tree is
modeled as a part of the Common Clock Framework.  This allows
for easier debugigng as you can use the standard tools such as
/sys/kernel/debug/clk/clk_summary.  It also simplifies enabling
the entirety of the clock tree needed, and makes sure unused
clocks become disabled.

These patches have been tested and are working on a Raspberry Pi
with the simplecard driver.

Annaliese McDermond (13):
  ASoC: tlv320aic32x4: Break out clock setting into separate function
  ASoC: tlv320aic32x4: Model PLL in CCF
  ASoC: tlv320aic32x4: Model CODEC_CLKIN in CCF
  ASoC: tlv320aic32x4: Model DAC/ADC dividers in CCF
  ASoC: tlv320aic32x4: Model BDIV divider in CCF
  ASoC: tlv320aic32x4: Control clock gating with CCF
  ASoC: tlv320aic32x4: Move aosr and dosr setting to separate functions
  ASoC: tlv320aic32x4: Dynamically Determine Clocking
  ASoC: tlv320aic32x4: Fix clock activation on bias level change
  ASoC: tlv320aic32x4: Remove sysclk references
  ASoC: tlv320aic32x4: Remove mclk references
  ASoC: tlv320aic32x4: Propery Set Processing Blocks
  ASoC: tlv320aic32x4: Allow 192000 Sample Rate

 sound/soc/codecs/Makefile            |   2 +-
 sound/soc/codecs/tlv320aic32x4-clk.c | 483 +++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.c     | 374 ++++++++++-----------
 sound/soc/codecs/tlv320aic32x4.h     |  11 +
 4 files changed, 670 insertions(+), 200 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic32x4-clk.c

-- 
Annaliese McDermond
nh6z@nh6z.net
