From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 06/14] ASoC: intel: constify snd_soc_dai_ops structures
Date: Fri, 18 Aug 2017 17:36:03 +0530
Message-ID: <1503057971-16033-7-git-send-email-arvind.yadav.cs@gmail.com>
References: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1503057971-16033-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: bardliao@realtek.com, oder_chiou@realtek.com, timur@tabi.org, lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

snd_soc_dai_ops are not supposed to change at runtime. All functions
working with snd_soc_dai_ops provided by <sound/soc-dai.h> work with
const snd_soc_dai_ops. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 6 +++---
 sound/soc/intel/skylake/skl-pcm.c            | 8 ++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/intel/atom/sst-mfld-platform-pcm.c b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
index b082b31..49c7b88 100644
--- a/sound/soc/intel/atom/sst-mfld-platform-pcm.c
+++ b/sound/soc/intel/atom/sst-mfld-platform-pcm.c
@@ -471,7 +471,7 @@ static void sst_disable_ssp(struct snd_pcm_substream *substream,
 	}
 }
 
-static struct snd_soc_dai_ops sst_media_dai_ops = {
+static const struct snd_soc_dai_ops sst_media_dai_ops = {
 	.startup = sst_media_open,
 	.shutdown = sst_media_close,
 	.prepare = sst_media_prepare,
@@ -480,11 +480,11 @@ static void sst_disable_ssp(struct snd_pcm_substream *substream,
 	.mute_stream = sst_media_digital_mute,
 };
 
-static struct snd_soc_dai_ops sst_compr_dai_ops = {
+static const struct snd_soc_dai_ops sst_compr_dai_ops = {
 	.mute_stream = sst_media_digital_mute,
 };
 
-static struct snd_soc_dai_ops sst_be_dai_ops = {
+static const struct snd_soc_dai_ops sst_be_dai_ops = {
 	.startup = sst_enable_ssp,
 	.hw_params = sst_be_hw_params,
 	.set_fmt = sst_set_format,
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index 0ebea34a..b1f2dba 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -628,7 +628,7 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static struct snd_soc_dai_ops skl_pcm_dai_ops = {
+static const struct snd_soc_dai_ops skl_pcm_dai_ops = {
 	.startup = skl_pcm_open,
 	.shutdown = skl_pcm_close,
 	.prepare = skl_pcm_prepare,
@@ -637,15 +637,15 @@ static int skl_link_hw_free(struct snd_pcm_substream *substream,
 	.trigger = skl_pcm_trigger,
 };
 
-static struct snd_soc_dai_ops skl_dmic_dai_ops = {
+static const struct snd_soc_dai_ops skl_dmic_dai_ops = {
 	.hw_params = skl_be_hw_params,
 };
 
-static struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
+static const struct snd_soc_dai_ops skl_be_ssp_dai_ops = {
 	.hw_params = skl_be_hw_params,
 };
 
-static struct snd_soc_dai_ops skl_link_dai_ops = {
+static const struct snd_soc_dai_ops skl_link_dai_ops = {
 	.prepare = skl_link_pcm_prepare,
 	.hw_params = skl_link_hw_params,
 	.hw_free = skl_link_hw_free,
-- 
1.9.1
