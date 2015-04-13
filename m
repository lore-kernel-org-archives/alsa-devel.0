From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 12/13] ASoC: wm_adsp: Add support for rev 2
	firmware file format
Date: Mon, 13 Apr 2015 13:28:04 +0100
Message-ID: <1428928085-20250-13-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 0E9742650BC
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 14:34:14 +0200 (CEST)
In-Reply-To: <1428928085-20250-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

Version 2 of the firmware file format includes length fields for the
various strings associated with control creation, to reduce file size.
However this does increase the parsing complexity slightly. This patch
adds support for the revision of the file format.

This patch also adds a new naming scheme for controls created from rev 2
firmware files. This version of the file format is commonly used to
add multiple controls per algorithm per memory region and the old
control naming scheme would cause multiple controls to have the same
name in this case.. Note that the naming scheme for older firmware
versions is left intact to ensure backwards compatibility.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm_adsp.c |  137 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 119 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index edf3ba3..a5dd22e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -620,8 +620,31 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 		return -EINVAL;
 	}
 
-	snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "DSP%d %s %x",
-		 dsp->num, region_name, alg_region->alg);
+	switch (dsp->fw_ver) {
+	case 0:
+	case 1:
+		snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN, "DSP%d %s %x",
+			 dsp->num, region_name, alg_region->alg);
+		break;
+	default:
+		ret = snprintf(name, SNDRV_CTL_ELEM_ID_NAME_MAXLEN,
+				"DSP%d%c %.12s %x", dsp->num, *region_name,
+				wm_adsp_fw_text[dsp->fw], alg_region->alg);
+
+		/* Truncate the subname from the start if it is too long */
+		if (subname) {
+			int avail = SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret - 2;
+			int skip = 0;
+
+			if (subname_len > avail)
+				skip = subname_len - avail;
+
+			snprintf(name + ret,
+				 SNDRV_CTL_ELEM_ID_NAME_MAXLEN - ret, " %.*s",
+				 subname_len - skip, subname + skip);
+		}
+		break;
+	}
 
 	list_for_each_entry(ctl, &dsp->ctl_list,
 			    list) {
@@ -704,18 +727,73 @@ struct wm_coeff_parsed_coeff {
 	int len;
 };
 
+static int wm_coeff_parse_string(int bytes, const u8 **pos, const u8 **str)
+{
+	int length;
+
+	switch (bytes) {
+	case 1:
+		length = **pos;
+		break;
+	case 2:
+		length = le16_to_cpu(*((u16 *)*pos));
+		break;
+	default:
+		return 0;
+	}
+
+	if (str)
+		*str = *pos + bytes;
+
+	*pos += ((length + bytes) + 3) & ~0x03;
+
+	return length;
+}
+
+static int wm_coeff_parse_int(int bytes, const u8 **pos)
+{
+	int val = 0;
+
+	switch (bytes) {
+	case 2:
+		val = le16_to_cpu(*((u16 *)*pos));
+		break;
+	case 4:
+		val = le32_to_cpu(*((u32 *)*pos));
+		break;
+	default:
+		break;
+	}
+
+	*pos += bytes;
+
+	return val;
+}
+
 static inline void wm_coeff_parse_alg(struct wm_adsp *dsp, const u8 **data,
 				      struct wm_coeff_parsed_alg *blk)
 {
 	const struct wmfw_adsp_alg_data *raw;
 
-	raw = (const struct wmfw_adsp_alg_data *)*data;
-	*data = raw->data;
+	switch (dsp->fw_ver) {
+	case 0:
+	case 1:
+		raw = (const struct wmfw_adsp_alg_data *)*data;
+		*data = raw->data;
 
-	blk->id = le32_to_cpu(raw->id);
-	blk->name = raw->name;
-	blk->name_len = strlen(raw->name);
-	blk->ncoeff = le32_to_cpu(raw->ncoeff);
+		blk->id = le32_to_cpu(raw->id);
+		blk->name = raw->name;
+		blk->name_len = strlen(raw->name);
+		blk->ncoeff = le32_to_cpu(raw->ncoeff);
+		break;
+	default:
+		blk->id = wm_coeff_parse_int(sizeof(raw->id), data);
+		blk->name_len = wm_coeff_parse_string(sizeof(u8), data,
+						      &blk->name);
+		wm_coeff_parse_string(sizeof(u16), data, NULL);
+		blk->ncoeff = wm_coeff_parse_int(sizeof(raw->ncoeff), data);
+		break;
+	}
 
 	adsp_dbg(dsp, "Algorithm ID: %#x\n", blk->id);
 	adsp_dbg(dsp, "Algorithm name: %.*s\n", blk->name_len, blk->name);
@@ -726,17 +804,39 @@ static inline void wm_coeff_parse_coeff(struct wm_adsp *dsp, const u8 **data,
 					struct wm_coeff_parsed_coeff *blk)
 {
 	const struct wmfw_adsp_coeff_data *raw;
+	const u8 *tmp;
+	int length;
 
-	raw = (const struct wmfw_adsp_coeff_data *)*data;
-	*data = *data + sizeof(raw->hdr) + le32_to_cpu(raw->hdr.size);
-
-	blk->offset = le16_to_cpu(raw->hdr.offset);
-	blk->mem_type = le16_to_cpu(raw->hdr.type);
-	blk->name = raw->name;
-	blk->name_len = strlen(raw->name);
-	blk->ctl_type = le16_to_cpu(raw->ctl_type);
-	blk->flags = le16_to_cpu(raw->flags);
-	blk->len = le32_to_cpu(raw->len);
+	switch (dsp->fw_ver) {
+	case 0:
+	case 1:
+		raw = (const struct wmfw_adsp_coeff_data *)*data;
+		*data = *data + sizeof(raw->hdr) + le32_to_cpu(raw->hdr.size);
+
+		blk->offset = le16_to_cpu(raw->hdr.offset);
+		blk->mem_type = le16_to_cpu(raw->hdr.type);
+		blk->name = raw->name;
+		blk->name_len = strlen(raw->name);
+		blk->ctl_type = le16_to_cpu(raw->ctl_type);
+		blk->flags = le16_to_cpu(raw->flags);
+		blk->len = le32_to_cpu(raw->len);
+		break;
+	default:
+		tmp = *data;
+		blk->offset = wm_coeff_parse_int(sizeof(raw->hdr.offset), &tmp);
+		blk->mem_type = wm_coeff_parse_int(sizeof(raw->hdr.type), &tmp);
+		length = wm_coeff_parse_int(sizeof(raw->hdr.size), &tmp);
+		blk->name_len = wm_coeff_parse_string(sizeof(u8), &tmp,
+						      &blk->name);
+		wm_coeff_parse_string(sizeof(u8), &tmp, NULL);
+		wm_coeff_parse_string(sizeof(u16), &tmp, NULL);
+		blk->ctl_type = wm_coeff_parse_int(sizeof(raw->ctl_type), &tmp);
+		blk->flags = wm_coeff_parse_int(sizeof(raw->flags), &tmp);
+		blk->len = wm_coeff_parse_int(sizeof(raw->len), &tmp);
+
+		*data = *data + sizeof(raw->hdr) + length;
+		break;
+	}
 
 	adsp_dbg(dsp, "\tCoefficient type: %#x\n", blk->mem_type);
 	adsp_dbg(dsp, "\tCoefficient offset: %#x\n", blk->offset);
@@ -836,6 +936,7 @@ static int wm_adsp_load(struct wm_adsp *dsp)
 	switch (header->ver) {
 	case 0:
 	case 1:
+	case 2:
 		break;
 	default:
 		adsp_err(dsp, "%s: unknown file format %d\n",
-- 
1.7.2.5
