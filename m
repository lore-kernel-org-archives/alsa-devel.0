From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/6] ASoC: davinci-mcasp: Fix rx format when
	more bclk is used on the bus
Date: Mon, 10 Nov 2014 12:32:19 +0200
Message-ID: <1415615540-28981-6-git-send-email-peter.ujfalusi@ti.com>
References: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 6859226150C
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 11:32:37 +0100 (CET)
In-Reply-To: <1415615540-28981-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: daniel@zonque.org, Misael Lopez Cruz <misael.lopez@ti.com>, alsa-devel@alsa-project.org, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org

When the bus is configured to have more BCLK then the data type demands we
need to use the rotation to move the data to correct place.

Reported-by: Misael Lopez Cruz <misael.lopez@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 40cf4bc447e6..6b15a974f585 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -494,8 +494,17 @@ static int davinci_config_channel_size(struct davinci_mcasp *mcasp,
 	 * both left and right channels), so it has to be divided by number of
 	 * tdm-slots (for I2S - divided by 2).
 	 */
-	if (mcasp->bclk_lrclk_ratio)
-		word_length = mcasp->bclk_lrclk_ratio / mcasp->tdm_slots;
+	if (mcasp->bclk_lrclk_ratio) {
+		u32 slot_length = mcasp->bclk_lrclk_ratio / mcasp->tdm_slots;
+
+		/*
+		 * When we have more bclk then it is needed for the data, we
+		 * need to use the rotation to move the received samples to have
+		 * correct alignment.
+		 */
+		rx_rotate = (slot_length - word_length) / 4;
+		word_length = slot_length;
+	}
 
 	/* mapping of the XSSZ bit-field as described in the datasheet */
 	fmt = (word_length >> 1) - 1;
-- 
2.1.3
