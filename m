From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/6] ASoC: davinci-mcasp: Dynamic AFIFO and DMA
	configuration
Date: Tue, 1 Apr 2014 15:55:06 +0300
Message-ID: <1396356912-30466-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E7422652BE
 for <alsa-devel@alsa-project.org>; Tue,  1 Apr 2014 14:55:19 +0200 (CEST)
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
Cc: detheridge@ti.com, alsa-devel@alsa-project.org, nsekhar@ti.com, jsarha@ti.com, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Hi,

Apart from the first patch which is a rebased resend of a previous patch this
series will change the way McASP driver will configure the AFIFO and thus the
DMA burst.

The AFIFO and DMA configuration will be in one function so it is going to be
easier to see the code and debug if needed.

The main change is that instead of static tx/rx numevt (which is provided via DT
or pdata) we are going to switch to dynamic configuration.
With this setup we do not need to place any constraint on the period or buffer
size since the AFIFO numevt and the corresponding DMA burst size will be picked
according to period size, active serializers and the preferred numevt level.
The only case when the code can fail if the period size in words can not be
divided evenly by the active serializers, which is unlikely to happen.

Regards,
Peter
---
Peter Ujfalusi (6):
  ASoC: davinci-mcasp: Assign the dma_data earlier in dai_probe callback
  ASoC: davinci-mcasp: Fix debug typo in davinci_mcasp_hw_params()
  ASoC: davinci-mcasp: Simplify and clean up the AFIFO configuration
    code
  ASoC: davinci-mcasp: Configure the AFIFO and DMA burst size at the
    same place
  ASoC: davinic-mcasp: Adopt the AFIFO/DMA configuration to the stream
    (dynamic depth)
  ASoC: davinci-mcasp: Fine tune and correct the DMA burst configuration

 sound/soc/davinci/davinci-mcasp.c | 145 +++++++++++++++++++++++---------------
 sound/soc/davinci/davinci-mcasp.h |   1 +
 2 files changed, 89 insertions(+), 57 deletions(-)

-- 
1.9.1
