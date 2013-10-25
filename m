From: Brian Austin <brian.austin@cirrus.com>
Subject: [PATCH RESEND v2 4/4] ASoC: cs42l52: Add chip rev id
	message
Date: Fri, 25 Oct 2013 10:01:17 -0500
Message-ID: <1382713277-10306-5-git-send-email-brian.austin@cirrus.com>
References: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0251.outbound.messaging.microsoft.com [213.199.154.251])
 by alsa0.perex.cz (Postfix) with ESMTP id CDD742655CE
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2013 16:59:10 +0200 (CEST)
In-Reply-To: <1382713277-10306-1-git-send-email-brian.austin@cirrus.com>
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
Cc: Brian Austin <brian.austin@cirrus.com>, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch adds a print message at bootup for the CODEC Rev ID

Signed-off-by: Brian Austin <brian.austin@cirrus.com>
---
 sound/soc/codecs/cs42l52.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/cs42l52.c b/sound/soc/codecs/cs42l52.c
index 56c5611..8b427c9 100644
--- a/sound/soc/codecs/cs42l52.c
+++ b/sound/soc/codecs/cs42l52.c
@@ -1223,6 +1223,9 @@ static int cs42l52_i2c_probe(struct i2c_client *i2c_client,
 		return ret;
 	}
 
+	dev_info(&i2c_client->dev, "Cirrus Logic CS42L52, Revision: %02X\n",
+			reg & 0xFF);
+
 	/* Set Platform Data */
 	if (cs42l52->pdata.mica_cfg)
 		regmap_update_bits(cs42l52->regmap, CS42L52_MICA_CTL,
-- 
1.8.4.rc3
