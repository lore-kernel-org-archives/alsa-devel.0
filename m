From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 0/4] ASoC: ti: davinci: Fixes for daVinci
	boards with McBSP
Date: Fri, 30 Aug 2019 13:38:37 +0300
Message-ID: <20190830103841.25128-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EBD0DF800E7
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 12:38:21 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: alsa-devel@alsa-project.org, nsekhar@ti.com, kuninori.morimoto.gx@renesas.com
List-Id: alsa-devel@alsa-project.org

Hi,

Morimoto-san pointed out in a private thread that the davinci-i2s driver is
using snd_soc_rtdcom_lookup(), which is should not really.

It took a while to get access to a daVinci board which uses McBSP, but
eventually I got access to a remote dm644x-evm and dma365-evm.

Initially the audio was not even probing on them (fixes sent for mach-davinci),
but then the driver was still crashing and not behaving correctly.

With the 4 patch dm644x-evm have working audio and the offending
snd_soc_rtdcom_lookup() is gone from the driver.
dm365-evm still have some issues regarding to EDMA, but it looks like a system
issue which can be fixed later.

Regards,
Peter
---
Peter Ujfalusi (4):
  ASoC: ti: davinci-i2s: Add S32_LE as support format
  ASoC: ti: davinci-i2s: Move the XSYNCERR workaround to .prepare
    callback
  ASoC: ti: edma-pcm: Fix for legacy dma_slave_map based channel lookup
  ASoC: ti: davinci-evm: Do not fail if the dai_set_sysclk returns
    -ENOTSUPP

 sound/soc/ti/davinci-evm.c |  2 +-
 sound/soc/ti/davinci-i2s.c | 90 +++++++++++++++++---------------------
 sound/soc/ti/edma-pcm.c    | 17 ++++++-
 3 files changed, 57 insertions(+), 52 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
