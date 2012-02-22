From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [RFC 0/7] ASoC: Introduce dmaengine pcm helper
	functions
Date: Wed, 22 Feb 2012 10:49:04 +0100
Message-ID: <1329904151-5927-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-087.synserver.de (smtp-out-093.synserver.de
	[212.40.185.93]) by alsa0.perex.cz (Postfix) with ESMTP id 4104D24154
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 10:47:40 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Russell King <linux@arm.linux.org.uk>, Ryan Mallon <rmallon@gmail.com>, Mika Westerberg <mika.westerberg@iki.fi>, Wolfram Sang <w.sang@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

Same series as send out yesterday (sans the cleanup patches which already have
been applied), since I forgot to Cc alsa-devel. Sorry for the noice if you got
the series twice.


This patch series introduces a new set of helper functions for dmaengine based
PCM drivers. Currently we have 6 different dmaengine based PCM drivers which are
all more or less similar in structure, but all have also individual requirements
which can't easily be generalized. So that's why this series does not introduce
a generic dmaengine PCM driver but rather a set of helper functions which can be
used to implement the common bits between such dmaengine based PCM drivers.

The helper functions only provide infrastructure code for dmaengines which
provide thed evice_prep_dma_cyclic. While it is possible to add support for
dmaengine, which only provide device_prep_slave_sg, it is in my opinion a better
idea to either implement the missing functionality in the dmaengine driver or
provide a emulation layer for cyclic transfer within the dmaengine framework
itself. This has the advantage that it is also available outside of ALSA.

This series converts the three PCM drivers which already use the circular
dmaengine prepare function. Since I don't have access to hardware using the
converted drivers the patches have only been compile tested. But the helper
functions introduced in this series have been runtime tested with a platform
which is not upstream yet.

The first two patches restructure the iMX and MXS drivers to request their DMA
channel in the PCM open callback instead of the hwparams callback.  This is done
to make their structure more similar to what it will be when using the helper
functions and make the actual patch converting them to the new dmaengine PCM
helper functions less intrusive. The next patch introduces the helper functions
and the last three patches respectively convert the imx, mxs and ep39xx
dmaengine based PCM drivers to use the new set of helper functions.

The set of helper functions consists of a open, a close, a trigger and a pointer
callback and also a function to convert hwparams to a dma_slave_config. The
trigger and pointer callbacks can usually be used directly for the pcm_ops
callbacks. The open callback wants to be called from a driver specific open
function which may do some driver specific setup tasks and provide the helper
open callback with a dma filter function. If the driver specific open functions
allocates resources they need to be freed in a driver specific close function
which has to call the helper close callback. If not the helper close callback
can be assigned directly to the pcm_ops struct.

If a driver needs to keep additional driver specific data around it can be done
by using snd_dmaengine_pcm_{get,set}_data. Normally a driver should not require
to keep additional data around, but all of the converted drivers need this,
because of this horrible abusive pattern where the dma channels private field
gets assigned configuration data in the filter callback. We should hopefully be
able to get rid of this pattern with Guennadi Liakhovetski's patches[1], which
add a slave configuration parameter to dma_request_channel, and with it the need
for storing extra private data.

While the DMA helper functions only use generic ALSA functions and nothing ASoC
specific I've placed the, under ASoC for now since the only users are ASoC
driver.

- Lars

[1] https://lkml.org/lkml/2012/2/1/227

Lars-Peter Clausen (7):
  ASoC: imx-ssi: Set dma data early
  ASoC: imx-pcm: Request DMA channel early
  ASoC: mxs-pcm: Request DMA channel early
  ASoC: Add dmaengine PCM helper functions
  ASoC: imx-pcm-dma: Use dmaengine PCM helper functions
  ASoC: mxs-pcm: Use dmaengine PCM helper functions
  ASoC: ep93xx-pcm: Use dmaengine PCM helper functions

 include/sound/dmaengine_pcm.h   |   49 +++++++
 sound/soc/Kconfig               |    3 +
 sound/soc/Makefile              |    3 +
 sound/soc/ep93xx/Kconfig        |    1 +
 sound/soc/ep93xx/ep93xx-pcm.c   |  148 +++-----------------
 sound/soc/imx/Kconfig           |    1 +
 sound/soc/imx/imx-pcm-dma-mx2.c |  196 ++++----------------------
 sound/soc/imx/imx-ssi.c         |   28 +++-
 sound/soc/mxs/Kconfig           |    1 +
 sound/soc/mxs/mxs-pcm.c         |  152 ++++-----------------
 sound/soc/mxs/mxs-pcm.h         |   12 --
 sound/soc/soc-dmaengine-pcm.c   |  287 +++++++++++++++++++++++++++++++++++++++
 12 files changed, 443 insertions(+), 438 deletions(-)
 create mode 100644 include/sound/dmaengine_pcm.h
 create mode 100644 sound/soc/soc-dmaengine-pcm.c

-- 
1.7.9
