From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/9] ASoC: tas2552: Fixes,
	cleanups and improvements
Date: Mon, 8 Jun 2015 15:19:47 +0300
Message-ID: <1433765996-28930-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id 1EDE72602AD
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 14:20:02 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com, dmurphy@ti.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Changes since v02:
- Dropped already applied patches from v02
- Fix bit shift in the PLL configuration patch (1/9) and add macro for it for
  readability
- New patches since v02:
 - fix module removing and loading issue by calling pm_runtime_disable when the
   module is removed
 - Remove extra semicolon
 - Consitent naming for 'struct tas2552_data': tas_data -> tas2552
 - Binding document update regarding to the added header file for clock
   selection

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
Peter Ujfalusi (9):
  ASoC: tas2552: Correct the PLL configuration
  ASoC: tas2552: Add control for selecting DIN source
  ASoC: tas2552: Correct Output Data register usage
  ASoC: tas2552: Correct Boost Auto-Pass Through Control register usage
  ASoC: tas2552: Code, define alignment changes for uniformity
  ASoC: tas2552: Call pm_runtime_disable when the module is removed
  ASoC: tas2552: Remove unneeded semicolon
  ASoC: tas2552: Use consistent name for 'struct tas2552_data'
  ASoC: tas2552: Update DT binding document regarding clkock
    configuration

 .../devicetree/bindings/sound/tas2552.txt          |   6 +
 sound/soc/codecs/tas2552.c                         | 173 ++++++++++++++-------
 sound/soc/codecs/tas2552.h                         |  61 ++++----
 3 files changed, 155 insertions(+), 85 deletions(-)

-- 
2.4.2
