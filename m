From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH v2 00/16] ASoC: fsl_ssi: Clean up - program
	flow level
Date: Wed, 10 Jan 2018 22:42:59 -0800
Message-ID: <1515652995-15996-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id CA421266F35
 for <alsa-devel@alsa-project.org>; Thu, 11 Jan 2018 07:44:05 +0100 (CET)
Received: by mail-pf0-f170.google.com with SMTP id m26so873604pfj.11
 for <alsa-devel@alsa-project.org>; Wed, 10 Jan 2018 22:44:05 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@tabi.org, broonie@kernel.org, mail@maciej.szmigiero.name
Cc: alsa-devel@alsa-project.org, kernel@pengutronix.de, linux-kernel@vger.kernel.org, caleb@crome.org, lgirdwood@gmail.com, arnaud.mouiche@invoxia.com, lukma@denx.de, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

==Change log==
v2
 * Reworked the series by taking suggestions from Maciej
  + Added PATCH-01 to keep all ssi->i2s_net updated
  + Replaced bool tx with bool dir in PATCH-03 and PATCH-06
  + Moved all initial register configurations from dai probe() to
    platform probe() so as to let AC97 CODEC successfully probe.
 * Added Tested-by from Caleb for TDM test cases.

==Background==
The fsl_ssi driver was designed for PPC originally and then it has
been updated to support different modes for i.MX Series, including
SDMA, I2S Master mode, AC97 and older i.MXs with FIQ, by different
contributors for different use cases in different coding styles.

Additionally, in order to fix/work-around hardware bugs and design
flaws, the driver made a lot of compromise so now its program flow
looks very complicated and it's getting hard to maintain or update.

So I am going to clean up the driver on both coding style level and
program flow level.

==Introduction==
This series of patches is the second set to clean up fsl_ssi driver
in the program flow level. Any patch here may impact a fundamental
test case like playback or record.

==Verification==
This series of patches require fully tested. I have done such tests
on i.MX6SoloX with WM8962 using imx_v6_v7_defconfig as:
 - Playback via I2S Master and Slave mode
 - Record via I2S Master and Slave mode
 - Simultaneous playback and record via I2S Master and Slave mode
 - Background playback with foreground record (starting at different
   time) via I2S Master and Slave mode
 - Background record with foreground playback (starting at different
   time) via I2S Master and Slave mode
 * All tests above by hacking offline_config to true in imx51.

Caleb has tested v1 with TDM lookback tests on i.MX6.

Example of uncovered tests: AC97, PowerPC and FIQ.

Nicolin Chen (16):
  ASoC: fsl_ssi: Keep ssi->i2s_net updated
  ASoC: fsl_ssi: Clean up set_dai_tdm_slot()
  ASoC: fsl_ssi: Maintain a mask of active streams
  ASoC: fsl_ssi: Rename fsl_ssi_disable_val macro
  ASoC: fsl_ssi: Clear FIFO directly in fsl_ssi_config()
  ASoC: fsl_ssi: Clean up helper functions of trigger()
  ASoC: fsl_ssi: Add DAIFMT define for AC97
  ASoC: fsl_ssi: Clean up fsl_ssi_setup_regvals()
  ASoC: fsl_ssi: Set xFEN0 and xFEN1 together
  ASoC: fsl_ssi: Use snd_soc_init_dma_data instead
  ASoC: fsl_ssi: Move one-time configurations to probe()
  ASoC: fsl_ssi: Setup AC97 in fsl_ssi_hw_init()
  ASoC: fsl_ssi: Clean up _fsl_ssi_set_dai_fmt()
  ASoC: fsl_ssi: Remove cpu_dai_drv from fsl_ssi structure
  ASoC: fsl_ssi: Move DT related code to a separate probe()
  ASoC: fsl_ssi: Use ssi->streams instead of reading register

 sound/soc/fsl/fsl_ssi.c | 740 ++++++++++++++++++++++++------------------------
 1 file changed, 369 insertions(+), 371 deletions(-)

-- 
2.7.4
