From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Do not print error on probe
	deferral" to the asoc tree
Date: Thu, 18 Jan 2018 11:23:00 +0000
Message-ID: <E1ec8Hc-0003ll-Gb@debutante>
References: <1516203981-6333-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 651A32671C0
 for <alsa-devel@alsa-project.org>; Thu, 18 Jan 2018 12:23:02 +0100 (CET)
In-Reply-To: <1516203981-6333-1-git-send-email-fabio.estevam@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@nxp.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: Do not print error on probe deferral

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

>From 8af5748fa48698a433ba9a1766204bda283dffa8 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Wed, 17 Jan 2018 13:48:54 -0200
Subject: [PATCH] ASoC: sgtl5000: Do not print error on probe deferral

When the MCLK is not yet available when the codec is probed, probe
deferral will happen and in this case we should not print an
error message.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index f2bb4feba3b6..633cdcfc933d 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1332,10 +1332,13 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 	sgtl5000->mclk = devm_clk_get(&client->dev, NULL);
 	if (IS_ERR(sgtl5000->mclk)) {
 		ret = PTR_ERR(sgtl5000->mclk);
-		dev_err(&client->dev, "Failed to get mclock: %d\n", ret);
 		/* Defer the probe to see if the clk will be provided later */
 		if (ret == -ENOENT)
 			ret = -EPROBE_DEFER;
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&client->dev, "Failed to get mclock: %d\n",
+				ret);
 		goto disable_regs;
 	}
 
-- 
2.15.1
