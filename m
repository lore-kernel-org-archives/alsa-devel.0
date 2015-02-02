From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: davinci-mcasp: Fixes for 3.20
Date: Mon, 2 Feb 2015 14:38:31 +0200
Message-ID: <1422880713-25414-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 427D42605AA
 for <alsa-devel@alsa-project.org>; Mon,  2 Feb 2015 13:38:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, daniel@zonque.org
List-Id: alsa-devel@alsa-project.org

Hi,

While doing the conversion of davinci DAI drivers to use edma-pcm I have noticed
couple of issues with the driver regarding to old daVinci device support which
resulted in the following two patch.

Some SoC uses shared IRQ line for all McASP instances
There are SoCs where a given McASP instance only supports DIT mode. Currently
the arch code feeds dummy resource in place of RX (which is not available). With
the second patch this is not going to be needed anymore.

If it is not too late for 3.20..

regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: davicni-mcasp: Mark the common irq line as shared
  ASoC: davinci-mcasp: Fix DIT only McASP instance support

 sound/soc/davinci/davinci-mcasp.c | 75 +++++++++++++++++++++------------------
 1 file changed, 41 insertions(+), 34 deletions(-)

-- 
2.2.2
