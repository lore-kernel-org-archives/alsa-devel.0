From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: cs4271: Remove outdated comment
Date: Tue,  4 Feb 2014 14:48:22 +0100
Message-ID: <1391521702-15594-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-089.synserver.de (smtp-out-089.synserver.de
 [212.40.185.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 45B782619E1
 for <alsa-devel@alsa-project.org>; Tue,  4 Feb 2014 14:48:19 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit 1b1861ead ("ASoC: cs4271: convert to direct regmap API usage") removed
the bus_type field from the cs4271_private struct, but left the comment that
described the field in there. This patch removes the comment.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/cs4271.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/cs4271.c b/sound/soc/codecs/cs4271.c
index ce05fd9..f7bbe6f 100644
--- a/sound/soc/codecs/cs4271.c
+++ b/sound/soc/codecs/cs4271.c
@@ -159,7 +159,6 @@ static bool cs4271_volatile_reg(struct device *dev, unsigned int reg)
 }
 
 struct cs4271_private {
-	/* SND_SOC_I2C or SND_SOC_SPI */
 	unsigned int			mclk;
 	bool				master;
 	bool				deemph;
-- 
1.8.0
