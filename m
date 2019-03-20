From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH v2 00/12] ASoC: tlv320aic32x4: Rework Clock
	Setting
Date: Tue, 19 Mar 2019 21:51:17 -0700
Message-ID: <20190320045129.6859-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp113.ord1c.emailsrvr.com (smtp113.ord1c.emailsrvr.com
 [108.166.43.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EF068F80736
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 05:51:42 +0100 (CET)
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

Changes in v2:
 - Update 0002 patch to change Kconfig to add dependency on CCF
 - Update 0002 patch to correct the SPDX identifier
 - Update 0002 patch to use EXPORT_SYMBOL_GPL() instead of
   EXPORT_SYMBOL()
 - Update patches 0002, 0004 and 0005 to use prepare/unprepare
   instead of enable/disable since the i2c operations are not
   atomic
 - Update 0004 patch to fix indentation in commit message
 - Drop patch 0009 because it is a duplicate of the already
   committed patch in 667e9334
 - Update 0019 patch to keep aic32x4_set_dai_sysclk but to have
   it use clk_set_rate to set the master clock rate
 
Annaliese McDermond (12):
  ASoC: tlv320aic32x4: Break out clock setting into separate function
  ASoC: tlv320aic32x4: Model PLL in CCF
  ASoC: tlv320aic32x4: Model CODEC_CLKIN in CCF
  ASoC: tlv320aic32x4: Model DAC/ADC dividers in CCF
  ASoC: tlv320aic32x4: Model BDIV divider in CCF
  ASoC: tlv320aic32x4: Control clock gating with CCF
  ASoC: tlv320aic32x4: Move aosr and dosr setting to separate functions
  ASoC: tlv320aic32x4: Dynamically Determine Clocking
  ASoC: tlv320aic32x4: Restructure set_dai_sysclk
  ASoC: tlv320aic32x4: Remove mclk references
  ASoC: tlv320aic32x4: Propery Set Processing Blocks
  ASoC: tlv320aic32x4: Allow 192000 Sample Rate

 sound/soc/codecs/Kconfig             |   1 +
 sound/soc/codecs/Makefile            |   2 +-
 sound/soc/codecs/tlv320aic32x4-clk.c | 483 +++++++++++++++++++++++++++
 sound/soc/codecs/tlv320aic32x4.c     | 365 ++++++++++----------
 sound/soc/codecs/tlv320aic32x4.h     |  11 +
 5 files changed, 674 insertions(+), 188 deletions(-)
 create mode 100644 sound/soc/codecs/tlv320aic32x4-clk.c

-- 
2.19.1
