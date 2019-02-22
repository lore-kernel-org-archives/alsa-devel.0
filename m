From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ASoC: cs35l36: Fix an IS_ERR() vs NULL
	checking bug
Date: Fri, 22 Feb 2019 09:31:51 +0300
Message-ID: <20190222063151.GC30993@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp2130.oracle.com (userp2130.oracle.com [156.151.31.86])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16C0CF80775
 for <alsa-devel@alsa-project.org>; Fri, 22 Feb 2019 07:32:06 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Brian Austin <brian.austin@cirrus.com>, James Schulman <james.schulman@cirrus.com>
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The irq_get_irq_data() function doesn't return error pointers, it
returns NULL.

Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 sound/soc/codecs/cs35l36.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index e374fffb7e17..901d57491218 100644
--- a/sound/soc/codecs/cs35l36.c
+++ b/sound/soc/codecs/cs35l36.c
@@ -1845,9 +1845,9 @@ static int cs35l36_i2c_probe(struct i2c_client *i2c_client,
 		cs35l36_apply_vpbr_config(cs35l36);
 
 	irq_d = irq_get_irq_data(i2c_client->irq);
-	if (IS_ERR(irq_d)) {
+	if (!irq_d) {
 		dev_err(&i2c_client->dev, "Invalid IRQ: %d\n", i2c_client->irq);
-		ret = PTR_ERR(irq_d);
+		ret = -ENODEV;
 		goto err;
 	}
 
-- 
2.17.1
