From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs35l36: Fix an IS_ERR() vs NULL
	checking bug" to the asoc tree
Date: Tue, 26 Feb 2019 12:06:33 +0000 (GMT)
Message-ID: <20190226120633.88F7511284F0@debutante.sirena.org.uk>
References: <20190222063151.GC30993@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D7C98F8968A
 for <alsa-devel@alsa-project.org>; Tue, 26 Feb 2019 13:06:36 +0100 (CET)
In-Reply-To: <20190222063151.GC30993@kadam>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Brian Austin <brian.austin@cirrus.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, James Schulman <james.schulman@cirrus.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs35l36: Fix an IS_ERR() vs NULL checking bug

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From eb23dcd20e91fe97679257dc4d195a707b4a0d1a Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 22 Feb 2019 09:31:51 +0300
Subject: [PATCH] ASoC: cs35l36: Fix an IS_ERR() vs NULL checking bug

The irq_get_irq_data() function doesn't return error pointers, it
returns NULL.

Fixes: 6ba9dd6c893b ("ASoC: cs35l36: Add support for Cirrus CS35L36 Amplifier")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs35l36.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l36.c b/sound/soc/codecs/cs35l36.c
index dc8cf61b9db8..e9b5f76f27a8 100644
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
2.20.1
