From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: avoid 64-bit compile warning"
	to the asoc tree
Date: Tue, 08 Dec 2015 19:11:13 +0000
Message-ID: <E1a6NfN-0003xJ-Ra@debutante>
References: <3548574.qiC2AlzHH4@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 285FF26062A
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2015 20:11:22 +0100 (CET)
In-Reply-To: <3548574.qiC2AlzHH4@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: avoid 64-bit compile warning

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

>From ff793af4ce13afa9836f6a396552d623ff880099 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 8 Dec 2015 16:12:54 +0100
Subject: [PATCH] ASoC: da7218: avoid 64-bit compile warning

When building the da7218 driver on a 64-bit architecture, we get
a harmless warning:

sound/soc/codecs/da7218.c: In function 'da7218_of_get_id':
sound/soc/codecs/da7218.c:2261:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]

This changes the code to use uintptr_t to ensure we have an integer
type of the same size as a pointer and won't get a warning on any
architecture.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4d50934abd22 ("ASoC: da7218: Add da7218 codec driver")
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7218.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index 4fee7aeaadc7..eacde128c4d6 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2258,7 +2258,7 @@ static inline int da7218_of_get_id(struct device *dev)
 	const struct of_device_id *id = of_match_device(da7218_of_match, dev);
 
 	if (id)
-		return (int) id->data;
+		return (uintptr_t)id->data;
 	else
 		return -EINVAL;
 }
-- 
2.6.2
