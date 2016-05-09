From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC: davinci-mcasp: Master mode clock
	divider correction
Date: Mon, 9 May 2016 13:42:28 +0300
Message-ID: <1462790552-6438-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id D4B332656F0
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2016 12:42:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, jsarha@ti.com
List-Id: alsa-devel@alsa-project.org

Hi,

If the McASP is used as clock master and the reference clock is AUXCLK we
can have additional level of divider. The BCLK divider is limited to
maximum 32, if the desired bclk can not be reached with this, the AUXCLK
divider also needs to be used.

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: davinci-mcasp: Use defines for clkdiv IDs
  ASoC: davinci-mcasp: Change __davinci_mcasp_set_clkdiv() first
    parameter
  ASoC: davinci-mcasp: Restructure the davinci_mcasp_calc_clk_div()
  ASoC: davinci-mcasp: Calculate AUXCLK divider when setting up master
    clocks

 sound/soc/davinci/davinci-mcasp.c | 82 +++++++++++++++++++++++++--------------
 sound/soc/davinci/davinci-mcasp.h |  5 +++
 2 files changed, 57 insertions(+), 30 deletions(-)

-- 
2.8.2
