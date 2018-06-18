From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: codecs: PCM1789: unconditionally flush
	work" to the asoc tree
Date: Mon, 18 Jun 2018 12:59:46 +0100
Message-ID: <E1fUsp0-0008P8-DO@debutante>
References: <20180617134532.1070-1-stefan@agner.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 84E632675D5
 for <alsa-devel@alsa-project.org>; Mon, 18 Jun 2018 13:59:54 +0200 (CEST)
In-Reply-To: <20180617134532.1070-1-stefan@agner.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stefan Agner <stefan@agner.ch>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: codecs: PCM1789: unconditionally flush work

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

>From a7dc662c6a7b9209df600c64b16d33d72dbf56b1 Mon Sep 17 00:00:00 2001
From: Stefan Agner <stefan@agner.ch>
Date: Sun, 17 Jun 2018 15:45:29 +0200
Subject: [PATCH] ASoC: codecs: PCM1789: unconditionally flush work

Work is guaranteed to be initialized on exit. Drop the unnecessary
if statement and always call flush_work.

This fixes a warning seen with clang:
sound/soc/codecs/pcm1789.c:265:13: warning: address of 'priv->work' will
      always evaluate to 'true' [-Wpointer-bool-conversion]
        if (&priv->work)
        ~~   ~~~~~~^~~~

Signed-off-by: Stefan Agner <stefan@agner.ch>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/pcm1789.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/pcm1789.c b/sound/soc/codecs/pcm1789.c
index 21f15219b3ad..8df6447c76a6 100644
--- a/sound/soc/codecs/pcm1789.c
+++ b/sound/soc/codecs/pcm1789.c
@@ -262,8 +262,7 @@ int pcm1789_common_exit(struct device *dev)
 {
 	struct pcm1789_private *priv = dev_get_drvdata(dev);
 
-	if (&priv->work)
-		flush_work(&priv->work);
+	flush_work(&priv->work);
 
 	return 0;
 }
-- 
2.17.1
