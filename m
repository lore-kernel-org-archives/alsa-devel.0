From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 00/23] ASoC: tas2552: Fixes,
	cleanups and improvements
Date: Thu, 4 Jun 2015 16:04:12 +0300
Message-ID: <1433423075-14142-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id DDF7526061B
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 15:04:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Changes since v01:
- missing patch found. It was merged with the previous patch while fixing
  checkpatch errors (patch 19 got squashed to patch 18)
- Sorry for this.

I have used the TAS2552-EVM to verify that my setup is in working condition for
a work on other audio product.
During the bringup of the EVM I have faced some issues and limitation with the
driver. The result is this series against the tas2552 driver.

Notable changes:
- Fixes for kernel crashes
- The enable-gpio was not optional as it was documented in the DTS
- Register bit definitions were not correct in several places
- Adding recommended startup/stop sequence
- Handling of sample formats the driver claims to support
- PLL configuration fixes and reference clock selection
- TDM support
- Gain control fix and control to select DIN source

Regards,
Peter
---
Peter Ujfalusi (23):
  ASoC: tas2552: Make the enable-gpio really optional
  ASoC: tas2552: Fix kernel crash when the codec is loaded but not part
    of a card
  ASoC: tas2552: Fix kernel crash caused by wrong kcontrol entry
  ASoC: tas2552: Correct PDM configuration register bit definitions
  ASoC: tas2552: Correct CFG1 register bit definitions
  ASoC: tas2552: Simplify the tas2552_mute function
  ASoC: tas2552: Simplify and reverse the functionality of
    tas2552_sw_shutdown
  ASoC: tas2552: Rename mclk parameter to pll_clkin to match with the
    datasheet
  DT/sound: bindings header file for tas2552 codec
  ASoC: tas2552: Add support for pll and pdm source clock selection
  ASoC: tas2552: Correct dai format support
  ASoC: tas2552: Correct and clean up data format and BCLK/WCLK
    direction
  ASoC: tas2552: Add TDM support
  ASoC: tas2552: Clean up the Digital - Analog DAPM route definition
  ASoC: tas2552: Correct the Speaker Driver Playback Volume (PGA_GAIN)
  ASoC: tas2552: Implement startup/stop sequence as per TRM
  ASoC: tas2552: Add support for word length configuration
  ASoC: tas2552: Configure the WCLK frequency based on the stream
  ASoC: tas2552: Correct the PLL configuration
  ASoC: tas2552: Add control for selecting DIN source
  ASoC: tas2552: Correct Output Data register usage
  ASoC: tas2552: Correct Boost Auto-Pass Through Control register usage
  ASoC: tas2552: Code, define alignment changes for uniformity

 include/dt-bindings/sound/tas2552.h |  18 ++
 sound/soc/codecs/tas2552.c          | 435 +++++++++++++++++++++++++++---------
 sound/soc/codecs/tas2552.h          | 149 ++++++------
 3 files changed, 431 insertions(+), 171 deletions(-)
 create mode 100644 include/dt-bindings/sound/tas2552.h

-- 
2.4.2
