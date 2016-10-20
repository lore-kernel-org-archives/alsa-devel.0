From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: fix a debug statement" to the asoc tree
Date: Thu, 20 Oct 2016 19:13:28 +0200
Message-ID: <E1bxGuG-0001TP-S1@finisterre>
References: <20161013084712.GB16198@mwanda>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161013084712.GB16198@mwanda>
Sender: linux-kernel-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Bard Liao <bardliao@realtek.com>, Mark Brown <broonie@kernel.org>Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: fix a debug statement

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

>From c975e39ccadf6dc047356c60773a043a2293b8cd Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 13 Oct 2016 11:47:13 +0300
Subject: [PATCH] ASoC: rt5663: fix a debug statement

We increment "i" before printing the debug statement.  That makes it
the wrong sleep_time[] information and Smatch complains that the last
increment could be beyond the end of the array.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 01a18d88f1eb..00ff2788879e 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1547,11 +1547,11 @@ static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)
 			msleep(sleep_time[i]);
 			val = snd_soc_read(codec, RT5663_EM_JACK_TYPE_2) &
 				0x0003;
+			dev_dbg(codec->dev, "%s: MX-00e7 val=%x sleep %d\n",
+				__func__, val, sleep_time[i]);
 			i++;
 			if (val == 0x1 || val == 0x2 || val == 0x3)
 				break;
-			dev_dbg(codec->dev, "%s: MX-00e7 val=%x sleep %d\n",
-				__func__, val, sleep_time[i]);
 		}
 		dev_dbg(codec->dev, "%s val = %d\n", __func__, val);
 		switch (val) {
-- 
2.9.3
