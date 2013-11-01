From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/6] ASoC: wm_adsp: Print error when regmap
	reads/writes fail
Date: Fri,  1 Nov 2013 15:56:52 +0000
Message-ID: <1383321417-1133-2-git-send-email-dp@opensource.wolfsonmicro.com>
References: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FA9726582D
 for <alsa-devel@alsa-project.org>; Fri,  1 Nov 2013 16:56:59 +0100 (CET)
In-Reply-To: <1383321417-1133-1-git-send-email-dp@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index b38f350..076da02 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -396,8 +396,8 @@ static int wm_coeff_write_control(struct snd_kcontrol *kcontrol,
 	ret = regmap_raw_write(adsp->regmap, reg, scratch,
 			       ctl->len);
 	if (ret) {
-		adsp_err(adsp, "Failed to write %zu bytes to %x\n",
-			 ctl->len, reg);
+		adsp_err(adsp, "Failed to write %zu bytes to %x: %d\n",
+			 ctl->len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
@@ -450,8 +450,8 @@ static int wm_coeff_read_control(struct snd_kcontrol *kcontrol,
 
 	ret = regmap_raw_read(adsp->regmap, reg, scratch, ctl->len);
 	if (ret) {
-		adsp_err(adsp, "Failed to read %zu bytes from %x\n",
-			 ctl->len, reg);
+		adsp_err(adsp, "Failed to read %zu bytes from %x: %d\n",
+			 ctl->len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
@@ -1313,8 +1313,8 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 						     le32_to_cpu(blk->len));
 			if (ret != 0) {
 				adsp_err(dsp,
-					"%s.%d: Failed to write to %x in %s\n",
-					file, blocks, reg, region_name);
+					"%s.%d: Failed to write to %x in %s: %d\n",
+					file, blocks, reg, region_name, ret);
 			}
 		}
 
-- 
1.8.4.2
