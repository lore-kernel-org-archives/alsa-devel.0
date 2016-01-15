From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5659: Staticise rt5659_i2c_shutdown"
	to the asoc tree
Date: Fri, 15 Jan 2016 18:18:55 +0000
Message-ID: <E1aK8xb-0005Qq-Cu@debutante>
References: <1452585226.5282.0.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D87CE260524
 for <alsa-devel@alsa-project.org>; Fri, 15 Jan 2016 19:19:05 +0100 (CET)
In-Reply-To: <1452585226.5282.0.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5659: Staticise rt5659_i2c_shutdown

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

>From c62db3d5abf89ca5502c7fe1f869c2862e48336d Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 12 Jan 2016 15:53:46 +0800
Subject: [PATCH] ASoC: rt5659: Staticise rt5659_i2c_shutdown

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index 820d8fa62b5e..47c717f4964a 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4184,7 +4184,7 @@ static int rt5659_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-void rt5659_i2c_shutdown(struct i2c_client *client)
+static void rt5659_i2c_shutdown(struct i2c_client *client)
 {
 	struct rt5659_priv *rt5659 = i2c_get_clientdata(client);
 
-- 
2.7.0.rc3
