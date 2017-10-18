From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Add helper to find codec_dai from
	dai_name" to the asoc tree
Date: Wed, 18 Oct 2017 12:27:14 +0100
Message-ID: <E1e4mVG-0003PZ-LC@debutante>
References: <20171012233805.30055-7-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 85EE8267411
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 13:27:29 +0200 (CEST)
In-Reply-To: <20171012233805.30055-7-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, andriy.shevchenko@linux.intel.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Add helper to find codec_dai from dai_name

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

>From 7c761b593e2c1dc6bc6c0c15ec338af1f00cabd7 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 12 Oct 2017 18:38:02 -0500
Subject: [PATCH] ASoC: Add helper to find codec_dai from dai_name

Create a helper function to remove duplicate code used in machine drivers

Suggested-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d22de9712c45..deacbafbae17 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1720,6 +1720,20 @@ struct snd_soc_dai *snd_soc_find_dai(
 
 #include <sound/soc-dai.h>
 
+static inline
+struct snd_soc_dai *snd_soc_card_get_codec_dai(struct snd_soc_card *card,
+					       const char *dai_name)
+{
+	struct snd_soc_pcm_runtime *rtd;
+
+	list_for_each_entry(rtd, &card->rtd_list, list) {
+		if (!strcmp(rtd->codec_dai->name, dai_name))
+			return rtd->codec_dai;
+	}
+
+	return NULL;
+}
+
 #ifdef CONFIG_DEBUG_FS
 extern struct dentry *snd_soc_debugfs_root;
 #endif
-- 
2.14.1
