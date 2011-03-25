From: Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH 0/3] Fix breakages due to recent updates
Date: Fri, 25 Mar 2011 16:51:43 +0100
Message-ID: <1301068306-11997-1-git-send-email-w.sang@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 5E1B910380B
	for <alsa-devel@alsa-project.org>; Fri, 25 Mar 2011 16:51:57 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Sascha Hauer <s.hauer@pengutronix.de>, Wolfram Sang <w.sang@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

I wanted to get sound out of my mx27-based PCM038 and it failed. I found two
flaws which were introduced by recent update-works. While being here, I found
some redundant code.

Wolfram Sang (3):
  ASoC: imx: set watermarks for mx2-dma
  ASoC: imx: fix burstsize for DMA
  ASoC: imx: remove superfluous code in imx-ssi.c

 sound/soc/imx/imx-pcm-dma-mx2.c |    9 +++++++--
 sound/soc/imx/imx-ssi.c         |    6 ------
 sound/soc/imx/imx-ssi.h         |    3 ---
 3 files changed, 7 insertions(+), 11 deletions(-)

-- 
1.7.2.5
