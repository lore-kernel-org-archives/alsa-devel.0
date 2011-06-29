From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: use dmaengine for atmel ssc/pcm dai drivers
Date: Wed, 29 Jun 2011 20:00:14 +0200
Message-ID: <1309370419-22810-1-git-send-email-nicolas.ferre@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

This patch series is built on top of ASoC git tree for-3.1 branch.

It will add the DMA use through dmaengine to the SSC/PCM Atmel drivers. These
drivers are curently using the PDC DMA feature which has been replaced by a DMA
controller in some chips. The dmaengine driver curently used is at_hdmac.

The first patch is a little update to wm8731 codec driver.

Nicolas Ferre (5):
      ASoC: wm8731: rework power management
      ASoC: atmel-ssc: add phybase in device structure
      ASoC: atmel-ssc: dmaengine usage switch depending on cpu
      ASoC: atmel_ssc_dai/atmel-pcm: adapt to dmaengine usage
      ASoC: atmel_ssc_dai: PM: actually stopping clock on suspend/resume

 drivers/misc/atmel-ssc.c        |    1 +
 include/linux/atmel-ssc.h       |    4 +
 sound/soc/atmel/atmel-pcm.c     |  382 +++++++++++++++++++++++++++++++++++---
 sound/soc/atmel/atmel-pcm.h     |    4 +-
 sound/soc/atmel/atmel_ssc_dai.c |   53 ++++--
 sound/soc/codecs/wm8731.c       |    5 +-
 6 files changed, 395 insertions(+), 54 deletions(-)
