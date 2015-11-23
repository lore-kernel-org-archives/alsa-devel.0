From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: davinci-mcasp: Fix master capture only
	mode
Date: Mon, 23 Nov 2015 12:51:53 +0200
Message-ID: <1448275913-30546-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
 by alsa0.perex.cz (Postfix) with ESMTP id E7EA8265238
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 11:51:57 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

When McASP is used as TX/RX synchronous (TX side generating clocks for RX
side also) and only capture is used we need to configure the number of TX
slots in order McASP to be able to generate the Frame sync.

Fixes: 9273de1940d9e ("ASoC: davinci-mcasp: Add set_tdm_slots() support")
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index caa0bebcd7f4..c1c9c2e3525b 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -908,6 +908,14 @@ static int mcasp_i2s_hw_param(struct davinci_mcasp *mcasp, int stream,
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMT_REG, busel | RXORD);
 		mcasp_mod_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG,
 			       FSRMOD(total_slots), FSRMOD(0x1FF));
+		/*
+		 * If McASP is set to be TX/RX synchronous and the playback is
+		 * not running already we need to configure the TX slots in
+		 * order to have correct FSX on the bus
+		 */
+		if (mcasp_is_synchronous(mcasp) && !mcasp->channels)
+			mcasp_mod_bits(mcasp, DAVINCI_MCASP_TXFMCTL_REG,
+				       FSXMOD(total_slots), FSXMOD(0x1FF));
 	}
 
 	return 0;
-- 
2.6.3
