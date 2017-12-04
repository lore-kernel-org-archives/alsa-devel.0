From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 00/10] ASoC: fsl_ssi: Clean up - coding style
	level
Date: Mon,  4 Dec 2017 12:46:33 -0800
Message-ID: <1512420403-10164-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f170.google.com (mail-pf0-f170.google.com
 [209.85.192.170])
 by alsa0.perex.cz (Postfix) with ESMTP id C3F96266BEF
 for <alsa-devel@alsa-project.org>; Mon,  4 Dec 2017 21:47:18 +0100 (CET)
Received: by mail-pf0-f170.google.com with SMTP id y89so9440060pfk.0
 for <alsa-devel@alsa-project.org>; Mon, 04 Dec 2017 12:47:18 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: mail@maciej.szmigiero.name, timur@tabi.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, caleb@crome.org, linux-kernel@vger.kernel.org, fabio.estevam@nxp.com, linuxppc-dev@lists.ozlabs.org
List-Id: alsa-devel@alsa-project.org

==Background==
The fsl_ssi driver was designed for PPC originally and then it has
been updated to support different modes for i.MX Series, including
SDMA, I2S Master mode, AC97 and older i.MXs with FIQ, by different
contributors for different use cases in different coding styles.

Additionally, in order to fix/work-around hardware bugs and design
flaws, the driver made a lot of compromise so now its program flow
looks very complicated and it's getting hard to maintain or update.

So I am going to clean up the driver in both coding style level and
program flow level.

==Introduction==
This series of patches is the first set to clean up fsl_ssi driver
in the coding style level. Any patch here is not supposed to change
the program flow.

==Verification==
Theoretically, it only needs code review, build and sanity tests. I
have done build and sanity tests on an i.MX 6 platform by building
using imx_v6_v7_defconfig and testing with I2S slave/master mode.

Nicolin Chen (10):
  ASoC: fsl_ssi: Remove unused struct device
  ASoC: fsl_ssi: Rename fsl_ssi_private to fsl_ssi
  ASoC: fsl_ssi: Cache pdev->dev pointer
  ASoC: fsl_ssi: Refine all comments
  ASoC: fsl_ssi: Rename registers and fields macros
  ASoC: fsl_ssi: Refine indentations and wrappings
  ASoC: fsl_ssi: Refine printk outputs
  ASoC: fsl_ssi: Rename cpu_dai parameter to dai
  ASoC: fsl_ssi: Rename scr_val to scr
  ASoC: fsl_ssi: Replace fsl_ssi_rxtx_reg_val with fsl_ssi_regvals

 sound/soc/fsl/fsl_ssi.c     | 1338 +++++++++++++++++++------------------------
 sound/soc/fsl/fsl_ssi.h     |  422 ++++++++------
 sound/soc/fsl/fsl_ssi_dbg.c |   59 +-
 3 files changed, 846 insertions(+), 973 deletions(-)

-- 
2.7.4
