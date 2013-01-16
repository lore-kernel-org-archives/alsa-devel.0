From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 11/19] ALSA: ymu831: add data parser
Date: Wed, 16 Jan 2013 17:37:04 +0900
Message-ID: <20130116173704.381ec63138c2ad11dee4640c@linux-mips.org>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, yuasa@linux-mips.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 sound/soc/codecs/ymu831/Makefile   |    3 +-
 sound/soc/codecs/ymu831/mcparser.c | 1132 ++++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/mcparser.h |   40 ++
 3 files changed, 1174 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/ymu831/mcparser.c
 create mode 100644 sound/soc/codecs/ymu831/mcparser.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index 01f5910..820dec7 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -5,6 +5,7 @@ snd-soc-ymu831-objs := \
 	mcdriver.o	\
 	mcedspdrv.o	\
 	mcfdspdrv.o	\
-	mcpacking.o
+	mcpacking.o	\
+	mcparser.o
 
 obj-$(CONFIG_SND_SOC_YMU831) += snd-soc-ymu831.o
diff --git a/sound/soc/codecs/ymu831/mcparser.c b/sound/soc/codecs/ymu831/mcparser.c
new file mode 100644
index 0000000..b2ba4bc
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcparser.c
@@ -0,0 +1,1132 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcparser.c
+ * Description	: MC data parser
+ * Version	: 1.0.0	Dec 13 2012
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty.	In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ * 1. The origin of this software must not be misrepresented; you must not
+ *	claim that you wrote the original software. If you use this software
+ *	in a product, an acknowledgment in the product documentation would be
+ *	appreciated but is not required.
+ * 2. Altered source versions must be plainly marked as such, and must not be
+ *	misrepresented as being the original software.
+ * 3. This notice may not be removed or altered from any source distribution.
+ *
+ ****************************************************************************/
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unnecessary comments
+ * - remove unused codes
+ */
+#include <linux/errno.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include "mcbdspdrv.h"
+#include "mccdspdrv.h"
+#include "mcdriver.h"
+#include "mcedspdrv.h"
+#include "mcfdspdrv.h"
+#include "mcparser.h"
+
+#define AEC_MIN_BYTES			12
+#define AEC_REVISION			5
+#define AEC_TARGET			253
+
+#define AEC_D7_MIN_BYTES		6
+#define AEC_D7_CHUNK_CONFIG		0x01000000
+#define AEC_D7_CHUNK_AE			0x02000000
+#define AEC_D7_CHUNK_BDSP_ES1		0x00010000
+#define AEC_D7_CHUNK_BDSP		0x00010001
+#define AEC_D7_CHUNK_FDSP_ES1		0x00020000
+#define AEC_D7_CHUNK_FDSP		0x00020001
+#define AEC_D7_CHUNK_VBOX		0x03000000
+#define AEC_D7_CHUNK_CDSPA		0x00030000
+#define AEC_D7_CHUNK_CDSPB		0x00030001
+#define AEC_D7_CHUNK_CDSP_DEBUG		0x00050000
+#define AEC_D7_CHUNK_OUTPUT0_ES1	0x04000000
+#define AEC_D7_CHUNK_OUTPUT1_ES1	0x04000001
+#define AEC_D7_CHUNK_OUTPUT0		0x04000002
+#define AEC_D7_CHUNK_OUTPUT1		0x04000003
+#define AEC_D7_CHUNK_SYSEQ_EX		0x00060000
+#define AEC_D7_CHUNK_INPUT0		0x05000000
+#define AEC_D7_CHUNK_INPUT1		0x05000001
+#define AEC_D7_CHUNK_INPUT2		0x05000002
+#define AEC_D7_CHUNK_PDM		0x06000000
+#define AEC_D7_CHUNK_E2			0x07000000
+#define AEC_D7_CHUNK_E2_CONFIG		0x00040000
+#define AEC_D7_CHUNK_ADJ		0x08000000
+#define AEC_D7_CHUNK_EDSP_MISC		0x09000000
+#define AEC_D7_CHUNK_CONTROL		0x0A000000
+
+struct mcdrv_aec_d7_info {
+	u8 *top;
+	u32 size;
+};
+
+static int analyze_audioengine_sub_data(u8 *data, u32 *offset, u32 *data_size,
+					struct mcdrv_aec_info *aec)
+{
+	enum mcdrv_dev_id dev_id;
+	u32 id, size;
+
+	dev_id = mc_dev_id_get();
+
+	while (*data_size > 0) {
+		if (*data_size < 8)
+			return -EINVAL;
+
+		id = htonl(*(u32 *) (data + *offset));
+		size = htonl(*(u32 *) (data + *offset + 4));
+
+		*data_size -= 8;
+		if (*data_size < size)
+			return -EINVAL;
+
+		if ((id == AEC_D7_CHUNK_BDSP_ES1 &&
+		     dev_id == MCDRV_DEV_ID_80_90H) ||
+		    (id == AEC_D7_CHUNK_BDSP &&
+		     dev_id != MCDRV_DEV_ID_80_90H)) {
+			if (aec->audio_engine.bdsp.data)
+				return -EINVAL;
+
+			aec->audio_engine.bdsp.data = data + *offset;
+			aec->audio_engine.bdsp.data_size = size;
+		} else if ((id == AEC_D7_CHUNK_FDSP_ES1 &&
+			    dev_id == MCDRV_DEV_ID_80_90H) ||
+			   (id == AEC_D7_CHUNK_FDSP &&
+			    dev_id != MCDRV_DEV_ID_80_90H)) {
+			if (aec->audio_engine.fdsp.data)
+				return -EINVAL;
+
+			aec->audio_engine.fdsp.data = data + *offset;
+			aec->audio_engine.fdsp.data_size = size;
+		} else
+			return -EINVAL;
+
+		*offset += size + 8;
+		*data_size -= size;
+	}
+
+	return 0;
+}
+
+static int analyze_vbox_sub_data(u8 *data, u32 *offset, u32 *data_size,
+				 struct mcdrv_aec_info *aec)
+{
+	enum mcdrv_dev_id dev_id;
+	u32 id, size;
+
+	dev_id = mc_dev_id_get();
+
+	while (*data_size > 0) {
+		if (*data_size < 8)
+			return -EINVAL;
+
+		id = htonl(*(u32 *) (data + *offset));
+		size = htonl(*(u32 *) (data + *offset + 4));
+
+		*data_size -= 8;
+		if (*data_size < size)
+			return -EINVAL;
+
+		if (id == AEC_D7_CHUNK_CDSPA) {
+			if (aec->vbox.cdsp_a.data)
+				return -EINVAL;
+
+			aec->vbox.cdsp_a.data = data + *offset;
+			aec->vbox.cdsp_a.data_size = size;
+		} else if (id == AEC_D7_CHUNK_CDSPB) {
+			if (aec->vbox.cdsp_b.data)
+				return -EINVAL;
+
+			aec->vbox.cdsp_b.data = data + *offset;
+			aec->vbox.cdsp_b.data_size = size;
+		} else if ((id == AEC_D7_CHUNK_FDSP_ES1 &&
+			    dev_id == MCDRV_DEV_ID_80_90H) ||
+			   (id == AEC_D7_CHUNK_FDSP &&
+			    dev_id != MCDRV_DEV_ID_80_90H)) {
+			if (aec->vbox.fdsp.data)
+				return -EINVAL;
+
+			aec->vbox.fdsp.data = data + *offset;
+			aec->vbox.fdsp.data_size = size;
+		} else if (id == AEC_D7_CHUNK_CDSP_DEBUG) {
+			if (size != 1)
+				return -EINVAL;
+
+			if (aec->vbox.cdsp_jtag_on != 0xff)
+				return -EINVAL;
+			if (data[*offset + 8] > 1)
+				return -EINVAL;
+			aec->vbox.cdsp_jtag_on = data[*offset + 8];
+		} else
+			return -EINVAL;
+
+		*offset += size + 8;
+		*data_size -= size;
+	}
+
+	return 0;
+}
+
+static int analyze_edsp_sub_data(u8 *data, u32 *offset, u32 *data_size,
+				 struct mcdrv_aec_info *aec)
+{
+	u32 id, size;
+
+	while (*data_size > 0) {
+		if (*data_size < 8)
+			return -EINVAL;
+
+		id = htonl(*(u32 *) (data + *offset));
+		size = htonl(*(u32 *) (data + *offset + 4));
+
+		*data_size -= 8;
+		if (*data_size < size)
+			return -EINVAL;
+
+		if (id == AEC_D7_CHUNK_E2_CONFIG) {
+			if (aec->e2.config.data)
+				return -EINVAL;
+
+			aec->e2.config.data = data + *offset;
+			aec->e2.config.data_size = size;
+
+			*offset += size + 8;
+			*data_size -= size;
+		} else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int get_d7_info(u8 *data, u32 size, struct mcdrv_aec_d7_info *d7_info)
+{
+	u32 data_size, offset, chunk_size;
+
+	if (size < AEC_MIN_BYTES)
+		return -EINVAL;
+
+	/* header */
+	if (data[0] != 0x41 || data[1] != 0x45 || data[2] != 0x43)
+		return -EINVAL;
+
+	/* revision */
+	if (data[3] != AEC_REVISION)
+		return -EINVAL;
+
+	/* size */
+	data_size = htonl(*(u32 *) (data + 4));
+	if (size != data_size + 8)
+		return -EINVAL;
+
+	/* target */
+	if (data[9] != AEC_TARGET)
+		return -EINVAL;
+
+	/* Reserved */
+	if (data[11] != 0x00)
+		return -EINVAL;
+
+	/* D7 Chunk Search */
+	d7_info->top = NULL;
+	d7_info->size = 0;
+	offset = AEC_MIN_BYTES;
+
+	while ((offset + AEC_D7_MIN_BYTES) < size) {
+		if (data[offset] == 0x44 && data[offset + 1] == 0x37) {
+			if (d7_info->top)
+				return -EINVAL;
+
+			chunk_size = htonl(*(u32 *) (data + offset + 2));
+			if ((offset + AEC_D7_MIN_BYTES + chunk_size) > size)
+				return -EINVAL;
+
+			d7_info->top = data + offset + AEC_D7_MIN_BYTES;
+			d7_info->size = chunk_size;
+		} else
+			return -EINVAL;
+
+		/* Next Chunk */
+		offset += chunk_size + AEC_D7_MIN_BYTES;
+	}
+
+	if (!d7_info->top)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int analyze_syseq_ex_sub_data(u8 *data, u32 *offset, u32 *sub_size,
+				     struct mcdrv_aec_syseq_ex *syseq_ex)
+{
+	u32 id, size;
+
+	while (*sub_size > 0) {
+		if (*sub_size < 8)
+			return -EINVAL;
+
+		id = htonl(*(u32 *) (data + *offset));
+		size = htonl(*(u32 *) (data + *offset + 4));
+
+		*offset += 8;
+		*sub_size -= 8;
+		if (*sub_size < size)
+			return -EINVAL;
+
+		if (id == AEC_D7_CHUNK_SYSEQ_EX) {
+			if (size != 30)
+				return -EINVAL;
+
+			if (syseq_ex->enable)
+				return -EINVAL;
+
+			syseq_ex->enable = true;
+			syseq_ex->band[0].coef_a0[0] = data[*offset++];
+			syseq_ex->band[0].coef_a0[1] = data[*offset++];
+			syseq_ex->band[0].coef_a0[2] = data[*offset++];
+			syseq_ex->band[0].coef_a1[0] = data[*offset++];
+			syseq_ex->band[0].coef_a1[1] = data[*offset++];
+			syseq_ex->band[0].coef_a1[2] = data[*offset++];
+			syseq_ex->band[0].coef_a2[0] = data[*offset++];
+			syseq_ex->band[0].coef_a2[1] = data[*offset++];
+			syseq_ex->band[0].coef_a2[2] = data[*offset++];
+			syseq_ex->band[0].coef_b1[0] = data[*offset++];
+			syseq_ex->band[0].coef_b1[1] = data[*offset++];
+			syseq_ex->band[0].coef_b1[2] = data[*offset++];
+			syseq_ex->band[0].coef_b2[0] = data[*offset++];
+			syseq_ex->band[0].coef_b2[1] = data[*offset++];
+			syseq_ex->band[0].coef_b2[2] = data[*offset++];
+			syseq_ex->band[1].coef_a0[0] = data[*offset++];
+			syseq_ex->band[1].coef_a0[1] = data[*offset++];
+			syseq_ex->band[1].coef_a0[2] = data[*offset++];
+			syseq_ex->band[1].coef_a1[0] = data[*offset++];
+			syseq_ex->band[1].coef_a1[1] = data[*offset++];
+			syseq_ex->band[1].coef_a1[2] = data[*offset++];
+			syseq_ex->band[1].coef_a2[0] = data[*offset++];
+			syseq_ex->band[1].coef_a2[1] = data[*offset++];
+			syseq_ex->band[1].coef_a2[2] = data[*offset++];
+			syseq_ex->band[1].coef_b1[0] = data[*offset++];
+			syseq_ex->band[1].coef_b1[1] = data[*offset++];
+			syseq_ex->band[1].coef_b1[2] = data[*offset++];
+			syseq_ex->band[1].coef_b2[0] = data[*offset++];
+			syseq_ex->band[1].coef_b2[1] = data[*offset++];
+			syseq_ex->band[1].coef_b2[2] = data[*offset++];
+			*sub_size -= size;
+		} else
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+int mc_parser_d7_data_analyze(u8 *data, u32 size, struct mcdrv_aec_info *aec)
+{
+	struct mcdrv_aec_d7_info d7_info;
+	enum mcdrv_dev_id dev_id;
+	u8 *d7_data;
+	u32 offset, d7_data_end;
+	u32 id, sub_size;
+	int n, ret;
+
+	ret = get_d7_info(data, size, &d7_info);
+	if (ret < 0)
+		return ret;
+
+	dev_id = mc_dev_id_get();
+
+	d7_data = d7_info.top;
+	d7_data_end = d7_info.size - 1;
+
+	aec->fdsp_locate = 0xFF;
+	aec->audio_engine.enable = false;
+	aec->audio_engine.bdsp.data = NULL;
+	aec->audio_engine.bdsp.data_size = 0;
+	aec->audio_engine.fdsp.data = NULL;
+	aec->audio_engine.fdsp.data_size = 0;
+	aec->vbox.enable = false;
+	aec->vbox.cdsp_a.data = NULL;
+	aec->vbox.cdsp_a.data_size = 0;
+	aec->vbox.cdsp_b.data = NULL;
+	aec->vbox.cdsp_b.data_size = 0;
+	aec->vbox.fdsp.data = NULL;
+	aec->vbox.fdsp.data_size = 0;
+	aec->vbox.cdsp_jtag_on = 0xff;
+	aec->output.lpf_pre_thru[0] = 0xFF;
+	aec->output.lpf_pre_thru[1] = 0xFF;
+	aec->input.dsf32_l_type[0] = 0xFF;
+	aec->input.dsf32_l_type[1] = 0xFF;
+	aec->input.dsf32_l_type[2] = 0xFF;
+	aec->pdm.mode = 0xFF;
+	aec->e2.enable = false;
+	aec->e2.config.data = NULL;
+	aec->e2.config.data_size = 0;
+	aec->adj.hold = 0xFF;
+	aec->edsp_misc.i2s_out_enable = 0xFF;
+	aec->control.command = 0xFF;
+
+	offset = 0;
+	while (offset <= d7_data_end && !ret) {
+		if ((offset + 8 - 1) > d7_data_end) {
+			ret = -EINVAL;
+			break;
+		}
+
+		id = htonl(*(u32 *) (d7_data + offset));
+		sub_size = htonl(*(u32 *) (d7_data + offset + 4));
+
+		offset += 8;
+		if ((offset + sub_size - 1) > d7_data_end) {
+			ret = -EINVAL;
+			break;
+		}
+
+		switch (id) {
+		case AEC_D7_CHUNK_CONFIG:
+			if (sub_size != 1 || aec->fdsp_locate != 0xFF ||
+			    d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->fdsp_locate = d7_data[offset++];
+			sub_size = 0;
+			break;
+		case AEC_D7_CHUNK_AE:
+			if (sub_size < 8 || aec->audio_engine.enable ||
+			    d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->audio_engine.enable = true;
+			aec->audio_engine.on = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->audio_engine.fdsp_on = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->audio_engine.bdsp_ae0_src = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->audio_engine.bdsp_ae1_src = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->audio_engine.mixer_in0_src = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->audio_engine.mixer_in1_src = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->audio_engine.mixer_in2_src = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->audio_engine.mixer_in3_src = d7_data[offset++];
+			sub_size--;
+
+			if (sub_size > 0) {
+				ret = analyze_audioengine_sub_data(d7_data,
+								   &offset,
+								   &sub_size,
+								   aec);
+			}
+			break;
+		case AEC_D7_CHUNK_VBOX:
+			if (sub_size < 15 || aec->vbox.enable) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.enable = true;
+
+			if (d7_data[offset] > 2 && d7_data[offset] != 0x11) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.cdsp_func_a_on = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2 && d7_data[offset] != 0x11) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.cdsp_func_b_on = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.fdsp_on = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 0x3F && d7_data[offset] < 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.fdsp_po_source = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 1 && d7_data[offset] < 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.isrc2_vsource = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 1 && d7_data[offset] < 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.isrc2_ch1_vsource = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 1 && d7_data[offset] < 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.isrc3_vsource = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 1 && d7_data[offset] < 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.lpt2_vsource = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 3 && d7_data[offset] < 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.lpt2_mix_vol_o = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 3 && d7_data[offset] < 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.lpt2_mix_vol_i = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 3 && d7_data[offset] < 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.src3_ctrl = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] == 3 || d7_data[offset] == 7 ||
+			    d7_data[offset] == 11 ||
+			    (d7_data[offset] > 13 && d7_data[offset] < 0xFF)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.src2_fs = d7_data[offset++];
+			sub_size--;
+
+			if (dev_id == MCDRV_DEV_ID_80_90H) {
+				if (d7_data[offset] > 1 &&
+				    d7_data[offset] < 0xFF) {
+					ret = -EINVAL;
+					break;
+				}
+				aec->vbox.src2_thru = d7_data[offset++];
+			} else
+				offset++;
+			sub_size--;
+
+			if (d7_data[offset] == 3 || d7_data[offset] == 7 ||
+			    d7_data[offset] == 11 ||
+			    (d7_data[offset] > 13 && d7_data[offset] < 0xFF)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.src3_fs = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 1 && d7_data[offset] < 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->vbox.src3_thru = d7_data[offset++];
+			sub_size--;
+
+			if (sub_size > 0) {
+				ret = analyze_vbox_sub_data(d7_data,
+							    &offset,
+							    &sub_size, aec);
+			}
+			break;
+		case AEC_D7_CHUNK_OUTPUT0_ES1:
+		case AEC_D7_CHUNK_OUTPUT1_ES1:
+		case AEC_D7_CHUNK_OUTPUT0:
+		case AEC_D7_CHUNK_OUTPUT1:
+			if (dev_id == MCDRV_DEV_ID_80_90H) {
+				if (id != AEC_D7_CHUNK_OUTPUT0_ES1 &&
+				    id != AEC_D7_CHUNK_OUTPUT1_ES1)
+					break;
+				n = id - AEC_D7_CHUNK_OUTPUT0_ES1;
+			} else {
+				if (id != AEC_D7_CHUNK_OUTPUT0 &&
+				    id != AEC_D7_CHUNK_OUTPUT1)
+					break;
+				n = id - AEC_D7_CHUNK_OUTPUT0;
+			}
+			if (sub_size < 47 ||
+			    aec->output.lpf_pre_thru[n] != 0xFF ||
+			    d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.lpf_pre_thru[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.lpf_post_thru[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dcc_sel[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 5) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.signal_detect_level = d7_data[offset++];
+
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.power_detect_level[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.osf_sel[n] = d7_data[offset++];
+
+			if (dev_id == MCDRV_DEV_ID_80_90H) {
+				if (d7_data[offset] > 1) {
+					ret = -EINVAL;
+					break;
+				}
+			} else {
+				if (d7_data[offset] > 7) {
+					ret = -EINVAL;
+					break;
+				}
+			}
+			aec->output.syseq_enb[n] = d7_data[offset++];
+			aec->output.syseq_coef_a0[n][0] = d7_data[offset++];
+			aec->output.syseq_coef_a0[n][1] = d7_data[offset++];
+			aec->output.syseq_coef_a0[n][2] = d7_data[offset++];
+			aec->output.syseq_coef_a1[n][0] = d7_data[offset++];
+			aec->output.syseq_coef_a1[n][1] = d7_data[offset++];
+			aec->output.syseq_coef_a1[n][2] = d7_data[offset++];
+			aec->output.syseq_coef_a2[n][0] = d7_data[offset++];
+			aec->output.syseq_coef_a2[n][1] = d7_data[offset++];
+			aec->output.syseq_coef_a2[n][2] = d7_data[offset++];
+			aec->output.syseq_coef_b1[n][0] = d7_data[offset++];
+			aec->output.syseq_coef_b1[n][1] = d7_data[offset++];
+			aec->output.syseq_coef_b1[n][2] = d7_data[offset++];
+			aec->output.syseq_coef_b2[n][0] = d7_data[offset++];
+			aec->output.syseq_coef_b2[n][1] = d7_data[offset++];
+			aec->output.syseq_coef_b2[n][2] = d7_data[offset++];
+
+			if (d7_data[offset] > 7) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.clip_md[n] = d7_data[offset++];
+			aec->output.clip_att[n] = d7_data[offset++];
+			aec->output.clip_rel[n] = d7_data[offset++];
+			aec->output.clip_g[n] = d7_data[offset++];
+			aec->output.osf_gain[n][0] = d7_data[offset++];
+			aec->output.osf_gain[n][1] = d7_data[offset++];
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dcl_on[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dcl_gain[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 0x7F) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dcl_limit[n][0] = d7_data[offset++];
+			aec->output.dcl_limit[n][1] = d7_data[offset++];
+
+			if (dev_id == MCDRV_DEV_ID_80_90H) {
+				if (d7_data[offset] > 1) {
+					ret = -EINVAL;
+					break;
+				}
+				aec->output.random_dither_on[n] =
+				    d7_data[offset++];
+			} else
+				offset++;
+
+			if (dev_id == MCDRV_DEV_ID_80_90H) {
+				if (d7_data[offset] > 3) {
+					ret = -EINVAL;
+					break;
+				}
+				aec->output.random_dither_level[n] =
+				    d7_data[offset++];
+			} else
+				offset++;
+
+			if (dev_id == MCDRV_DEV_ID_80_90H) {
+				if (d7_data[offset] > 1) {
+					ret = -EINVAL;
+					break;
+				}
+				aec->output.random_dither_pos[n] =
+				    d7_data[offset++];
+			} else
+				offset++;
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dc_dither_on[n] = d7_data[offset++];
+
+			if (dev_id == MCDRV_DEV_ID_80_90H) {
+				if (d7_data[offset] > 15) {
+					ret = -EINVAL;
+					break;
+				}
+				aec->output.dc_dither_level[n] =
+				    d7_data[offset++];
+			} else
+				offset++;
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dither_type[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dng_on[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 31) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dng_zero[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dng_time[n] = d7_data[offset++];
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->output.dng_fw[n] = d7_data[offset++];
+			aec->output.dng_attack = d7_data[offset++];
+			aec->output.dng_release = d7_data[offset++];
+			aec->output.dng_target[n] = d7_data[offset++];
+			aec->output.dng_target_lineout[n] = d7_data[offset++];
+			if (n == 0)
+				aec->output.dng_target_rc = d7_data[offset++];
+			else
+				offset++;
+
+			sub_size -= 47;
+			if (sub_size > 0)
+				ret = analyze_syseq_ex_sub_data(data, &offset,
+								&sub_size,
+								&aec->output.
+								syseq_ex[n]);
+			break;
+		case AEC_D7_CHUNK_INPUT0:
+		case AEC_D7_CHUNK_INPUT1:
+		case AEC_D7_CHUNK_INPUT2:
+			n = id - AEC_D7_CHUNK_INPUT0;
+			if (sub_size < 16 ||
+			    aec->input.dsf32_l_type[n] != 0xFF ||
+			    (n == 0 && d7_data[offset] > 2) ||
+			    (n != 0 && d7_data[offset] > 1)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.dsf32_l_type[n] = d7_data[offset++];
+
+			if ((n == 0 && d7_data[offset] > 2) ||
+			    (n != 0 && d7_data[offset] > 1)) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.dsf32_r_type[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.dsf4_sel[n] = d7_data[offset++];
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.dcc_sel[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.dng_on[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.dng_att[n] = d7_data[offset++];
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.dng_rel[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.dng_fw[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 0x3F) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.dng_time[n] = d7_data[offset++];
+			aec->input.dng_zero[n][0] = d7_data[offset++];
+			aec->input.dng_zero[n][1] = d7_data[offset++];
+			aec->input.dng_target[n][0] = d7_data[offset++];
+			aec->input.dng_target[n][1] = d7_data[offset++];
+
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.depop_att[n] = d7_data[offset++];
+
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->input.depop_wait[n] = d7_data[offset++];
+			if (n == 2) {
+				if (d7_data[offset] > 1) {
+					ret = -EINVAL;
+					break;
+				}
+
+				aec->input.ref_sel = d7_data[offset++];
+			} else
+				offset++;
+
+			sub_size = 0;
+			break;
+		case AEC_D7_CHUNK_PDM:
+			if (sub_size != 10 || aec->pdm.mode != 0xFF ||
+			    d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.mode = d7_data[offset++];
+
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.st_wait = d7_data[offset++];
+
+			if (d7_data[offset] > 7) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.pdm0_loadtime = d7_data[offset++];
+
+			if (d7_data[offset] > 63) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.pdm0_l_finedelay = d7_data[offset++];
+
+			if (d7_data[offset] > 63) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.pdm0_r_finedelay = d7_data[offset++];
+
+			if (d7_data[offset] > 7) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.pdm1_loadtime = d7_data[offset++];
+
+			if (d7_data[offset] > 63) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.pdm1_l_finedelay = d7_data[offset++];
+
+			if (d7_data[offset] > 63) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.pdm1_r_finedelay = d7_data[offset++];
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.pdm0_data_delay = d7_data[offset++];
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->pdm.pdm1_data_delay = d7_data[offset++];
+
+			sub_size = 0;
+			break;
+		case AEC_D7_CHUNK_E2:
+			if (sub_size < 3 || aec->e2.enable) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->e2.enable = true;
+
+			if (d7_data[offset] > 4) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->e2.da_sel = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 8) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->e2.ad_sel = d7_data[offset++];
+			sub_size--;
+
+			if (d7_data[offset] > 2) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->e2.on = d7_data[offset++];
+			sub_size--;
+
+			if (sub_size > 0) {
+				ret = analyze_edsp_sub_data(d7_data,
+							    &offset,
+							    &sub_size, aec);
+			}
+			break;
+		case AEC_D7_CHUNK_ADJ:
+			if (sub_size != 4 || aec->adj.hold != 0xFF ||
+			    d7_data[offset] > 0x3F) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->adj.hold = d7_data[offset++];
+
+			if (d7_data[offset] > 0x0F) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->adj.cnt = d7_data[offset++];
+			aec->adj.max[0] = d7_data[offset++];
+			aec->adj.max[1] = d7_data[offset++];
+
+			sub_size = 0;
+			break;
+		case AEC_D7_CHUNK_EDSP_MISC:
+			if (sub_size != 3 ||
+			    aec->edsp_misc.i2s_out_enable != 0xFF ||
+			    d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->edsp_misc.i2s_out_enable = d7_data[offset++];
+
+			if (d7_data[offset] > 1) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->edsp_misc.ch_sel = d7_data[offset++];
+
+			if (d7_data[offset] > 3) {
+				ret = -EINVAL;
+				break;
+			}
+
+			aec->edsp_misc.loopback = d7_data[offset++];
+
+			sub_size = 0;
+			break;
+		case AEC_D7_CHUNK_CONTROL:
+			if (sub_size != 5 || aec->control.command != 0xFF) {
+				ret = -EINVAL;
+				break;
+			}
+			if (dev_id == MCDRV_DEV_ID_80_90H) {
+				if (d7_data[offset] < 1
+				    || d7_data[offset] > 2) {
+					ret = -EINVAL;
+					break;
+				}
+			} else {
+				if (d7_data[offset] < 1
+				    || d7_data[offset] > 4) {
+					ret = -EINVAL;
+					break;
+				}
+			}
+
+			aec->control.command = d7_data[offset++];
+			aec->control.param[0] = d7_data[offset++];
+			aec->control.param[1] = d7_data[offset++];
+			aec->control.param[2] = d7_data[offset++];
+			aec->control.param[3] = d7_data[offset++];
+
+			sub_size = 0;
+			break;
+		default:
+			ret = -EINVAL;
+		}
+
+		offset += sub_size;
+	}
+
+	return ret;
+}
diff --git a/sound/soc/codecs/ymu831/mcparser.h b/sound/soc/codecs/ymu831/mcparser.h
new file mode 100644
index 0000000..996c8ab
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mcparser.h
@@ -0,0 +1,40 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mcparser.h
+ * Description	: MC data parser header
+ * Version	: 1.0.0	Dec 13 2012
+ *
+ * This software is provided 'as-is', without any express or implied
+ * warranty.	In no event will the authors be held liable for any damages
+ * arising from the use of this software.
+ *
+ * Permission is granted to anyone to use this software for any purpose,
+ * including commercial applications, and to alter it and redistribute it
+ * freely, subject to the following restrictions:
+ *
+ * 1. The origin of this software must not be misrepresented; you must not
+ *	claim that you wrote the original software. If you use this software
+ *	in a product, an acknowledgment in the product documentation would be
+ *	appreciated but is not required.
+ * 2. Altered source versions must be plainly marked as such, and must not be
+ *	misrepresented as being the original software.
+ * 3. This notice may not be removed or altered from any source distribution.
+ *
+ ****************************************************************************/
+/*
+ * changelog:
+ * - change in the Linux coding style
+ * - remove unused codes
+ */
+#ifndef _MCPARSER_H
+#define _MCPARSER_H
+
+#include <linux/types.h>
+
+#include "mcresctrl.h"
+
+int mc_parser_d7_data_analyze(u8 *data, u32 size, struct mcdrv_aec_info *aec);
+
+#endif /* _MCPARSER_H */
-- 
1.7.9.5
