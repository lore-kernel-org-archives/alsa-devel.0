From: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: wm_adsp: Print error when regmap
	reads/writes fail
Date: Wed, 30 Oct 2013 16:54:28 +0000
Message-ID: <1383152069-8646-1-git-send-email-dp@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4F5F82654AF
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2013 18:00:54 +0100 (CET)
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

Change-Id: I782f7684d9ef38adcbee6c6ed6809534dc7ff9b9
Signed-off-by: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index e09ac94..cd007cc 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -339,8 +339,8 @@ static int wm_coeff_write_control(struct snd_kcontrol *kcontrol,
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
@@ -393,8 +393,8 @@ static int wm_coeff_read_control(struct snd_kcontrol *kcontrol,
 
 	ret = regmap_raw_read(adsp->regmap, reg, scratch, ctl->len);
 	if (ret) {
-		adsp_err(adsp, "Failed to read %zu bytes from %x\n",
-			 ctl->len, reg);
+		adsp_err(adsp, "Failed to read %zu bytes from %x: %d\n",
+			 ctl->len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
@@ -1227,8 +1227,8 @@ static int wm_adsp_load_coeff(struct wm_adsp *dsp)
 					       le32_to_cpu(blk->len));
 			if (ret != 0) {
 				adsp_err(dsp,
-					"%s.%d: Failed to write to %x in %s\n",
-					file, blocks, reg, region_name);
+					"%s.%d: Failed to write to %x in %s: %d\n",
+					file, blocks, reg, region_name, ret);
 			}
 
 			kfree(buf);
-- 
1.8.4.2
