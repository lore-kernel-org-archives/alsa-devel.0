From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: max98925: reading beyond the end of the
	array" to the asoc tree
Date: Tue, 21 Jul 2015 11:49:13 +0100
Message-ID: <E1ZHV6n-0002rL-SY@debutante>
References: <20150721085527.GA22070@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 57A752614EE
 for <alsa-devel@alsa-project.org>; Tue, 21 Jul 2015 12:49:20 +0200 (CEST)
In-Reply-To: <20150721085527.GA22070@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: max98925: reading beyond the end of the array

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

>From 6eb1c2a63d0415bd66c9c866b7d405662f50d5e4 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 21 Jul 2015 11:55:27 +0300
Subject: [PATCH] ASoC: max98925: reading beyond the end of the array

Debug prints are seldom useful and this one has an annoying thing where
it reads one space beyond the end of the array on error.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98925.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98925.c b/sound/soc/codecs/max98925.c
index eddf8bc07314..0883d87776b1 100644
--- a/sound/soc/codecs/max98925.c
+++ b/sound/soc/codecs/max98925.c
@@ -271,8 +271,6 @@ static inline int max98925_rate_value(struct snd_soc_codec *codec,
 			break;
 		}
 	}
-	dev_dbg(codec->dev, "%s: sample rate is %d, returning %d\n",
-				__func__, rate_table[i].rate, *value);
 	return ret;
 }
 
-- 
2.1.4
