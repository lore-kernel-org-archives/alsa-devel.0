From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sigmadsp: Fix missleading return value"
	to the asoc tree
Date: Wed, 10 Feb 2016 19:22:52 +0000
Message-ID: <E1aTaLk-0000f5-U7@debutante>
References: <1455115890-23127-1-git-send-email-pascal.huerst@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E1E87260617
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2016 20:23:02 +0100 (CET)
In-Reply-To: <1455115890-23127-1-git-send-email-pascal.huerst@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pascal Huerst <pascal.huerst@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sigmadsp: Fix missleading return value

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

>From 61c4a1ac4d900e743af0b363fe520405939eab47 Mon Sep 17 00:00:00 2001
From: Pascal Huerst <pascal.huerst@gmail.com>
Date: Wed, 10 Feb 2016 15:59:28 +0100
Subject: [PATCH] ASoC: sigmadsp: Fix missleading return value

Forwarding the return value of i2c_master_send, leads to errors
later on, since i2c_master_send returns the number of bytes
transmittet. Check for ret < 0 instead and return 0 otherwise.

Signed-off-by: Pascal Huerst <pascal.huerst@gmail.com>
Acked-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sigmadsp-i2c.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/sigmadsp-i2c.c b/sound/soc/codecs/sigmadsp-i2c.c
index 21ca3a5e9f66..d374c18d4db7 100644
--- a/sound/soc/codecs/sigmadsp-i2c.c
+++ b/sound/soc/codecs/sigmadsp-i2c.c
@@ -31,7 +31,10 @@ static int sigmadsp_write_i2c(void *control_data,
 
 	kfree(buf);
 
-	return ret;
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static int sigmadsp_read_i2c(void *control_data,
-- 
2.7.0
