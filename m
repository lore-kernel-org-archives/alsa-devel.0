From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/2] ASoC: omap-mcbsp: dma_op_mode changes
Date: Thu, 15 Mar 2012 12:37:12 +0200
Message-ID: <1331807834-25675-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 52E351045F1
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 11:37:42 +0100 (CET)
Received: by mail-lpp01m010-f51.google.com with SMTP id p9so2305787laa.10
	for <alsa-devel@alsa-project.org>; Thu, 15 Mar 2012 03:37:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hello,

Removing the frame dm_op_mode, and using packet mode in element mode on
OMAP3+ to transfer 1 sample at the time between the McBSP FIFO and memory.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: omap-mcbsp: Use DMA packet mode for non mono streams on OMAP3+
  ASoC: omap-mcbsp: Remove unused FRAME dma_op_mode

 sound/soc/omap/mcbsp.c      |    2 +-
 sound/soc/omap/mcbsp.h      |    1 -
 sound/soc/omap/omap-mcbsp.c |   31 +++++++++++++++++--------------
 3 files changed, 18 insertions(+), 16 deletions(-)

-- 
1.7.8.5
