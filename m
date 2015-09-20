From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm0010: fix memory leak" to the asoc
	tree
Date: Sat, 19 Sep 2015 17:13:03 -0700
Message-ID: <E1ZdSFb-00040J-FW@finisterre>
References: <1442572341-28201-2-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2CBE42605D9
 for <alsa-devel@alsa-project.org>; Sun, 20 Sep 2015 02:13:28 +0200 (CEST)
In-Reply-To: <1442572341-28201-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sudip Mukherjee <sudip@vectorindia.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm0010: fix memory leak

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

>From 2ace47be5a315def8f493ca77aa59c077ade30a1 Mon Sep 17 00:00:00 2001
From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Fri, 18 Sep 2015 16:02:20 +0530
Subject: [PATCH] ASoC: wm0010: fix memory leak

We have requested for the firmware but we have missed releasing it both
on success and on error path.
While checking the code it turned out that the requested firmware is not
even used. More over the same firmware is being loaded by
wm0010_stage2_load().

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm0010.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/sound/soc/codecs/wm0010.c b/sound/soc/codecs/wm0010.c
index 9d370a4..7a1bc40 100644
--- a/sound/soc/codecs/wm0010.c
+++ b/sound/soc/codecs/wm0010.c
@@ -577,7 +577,6 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	struct wm0010_priv *wm0010 = snd_soc_codec_get_drvdata(codec);
 	unsigned long flags;
 	int ret;
-	const struct firmware *fw;
 	struct spi_message m;
 	struct spi_transfer t;
 	struct dfw_pllrec pll_rec;
@@ -623,14 +622,6 @@ static int wm0010_boot(struct snd_soc_codec *codec)
 	wm0010->state = WM0010_OUT_OF_RESET;
 	spin_unlock_irqrestore(&wm0010->irq_lock, flags);
 
-	/* First the bootloader */
-	ret = request_firmware(&fw, "wm0010_stage2.bin", codec->dev);
-	if (ret != 0) {
-		dev_err(codec->dev, "Failed to request stage2 loader: %d\n",
-			ret);
-		goto abort;
-	}
-
 	if (!wait_for_completion_timeout(&wm0010->boot_completion,
 					 msecs_to_jiffies(20)))
 		dev_err(codec->dev, "Failed to get interrupt from DSP\n");
-- 
2.5.0
