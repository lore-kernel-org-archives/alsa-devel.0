From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH 3/3] ASoC: sgtl5000: Defer probe in case of I2C
	error
Date: Tue, 25 Jun 2013 11:00:01 -0300
Message-ID: <1372168801-4221-3-git-send-email-fabio.estevam@freescale.com>
References: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 4741E2608EC
 for <alsa-devel@alsa-project.org>; Tue, 25 Jun 2013 16:00:45 +0200 (CEST)
In-Reply-To: <1372168801-4221-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: marex@denx.de, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

In case of I2C error, let's defer the probe.

On mx28, for example, the first read of the codec revision register fails 
because there is no codec clock provided at this point. The codec clock will be 
enabled later in the mxs-saif driver, so return -EPROBE_DEFER in case of I2C 
read error, so that the codec driver can do another attempt at a later stage 
when the codec clock is available.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/codecs/sgtl5000.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index d441559..a2dce4a 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1536,9 +1536,12 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 
 	/* read chip information */
 	ret = regmap_read(sgtl5000->regmap, SGTL5000_CHIP_ID, &reg);
-	if (ret)
+	if (ret) {
+		ret = -EPROBE_DEFER; /* If I2C read failed, try again later */
 		goto disable_clk;
 
+	}
+
 	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
 	    SGTL5000_PARTID_PART_ID) {
 		dev_err(&client->dev,
-- 
1.8.1.2
