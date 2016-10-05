From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: tas571x: wait 50ms after oscillator
	trim" to the asoc tree
Date: Wed, 05 Oct 2016 17:22:02 +0200
Message-ID: <E1bro1C-0004lS-Lw@finisterre>
References: <1475505650-8572-5-git-send-email-brain@jikos.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3380C261740
 for <alsa-devel@alsa-project.org>; Wed,  5 Oct 2016 17:22:18 +0200 (CEST)
In-Reply-To: <1475505650-8572-5-git-send-email-brain@jikos.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <brain@jikos.cz>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: tas571x: wait 50ms after oscillator trim

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 5e549a0c18fc0321c18e7b6842cb7afc90aab396 Mon Sep 17 00:00:00 2001
From: Petr Kulhavy <brain@jikos.cz>
Date: Mon, 3 Oct 2016 16:40:49 +0200
Subject: [PATCH] ASoC: tas571x: wait 50ms after oscillator trim

Wait extra 50ms after writing the oscillator trim register in probe(), as
recommended by the TAS5721 and TAS5711 datasheets.

Signed-off-by: Petr Kulhavy <brain@jikos.cz>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/tas571x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/tas571x.c b/sound/soc/codecs/tas571x.c
index df5e5cb33baa..de65ecf534af 100644
--- a/sound/soc/codecs/tas571x.c
+++ b/sound/soc/codecs/tas571x.c
@@ -754,6 +754,7 @@ static int tas571x_i2c_probe(struct i2c_client *client,
 	if (ret)
 		return ret;
 
+	usleep_range(50000, 60000);
 
 	memcpy(&priv->codec_driver, &tas571x_codec, sizeof(priv->codec_driver));
 	priv->codec_driver.component_driver.controls = priv->chip->controls;
-- 
2.9.3
