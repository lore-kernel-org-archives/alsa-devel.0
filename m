From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v3 0/3] ASoC: davinci: perparation for eDMA
	dmaengine PCM
Date: Tue, 18 Mar 2014 15:20:34 +0200
Message-ID: <1395148837-20850-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id BABF026072A
 for <alsa-devel@alsa-project.org>; Tue, 18 Mar 2014 14:20:44 +0100 (CET)
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

Changes since v2:
- Constraint only placed for the period size [1]
- Patch for davinci-pcm.h to add empty function in case of !DAVINCI platforms

When the edma arch and dmaengine patches has been taken only one patch is needed
to switch AM335x/AM437x to use the edma-pcm.

[1]. I was not able to reporoduce the issue I have seen with mplayer anymore.
     As it was thought constraint for the period size is enough and there's no
     need to place the same constraint on buffer size.

Regards,
Peter
---
Peter Ujfalusi (3):
  ASoC: davinci-mcasp: Constraint on the period and buffer size based on
    FIFO usage
  ASoC: davinci-mcasp: Assign the dma_data earlier in dai_probe callback
  ASoC: davinci-pcm: Add empty functions for !CONFIG_SND_DAVINCI_SOC
    builds

 sound/soc/davinci/davinci-mcasp.c | 33 +++++++++++++++++++++++++++++----
 sound/soc/davinci/davinci-pcm.h   | 10 ++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

-- 
1.9.0
