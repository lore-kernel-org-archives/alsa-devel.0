From: Nicolin Chen <Guangyu.Chen@freescale.com>
Subject: [PATCH 0/6] ASoC: fsl_sai: Fix some minor issues
Date: Fri, 20 Dec 2013 16:39:46 +0800
Message-ID: <cover.1387528048.git.Guangyu.Chen@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 1E838265383
 for <alsa-devel@alsa-project.org>; Fri, 20 Dec 2013 09:39:49 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, linux@arm.linux.org.uk
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, timur@tabi.org, lgirdwood@gmail.com, Li.Xiubo@freescale.com
List-Id: alsa-devel@alsa-project.org

This series patches fix some minor issues in the new fsl_sai driver.

@Mark Brown
I's so busy these days that I couldn't send these, which should have been
review comments, in time. So some of them might be too minor to become a
meaningful patch but I still sent them to see if you would like to apply.

Thank you.

Nicolin Chen (6):
  ASoC: fsl_sai: Keep symmetry for clk_enable() and clk_disable()
  ASoC: fsl_sai: Use snd_pcm_format_width()
  ASoC: fsl_sai: Drop useless channels check in hw_params()
  ASoC: fsl_sai: Drop useless ret in startup()
  ASoC: fsl_sai: Make dev_err information neater
  ASoC: fsl_sai: Sort local variable in general way

 sound/soc/fsl/fsl_sai.c | 71 ++++++++++++++++---------------------------------
 1 file changed, 23 insertions(+), 48 deletions(-)

-- 
1.8.4
