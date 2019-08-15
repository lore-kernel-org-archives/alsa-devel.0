From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: Print constant literals
	from format specifier" to the asoc tree
Date: Thu, 15 Aug 2019 18:14:25 +0100 (BST)
Message-ID: <20190815171425.0E5042742B9E@ypsilon.sirena.org.uk>
References: <20190621113116.47525-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr1-f99.google.com (mail-wr1-f99.google.com
 [209.85.221.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ED0BFF805F6
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 19:14:26 +0200 (CEST)
Received: by mail-wr1-f99.google.com with SMTP id u16so2890517wrr.0
 for <alsa-devel@alsa-project.org>; Thu, 15 Aug 2019 10:14:26 -0700 (PDT)
In-Reply-To: <20190621113116.47525-1-andriy.shevchenko@linux.intel.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: Print constant literals from format specifier

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From ff30779bd50eb823e2e75cfc7cc8a3373bfa3fd9 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 21 Jun 2019 14:31:16 +0300
Subject: [PATCH] ASoC: Intel: Skylake: Print constant literals from format
 specifier

Instead of using two additional "%s" specifiers, put the constant string
literals directly to the format specifier.

Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Link: https://lore.kernel.org/r/20190621113116.47525-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-sst.c b/sound/soc/intel/skylake/skl-sst.c
index 8af7546def1f..61a8e4756a2b 100644
--- a/sound/soc/intel/skylake/skl-sst.c
+++ b/sound/soc/intel/skylake/skl-sst.c
@@ -413,8 +413,7 @@ static int skl_load_module(struct sst_dsp *ctx, u16 mod_id, u8 *guid)
 	int ret = 0;
 	char mod_name[64]; /* guid str = 32 chars + 4 hyphens */
 
-	snprintf(mod_name, sizeof(mod_name), "%s%pUL%s",
-					     "intel/dsp_fw_", guid, ".bin");
+	snprintf(mod_name, sizeof(mod_name), "intel/dsp_fw_%pUL.bin", guid);
 
 	module_entry = skl_module_get_from_id(ctx, mod_id);
 	if (module_entry == NULL) {
-- 
2.20.1
