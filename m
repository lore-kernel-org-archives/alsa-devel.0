From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: Clarify a bit about the ER1
	meaning" to the asoc tree
Date: Mon, 22 Jan 2018 12:26:38 +0000
Message-ID: <E1edbBO-0004eW-77@debutante>
References: <1516275928-10318-1-git-send-email-fabio.estevam@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 13203267338
 for <alsa-devel@alsa-project.org>; Mon, 22 Jan 2018 13:26:40 +0100 (CET)
In-Reply-To: <1516275928-10318-1-git-send-email-fabio.estevam@nxp.com>
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

   ASoC: sgtl5000: Clarify a bit about the ER1 meaning

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

>From da689e0da3c042c9d240e21189a2af0aa9da3ab5 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <fabio.estevam@nxp.com>
Date: Thu, 18 Jan 2018 09:45:28 -0200
Subject: [PATCH] ASoC: sgtl5000: Clarify a bit about the ER1 meaning

The "check ER1" message is not very clear about its meaning.

Improve it a bit by referring to it as "ER1 erratum" so that it
becomes clearer that ER1 references to a SGTL5000 erratum.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index 633cdcfc933d..e1ab5537d27a 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -1392,7 +1392,7 @@ static int sgtl5000_i2c_probe(struct i2c_client *client,
 
 		ana_pwr |= SGTL5000_LINEREG_D_POWERUP;
 		dev_info(&client->dev,
-			 "Using internal LDO instead of VDDD: check ER1\n");
+			 "Using internal LDO instead of VDDD: check ER1 erratum\n");
 	} else {
 		/* using external LDO for VDDD
 		 * Clear startup powerup and simple powerup
-- 
2.15.1
