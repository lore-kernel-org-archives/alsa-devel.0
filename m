From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] ASoC: wm_adsp: Make some variables static
Date: Thu, 21 Mar 2019 10:01:06 +0800
Message-ID: <20190321020106.11096-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, ckeepax@opensource.cirrus.com, rf@opensource.cirrus.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warnings:

sound/soc/codecs/wm_adsp.c:309:20: warning: symbol 'wm_adsp1_ops' was not declared. Should it be static?
sound/soc/codecs/wm_adsp.c:310:20: warning: symbol 'wm_adsp2_ops' was not declared. Should it be static?
sound/soc/codecs/wm_adsp.c:311:20: warning: symbol 'wm_halo_ops' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: make variables static
---
 sound/soc/codecs/wm_adsp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 644aaf1..c41bffc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -306,9 +306,9 @@
 #define HALO_MPU_VIO_ERR_SRC_MASK           0x00007fff
 #define HALO_MPU_VIO_ERR_SRC_SHIFT                   0
 
-struct wm_adsp_ops wm_adsp1_ops;
-struct wm_adsp_ops wm_adsp2_ops[];
-struct wm_adsp_ops wm_halo_ops;
+static struct wm_adsp_ops wm_adsp1_ops;
+static struct wm_adsp_ops wm_adsp2_ops[];
+static struct wm_adsp_ops wm_halo_ops;
 
 struct wm_adsp_buf {
 	struct list_head list;
@@ -4407,13 +4407,13 @@ irqreturn_t wm_halo_wdt_expire(int irq, void *data)
 }
 EXPORT_SYMBOL_GPL(wm_halo_wdt_expire);
 
-struct wm_adsp_ops wm_adsp1_ops = {
+static struct wm_adsp_ops wm_adsp1_ops = {
 	.validate_version = wm_adsp_validate_version,
 	.parse_sizes = wm_adsp1_parse_sizes,
 	.region_to_reg = wm_adsp_region_to_reg,
 };
 
-struct wm_adsp_ops wm_adsp2_ops[] = {
+static struct wm_adsp_ops wm_adsp2_ops[] = {
 	{
 		.sys_config_size = sizeof(struct wm_adsp_system_config_xm_hdr),
 		.parse_sizes = wm_adsp2_parse_sizes,
@@ -4474,7 +4474,7 @@ struct wm_adsp_ops wm_adsp2_ops[] = {
 	},
 };
 
-struct wm_adsp_ops wm_halo_ops = {
+static struct wm_adsp_ops wm_halo_ops = {
 	.sys_config_size = sizeof(struct wm_halo_system_config_xm_hdr),
 	.parse_sizes = wm_adsp2_parse_sizes,
 	.validate_version = wm_halo_validate_version,
-- 
2.7.0
