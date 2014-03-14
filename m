From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 0/4] ASoC: davinci: edma dmaengine PCM and
	mcasp preparation
Date: Fri, 14 Mar 2014 16:42:44 +0200
Message-ID: <1394808168-32608-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id F1E7F265450
 for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2014 15:42:53 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, nsekhar@ti.com, Jyri Sarha <jsarha@ti.com>, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

This is a cutdown version of the previous [1] series containing only the ASoC
part of the edma dmaengine conversion, but without the actual switch to this new
edma-pcm platform for the McASP since the edma arch and dmaengine core changes
are needed for it to be usable.

Changes since v1:
- arch and dmaengine patches has been dropped from the ASoC series
- Patches has been reordered so only one patch is going to be needed to switch
  AM335x/AM447x to use the edma-pcm platform driver
- all comments from Lars-Peter Clausen has been addressed for the edma-pcm driver
- no changes to Kconfig/Makefile - do not yet build the edma-pcm driver. It will
  be enabled and integrated when we can do the real switch.

[1] http://mailman.alsa-project.org/pipermail/alsa-devel/2014-March/074269.html

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: davinci: Add edma dmaengine platform driver
  ASoC: davinci-mcasp: Provide correct filter_data for dmaengine for
    non-DT boot
  ASoC: davinci-mcasp: Constraint on the period and buffer size based on
    FIFO usage
  ASoC: davinci-mcasp: Assign the dma_data earlier in dai_probe callback

 sound/soc/davinci/davinci-mcasp.c | 59 +++++++++++++++++++++++++++++++++------
 sound/soc/davinci/edma-pcm.c      | 57 +++++++++++++++++++++++++++++++++++++
 sound/soc/davinci/edma-pcm.h      | 25 +++++++++++++++++
 3 files changed, 132 insertions(+), 9 deletions(-)
 create mode 100644 sound/soc/davinci/edma-pcm.c
 create mode 100644 sound/soc/davinci/edma-pcm.h

-- 
1.9.0
