From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: Intel: Skylake: fix memory leak of module on error exit path
Date: Thu, 29 Sep 2016 18:32:12 +0100
Message-ID: <20160929173212.13700-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Vinod Koul <vinod.koul@intel.com>, Dharageswari R <dharageswari.r@intel.com>, Senthilnathan Veppur <senthilnathanx.veppur@intel.com>, Shreyas NC <shreyas.nc@intel.com>, Ramesh Babu <ramesh.babu@intel.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

Currently there is a memory leak of module on a ENOMEM return path.
Fix this by kfree'ing module before returning.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/intel/skylake/skl-sst-utils.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index d3120ba..8dc0303 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -354,8 +354,10 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
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
