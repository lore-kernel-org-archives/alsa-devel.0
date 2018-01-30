From: Ladislav Michl <ladis@linux-mips.org>
Subject: [PATCH 2/7] ASoC: atmel_ssc_dai: Fix TCMR settings in
	I2S slave mode
Date: Tue, 30 Jan 2018 12:08:10 +0100
Message-ID: <20180130110810.GC18123@lenoch>
References: <20180130110604.GA18123@lenoch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by alsa0.perex.cz (Postfix) with ESMTP id 90D5E2671F2
 for <alsa-devel@alsa-project.org>; Tue, 30 Jan 2018 12:08:11 +0100 (CET)
Received: (from localhost user: 'ladis' uid#1021 fake: STDIN
 (ladis@eddie.linux-mips.org)) by eddie.linux-mips.org
 id S23994711AbeA3LILIMgf0 (ORCPT
 <rfc822;alsa-devel@alsa-project.org>);
 Tue, 30 Jan 2018 12:08:11 +0100
Content-Disposition: inline
In-Reply-To: <20180130110604.GA18123@lenoch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, anish kumar <yesanishhere@gmail.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
---
 sound/soc/atmel/atmel_ssc_dai.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
index a1e2c5682dcd..8e145487cb18 100644
--- a/sound/soc/atmel/atmel_ssc_dai.c
+++ b/sound/soc/atmel/atmel_ssc_dai.c
@@ -647,7 +647,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
 
 		tcmr =	  SSC_BF(TCMR_PERIOD, 0)
 			| SSC_BF(TCMR_STTDLY, START_DELAY)
-			| SSC_BF(TCMR_START, SSC_START_FALLING_RF)
+			| SSC_BF(TCMR_START, SSC_START_TX_RX)
 			| SSC_BF(TCMR_CKI, SSC_CKI_FALLING)
 			| SSC_BF(TCMR_CKO, SSC_CKO_NONE)
 			| SSC_BF(TCMR_CKS, ssc->clk_from_rk_pin ?
-- 
2.15.1
