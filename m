From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Skylake: fix memory leak of module on error exit path" to the asoc tree
Date: Thu, 29 Sep 2016 11:32:26 -0700
Message-ID: <E1bpg8A-0007fo-8t@finisterre>
References: <20160929173212.13700-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160929173212.13700-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Dharageswari R <dharageswari.r@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Shreyas NC <shreyas.nc@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Skylake: fix memory leak of module on error exit path

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

>From 0730bd2e2ade00d88647b13a0c17cde254ddf56e Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Thu, 29 Sep 2016 18:32:12 +0100
Subject: [PATCH] ASoC: Intel: Skylake: fix memory leak of module on error exit
 path

Currently there is a memory leak of module on a ENOMEM return path.
Fix this by kfree'ing module before returning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 1aa0f371b381..3fe939c36e3a 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -349,8 +349,10 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 		module->max_instance = mod_entry->instance_max_count;
 		size = sizeof(int) * mod_entry->instance_max_count;
 		module->instance_id = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
-		if (!module->instance_id)
+		if (!module->instance_id) {
+			kfree(module);
 			return -ENOMEM;
+		}
 
 		list_add_tail(&module->list, &skl->uuid_list);
 
-- 
2.9.3
