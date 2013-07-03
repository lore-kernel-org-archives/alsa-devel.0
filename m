From: Bo Shen <voice.shen@atmel.com>
Subject: [v2 2/5] ASoC: atmel_ssc_dai: add error mask define
Date: Wed,  3 Jul 2013 16:37:57 +0800
Message-ID: <1372840680-2253-3-git-send-email-voice.shen@atmel.com>
References: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by alsa0.perex.cz (Postfix) with ESMTP id 25978261A2A
 for <alsa-devel@alsa-project.org>; Wed,  3 Jul 2013 10:40:49 +0200 (CEST)
In-Reply-To: <1372840680-2253-1-git-send-email-voice.shen@atmel.com>
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
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, richard.genoud@gmail.com, Nicolas Ferre <nicolas.ferre@atmel.com>, linux-sound@vger.kernel.org, Bo Shen <voice.shen@atmel.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

add error mask define, which will be used when execute DMA transfer

Signed-off-by: Bo Shen <voice.shen@atmel.com>
---
Change in v2:
  - new patch
---
 sound/soc/atmel/atmel_ssc_dai.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index 6cf9cf1..1ab4763 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -73,6 +73,7 @@ static struct atmel_ssc_mask ssc_tx_mask = {
 	.ssc_disable	= SSC_BIT(CR_TXDIS),
 	.ssc_endx	= SSC_BIT(SR_ENDTX),
 	.ssc_endbuf	= SSC_BIT(SR_TXBUFE),
+	.ssc_error	= SSC_BIT(SR_OVRUN),
 	.pdc_enable	= ATMEL_PDC_TXTEN,
 	.pdc_disable	= ATMEL_PDC_TXTDIS,
 };
@@ -82,6 +83,7 @@ static struct atmel_ssc_mask ssc_rx_mask = {
 	.ssc_disable	= SSC_BIT(CR_RXDIS),
 	.ssc_endx	= SSC_BIT(SR_ENDRX),
 	.ssc_endbuf	= SSC_BIT(SR_RXBUFF),
+	.ssc_error	= SSC_BIT(SR_OVRUN),
 	.pdc_enable	= ATMEL_PDC_RXTEN,
 	.pdc_disable	= ATMEL_PDC_RXTDIS,
 };
-- 
1.7.9.5
