From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 14/14] ALSA: sb: Proper endian notations
Date: Wed, 25 Jul 2018 23:24:14 +0200
Message-ID: <20180725212414.19795-15-tiwai@suse.de>
References: <20180725212414.19795-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id CDCFA2677AA
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:24:17 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 8ADA6B37E
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:24:16 +0000 (UTC)
In-Reply-To: <20180725212414.19795-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The data types defined in SB CSP driver code are all in little-endian,
hence the proper type like __le32 should be used.

Spotted by sparse, a warning like:
  sound/isa/sb/sb16_csp.c:330:14: warning: cast to restricted __le32

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/sb/sb16_csp.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/isa/sb/sb16_csp.c b/sound/isa/sb/sb16_csp.c
index 2210e7c72787..b9d67a7065cd 100644
--- a/sound/isa/sb/sb16_csp.c
+++ b/sound/isa/sb/sb16_csp.c
@@ -60,18 +60,18 @@ MODULE_FIRMWARE("sb16/ima_adpcm_capture.csp");
  * RIFF data format
  */
 struct riff_header {
-	__u32 name;
-	__u32 len;
+	__le32 name;
+	__le32 len;
 };
 
 struct desc_header {
 	struct riff_header info;
-	__u16 func_nr;
-	__u16 VOC_type;
-	__u16 flags_play_rec;
-	__u16 flags_16bit_8bit;
-	__u16 flags_stereo_mono;
-	__u16 flags_rates;
+	__le16 func_nr;
+	__le16 VOC_type;
+	__le16 flags_play_rec;
+	__le16 flags_16bit_8bit;
+	__le16 flags_stereo_mono;
+	__le16 flags_rates;
 };
 
 /*
@@ -314,7 +314,7 @@ static int snd_sb_csp_riff_load(struct snd_sb_csp * p,
 	unsigned short func_nr = 0;
 
 	struct riff_header file_h, item_h, code_h;
-	__u32 item_type;
+	__le32 item_type;
 	struct desc_header funcdesc_h;
 
 	unsigned long flags;
@@ -326,7 +326,7 @@ static int snd_sb_csp_riff_load(struct snd_sb_csp * p,
 
 	if (copy_from_user(&file_h, data_ptr, sizeof(file_h)))
 		return -EFAULT;
-	if ((file_h.name != RIFF_HEADER) ||
+	if ((le32_to_cpu(file_h.name) != RIFF_HEADER) ||
 	    (le32_to_cpu(file_h.len) >= SNDRV_SB_CSP_MAX_MICROCODE_FILE_SIZE - sizeof(file_h))) {
 		snd_printd("%s: Invalid RIFF header\n", __func__);
 		return -EINVAL;
@@ -336,7 +336,7 @@ static int snd_sb_csp_riff_load(struct snd_sb_csp * p,
 
 	if (copy_from_user(&item_type, data_ptr, sizeof(item_type)))
 		return -EFAULT;
-	if (item_type != CSP__HEADER) {
+	if (le32_to_cpu(item_type) != CSP__HEADER) {
 		snd_printd("%s: Invalid RIFF file type\n", __func__);
 		return -EINVAL;
 	}
@@ -346,12 +346,12 @@ static int snd_sb_csp_riff_load(struct snd_sb_csp * p,
 		if (copy_from_user(&item_h, data_ptr, sizeof(item_h)))
 			return -EFAULT;
 		data_ptr += sizeof(item_h);
-		if (item_h.name != LIST_HEADER)
+		if (le32_to_cpu(item_h.name) != LIST_HEADER)
 			continue;
 
 		if (copy_from_user(&item_type, data_ptr, sizeof(item_type)))
 			 return -EFAULT;
-		switch (item_type) {
+		switch (le32_to_cpu(item_type)) {
 		case FUNC_HEADER:
 			if (copy_from_user(&funcdesc_h, data_ptr + sizeof(item_type), sizeof(funcdesc_h)))
 				return -EFAULT;
@@ -378,7 +378,7 @@ static int snd_sb_csp_riff_load(struct snd_sb_csp * p,
 					return -EFAULT;
 
 				/* init microcode blocks */
-				if (code_h.name != INIT_HEADER)
+				if (le32_to_cpu(code_h.name) != INIT_HEADER)
 					break;
 				data_ptr += sizeof(code_h);
 				err = snd_sb_csp_load_user(p, data_ptr, le32_to_cpu(code_h.len),
@@ -391,7 +391,7 @@ static int snd_sb_csp_riff_load(struct snd_sb_csp * p,
 			if (copy_from_user(&code_h, data_ptr, sizeof(code_h)))
 				return -EFAULT;
 
-			if (code_h.name != MAIN_HEADER) {
+			if (le32_to_cpu(code_h.name) != MAIN_HEADER) {
 				snd_printd("%s: Missing 'main' microcode\n", __func__);
 				return -EINVAL;
 			}
-- 
2.18.0
