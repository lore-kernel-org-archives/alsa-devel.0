From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: [PATCH 05/19] ALSA: ymu831: add C-DSP driver
Date: Wed, 16 Jan 2013 17:31:03 +0900
Message-ID: <20130116173103.afe73d898a082a6e2abbacb4@linux-mips.org>
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
 sound/soc/codecs/ymu831/Makefile    |    3 +-
 sound/soc/codecs/ymu831/mccdspdrv.c | 5119 +++++++++++++++++++++++++++++++++++
 sound/soc/codecs/ymu831/mccdspdrv.h |   57 +
 3 files changed, 5178 insertions(+), 1 deletion(-)
 create mode 100644 sound/soc/codecs/ymu831/mccdspdrv.c
 create mode 100644 sound/soc/codecs/ymu831/mccdspdrv.h

diff --git a/sound/soc/codecs/ymu831/Makefile b/sound/soc/codecs/ymu831/Makefile
index e74a60f..b42881e 100644
--- a/sound/soc/codecs/ymu831/Makefile
+++ b/sound/soc/codecs/ymu831/Makefile
@@ -1,4 +1,5 @@
 snd-soc-ymu831-objs := \
-	mcbdspdrv.o
+	mcbdspdrv.o	\
+	mccdspdrv.o
 
 obj-$(CONFIG_SND_SOC_YMU831) += snd-soc-ymu831.o
diff --git a/sound/soc/codecs/ymu831/mccdspdrv.c b/sound/soc/codecs/ymu831/mccdspdrv.c
new file mode 100644
index 0000000..c1c9e83
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mccdspdrv.c
@@ -0,0 +1,5119 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mccdspdrv.c
+ * Description	: MC C-DSP driver
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
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
+
+#include "mccdspdrv.h"
+#include "mccdspos.h"
+#include "mcdefs.h"
+#include "mcdevif.h"
+#include "mcresctrl.h"
+
+#undef LOW_BYTE
+#define	LOW_BYTE(w)		((u8)((u16)(w) & 0xff))
+
+#undef	HIGH_BYTE
+#define	HIGH_BYTE(w)		((u8)((u16)(w) >> 8))
+
+#undef	MAKE_HALFWORD
+#define	MAKE_HALFWORD(l, h)	(((u16)(l) & 0xff) | (((u16)(h) & 0xff) << 8))
+
+#define CODER_DEC			0	/* FuncA */
+#define CODER_ENC			1	/* FuncB */
+
+/* state */
+#define STATE_NOTINIT			0
+#define STATE_INIT			1
+#define STATE_READY_SETUP		2
+#define STATE_READY			3
+#define STATE_PLAYING			4
+
+/* call back */
+
+#define CALLBACK_HOSTCOMMAND		0	/* Host command */
+#define CALLBACK_END_OF_SEQUENCE	1	/* End */
+#define CALLBACK_DFIFOPOINT		2	/* DEC_FIFO IRQ point */
+#define CALLBACK_RFIFOPOINT		3	/* REC_FIFO IRQ point */
+#define CALLBACK_DFIFOEMPTY		4	/* DEC_FIFO empty */
+#define CALLBACK_RECBUF_OVF		5	/* Record buffer over flow */
+#define CALLBACK_TIMER			6	/* Timer */
+#define CALLBACK_PLAY_ERROR1		7	/* Play error */
+#define CALLBACK_PLAY_ERROR2		8	/* Play error */
+#define CALLBACK_HW_ERROR		9	/* Hardware error */
+#define CALLBACK_COUNT			10
+
+/* callback position */
+#define CBPOS_DFIFO_NONE		-1
+#define CBPOS_DFIFO_DEF			2048
+#define CBPOS_DFIFO_MIN			0
+#define CBPOS_DFIFO_MAX			4096
+
+#define CBPOS_RFIFO_NONE		-1
+#define CBPOS_RFIFO_DEF			2048
+#define CBPOS_RFIFO_MIN			0
+#define CBPOS_RFIFO_MAX			4096
+
+/* Program parameter */
+#define PRG_DESC_VENDER_ID		0
+#define PRG_DESC_FUNCTION_ID		2
+#define PRG_DESC_PRG_TYPE		4
+#define PRG_DESC_OUTPUT_TYPE		6
+#define PRG_DESC_PRG_SCRAMBLE		8
+#define PRG_DESC_DATA_SCRAMBLE		10
+#define PRG_DESC_ENTRY_ADR		12
+#define PRG_DESC_PRG_LOAD_ADR		14
+#define PRG_DESC_PRG_SIZE		16
+#define PRG_DESC_DATA_LOAD_ADR		18
+#define PRG_DESC_DATA_SIZE		20
+#define PRG_DESC_WORK_BEGIN_ADR		22
+#define PRG_DESC_WORK_SIZE		24
+#define PRG_DESC_STACK_BEGIN_ADR	26
+#define PRG_DESC_STACK_SIZE		28
+#define PRG_DESC_OUTSTARTMODE		30
+#define PRG_DESC_RESOURCE_FLAG		32
+#define PRG_DESC_MAX_LOAD		34
+#define PRG_DESC_PROGRAM		36
+
+/* Program data parameter */
+#define	PRG_PRM_TYPE_TASK0		0x0001
+#define	PRG_PRM_TYPE_TASK1		0x0002
+#define	PRG_PRM_SCRMBL_DISABLE		0x0000
+#define	PRG_PRM_SCRMBL_ENABLE		0x0001
+#define	PRG_PRM_IOTYPE_IN_MASK		0xff00
+#define	PRG_PRM_IOTYPE_IN_PCM		0x0000
+#define	PRG_PRM_IOTYPE_IN_NOPCM		0x0100
+#define	PRG_PRM_IOTYPE_OUT_MASK		0x00ff
+#define	PRG_PRM_IOTYPE_OUT_PCM		0x0000
+#define	PRG_PRM_IOTYPE_OUT_NOPCM	0x0001
+
+/* OS parameter */
+#define ADR_OS_PROG_L			0x00
+#define ADR_OS_PROG_H			0x00
+#define ADR_OS_DATA_L			0x00
+#define ADR_OS_DATA_H			0x00
+
+/* CDSP MSEL */
+#define MSEL_PROG			0x00
+#define MSEL_DATA			0x01
+
+/* FIFO size */
+#define FIFOSIZE_DFIFO			4096
+#define FIFOSIZE_OFIFO			8192
+#define FIFOSIZE_EFIFO			8192
+#define FIFOSIZE_RFIFO			4096
+#define FIFOSIZE_FFIFO			1024
+
+#define DFIFO_DUMMY_SPACE		2
+
+/* FIFO ID */
+#define FIFO_NONE			0x00000000L
+#define FIFO_DFIFO_MASK			0x000000ffL
+#define FIFO_DFIFO			0x00000001L
+#define FIFO_EFIFO_MASK			0x0000ff00L
+#define FIFO_EFIFO			0x00000100L
+#define FIFO_OFIFO_MASK			0x00ff0000L
+#define FIFO_OFIFO			0x00010000L
+#define FIFO_RFIFO_MASK			0xff000000L
+#define FIFO_RFIFO			0x01000000L
+
+#define PORT_SEL_NONE			0
+#define PORT_SEL_NORMAL			1
+#define PORT_SEL_REF			2
+
+#define RFIFO_CH_NUM			2
+#define RFIFO_BIT_WIDTH			16
+
+/* format */
+#define CODER_FMT_FS_48000		0
+#define CODER_FMT_FS_44100		1
+#define CODER_FMT_FS_32000		2
+#define CODER_FMT_FS_24000		4
+#define CODER_FMT_FS_22050		5
+#define CODER_FMT_FS_16000		6
+#define CODER_FMT_FS_12000		8
+#define CODER_FMT_FS_11025		9
+#define CODER_FMT_FS_8000		10
+
+#define CODER_FMT_ETOBUF_LRMIX		0
+#define CODER_FMT_ETOBUF_LCH		1
+#define CODER_FMT_ETOBUF_RCH		2
+
+#define CODER_FMT_BUFTOO_NONE		0
+#define CODER_FMT_BUFTOO_CONV		1
+
+/* InputDataEnd Command */
+#define INPUTDATAEND_EMPTY		0
+#define INPUTDATAEND_WRITE		1
+
+/* TimerReste Command */
+#define TIMERRESET_RESET		0
+#define TIMERRESET_OFF			1
+
+/* dual mono */
+#define CODER_DUALMONO_LR		0
+#define CODER_DUALMONO_L		1
+#define CODER_DUALMONO_R		2
+
+/* Fs */
+#define OUTPUT_FS_8000			8000
+#define OUTPUT_FS_11025			11025
+#define OUTPUT_FS_12000			12000
+#define OUTPUT_FS_16000			16000
+#define OUTPUT_FS_22050			22050
+#define OUTPUT_FS_24000			24000
+#define OUTPUT_FS_32000			32000
+#define OUTPUT_FS_44100			44100
+#define OUTPUT_FS_48000			48000
+#define OUTPUT_FS_MIN			OUTPUT_FS_8000
+#define OUTPUT_FS_MAX			OUTPUT_FS_48000
+#define OUTPUT_FS_DEF			OUTPUT_FS_48000
+
+/* Start Sample */
+#define OFIFO_BUF_SAMPLE_MIN		0
+#define OFIFO_BUF_SAMPLE_MAX		1024
+#define OFIFO_BUF_SAMPLE_DEF		500
+
+#define RFIFO_BUF_SAMPLE_MIN		0
+#define RFIFO_BUF_SAMPLE_MAX		512
+#define RFIFO_BUF_SAMPLE_DEF		500
+
+/* Stop: verify stop completion */
+#define MADEVCDSP_VERIFY_COMP_OFF	0
+#define MADEVCDSP_VERIFY_COMP_ON	1
+
+/* EVT */
+#define EVENT_TIMER			0x01
+#define EVENT_CLEAR			0x00
+
+/* Error code: CDSP */
+#define	CDSP_ERR_NO_ERROR		0x0000
+#define	CDSP_ERR_MEM_PROTECTION		0xfff1
+#define	CDSP_ERR_WDT			0xfff2
+#define	CDSP_ERR_PROG_DOWNLOAD		0xffff
+
+/* Error code: DEC/ENC */
+#define	DEC_ERR_NO_ERROR		0x00
+#define	DEC_ERR_PROG_SPECIFIC_MIN	0x01
+#define	DEC_ERR_PROG_SPECIFIC_MAX	0xef
+#define	DEC_ERR_NOT_READY		0xf0
+#define	DEC_ERR_MEM_PROTECTION		0xf1
+#define	DEC_ERR_WDT			0xf2
+
+/* c-dsp chunk */
+#define CHUNK_SIZE			8
+
+#define CDSP_FUNC_NUMBER		0
+
+#define AEC_CDSP_TAG_PROG		0x00001000
+#define PROG_FIX_SIZE			4
+#define AEC_CDSP_TAG_PRM		0x00001100
+#define PRM_FIX_SIZE			4
+#define PRM_UNIT_SIZE			17
+#define AEC_CDSP_TAG_FIFO		0x00001200
+#define FIFO_FIX_SIZE			26
+#define AEC_CDSP_TAG_EXT		0x00001300
+#define EXT_FIX_SIZE			5
+
+#define ROUTE_OUT0L_SEL			0
+#define ROUTE_OUT0R_SEL			1
+#define ROUTE_OUT1L_SEL			2
+#define ROUTE_OUT1R_SEL			3
+#define ROUTE_OUT2L_SEL			4
+#define ROUTE_OUT2R_SEL			5
+#define ROUTE_EFIFO0_SEL		6
+#define ROUTE_EFIFO1_SEL		7
+#define ROUTE_EFIFO2_SEL		8
+#define ROUTE_EFIFO3_SEL		9
+#define CDSP_EFIFO_CH			10
+#define CDSP_EFIFO_BIT_WIDTH		11
+#define CDSP_EFIFO_E2BUF_MODE		12
+#define CDSP_OFIFO_CH			13
+#define CDSP_OFIFO_BIT_WIDTH		14
+#define CDSP_DFIFO_BIT_WIDTH		15
+#define CDSP_RFIFO_BIT_WIDTH		16
+#define CDSP_USE_FIFO			17
+#define CDSP_DFIFO_CB_POINT		18	/* 2Byte */
+#define CDSP_RFIFO_CB_POINT		20	/* 2Byte */
+#define CDSP_OFIFO_BUFFERING		22	/* 2Byte */
+#define CDSP_RFIFO_BUFFERING		24	/* 2Byte */
+
+#define OUT_LOOPBACK_L			4
+#define OUT_LOOPBACK_R			5
+
+#define CDSP_FIFO_MASK			0x0f
+#define CDSP_FIFO_EFIFO_BIT		0x01
+#define CDSP_FIFO_OFIFO_BIT		0x02
+#define CDSP_FIFO_DFIFO_BIT		0x04
+#define CDSP_FIFO_RFIFO_BIT		0x08
+#define CDSP_FIFO_OTHER_MASK		0xf0
+#define CDSP_FIFO_OTHER_OUTBUF_BIT	0x10
+#define CDSP_FIFO_OTHER_INBUF_BIT	0x20
+
+#define CDSP_FIFO_DONTCARE		0xff
+#define CDSP_FIFO_DONTCARE_W		0xffff
+#define CDSP_FIFO_DONTCARE_CB		0xfffe
+#define CDSP_FIFO_NOT_CB		0xffff
+
+#define CDSP_PRM_CMD			0
+#define CDSP_PRM_PRM0			1
+
+#define AEC_FUNC_INFO_A			0
+#define AEC_FUNC_INFO_B			1
+#define AEC_FUNC_INFO_NUM		2
+
+#define EXT_COMMAND			0
+#define EXT_COMMAND_CLEAR		1
+
+/* Command (Host -> OS) */
+#define CDSP_CMD_HOST2OS_CMN_NONE			0x00
+#define CDSP_CMD_HOST2OS_CMN_RESET			0x01
+#define CDSP_CMD_HOST2OS_CMN_CLEAR			0x02
+#define CDSP_CMD_HOST2OS_CMN_STANDBY			0x03
+#define CDSP_CMD_HOST2OS_CMN_GET_PRG_VER		0x04
+#define CDSP_CMD_HOST2OS_SYS_GET_OS_VER			0x20
+#define CDSP_CMD_HOST2OS_SYS_SET_PRG_INFO		0x21
+#define CDSP_CMD_HOST2OS_SYS_SET_FORMAT			0x22
+#define CDSP_CMD_HOST2OS_SYS_SET_CONNECTION		0x23
+#define CDSP_CMD_HOST2OS_SYS_VERIFY_STOP_COMP		0x24
+#define CDSP_CMD_HOST2OS_SYS_INPUT_DATA_END		0x25
+#define CDSP_CMD_HOST2OS_SYS_CLEAR_INPUT_DATA_END	0x26
+#define CDSP_CMD_HOST2OS_SYS_SET_TIMER			0x27
+#define CDSP_CMD_HOST2OS_SYS_TIMER_RESET		0x28
+#define CDSP_CMD_HOST2OS_SYS_TERMINATE			0x29
+#define CDSP_CMD_HOST2OS_SYS_SET_DUAL_MONO		0x2a
+#define CDSP_CMD_HOST2OS_SYS_GET_INPUT_POS		0x2b
+#define CDSP_CMD_HOST2OS_SYS_RESET_INPUT_POS		0x2c
+#define CDSP_CMD_HOST2OS_SYS_HALT			0x2d
+#define CDSP_CMD_HOST2OS_SYS_SET_CLOCK_SOURCE		0x2e
+#define CDSP_CMD_DRV_SYS_SET_CONNECTION_EX		0x3e
+#define CDSP_CMD_DRV_SYS_SET_BIT_WIDTH			0x3f
+#define CDSP_CMD_HOST2OS_PRG_MIN			0x40
+#define CDSP_CMD_HOST2OS_PRG_MAX			0x6f
+
+/* Command (OS -> Host) */
+#define CDSP_CMD_OS2HOST_CMN_NONE			0x00
+#define CDSP_CMD_OS2HOST_CMN_MIN			0x01
+#define CDSP_CMD_OS2HOST_CMN_MAX			0x3f
+#define CDSP_CMD_OS2HOST_PRG_MIN			0x40
+#define CDSP_CMD_OS2HOST_PRG_MAX			0x6f
+#define CDSP_CMD_OS2HOST_DISABLE_MIN			0x70
+#define CDSP_CMD_OS2HOST_DISABLE_MAX			0x7f
+#define CDSP_CMD_OS2HOST_READY_MIN			0x80
+#define CDSP_CMD_OS2HOST_READY_MAX			0xff
+#define CDSP_CMD_OS2HOST_CMN_NOTIFY_OUT_FORMAT		0x01
+
+/* Command parameter */
+#define CDSP_CMD_PARAM_ARGUMENT_00			0
+#define CDSP_CMD_PARAM_ARGUMENT_01			1
+#define CDSP_CMD_PARAM_ARGUMENT_02			2
+#define CDSP_CMD_PARAM_ARGUMENT_03			3
+#define CDSP_CMD_PARAM_ARGUMENT_04			4
+#define CDSP_CMD_PARAM_ARGUMENT_05			5
+#define CDSP_CMD_PARAM_ARGUMENT_06			6
+#define CDSP_CMD_PARAM_ARGUMENT_07			7
+#define CDSP_CMD_PARAM_ARGUMENT_08			8
+#define CDSP_CMD_PARAM_ARGUMENT_09			9
+#define CDSP_CMD_PARAM_ARGUMENT_10			10
+#define CDSP_CMD_PARAM_ARGUMENT_11			11
+#define CDSP_CMD_PARAM_ARGUMENT_NUM			12
+#define CDSP_CMD_PARAM_RESULT_00			12
+#define CDSP_CMD_PARAM_RESULT_01			13
+#define CDSP_CMD_PARAM_RESULT_02			14
+#define CDSP_CMD_PARAM_RESULT_03			15
+#define CDSP_CMD_PARAM_RESULT_NUM			4
+#define CDSP_CMD_PARAM_NUM	\
+		(CDSP_CMD_PARAM_ARGUMENT_NUM + CDSP_CMD_PARAM_RESULT_NUM)
+
+/* Command Completion */
+#define CDSP_CMD_COMPLETION				0x80
+
+/* Connect FIFO */
+#define CDSP_IN_SOURCE_DFIFO				0
+#define CDSP_IN_SOURCE_EFIFO				1
+#define CDSP_IN_SOURCE_OTHER_OUTBUF			2
+#define CDSP_IN_SOURCE_NONE				3
+#define CDSP_IN_SOURCE_DFIFO_EFIFO			4
+
+#define CDSP_OUT_DEST_OFIFO				0
+#define CDSP_OUT_DEST_RFIFO				1
+#define CDSP_OUT_DEST_OTHER_INBUF			2
+#define CDSP_OUT_DEST_NONE				3
+#define CDSP_OUT_DEST_OFIFO_RFIFO			4
+
+struct coder_firmware {
+	u8 *firmware;
+	u32 size;
+};
+
+struct coder_version {
+	u32 id;
+	u16 prog_ver_h;
+	u16 prog_ver_m;
+	u16 prog_ver_l;
+	u16 os_ver_h;
+	u16 os_ver_m;
+	u16 os_ver_l;
+};
+
+struct fsq_data_info {
+	u8 *data;
+	u16 size;
+	u16 load_addr;
+	u16 scramble;
+	u8 msel;
+};
+
+struct fifo_info {
+	int dfifo_cb_pos;
+	int rfifo_cb_pos;
+	u32 ofifo_buf_sample;
+	bool ofifo_output_start;
+	u32 dfifo_write_size;
+	u32 rfifo_buf_sample;
+	bool rfifo_output_start;
+
+	u8 out0_sel;
+	u8 out1_sel;
+	u8 out2_sel;
+	u8 rdfifo_bit_sel;
+	u8 efifo01_sel;
+	u8 efifo23_sel;
+};
+
+struct version_info {
+	u16 version_h;
+	u16 version_l;
+};
+
+struct callback_info {
+	bool on[CALLBACK_COUNT];
+	u32 ex_info[CALLBACK_COUNT];
+};
+
+struct program_info {
+	u16 vendor_id;
+	u16 function_id;
+	u16 prog_type;
+	u16 inout_type;
+	u16 prog_scramble;
+	u16 data_scramble;
+	u16 entry_addr;
+	u16 prog_loadaddr;
+	u16 prog_size;
+	u16 data_loadaddr;
+	u16 data_size;
+	u16 work_begin;
+	u16 work_size;
+	u16 stack_begin;
+	u16 stack_size;
+	u16 output_start_mode;
+	u16 resource_flag;
+	u16 max_load;
+};
+
+struct format_info {
+	u8 fs;
+	u8 etobuf;
+};
+
+struct connection_info {
+	u8 src;
+	u8 dest;
+};
+
+struct connection_ex_info {
+	u8 efifo_ch;
+	u8 ofifo_ch;
+};
+
+struct bit_width_info {
+	u8 efifo;
+	u8 ofifo;
+};
+
+struct coder_params {
+	u8 command;
+	u8 params[16];
+};
+
+struct coder_info {
+	u8 state;
+	bool preinput_dataend_set;
+	bool input_dataend_set;
+	bool change_output_fs;
+	bool format_propagate;
+	u32 input_pos;
+	u8 error_code;
+	struct callback_info callback;
+	struct version_info program;
+	struct program_info prog_info;
+	struct format_info format;
+	struct connection_info conn_info;
+	struct connection_ex_info conn_ex_info;
+	struct bit_width_info bit_width;
+	struct coder_params coder;
+};
+
+struct cdsp_info {
+	u16 hw_error_code;
+	struct version_info os;
+};
+
+struct aec_cdsp_func_info {
+	enum mc_cdsp_id id;
+	bool func_on;
+	u8 *data;
+	u32 data_size;
+	u8 *fifo_data;
+	u8 *prog_data;
+	u32 prog_size;
+	u8 *param_data;
+	u32 param_num;
+	u8 *ext;
+
+	struct format_info format;
+	struct connection_info conn_info;
+	struct connection_ex_info conn_ex_info;
+	struct bit_width_info bit_width;
+};
+
+struct aec_cdsp_info {
+	struct aec_cdsp_func_info func_info[AEC_FUNC_INFO_NUM];
+
+	int dfifo_cb_pos;
+	int rfifo_cb_pos;
+	u32 ofifo_buf_sample;
+	u32 rfifo_buf_sample;
+	u8 out0_sel;
+	u8 out1_sel;
+	u8 out2_sel;
+	u8 rdfifo_bit_sel;
+	u8 efifo01_sel;
+	u8 efifo23_sel;
+};
+
+static struct cdsp_info mc_cdsp_info = {
+	.hw_error_code = CDSP_ERR_NO_ERROR,
+};
+
+static struct fifo_info mc_fifo_info;
+
+static struct coder_info mc_dec_info = {
+	.state = STATE_NOTINIT,
+	.format = {
+		   .fs = CODER_FMT_FS_48000,
+		   .etobuf = CODER_FMT_ETOBUF_LRMIX,
+		   },
+	.conn_info = {
+		      .src = CDSP_IN_SOURCE_NONE,
+		      .dest = CDSP_OUT_DEST_NONE,
+		      },
+	.conn_ex_info = {
+			 .efifo_ch = 2,
+			 .ofifo_ch = 2,
+			 },
+	.bit_width = {
+		      .efifo = 16,
+		      .ofifo = 16,
+		      },
+};
+
+static struct coder_info mc_enc_info = {
+	.state = STATE_NOTINIT,
+	.format = {
+		   .fs = CODER_FMT_FS_48000,
+		   .etobuf = CODER_FMT_ETOBUF_LRMIX,
+		   },
+	.conn_info = {
+		      .src = CDSP_IN_SOURCE_NONE,
+		      .dest = CDSP_OUT_DEST_NONE,
+		      },
+	.conn_ex_info = {
+			 .efifo_ch = 2,
+			 .ofifo_ch = 2,
+			 },
+	.bit_width = {
+		      .efifo = 16,
+		      .ofifo = 16,
+		      },
+};
+
+static int cdsp_coder_start(enum mc_cdsp_id id);
+
+static void cdsp_registers_init(void)
+{
+	int i;
+
+	mc_packet_add_force_write_c(MCI_CDSP_RESET,
+				    MCB_CDSP_DMODE | MCB_CDSP_FSQ_SRST |
+				    MCB_CDSP_SRST);
+
+	/* Disable interrupt */
+	mc_packet_add_force_write_c(MCI_DEC_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_ENC_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_DFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_OFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_EFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_RFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_FFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_CDSP_ENABLE, 0);
+	mc_packet_add_force_write_if(MCI_ECDSP, 0);
+
+	/* Clear interrupt flag */
+	mc_packet_add_force_write_c(MCI_DEC_FLG, MCB_DEC_FLG_ALL);
+	mc_packet_add_force_write_c(MCI_ENC_FLG, MCB_ENC_FLG_ALL);
+	mc_packet_add_force_write_c(MCI_DFIFO_FLG, MCB_DFIFO_FLG_ALL);
+	mc_packet_add_force_write_c(MCI_OFIFO_FLG, MCB_OFIFO_FLG_ALL);
+	mc_packet_add_force_write_c(MCI_EFIFO_FLG, MCB_EFIFO_FLG_ALL);
+	mc_packet_add_force_write_c(MCI_RFIFO_FLG, MCB_RFIFO_FLG_ALL);
+	mc_packet_add_force_write_c(MCI_FFIFO_FLG, MCB_FFIFO_FLG_ALL);
+	mc_packet_add_force_write_c(MCI_CDSP_FLG, MCB_CDSP_FLG_ALL);
+	mc_packet_add_force_write_if(MCI_CDSP, MCB_IRQFLAG_CDSP_ALL);
+
+	/* Other registers */
+	mc_packet_add_force_write_c(MCI_DEC_START, 0);
+	mc_packet_add_force_write_c(MCI_DEC_START2, 0);
+	mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, 0);
+
+	mc_packet_add_force_write_c(MCI_PWM_DIGITAL_CDSP, 0);
+
+	mc_packet_add_force_write_c(MCI_DEC_POS4, 0);
+	mc_packet_add_force_write_c(MCI_ENC_POS4, 0);
+	mc_packet_add_force_write_c(MCI_DFIFO_IRQ_PNT_H, 0);
+	mc_packet_add_force_write_c(MCI_DFIFO_IRQ_PNT_L, 0);
+	mc_packet_add_force_write_c(MCI_OFIFO_IRQ_PNT_H, 0);
+	mc_packet_add_force_write_c(MCI_OFIFO_IRQ_PNT_L, 0);
+	mc_packet_add_force_write_c(MCI_EFIFO_IRQ_PNT_H, 0);
+	mc_packet_add_force_write_c(MCI_EFIFO_IRQ_PNT_L, 0);
+	mc_packet_add_force_write_c(MCI_RFIFO_IRQ_PNT_H, 0);
+	mc_packet_add_force_write_c(MCI_RFIFO_IRQ_PNT_L, 0);
+	mc_packet_add_force_write_c(MCI_FFIFO_IRQ_PNT_H, 0);
+	mc_packet_add_force_write_c(MCI_FFIFO_IRQ_PNT_L, 0);
+	mc_packet_add_force_write_c(MCI_CDSP_MAR_H, 0);
+	mc_packet_add_force_write_c(MCI_CDSP_MAR_L, 0);
+	mc_packet_add_force_write_c(MCI_DEC_GPR_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_DEC_SFR1, 0);
+	mc_packet_add_force_write_c(MCI_DEC_SFR0, 0);
+	mc_packet_add_force_write_c(MCI_ENC_GPR_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_ENC_SFR1, 0);
+	mc_packet_add_force_write_c(MCI_ENC_SFR0, 0);
+	mc_packet_add_force_write_c(MCI_DEC_EVT, 0);
+	mc_packet_add_force_write_c(MCI_ENC_EVT, 0);
+	mc_packet_add_force_write_c(MCI_DEC_FIFO_CH, 0);
+	mc_packet_add_force_write_c(MCI_RDFIFO_BIT_SEL, 0);
+	mc_packet_add_force_write_c(MCI_OUT0_SEL, MCI_OUT0_SEL_DEF);
+	mc_packet_add_force_write_c(MCI_OUT1_SEL, MCI_OUT1_SEL_DEF);
+	mc_packet_add_force_write_c(MCI_OUT2_SEL, MCI_OUT2_SEL_DEF);
+	mc_packet_add_force_write_c(MCI_EFIFO01_SEL, MCI_EFIFO01_SEL_DEF);
+	mc_packet_add_force_write_c(MCI_EFIFO23_SEL, MCI_EFIFO23_SEL_DEF);
+
+	for (i = 0; i < CDSP_CMD_PARAM_NUM; i++) {
+		mc_packet_add_force_write_c((MCI_DEC_GPR15 + i), 0);
+		mc_packet_add_force_write_c((MCI_ENC_GPR15 + i), 0);
+		mc_packet_add_force_write_c((MCI_DEC_CTL15 + i), 0);
+		mc_packet_add_force_write_c((MCI_ENC_CTL15 + i), 0);
+	}
+
+	mc_packet_execute();
+}
+
+static inline void cdsp_os_download(const u8 *firmware)
+{
+	u8 data, msel[2];
+	u8 addr_h[2], addr_l[2];
+	u32 os_size[2], i, j;
+	const u8 *os_prog[2];
+
+	msel[0] = MCB_CDSP_MSEL_PROG;
+	addr_h[0] = ADR_OS_PROG_H;
+	addr_l[0] = ADR_OS_PROG_L;
+	os_size[0] = MAKE_HALFWORD(firmware[0], firmware[1]) * 2;
+	os_prog[0] = &firmware[4];
+
+	msel[1] = MCB_CDSP_MSEL_DATA;
+	addr_h[1] = ADR_OS_DATA_H;
+	addr_l[1] = ADR_OS_DATA_L;
+	os_size[1] = MAKE_HALFWORD(firmware[2], firmware[3]) * 2;
+	os_prog[1] = &os_prog[0][os_size[0]];
+
+	mc_read_c(MCI_CDSP_RESET, &data, 1);
+
+	/* CDSP_SRST Set : CDSP OS stop */
+	data &= ~MCB_CDSP_FMODE;
+	data |= MCB_CDSP_SRST;
+	mc_packet_add_force_write_c(MCI_CDSP_RESET, data);
+
+	/* Program & Data Write */
+	for (i = 0; i < 2; i++) {
+		/* CDSP_MSEL Set */
+		data &= ~MCB_CDSP_MSEL;
+		data |= msel[i];
+		mc_packet_add_force_write_c(MCI_CDSP_RESET, data);
+
+		/* CDSP_MAR Set */
+		mc_packet_add_force_write_c(MCI_CDSP_MAR_H, addr_h[i]);
+		mc_packet_add_force_write_c(MCI_CDSP_MAR_L, addr_l[i]);
+
+		mc_packet_execute();
+
+		/* FSQ_FIFO Write */
+		for (j = 0; j < os_size[i]; ++j)
+			mc_packet_add_force_write_if(MCI_FSQ_FFIFO,
+						     os_prog[i][j]);
+
+		mc_packet_execute();
+
+	}
+
+	/* CDSP_SRST Release : CDSP OS start */
+	data &= ~MCB_CDSP_SRST;
+	mc_packet_add_force_write_c(MCI_CDSP_RESET, data);
+	/* 100 ns wait */
+	mc_packet_add_wait(1);
+
+	mc_packet_execute();
+}
+
+static void cdsp_command_write_complete(enum mc_cdsp_id id,
+					struct coder_params *coder)
+{
+	u32 sfr, ctl, base, i;
+
+	if (id == CDSP_DECODER) {
+		sfr = MCI_DEC_SFR1;
+		ctl = MCI_DEC_CTL0;
+	} else {
+		sfr = MCI_ENC_SFR1;
+		ctl = MCI_ENC_CTL0;
+	}
+
+	/* Write result */
+	base = CDSP_CMD_PARAM_RESULT_00;
+	for (i = base; i < base + CDSP_CMD_PARAM_RESULT_NUM; i++)
+		mc_packet_add_write_c(ctl - i, coder->params[i]);
+
+	/* Write complete command */
+	mc_packet_add_force_write_c(sfr, coder->command | CDSP_CMD_COMPLETION);
+
+	mc_packet_execute();
+}
+
+static int cdsp_command_wait_complete(enum mc_cdsp_id id)
+{
+	u32 sfr;
+	int ret;
+
+	if (id == CDSP_DECODER)
+		sfr = MCI_DEC_SFR0;
+	else
+		sfr = MCI_ENC_SFR0;
+
+	/* Polling */
+	mc_packet_add_wait_event(MCDRV_EVT_C_REG_FLAG_SET | (sfr << 8) |
+				 CDSP_CMD_COMPLETION);
+
+	ret = mc_packet_execute();
+	if (ret < 0) {
+		/* Time out */
+		mc_packet_add_force_write_c(sfr, CDSP_CMD_COMPLETION);
+
+		mc_packet_execute();
+	}
+
+	return ret;
+}
+
+static int cdsp_command_init(enum mc_cdsp_id id)
+{
+	struct coder_params coder;
+
+	coder.command = CDSP_CMD_OS2HOST_CMN_NONE;
+	coder.params[CDSP_CMD_PARAM_RESULT_00] = 0;
+	coder.params[CDSP_CMD_PARAM_RESULT_01] = 0;
+	coder.params[CDSP_CMD_PARAM_RESULT_02] = 0;
+	coder.params[CDSP_CMD_PARAM_RESULT_03] = 0;
+
+	cdsp_command_write_complete(id, &coder);
+
+	return cdsp_command_wait_complete(id);
+}
+
+static int cdsp_command_write_host2os(enum mc_cdsp_id id,
+				      struct coder_params *coder)
+{
+	u32 sfr, ctl, gpr;
+	u8 data;
+	int count, i, ret;
+
+	if (id == CDSP_DECODER) {
+		sfr = MCI_DEC_SFR0;
+		ctl = MCI_DEC_CTL0;
+		gpr = MCI_DEC_GPR0;
+	} else {
+		sfr = MCI_ENC_SFR0;
+		ctl = MCI_ENC_CTL0;
+		gpr = MCI_ENC_GPR0;
+	}
+
+	/* Polling */
+	ret = cdsp_command_wait_complete(id);
+	if (ret < 0)
+		return ret;
+
+	/* Write parameter */
+	switch (coder->command) {
+	case CDSP_CMD_HOST2OS_CMN_NONE:
+	case CDSP_CMD_HOST2OS_CMN_RESET:
+	case CDSP_CMD_HOST2OS_CMN_CLEAR:
+	case CDSP_CMD_HOST2OS_CMN_STANDBY:
+	case CDSP_CMD_HOST2OS_CMN_GET_PRG_VER:
+	case CDSP_CMD_HOST2OS_SYS_GET_OS_VER:
+	case CDSP_CMD_HOST2OS_SYS_VERIFY_STOP_COMP:
+	case CDSP_CMD_HOST2OS_SYS_CLEAR_INPUT_DATA_END:
+	case CDSP_CMD_HOST2OS_SYS_TERMINATE:
+	case CDSP_CMD_HOST2OS_SYS_GET_INPUT_POS:
+	case CDSP_CMD_HOST2OS_SYS_RESET_INPUT_POS:
+	case CDSP_CMD_HOST2OS_SYS_HALT:
+		count = 0;
+		break;
+	case CDSP_CMD_HOST2OS_SYS_INPUT_DATA_END:
+	case CDSP_CMD_HOST2OS_SYS_TIMER_RESET:
+	case CDSP_CMD_HOST2OS_SYS_SET_DUAL_MONO:
+	case CDSP_CMD_HOST2OS_SYS_SET_CLOCK_SOURCE:
+		count = 1;
+		break;
+	case CDSP_CMD_HOST2OS_SYS_SET_PRG_INFO:
+		count = 11;
+		break;
+	case CDSP_CMD_HOST2OS_SYS_SET_FORMAT:
+		count = 2;
+		break;
+	case CDSP_CMD_HOST2OS_SYS_SET_CONNECTION:
+		count = 2;
+		break;
+	case CDSP_CMD_HOST2OS_SYS_SET_TIMER:
+		count = 4;
+		break;
+	default:
+		/* Program dependence command */
+		count = CDSP_CMD_PARAM_ARGUMENT_NUM;
+		break;
+	}
+
+	for (i = 0; i < count; i++)
+		mc_packet_add_write_c(ctl - i, coder->params[i]);
+
+	/* Write command */
+	mc_packet_add_force_write_c(sfr, coder->command);
+
+	mc_packet_execute();
+
+	/* Polling */
+	ret = cdsp_command_wait_complete(id);
+	if (ret < 0)
+		return ret;
+
+	/* Error check */
+	mc_read_c(sfr, &data, 1);
+	if (data >= 0xF0) {
+		if (data == 0xF7)
+			return -EBUSY;
+		if (data >= 0xF3 && data <= 0xF6)
+			return -EINVAL;
+		return -EIO;
+	}
+
+	/* Get result */
+	count = CDSP_CMD_PARAM_RESULT_00;
+	for (i = count; i < count + CDSP_CMD_PARAM_RESULT_NUM; i++) {
+		mc_read_c((gpr - i), &data, 1);
+		coder->params[i] = data;
+	}
+
+	return data;
+}
+
+static int cdsp_os_init(void)
+{
+	struct coder_params coder;
+	int ret;
+
+	/* CDSP_ERR/WDT_FLG Flag clear */
+	mc_packet_add_force_write_c(MCI_CDSP_FLG, MCB_CDSP_FLG_ALL);
+
+	/* IRQ Flag clear */
+	mc_packet_add_force_write_if(MCI_CDSP, MCB_IRQFLAG_CDSP_ALL);
+
+	/* ECDSP_ERR/WDT Enable */
+	mc_packet_add_force_write_c(MCI_CDSP_ENABLE, MCB_CDSP_ENABLE_ALL);
+
+	/* IRQ: ECDSP=Enable, other=Disable */
+	mc_packet_add_force_write_if(MCI_ECDSP, MCB_ECDSP);
+
+	mc_packet_execute();
+
+	/* Command register Initialize */
+	ret = cdsp_command_init(CODER_DEC);
+	if (ret < 0)
+		return ret;
+
+	ret = cdsp_command_init(CODER_ENC);
+	if (ret < 0)
+		return ret;
+
+	/* READY Polling */
+	mc_packet_add_wait_event(MCDRV_EVT_C_REG_FLAG_SET |
+				 (MCI_CDSP_POWER_MODE << 8) | MCB_CDSP_SLEEP);
+
+	ret = mc_packet_execute();
+	if (ret < 0)
+		return ret;
+
+	/* GetOsVersion command */
+	coder.command = CDSP_CMD_HOST2OS_SYS_GET_OS_VER;
+	ret = cdsp_command_write_host2os(CODER_DEC, &coder);
+	if (ret < 0)
+		return ret;
+
+	mc_cdsp_info.os.version_h =
+	    MAKE_HALFWORD(coder.params[CDSP_CMD_PARAM_RESULT_00],
+			  coder.params[CDSP_CMD_PARAM_RESULT_01]);
+	mc_cdsp_info.os.version_l =
+	    MAKE_HALFWORD(coder.params[CDSP_CMD_PARAM_RESULT_02],
+			  coder.params[CDSP_CMD_PARAM_RESULT_03]);
+
+	return 0;
+}
+
+static void cdsp_coder_info_init(struct coder_info *info)
+{
+	memset(info, 0, sizeof(struct coder_info));
+
+	info->state = STATE_INIT;
+
+	info->prog_info.inout_type =
+	    PRG_PRM_IOTYPE_IN_PCM | PRG_PRM_IOTYPE_OUT_PCM;
+
+	info->format.fs = CODER_FMT_FS_48000;
+	info->format.etobuf = CODER_FMT_ETOBUF_LRMIX;
+
+	info->conn_info.src = CDSP_IN_SOURCE_NONE;
+	info->conn_info.dest = CDSP_OUT_DEST_NONE;
+
+	info->conn_ex_info.efifo_ch = 2;
+	info->conn_ex_info.ofifo_ch = 2;
+
+	info->bit_width.efifo = 16;
+	info->bit_width.ofifo = 16;
+}
+
+static inline struct coder_info *cdsp_coder_info_get(enum mc_cdsp_id id)
+{
+	if (id == CDSP_DECODER)
+		return &mc_dec_info;
+
+	return &mc_enc_info;
+}
+
+static inline enum mc_cdsp_id cdsp_another_id_get(enum mc_cdsp_id id)
+{
+	if (id == CDSP_DECODER)
+		return CDSP_ENCODER;
+
+	return CDSP_DECODER;
+}
+
+static void cdsp_command_read_os2host(enum mc_cdsp_id id,
+				      struct coder_params *coder)
+{
+	u32 sfr, gpr, count, i;
+	u8 data;
+
+	if (id == CDSP_DECODER) {
+		sfr = MCI_DEC_SFR1;
+		gpr = MCI_DEC_GPR0;
+	} else {
+		sfr = MCI_ENC_SFR1;
+		gpr = MCI_ENC_GPR0;
+	}
+
+	mc_read_c(sfr, &data, 1);
+
+	coder->command = data;
+	switch (coder->command) {
+	case CDSP_CMD_OS2HOST_CMN_NONE:
+		count = 0;
+		break;
+	case CDSP_CMD_OS2HOST_CMN_NOTIFY_OUT_FORMAT:
+		count = 4;
+		break;
+	default:
+		/* Program dependence command */
+		count = CDSP_CMD_PARAM_ARGUMENT_NUM;
+		break;
+	}
+
+	for (i = 0; i < count; i++) {
+		mc_read_c((gpr - i), &data, 1);
+		coder->params[i] = data;
+	}
+}
+
+static int cdsp_command_inputdataend(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	u8 src, dest;
+
+	info = cdsp_coder_info_get(id);
+
+	src = info->conn_info.src;
+	if (src == CDSP_IN_SOURCE_DFIFO || src == CDSP_IN_SOURCE_DFIFO_EFIFO) {
+		if (mc_fifo_info.dfifo_write_size & 0x01) {
+			mc_packet_add_force_write_if(MCI_DEC_FIFO, 0);
+
+			mc_fifo_info.dfifo_write_size = 0;
+		}
+	}
+
+	coder.params[CDSP_CMD_PARAM_ARGUMENT_00] = INPUTDATAEND_EMPTY;
+
+	dest = info->conn_info.dest;
+	if ((mc_fifo_info.rdfifo_bit_sel & MCB_RFIFO_SEL_HOST) &&
+	    (dest == CDSP_OUT_DEST_RFIFO || dest == CDSP_OUT_DEST_OFIFO_RFIFO))
+		coder.params[CDSP_CMD_PARAM_ARGUMENT_00] = INPUTDATAEND_WRITE;
+
+	/* InputDataEnd command */
+	coder.command = CDSP_CMD_HOST2OS_SYS_INPUT_DATA_END;
+
+	return cdsp_command_write_host2os(id, &coder);
+}
+
+static void cdsp_ofifo_start_real(void)
+{
+	u8 data;
+
+	mc_read_c(MCI_DEC_START, &data, 1);
+	data |= MCB_DEC_OUT_START;
+	mc_packet_add_write_c(MCI_DEC_START, data);
+
+	mc_packet_execute();
+}
+
+static void cdsp_rfifo_start_real(void)
+{
+	u8 data;
+
+	mc_read_c(MCI_DEC_START2, &data, 1);
+	data |= MCB_RFIFO_START;
+	mc_packet_add_write_c(MCI_DEC_START2, data);
+
+	mc_packet_execute();
+}
+
+static u32 cdsp_fifoid_get(struct connection_info *conn_info)
+{
+	u32 id = 0;
+
+	switch (conn_info->src) {
+	case CDSP_IN_SOURCE_DFIFO:
+		id |= FIFO_DFIFO;
+		break;
+	case CDSP_IN_SOURCE_EFIFO:
+		id |= FIFO_EFIFO;
+		break;
+	case CDSP_IN_SOURCE_DFIFO_EFIFO:
+		id |= FIFO_DFIFO | FIFO_EFIFO;
+		break;
+	default:
+		break;
+	}
+
+	switch (conn_info->dest) {
+	case CDSP_OUT_DEST_OFIFO:
+		id |= FIFO_OFIFO;
+		break;
+	case CDSP_OUT_DEST_RFIFO:
+		id |= FIFO_RFIFO;
+		break;
+	case CDSP_OUT_DEST_OFIFO_RFIFO:
+		id |= FIFO_OFIFO | FIFO_RFIFO;
+		break;
+	default:
+		break;
+	}
+
+	return id;
+}
+
+static u32 cdsp_fifoid_get_from_coderid(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+
+	info = cdsp_coder_info_get(id);
+
+	return cdsp_fifoid_get(&info->conn_info);
+}
+
+static inline void cdsp_output_format_notify_os2host(enum mc_cdsp_id id)
+{
+	struct coder_info *info, *another_info;
+	enum mc_cdsp_id another_id;
+	u32 fifo_id, another_fifo_id;
+
+	info = cdsp_coder_info_get(id);
+
+	another_id = cdsp_another_id_get(id);
+	another_info = cdsp_coder_info_get(another_id);
+
+	info->format.fs = info->coder.params[CDSP_CMD_PARAM_ARGUMENT_00];
+
+	another_fifo_id = 0;
+	if (info->conn_info.dest == CDSP_OUT_DEST_OTHER_INBUF) {
+		fifo_id = cdsp_fifoid_get(&another_info->conn_info);
+		if (fifo_id & FIFO_OFIFO_MASK)
+			another_fifo_id |= FIFO_OFIFO;
+		if ((fifo_id & FIFO_RFIFO_MASK) &&
+		    !(mc_fifo_info.rdfifo_bit_sel & MCB_RFIFO_SEL_HOST))
+			another_fifo_id |= FIFO_RFIFO;
+	} else {
+		fifo_id = cdsp_fifoid_get(&info->conn_info);
+		fifo_id &= ~(FIFO_DFIFO_MASK | FIFO_EFIFO_MASK);
+		if (mc_fifo_info.rdfifo_bit_sel & MCB_RFIFO_SEL_HOST)
+			fifo_id &= ~FIFO_RFIFO_MASK;
+		if (fifo_id != FIFO_NONE) {
+			if (fifo_id & FIFO_OFIFO_MASK)
+				/* Wait OFIFO_EMPTY */
+				mc_packet_add_force_write_c(MCI_OFIFO_FLG,
+							    MCB_OFIFO_FLG_OEMP);
+			if (fifo_id & FIFO_RFIFO_MASK)
+				/* Wait RFIFO_EMPTY */
+				mc_packet_add_force_write_c(MCI_RFIFO_FLG,
+							    MCB_RFIFO_FLG_REMP);
+			if (fifo_id & FIFO_OFIFO_MASK)
+				mc_packet_add_wait_event
+				    (MCDRV_EVT_C_REG_FLAG_SET |
+				     (MCI_OFIFO_FLG << 8) | MCB_OFIFO_FLG_OEMP);
+
+			if (fifo_id & FIFO_RFIFO_MASK)
+				mc_packet_add_wait_event
+				    (MCDRV_EVT_C_REG_FLAG_SET |
+				     (MCI_RFIFO_FLG << 8) | MCB_RFIFO_FLG_REMP);
+
+			mc_packet_execute();
+
+			if (fifo_id & FIFO_OFIFO_MASK)
+				/* Clear OFIFO_EMPTY */
+				mc_packet_add_force_write_c(MCI_OFIFO_FLG,
+							    MCB_OFIFO_FLG_ALL);
+
+			if (fifo_id & FIFO_RFIFO_MASK)
+				/* Clear RFIFO_EMPTY */
+				mc_packet_add_force_write_c(MCI_RFIFO_FLG,
+							    MCB_RFIFO_FLG_ALL);
+
+			mc_packet_execute();
+		}
+	}
+
+	if (another_fifo_id && !another_info->input_dataend_set) {
+		another_info->preinput_dataend_set = false;
+
+		cdsp_command_inputdataend(another_id);
+
+		another_info->format_propagate = true;
+
+		if (another_fifo_id & FIFO_OFIFO_MASK)
+			cdsp_ofifo_start_real();
+		if (another_fifo_id & FIFO_RFIFO_MASK)
+			cdsp_rfifo_start_real();
+
+	} else
+		info->callback.on[CALLBACK_HOSTCOMMAND] = true;
+}
+
+static void cdsp_interrupt_proc_coder_sfr(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	u8 command;
+
+	info = cdsp_coder_info_get(id);
+
+	/* Read SFR data */
+	cdsp_command_read_os2host(id, &info->coder);
+	command = info->coder.command;
+
+	if (command >= CDSP_CMD_OS2HOST_READY_MIN)
+		return;		/* ready */
+
+	if (command <= CDSP_CMD_OS2HOST_CMN_MAX)
+		/* Common Command */
+		switch (command) {
+		case CDSP_CMD_OS2HOST_CMN_NOTIFY_OUT_FORMAT:
+			cdsp_output_format_notify_os2host(id);
+			break;
+		default:
+			/* DEC/ENC_SFR1 Write complete */
+			info->coder.params[CDSP_CMD_PARAM_RESULT_00] = 0;
+			info->coder.params[CDSP_CMD_PARAM_RESULT_01] = 0;
+			info->coder.params[CDSP_CMD_PARAM_RESULT_02] = 0;
+			info->coder.params[CDSP_CMD_PARAM_RESULT_03] = 0;
+			cdsp_command_write_complete(id, &info->coder);
+			break;
+	} else if (command <= CDSP_CMD_OS2HOST_PRG_MAX)
+		/* Callback (HOST COMMAND) */
+		info->callback.on[CALLBACK_HOSTCOMMAND] = true;
+}
+
+static void cdsp_interrupt_proc_coder_event(enum mc_cdsp_id id)
+{
+	u8 add, event;
+
+	/* Read EVT data */
+	if (id == CDSP_DECODER)
+		add = MCI_DEC_EVT;
+	else
+		add = MCI_ENC_EVT;
+
+	mc_read_c(add, &event, 1);
+	mc_packet_add_force_write_c(add, 0);
+
+	mc_packet_execute();
+
+	/* Timer Event */
+	if (event & EVENT_TIMER) {
+		/* Callback (TIMER) */
+		struct coder_info *info;
+		info = cdsp_coder_info_get(id);
+		info->callback.on[CALLBACK_TIMER] = true;
+	}
+}
+
+static int cdsp_coder_stop(enum mc_cdsp_id id, u8 verify)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	u32 fifo_id;
+	u8 data, addint;
+	int ret = 0;
+
+	info = cdsp_coder_info_get(id);
+
+	/* State check */
+	if (info->state != STATE_PLAYING)
+		return -EBUSY;
+
+	fifo_id = cdsp_fifoid_get(&info->conn_info);
+	if (fifo_id & FIFO_EFIFO) {
+		mc_read_c(MCI_DEC_FIFO_CH, &data, 1);
+		data &= ~MCB_DEC_EFIFO_START;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_CH, data);
+
+		mc_packet_execute();
+	}
+	if ((fifo_id & FIFO_DFIFO) &&
+	    !(mc_fifo_info.rdfifo_bit_sel & MCB_DFIFO_SEL_HOST)) {
+		mc_read_c(MCI_RDFIFO_BIT_SEL, &data, 1);
+		data &= ~MCB_RDFIFO_DFIFO_START;
+		mc_packet_add_force_write_c(MCI_RDFIFO_BIT_SEL, data);
+
+		mc_packet_execute();
+	}
+
+	/* DEC/ENC Stop */
+	mc_read_c(MCI_DEC_START, &data, 1);
+	if (id == CDSP_DECODER) {
+		data &= ~MCB_DEC_DEC_START;
+		addint = MCI_DEC_ENABLE;
+	} else {
+		data &= ~MCB_DEC_ENC_START;
+		addint = MCI_ENC_ENABLE;
+	}
+	mc_packet_add_force_write_c(MCI_DEC_START, data);
+
+	mc_packet_execute();
+
+	/* VerifyStopCompletion command */
+	if (verify == MADEVCDSP_VERIFY_COMP_ON) {
+		coder.command = CDSP_CMD_HOST2OS_SYS_VERIFY_STOP_COMP;
+		ret = cdsp_command_write_host2os(id, &coder);
+	}
+
+	/* DEC/ENC END,ERR Interrupt Disable */
+	mc_read_c(addint, &data, 1);
+	data &= ~(MCB_EDEC_END | MCB_EDEC_ERR);
+	mc_packet_add_force_write_c(addint, data);
+
+	mc_packet_execute();
+
+	return ret;
+}
+
+static void cdsp_fifo_stop(enum mc_cdsp_id id)
+{
+	u32 fifo_id;
+	u8 data;
+
+	fifo_id = cdsp_fifoid_get_from_coderid(id);
+
+	if (fifo_id & FIFO_DFIFO_MASK) {
+		/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt Disable */
+		mc_packet_add_force_write_c(MCI_DFIFO_ENABLE, 0);
+
+		mc_packet_execute();
+
+		mc_read_digital(MCI_ECDSP, &data, 1);
+		data &= ~MCB_EDFIFO;
+		mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+		mc_packet_execute();
+	}
+
+	if (fifo_id & FIFO_EFIFO_MASK) {
+		/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt Disable */
+		mc_packet_add_force_write_c(MCI_EFIFO_ENABLE, 0);
+
+		mc_packet_execute();
+
+		mc_read_digital(MCI_ECDSP, &data, 1);
+		data &= ~MCB_EEFIFO;
+		mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+		mc_packet_execute();
+	}
+
+	if (fifo_id & FIFO_OFIFO_MASK) {
+		/* OUT Stop */
+		mc_read_c(MCI_DEC_START, &data, 1);
+
+		data &= ~MCB_DEC_OUT_START;
+		mc_packet_add_force_write_c(MCI_DEC_START, data);
+
+		/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt Disable */
+		mc_packet_add_force_write_c(MCI_OFIFO_ENABLE, 0);
+
+		mc_packet_execute();
+
+		mc_read_digital(MCI_ECDSP, &data, 1);
+		data &= ~MCB_EOFIFO;
+		mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+		mc_packet_execute();
+	}
+
+	if (fifo_id & FIFO_RFIFO_MASK) {
+		if (!(mc_fifo_info.rdfifo_bit_sel & MCB_RFIFO_SEL_HOST)) {
+			/* OUT Stop */
+			mc_read_c(MCI_DEC_START2, &data, 1);
+
+			data &= ~MCB_RFIFO_START;
+			mc_packet_add_force_write_c(MCI_DEC_START2, data);
+		}
+
+		/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt Disable */
+		mc_packet_add_force_write_c(MCI_RFIFO_ENABLE, 0);
+
+		mc_packet_execute();
+
+		mc_read_digital(MCI_ECDSP, &data, 1);
+		data &= ~MCB_ERFIFO;
+		mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+		mc_packet_execute();
+	}
+}
+
+static u32 cdsp_convert_sample_to_msec(u8 fs, u32 sample)
+{
+	u32 base, msec;
+
+	if (!sample)
+		return 0;
+
+	switch (fs) {
+	case CODER_FMT_FS_48000:
+		base = OUTPUT_FS_48000;
+		break;
+	case CODER_FMT_FS_44100:
+		base = OUTPUT_FS_44100;
+		break;
+	case CODER_FMT_FS_32000:
+		base = OUTPUT_FS_32000;
+		break;
+	case CODER_FMT_FS_24000:
+		base = OUTPUT_FS_24000;
+		break;
+	case CODER_FMT_FS_22050:
+		base = OUTPUT_FS_22050;
+		break;
+	case CODER_FMT_FS_16000:
+		base = OUTPUT_FS_16000;
+		break;
+	case CODER_FMT_FS_12000:
+		base = OUTPUT_FS_12000;
+		break;
+	case CODER_FMT_FS_11025:
+		base = OUTPUT_FS_11025;
+		break;
+	case CODER_FMT_FS_8000:
+		base = OUTPUT_FS_8000;
+		break;
+	default:
+		base = OUTPUT_FS_DEF;
+		break;
+	}
+
+	msec = (sample / base) * 1000;
+	msec += (((sample % base) * 1000) + (base - 1)) / base;
+
+	return msec;
+}
+
+static int cdsp_output_get_position(enum mc_cdsp_id id, u32 *pos)
+{
+	struct coder_info *info;
+	u32 output_pos;
+	u8 data[4];
+
+	info = cdsp_coder_info_get(id);
+
+	/* Path check */
+	switch (info->conn_info.dest) {
+	case CDSP_OUT_DEST_RFIFO:
+	case CDSP_OUT_DEST_OTHER_INBUF:
+	case CDSP_OUT_DEST_NONE:
+		return -EIO;
+	default:
+		break;
+	}
+
+	/* DEC_POS Read */
+	mc_read_c(MCI_DEC_POS1, &data[3], 1);
+	mc_read_c(MCI_DEC_POS2, &data[2], 1);
+	mc_read_c(MCI_DEC_POS3, &data[1], 1);
+	mc_read_c(MCI_DEC_POS4, &data[0], 1);
+
+	output_pos = (u32) data[3] << 24 | (u32) data[2] << 16 |
+	    (u32) data[1] << 8 | (u32) data[0];
+
+	*pos = cdsp_convert_sample_to_msec(info->format.fs, output_pos);
+
+	return 0;
+}
+
+static void cdsp_interrupt_proc_coder_error(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	u8 addr, data, error;
+	u32 pos = 0;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	/* Read ERR data */
+	if (id == CDSP_DECODER)
+		addr = MCI_DEC_ERROR;
+	else
+		addr = MCI_ENC_ERROR;
+
+	mc_read_c(addr, &error, 1);
+
+	info->error_code = error;
+
+	ret = cdsp_output_get_position(id, &pos);
+	if (ret)
+		return;
+
+	if (error > DEC_ERR_PROG_SPECIFIC_MAX) {
+		/* Stop */
+		cdsp_fifo_stop(id);
+		ret = cdsp_coder_stop(id, MADEVCDSP_VERIFY_COMP_OFF);
+
+		/* Reset command */
+		coder.command = CDSP_CMD_HOST2OS_CMN_RESET;
+		ret = cdsp_command_write_host2os(id, &coder);
+
+		/* Command register Initialize */
+		cdsp_command_init(id);
+
+		/* EDEC/EENC_SFR Disable */
+		if (id == CDSP_DECODER) {
+			mc_read_c(MCI_DEC_ENABLE, &data, 1);
+			data &= ~MCB_EDEC_SFR;
+			mc_packet_add_force_write_c(MCI_DEC_ENABLE, data);
+		} else {
+			mc_read_c(MCI_ENC_ENABLE, &data, 1);
+			data &= ~MCB_EENC_SFR;
+			mc_packet_add_force_write_c(MCI_ENC_ENABLE, data);
+		}
+		mc_packet_execute();
+
+		/* EDEC/EENC Disable */
+		mc_read_digital(MCI_ECDSP, &data, 1);
+		if (id == CDSP_DECODER)
+			data &= ~MCB_EDEC;
+		else
+			data &= ~MCB_EENC;
+
+		mc_packet_add_force_write_if(MCI_ECDSP, data);
+		mc_packet_execute();
+
+		/* Parameter Initialize */
+		info->prog_info.vendor_id = 0;
+		info->prog_info.function_id = 0;
+
+		info->state = STATE_READY_SETUP;
+
+		/* Callback (ERROR) */
+		info->callback.on[CALLBACK_PLAY_ERROR2] = true;
+		info->callback.ex_info[CALLBACK_PLAY_ERROR2] =
+		    (pos << 8) | (error & 0xFF);
+	} else {
+		cdsp_fifo_stop(id);
+		cdsp_coder_stop(id, MADEVCDSP_VERIFY_COMP_OFF);
+
+		info->state = STATE_READY;
+
+		/* Callback (ERROR) */
+		info->callback.on[CALLBACK_PLAY_ERROR1] = true;
+		info->callback.ex_info[CALLBACK_PLAY_ERROR1] =
+		    (pos << 8) | (error & 0xFF);
+	}
+}
+
+static void cdsp_output_start(struct coder_info *info)
+{
+	u8 dest;
+
+	dest = info->conn_info.dest;
+	switch (dest) {
+	case CDSP_OUT_DEST_OFIFO:
+		break;
+	case CDSP_OUT_DEST_OFIFO_RFIFO:
+		if (mc_fifo_info.rdfifo_bit_sel & MCB_RFIFO_SEL_HOST)
+			dest = CDSP_OUT_DEST_OFIFO;
+		break;
+	case CDSP_OUT_DEST_RFIFO:
+		if (mc_fifo_info.rdfifo_bit_sel & MCB_RFIFO_SEL_HOST)
+			return;
+		break;
+	default:
+		return;
+	}
+
+	if (info->prog_info.output_start_mode && !info->change_output_fs)
+		return;
+
+	switch (dest) {
+	case CDSP_OUT_DEST_OFIFO:
+		if (!mc_fifo_info.ofifo_output_start)
+			return;
+
+		cdsp_ofifo_start_real();
+		break;
+	case CDSP_OUT_DEST_OFIFO_RFIFO:
+		if (!mc_fifo_info.ofifo_output_start ||
+		    !mc_fifo_info.rfifo_output_start)
+			return;
+
+		cdsp_ofifo_start_real();
+		cdsp_rfifo_start_real();
+		break;
+	case CDSP_OUT_DEST_RFIFO:
+		if (!mc_fifo_info.rfifo_output_start)
+			return;
+
+		cdsp_rfifo_start_real();
+		break;
+	default:
+		break;
+	}
+}
+
+static void cdsp_interrupt_proc_coder_end(enum mc_cdsp_id id)
+{
+	struct coder_info *info, *another_info;
+	struct coder_params coder;
+	enum mc_cdsp_id another_id;
+	u8 data;
+
+	info = cdsp_coder_info_get(id);
+
+	another_id = cdsp_another_id_get(id);
+	another_info = cdsp_coder_info_get(another_id);
+
+	if (info->format_propagate) {
+		info->format.fs = another_info->format.fs;
+
+		/* DEC/ENC Stop */
+		mc_read_c(MCI_DEC_START, &data, 1);
+		if (id == CDSP_DECODER)
+			data &= ~MCB_DEC_DEC_START;
+		else
+			data &= ~MCB_DEC_ENC_START;
+
+		mc_packet_add_force_write_c(MCI_DEC_START, data);
+		mc_packet_execute();
+
+		/* VerifyStopCompletion command */
+		coder.command = CDSP_CMD_HOST2OS_SYS_VERIFY_STOP_COMP;
+		cdsp_command_write_host2os(id, &coder);
+
+		/* GetInputPos command */
+		coder.command = CDSP_CMD_HOST2OS_SYS_GET_INPUT_POS;
+		cdsp_command_write_host2os(id, &coder);
+
+		/* InputPos */
+		info->input_pos +=
+		    *(u32 *) (coder.params + CDSP_CMD_PARAM_RESULT_00);
+
+		/* Clear command */
+		coder.command = CDSP_CMD_HOST2OS_CMN_CLEAR;
+		cdsp_command_write_host2os(id, &coder);
+
+		/* DEC/ENC Start */
+		mc_read_c(MCI_DEC_START, &data, 1);
+		if (id == CDSP_DECODER)
+			data |= MCB_DEC_DEC_START;
+		else
+			data |= MCB_DEC_ENC_START;
+
+		mc_packet_add_force_write_c(MCI_DEC_START, data);
+
+		mc_packet_execute();
+
+		info->format_propagate = false;
+
+		/* Callback (HOST Command) */
+		another_info->callback.on[CALLBACK_HOSTCOMMAND] = true;
+	} else {
+		switch (another_info->state) {
+		case STATE_READY_SETUP:
+			another_info->preinput_dataend_set = true;
+			break;
+		case STATE_READY:
+		case STATE_PLAYING:
+			if (another_info->conn_info.src ==
+			    CDSP_IN_SOURCE_OTHER_OUTBUF) {
+				/* InputDataEnd command */
+				cdsp_command_inputdataend(another_id);
+				/* Input data end flag - set */
+				another_info->input_dataend_set = true;
+				cdsp_output_start(another_info);
+			}
+			break;
+		default:
+			break;
+		}
+
+		/* ClearInputDataEnd command */
+		coder.command = CDSP_CMD_HOST2OS_SYS_CLEAR_INPUT_DATA_END;
+		cdsp_command_write_host2os(id, &coder);
+
+		/* Input data end flag - release */
+		info->input_dataend_set = false;
+
+		cdsp_fifo_stop(id);
+		cdsp_coder_stop(id, MADEVCDSP_VERIFY_COMP_ON);
+
+		info->state = STATE_READY;
+
+		/* Callback (DEC/ENC END) */
+		info->callback.on[CALLBACK_END_OF_SEQUENCE] = true;
+	}
+}
+
+static void cdsp_interrupt_proc_coder(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	u8 addr, data, clear = 0;
+
+	info = cdsp_coder_info_get(id);
+
+	/* Read interrupt flag */
+	if (id == CDSP_DECODER)
+		addr = MCI_DEC_FLG;
+	else
+		addr = MCI_ENC_FLG;
+	mc_read_c(addr, &data, 1);
+
+	if (id == CODER_DEC) {
+		if (data & MCB_DEC_FLG_SFR) {
+			cdsp_interrupt_proc_coder_sfr(id);
+			clear |= MCB_DEC_FLG_SFR;
+		}
+		if (data & MCB_DEC_FLG_ERR) {
+			cdsp_interrupt_proc_coder_error(id);
+			clear |= MCB_DEC_FLG_ERR;
+		}
+		if ((data & MCB_DEC_FLG_END) && info->state == STATE_PLAYING) {
+			cdsp_interrupt_proc_coder_end(id);
+			clear |= MCB_DEC_FLG_END;
+		}
+		if (data & MCB_DEC_EVT_FLG) {
+			cdsp_interrupt_proc_coder_event(id);
+			clear |= MCB_DEC_EVT_FLG;
+		}
+	} else {
+		if (data & MCB_ENC_FLG_SFR) {
+			cdsp_interrupt_proc_coder_sfr(id);
+			clear |= MCB_ENC_FLG_SFR;
+		}
+		if (data & MCB_ENC_FLG_ERR) {
+			cdsp_interrupt_proc_coder_error(id);
+			clear |= MCB_ENC_FLG_ERR;
+		}
+		if ((data & MCB_ENC_FLG_END) && info->state == STATE_PLAYING) {
+			cdsp_interrupt_proc_coder_end(id);
+			clear |= MCB_ENC_FLG_END;
+		}
+		if (data & MCB_ENC_EVT_FLG) {
+			cdsp_interrupt_proc_coder_event(id);
+			clear |= MCB_ENC_EVT_FLG;
+		}
+	}
+
+	mc_packet_add_force_write_c(addr, clear);
+
+	mc_packet_execute();
+}
+
+static void cdsp_interrupt_proc_dfifo(void)
+{
+	struct coder_info *info;
+	u8 flag, ctrl;
+
+	/* Read interrupt flag */
+	mc_read_c(MCI_DFIFO_FLG, &flag, 1);
+
+	/* Interrupt process */
+	/* EDPNT, EDEMP Read */
+	mc_read_c(MCI_DFIFO_ENABLE, &ctrl, 1);
+
+	info = cdsp_coder_info_get(CODER_DEC);
+	if (!((info->conn_info.src == CDSP_IN_SOURCE_DFIFO ||
+	       info->conn_info.src == CDSP_IN_SOURCE_DFIFO_EFIFO) &&
+	      info->state > STATE_INIT)) {
+		info = cdsp_coder_info_get(CODER_ENC);
+		if (!((info->conn_info.src == CDSP_IN_SOURCE_DFIFO ||
+		       info->conn_info.src == CDSP_IN_SOURCE_DFIFO_EFIFO) &&
+		      info->state > STATE_INIT))
+			info = NULL;
+	}
+
+	/* DPNT */
+	if ((flag & MCB_DFIFO_FLG_DPNT) && (ctrl & MCB_DFIFO_EDPNT)) {
+		/* EDPNT Disable */
+		ctrl &= ~MCB_DFIFO_EDPNT;
+
+		/* Callback (DFIFO POINT) */
+		if (info)
+			info->callback.on[CALLBACK_DFIFOPOINT] = true;
+	}
+
+	/* DEMP */
+	if ((flag & MCB_DFIFO_FLG_DEMP) && (ctrl & MCB_DFIFO_EDEMP)) {
+		/* EDEMP Disable */
+		ctrl &= ~MCB_DFIFO_EDEMP;
+
+		/* Callback (DFIFO EMPTY) */
+		if (info)
+			info->callback.on[CALLBACK_DFIFOEMPTY] = true;
+	}
+
+	mc_packet_add_force_write_c(MCI_DFIFO_ENABLE, ctrl);
+
+	/* Clear interrupt flag */
+	mc_packet_add_force_write_c(MCI_DFIFO_FLG, flag);
+
+	mc_packet_execute();
+}
+
+static void cdsp_interrupt_proc_ofifo_core(void)
+{
+	struct coder_info *info;
+	u8 data;
+
+	/* EOPNT Disable */
+	mc_read_c(MCI_OFIFO_ENABLE, &data, 1);
+	data &= ~MCB_OFIFO_EOPNT;
+	mc_packet_add_force_write_c(MCI_OFIFO_ENABLE, data);
+
+	/* EOFIFO Disable */
+	mc_read_digital(MCI_ECDSP, &data, 1);
+	data &= ~MCB_EOFIFO;
+	mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+	mc_packet_execute();
+
+	/* OUT START */
+	mc_fifo_info.ofifo_output_start = true;
+
+	info = cdsp_coder_info_get(CODER_DEC);
+	if (!((info->conn_info.dest == CDSP_OUT_DEST_OFIFO ||
+	       info->conn_info.dest == CDSP_OUT_DEST_OFIFO_RFIFO) &&
+	      info->state > STATE_INIT)) {
+		info = cdsp_coder_info_get(CODER_ENC);
+		if (!((info->conn_info.dest == CDSP_OUT_DEST_OFIFO ||
+		       info->conn_info.dest == CDSP_OUT_DEST_OFIFO_RFIFO) &&
+		      info->state > STATE_INIT))
+			info = NULL;
+	}
+
+	/* OUT_START Set */
+	if (info)
+		cdsp_output_start(info);
+}
+
+static inline void cdsp_interrupt_proc_ofifo(void)
+{
+	u8 flag;
+
+	/* Read interrupt flag */
+	mc_read_c(MCI_OFIFO_FLG, &flag, 1);
+
+	/* Interrupt process */
+	if (flag & MCB_OFIFO_FLG_OPNT)
+		cdsp_interrupt_proc_ofifo_core();
+
+	/* Clear interrupt flag */
+	mc_packet_add_force_write_c(MCI_OFIFO_FLG, flag);
+
+	mc_packet_execute();
+}
+
+static void cdsp_interrupt_proc_rfifo_core(void)
+{
+	struct coder_info *info;
+	u8 data;
+
+	/* ERPNT Disable */
+	mc_read_c(MCI_RFIFO_ENABLE, &data, 1);
+	data &= ~MCB_RFIFO_ERPNT;
+	mc_packet_add_force_write_c(MCI_RFIFO_ENABLE, data);
+
+	/* ERFIFO Disable */
+	mc_read_digital(MCI_ECDSP, &data, 1);
+	data &= ~MCB_ERFIFO;
+	mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+	mc_packet_execute();
+
+	/* OUT START */
+	mc_fifo_info.rfifo_output_start = true;
+
+	info = cdsp_coder_info_get(CODER_DEC);
+	if (!((info->conn_info.dest == CDSP_OUT_DEST_RFIFO ||
+	       info->conn_info.dest == CDSP_OUT_DEST_OFIFO_RFIFO) &&
+	      info->state > STATE_INIT)) {
+		info = cdsp_coder_info_get(CODER_ENC);
+		if (!((info->conn_info.dest == CDSP_OUT_DEST_RFIFO ||
+		       info->conn_info.dest == CDSP_OUT_DEST_OFIFO_RFIFO) &&
+		      info->state > STATE_INIT))
+			info = NULL;
+	}
+
+	/* OUT_START Set */
+	if (info)
+		cdsp_output_start(info);
+}
+
+static inline void cdsp_interrupt_proc_rfifo_port(void)
+{
+	u8 flag;
+
+	/* Read interrupt flag */
+	mc_read_c(MCI_RFIFO_FLG, &flag, 1);
+
+	/* Interrupt process */
+	if (flag & MCB_OFIFO_FLG_OPNT)
+		cdsp_interrupt_proc_rfifo_core();
+
+	/* Clear interrupt flag */
+	mc_packet_add_force_write_c(MCI_RFIFO_FLG, flag);
+
+	mc_packet_execute();
+}
+
+static inline void cdsp_interrupt_proc_rfifo_host(void)
+{
+	struct coder_info *info;
+	u8 flag, ctrl;
+
+	/* Read interrupt flag */
+	mc_read_c(MCI_RFIFO_FLG, &flag, 1);
+
+	/* ERxxx Read */
+	mc_read_c(MCI_RFIFO_ENABLE, &ctrl, 1);
+
+	if (flag & MCB_RFIFO_FLG_RPNT) {
+		info = cdsp_coder_info_get(CODER_DEC);
+		if (!((info->conn_info.dest == CDSP_OUT_DEST_RFIFO ||
+		       info->conn_info.dest == CDSP_OUT_DEST_OFIFO_RFIFO) &&
+		      info->state > STATE_INIT)) {
+			info = cdsp_coder_info_get(CODER_ENC);
+			if (!((info->conn_info.dest == CDSP_OUT_DEST_RFIFO ||
+			       info->conn_info.dest ==
+			       CDSP_OUT_DEST_OFIFO_RFIFO)
+			      && info->state > STATE_INIT))
+				info = NULL;
+		}
+
+		if (ctrl & MCB_RFIFO_ERPNT) {
+			/* ERPNT Disable */
+			ctrl &= ~MCB_RFIFO_ERPNT;
+
+			/* Callback (RFIFO POINT) */
+			if (info)
+				info->callback.on[CALLBACK_RFIFOPOINT] = true;
+		}
+
+		if ((flag & MCB_RFIFO_FLG_ROVF) && (ctrl & MCB_RFIFO_EROVF)) {
+			/* EROVF Disable */
+			ctrl &= ~MCB_RFIFO_EROVF;
+
+			/* Callback (RecBuf Overflow) */
+			if (info)
+				info->callback.on[CALLBACK_RECBUF_OVF] = true;
+		}
+
+		mc_packet_add_force_write_c(MCI_RFIFO_ENABLE, ctrl);
+	}
+
+	/* Clear interrupt flag */
+	mc_packet_add_force_write_c(MCI_RFIFO_FLG, flag);
+
+	mc_packet_execute();
+}
+
+static inline void cdsp_interrupt_proc_rfifo(void)
+{
+	if (mc_fifo_info.rdfifo_bit_sel & MCB_RFIFO_SEL_HOST)
+		cdsp_interrupt_proc_rfifo_host();
+	else
+		cdsp_interrupt_proc_rfifo_port();
+}
+
+static inline void cdsp_interrupt_proc(void)
+{
+	u8 data, error;
+
+	/* Read interrupt flag */
+	mc_read_c(MCI_CDSP_FLG, &data, 1);
+
+	/* Interrupt process */
+	if (data & MCB_CDSP_FLG_ERR) {
+		mc_read_c(MCI_CDSP_ERR, &error, 1);
+
+		mc_cdsp_info.hw_error_code = error;
+	} else if (data & MCB_CDSP_FLG_WDT)
+		mc_cdsp_info.hw_error_code = CDSP_ERR_WDT;
+
+	/* Interrupt ALL disable */
+	mc_packet_add_force_write_c(MCI_DEC_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_ENC_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_DFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_OFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_EFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_RFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_FFIFO_ENABLE, 0);
+	mc_packet_add_force_write_c(MCI_CDSP_ENABLE, 0);
+	mc_packet_add_force_write_if(MCI_ECDSP, 0);
+
+	/* State update */
+	mc_dec_info.state = STATE_NOTINIT;
+	mc_enc_info.state = STATE_NOTINIT;
+
+	/* Callback (HW ERROR) */
+	mc_dec_info.callback.on[CALLBACK_HW_ERROR] = true;
+	mc_dec_info.callback.ex_info[CALLBACK_HW_ERROR] =
+	    mc_cdsp_info.hw_error_code & 0xFF;
+	mc_enc_info.callback.on[CALLBACK_HW_ERROR] = true;
+	mc_enc_info.callback.ex_info[CALLBACK_HW_ERROR] =
+	    mc_cdsp_info.hw_error_code & 0xFF;
+
+	/* Clear interrupt flag */
+	mc_packet_add_force_write_c(MCI_CDSP_FLG, data);
+
+	mc_packet_execute();
+}
+
+static inline void cdsp_callback_proc_core(struct callback_info *callback,
+					   int handle)
+{
+	callback->on[CALLBACK_HOSTCOMMAND] = false;
+	callback->on[CALLBACK_END_OF_SEQUENCE] = false;
+	callback->on[CALLBACK_DFIFOPOINT] = false;
+	callback->on[CALLBACK_RFIFOPOINT] = false;
+	callback->on[CALLBACK_DFIFOEMPTY] = false;
+	callback->on[CALLBACK_RECBUF_OVF] = false;
+	callback->on[CALLBACK_TIMER] = false;
+	callback->on[CALLBACK_PLAY_ERROR1] = false;
+	callback->ex_info[CALLBACK_PLAY_ERROR1] = 0;
+	callback->on[CALLBACK_PLAY_ERROR2] = false;
+	callback->ex_info[CALLBACK_PLAY_ERROR2] = 0;
+	callback->on[CALLBACK_HW_ERROR] = false;
+	callback->ex_info[CALLBACK_HW_ERROR] = 0;
+}
+
+static inline void cdsp_callback_proc(void)
+{
+	cdsp_callback_proc_core(&mc_dec_info.callback, 0);
+	cdsp_callback_proc_core(&mc_enc_info.callback, 1);
+}
+
+static void cdsp_get_data(struct mcdrv_aec_info *aec_info,
+			  struct aec_cdsp_info *cdsp_info)
+{
+	struct aec_cdsp_func_info *finfo_a;
+	struct aec_cdsp_func_info *finfo_b;
+
+	finfo_a = &cdsp_info->func_info[AEC_FUNC_INFO_A];
+	finfo_b = &cdsp_info->func_info[AEC_FUNC_INFO_B];
+
+	finfo_a->id = CDSP_DECODER;
+	finfo_a->func_on = false;
+	finfo_a->data = NULL;
+	finfo_a->data_size = 0;
+
+	finfo_b->id = CDSP_ENCODER;
+	finfo_b->func_on = false;
+	finfo_b->data = NULL;
+	finfo_b->data_size = 0;
+
+	if (aec_info->vbox.enable) {
+		finfo_a->func_on = aec_info->vbox.cdsp_func_a_on;
+		finfo_b->func_on = aec_info->vbox.cdsp_func_b_on;
+
+		if (!finfo_a->func_on && !finfo_b->func_on)
+			return;
+
+		if (finfo_a->func_on) {
+			finfo_a->data = aec_info->vbox.cdsp_a.data;
+			finfo_a->data_size = aec_info->vbox.cdsp_a.data_size;
+		}
+
+		if (finfo_b->func_on) {
+			finfo_b->data = aec_info->vbox.cdsp_b.data;
+			finfo_b->data_size = aec_info->vbox.cdsp_b.data_size;
+		}
+	}
+
+	if (finfo_a->data)
+		finfo_a->data = &finfo_a->data[CHUNK_SIZE];
+
+	if (finfo_b->data)
+		finfo_b->data = &finfo_b->data[CHUNK_SIZE];
+}
+
+static inline int cdsp_fifo_check(enum mc_cdsp_id id,
+				  struct aec_cdsp_info *cdsp_info)
+{
+	struct aec_cdsp_func_info *finfo;
+	u32 pos, sample, fifo_id;
+	u8 sel, fifo, src, dest, bit, ch, etobuf, tmp;
+	u8 *data;
+
+	if (id == CDSP_DECODER)
+		finfo = &cdsp_info->func_info[AEC_FUNC_INFO_A];
+	else
+		finfo = &cdsp_info->func_info[AEC_FUNC_INFO_B];
+
+	data = finfo->fifo_data;
+
+	fifo = data[CDSP_USE_FIFO];
+	if (fifo != CDSP_FIFO_DONTCARE) {
+		if ((fifo & CDSP_FIFO_OTHER_OUTBUF_BIT) &&
+		    ((fifo & CDSP_FIFO_EFIFO_BIT) ||
+		     (fifo & CDSP_FIFO_DFIFO_BIT)))
+			return -EINVAL;
+
+		if ((fifo & CDSP_FIFO_OTHER_INBUF_BIT) &&
+		    ((fifo & CDSP_FIFO_OFIFO_BIT) ||
+		     (fifo & CDSP_FIFO_RFIFO_BIT)))
+			return -EINVAL;
+
+		if (fifo & CDSP_FIFO_OTHER_OUTBUF_BIT)
+			src = CDSP_IN_SOURCE_OTHER_OUTBUF;
+		else if ((fifo & CDSP_FIFO_EFIFO_BIT) &&
+			 (fifo & CDSP_FIFO_DFIFO_BIT))
+			src = CDSP_IN_SOURCE_DFIFO_EFIFO;
+		else if (fifo & CDSP_FIFO_DFIFO_BIT)
+			src = CDSP_IN_SOURCE_DFIFO;
+		else if (fifo & CDSP_FIFO_EFIFO_BIT)
+			src = CDSP_IN_SOURCE_EFIFO;
+		else
+			src = CDSP_IN_SOURCE_NONE;
+
+		finfo->conn_info.src = src;
+
+		if (fifo & CDSP_FIFO_OTHER_INBUF_BIT)
+			dest = CDSP_OUT_DEST_OTHER_INBUF;
+		else if ((fifo & CDSP_FIFO_OFIFO_BIT) &&
+			 (fifo & CDSP_FIFO_RFIFO_BIT))
+			dest = CDSP_OUT_DEST_OFIFO_RFIFO;
+		else if (fifo & CDSP_FIFO_OFIFO_BIT)
+			dest = CDSP_OUT_DEST_OFIFO;
+		else if (fifo & CDSP_FIFO_RFIFO_BIT)
+			dest = CDSP_OUT_DEST_RFIFO;
+		else
+			dest = CDSP_OUT_DEST_NONE;
+
+		finfo->conn_info.dest = dest;
+	}
+
+	fifo_id = cdsp_fifoid_get(&finfo->conn_info);
+
+	/* EFIFO */
+	if (fifo_id & FIFO_EFIFO) {
+		tmp = data[ROUTE_EFIFO0_SEL];
+		if (tmp != CDSP_FIFO_DONTCARE) {
+			sel = cdsp_info->efifo01_sel & ~MCB_EFIFO0_SEL;
+			sel |= tmp & MCB_EFIFO0_SEL;
+			cdsp_info->efifo01_sel = sel;
+		}
+
+		tmp = data[ROUTE_EFIFO1_SEL];
+		if (tmp != CDSP_FIFO_DONTCARE) {
+			sel = cdsp_info->efifo01_sel & ~MCB_EFIFO1_SEL;
+			sel |= (tmp << 4) & MCB_EFIFO1_SEL;
+			cdsp_info->efifo01_sel = sel;
+		}
+
+		tmp = data[ROUTE_EFIFO2_SEL];
+		if (tmp != CDSP_FIFO_DONTCARE) {
+			sel = cdsp_info->efifo23_sel & ~MCB_EFIFO2_SEL;
+			sel |= tmp & MCB_EFIFO2_SEL;
+			cdsp_info->efifo23_sel = sel;
+		}
+
+		tmp = data[ROUTE_EFIFO3_SEL];
+		if (tmp != CDSP_FIFO_DONTCARE) {
+			sel = cdsp_info->efifo23_sel & ~MCB_EFIFO3_SEL;
+			sel |= (tmp << 4) & MCB_EFIFO3_SEL;
+			cdsp_info->efifo23_sel = sel;
+		}
+
+		/* 0: 2ch 16bit */
+		/* 1: 4ch 16bit */
+		/* 2: 2ch 32bit   */
+		/* 3: 4ch 32bit */
+		ch = finfo->conn_ex_info.efifo_ch;
+		bit = finfo->bit_width.efifo;
+		etobuf = finfo->format.etobuf;
+
+		tmp = data[CDSP_EFIFO_CH];
+		switch (tmp) {
+		case 2:
+		case 4:
+			ch = tmp;
+			break;
+		case CDSP_FIFO_DONTCARE:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		tmp = data[CDSP_EFIFO_BIT_WIDTH];
+		switch (tmp) {
+		case 16:
+		case 32:
+			bit = tmp;
+			break;
+		case CDSP_FIFO_DONTCARE:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		tmp = data[CDSP_EFIFO_E2BUF_MODE];
+		switch (tmp) {
+		case CODER_FMT_ETOBUF_LRMIX:
+		case CODER_FMT_ETOBUF_LCH:
+		case CODER_FMT_ETOBUF_RCH:
+			etobuf = tmp;
+			break;
+		case CDSP_FIFO_DONTCARE:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		finfo->conn_ex_info.efifo_ch = ch;
+		finfo->bit_width.efifo = bit;
+		finfo->format.etobuf = etobuf;
+	}
+
+	/* OFIFO */
+	tmp = data[ROUTE_OUT0L_SEL];
+	if (tmp != CDSP_FIFO_DONTCARE) {
+		if ((fifo_id & FIFO_OFIFO) ||
+		    (tmp == OUT_LOOPBACK_L) || (tmp == OUT_LOOPBACK_R)) {
+			sel = cdsp_info->out0_sel & ~MCB_OUT0L_SEL;
+			sel |= tmp & MCB_OUT0L_SEL;
+			cdsp_info->out0_sel = sel;
+		}
+	}
+
+	tmp = data[ROUTE_OUT0R_SEL];
+	if (tmp != CDSP_FIFO_DONTCARE) {
+		if ((fifo_id & FIFO_OFIFO) ||
+		    (tmp == OUT_LOOPBACK_L) || (tmp == OUT_LOOPBACK_R)) {
+			sel = cdsp_info->out0_sel & ~MCB_OUT0R_SEL;
+			sel |= (tmp << 4) & MCB_OUT0R_SEL;
+			cdsp_info->out0_sel = sel;
+		}
+	}
+
+	tmp = data[ROUTE_OUT1L_SEL];
+	if (tmp != CDSP_FIFO_DONTCARE) {
+		if ((fifo_id & FIFO_OFIFO) ||
+		    (tmp == OUT_LOOPBACK_L) || (tmp == OUT_LOOPBACK_R)) {
+			sel = cdsp_info->out1_sel & ~MCB_OUT1L_SEL;
+			sel |= tmp & MCB_OUT1L_SEL;
+			cdsp_info->out1_sel = sel;
+		}
+	}
+
+	tmp = data[ROUTE_OUT1R_SEL];
+	if (tmp != CDSP_FIFO_DONTCARE) {
+		if ((fifo_id & FIFO_OFIFO) ||
+		    (tmp == OUT_LOOPBACK_L) || (tmp == OUT_LOOPBACK_R)) {
+			sel = cdsp_info->out1_sel & ~MCB_OUT1R_SEL;
+			sel |= (tmp << 4) & MCB_OUT1R_SEL;
+			cdsp_info->out1_sel = sel;
+		}
+	}
+
+	tmp = data[ROUTE_OUT2L_SEL];
+	if (tmp != CDSP_FIFO_DONTCARE) {
+		if ((fifo_id & FIFO_OFIFO) ||
+		    (tmp == OUT_LOOPBACK_L) || (tmp == OUT_LOOPBACK_R)) {
+			sel = cdsp_info->out2_sel & ~MCB_OUT2L_SEL;
+			sel |= tmp & MCB_OUT2L_SEL;
+			cdsp_info->out2_sel = sel;
+		}
+	}
+
+	tmp = data[ROUTE_OUT2R_SEL];
+	if (tmp != CDSP_FIFO_DONTCARE) {
+		if ((fifo_id & FIFO_OFIFO) ||
+		    (tmp == OUT_LOOPBACK_L) || (tmp == OUT_LOOPBACK_R)) {
+			sel = cdsp_info->out2_sel & ~MCB_OUT2R_SEL;
+			sel |= (tmp << 4) & MCB_OUT2R_SEL;
+			cdsp_info->out2_sel = sel;
+		}
+	}
+
+	if (fifo_id & FIFO_OFIFO) {
+		/* 0: 2ch 16bit) */
+		/* 1: 4ch 16bit */
+		/* 2: 2ch 32bit */
+		/* 3: 4ch 32bit */
+		ch = finfo->conn_ex_info.ofifo_ch;
+		bit = finfo->bit_width.ofifo;
+
+		tmp = data[CDSP_OFIFO_CH];
+		switch (tmp) {
+		case 2:
+		case 4:
+			ch = tmp;
+			break;
+		case CDSP_FIFO_DONTCARE:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		tmp = data[CDSP_OFIFO_BIT_WIDTH];
+		switch (tmp) {
+		case 16:
+		case 32:
+			bit = tmp;
+			break;
+		case CDSP_FIFO_DONTCARE:
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		finfo->conn_ex_info.ofifo_ch = ch;
+		finfo->bit_width.ofifo = bit;
+
+		sample = ((u32) data[CDSP_OFIFO_BUFFERING + 0] << 8) |
+		    (u32) data[CDSP_OFIFO_BUFFERING + 1];
+		if (sample != CDSP_FIFO_DONTCARE_W) {
+			if (sample > OFIFO_BUF_SAMPLE_MAX)
+				return -EINVAL;
+			cdsp_info->ofifo_buf_sample = sample;
+		}
+	}
+
+	/* DFIFO */
+	if (fifo_id & FIFO_DFIFO) {
+		tmp = data[CDSP_DFIFO_BIT_WIDTH];
+		if (tmp != CDSP_FIFO_DONTCARE) {
+			sel = cdsp_info->rdfifo_bit_sel & ~MCB_DFIFO_BIT;
+			if (tmp == 32)
+				sel |= MCB_DFIFO_BIT;
+			cdsp_info->rdfifo_bit_sel = sel;
+		}
+
+		pos = ((u32) data[CDSP_DFIFO_CB_POINT + 0] << 8) |
+		    (u32) data[CDSP_DFIFO_CB_POINT + 1];
+		switch (pos) {
+		case CDSP_FIFO_DONTCARE_CB:
+			break;
+		case CDSP_FIFO_NOT_CB:
+			cdsp_info->dfifo_cb_pos = CBPOS_DFIFO_NONE;
+			break;
+		default:
+			if (pos > CBPOS_DFIFO_MAX)
+				return -EINVAL;
+
+			cdsp_info->dfifo_cb_pos = pos;
+			break;
+		}
+	}
+
+	/* RFIFO */
+	if (fifo_id & FIFO_RFIFO) {
+		tmp = data[CDSP_RFIFO_BIT_WIDTH];
+		if (tmp != CDSP_FIFO_DONTCARE) {
+			sel = cdsp_info->rdfifo_bit_sel & ~MCB_RFIFO_BIT;
+			if (tmp == 32)
+				sel |= MCB_RFIFO_BIT;
+			cdsp_info->rdfifo_bit_sel = sel;
+		}
+
+		pos = ((u32) data[CDSP_RFIFO_CB_POINT + 0] << 8) |
+		    (u32) data[CDSP_RFIFO_CB_POINT + 1];
+		switch (pos) {
+		case CDSP_FIFO_DONTCARE_CB:
+			break;
+		case CDSP_FIFO_NOT_CB:
+			cdsp_info->rfifo_cb_pos = CBPOS_RFIFO_NONE;
+			break;
+		default:
+			if (pos > CBPOS_RFIFO_MAX)
+				return -EINVAL;
+
+			cdsp_info->rfifo_cb_pos = pos;
+			break;
+		}
+
+		sample = ((u32) data[CDSP_RFIFO_BUFFERING + 0] << 8) |
+		    (u32) data[CDSP_RFIFO_BUFFERING + 1];
+		if (sample != CDSP_FIFO_DONTCARE_W) {
+			if (sample > RFIFO_BUF_SAMPLE_MAX)
+				return -EINVAL;
+
+			cdsp_info->rfifo_buf_sample = sample;
+		}
+	}
+
+	return 0;
+}
+
+static int cdsp_memoryrange_check(u16 start1, u16 size1, u16 start2, u16 size2)
+{
+	u16 end1, end2;
+
+	end1 = start1 + size1 - 1;
+	end2 = start2 + size2 - 1;
+
+	if (start2 >= start1 && start2 <= end1)
+		return -EINVAL;
+
+	if (end2 >= start1 && end2 <= end1)
+		return -EINVAL;
+
+	if (start1 >= start2 && start1 <= end2)
+		return -EINVAL;
+
+	if (end1 >= start2 && end1 <= end2)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline int cdsp_program_check(enum mc_cdsp_id id,
+				     struct coder_firmware *coder)
+{
+	struct coder_info *info;
+	struct coder_info *another_info;
+	struct program_info *another_pinfo;
+	u16 prog_loadaddr, prog_size;
+	u16 data_loadaddr, data_size;
+	u16 work_begin, work_size;
+	u16 stack_begin, stack_size;
+	u16 prog_type;
+	u32 total_size;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+	another_info = cdsp_coder_info_get(cdsp_another_id_get(id));
+
+	/* Size Check */
+	if (coder->size < PRG_DESC_PROGRAM)
+		return -EINVAL;
+
+	total_size = MAKE_HALFWORD(coder->firmware[PRG_DESC_PRG_SIZE],
+				   coder->firmware[PRG_DESC_PRG_SIZE + 1]);
+	total_size += MAKE_HALFWORD(coder->firmware[PRG_DESC_DATA_SIZE],
+				    coder->firmware[PRG_DESC_DATA_SIZE + 1]);
+	total_size += PRG_DESC_PROGRAM / 2;
+	if (coder->size != (total_size * 2))
+		return -EINVAL;
+
+	/* Program Type Check */
+	prog_type = MAKE_HALFWORD(coder->firmware[PRG_DESC_PRG_TYPE],
+				  coder->firmware[PRG_DESC_PRG_TYPE + 1]);
+	if (id == CDSP_DECODER && prog_type != PRG_PRM_TYPE_TASK0)
+		return -EINVAL;
+
+	if (id == CDSP_ENCODER && prog_type != PRG_PRM_TYPE_TASK1)
+		return -EINVAL;
+
+	if (another_info->state == STATE_NOTINIT ||
+	    another_info->state == STATE_INIT)
+		return 0;
+
+	/* RAM Check */
+	prog_loadaddr = MAKE_HALFWORD(coder->firmware[PRG_DESC_PRG_LOAD_ADR],
+				      coder->firmware[PRG_DESC_PRG_LOAD_ADR +
+						      1]);
+	prog_size =
+	    MAKE_HALFWORD(coder->firmware[PRG_DESC_PRG_SIZE],
+			  coder->firmware[PRG_DESC_PRG_SIZE + 1]);
+	data_loadaddr =
+	    MAKE_HALFWORD(coder->firmware[PRG_DESC_DATA_LOAD_ADR],
+			  coder->firmware[PRG_DESC_DATA_LOAD_ADR + 1]);
+	data_size =
+	    MAKE_HALFWORD(coder->firmware[PRG_DESC_DATA_SIZE],
+			  coder->firmware[PRG_DESC_DATA_SIZE + 1]);
+	work_begin =
+	    MAKE_HALFWORD(coder->firmware[PRG_DESC_WORK_BEGIN_ADR],
+			  coder->firmware[PRG_DESC_WORK_BEGIN_ADR + 1]);
+	work_size =
+	    MAKE_HALFWORD(coder->firmware[PRG_DESC_WORK_SIZE],
+			  coder->firmware[PRG_DESC_WORK_SIZE + 1]);
+	stack_begin =
+	    MAKE_HALFWORD(coder->firmware[PRG_DESC_STACK_BEGIN_ADR],
+			  coder->firmware[PRG_DESC_STACK_BEGIN_ADR + 1]);
+	stack_size =
+	    MAKE_HALFWORD(coder->firmware[PRG_DESC_STACK_SIZE],
+			  coder->firmware[PRG_DESC_STACK_SIZE + 1]);
+	another_pinfo = &another_info->prog_info;
+
+	/* Program & Program */
+	ret = cdsp_memoryrange_check(prog_loadaddr, prog_size,
+				     another_pinfo->prog_loadaddr,
+				     another_pinfo->prog_size);
+	if (ret < 0)
+		return ret;
+
+	/* Data & Data */
+	ret = cdsp_memoryrange_check(data_loadaddr, data_size,
+				     another_pinfo->data_loadaddr,
+				     another_pinfo->data_size);
+	if (ret < 0)
+		return ret;
+
+	/* Data & Stack */
+	ret = cdsp_memoryrange_check(data_loadaddr, data_size,
+				     another_pinfo->stack_begin,
+				     another_pinfo->stack_size);
+	if (ret < 0)
+		return ret;
+
+	ret = cdsp_memoryrange_check(stack_begin, stack_size,
+				     another_pinfo->data_loadaddr,
+				     another_pinfo->data_size);
+	if (ret < 0)
+		return ret;
+
+	/* Work & Work */
+	ret = cdsp_memoryrange_check(work_begin, work_size,
+				     another_pinfo->work_begin,
+				     another_pinfo->work_size);
+	if (ret < 0)
+		return ret;
+
+	/* Work & Stack */
+	ret = cdsp_memoryrange_check(work_begin, work_size,
+				     another_pinfo->stack_begin,
+				     another_pinfo->stack_size);
+	if (ret < 0)
+		return ret;
+
+	return cdsp_memoryrange_check(stack_begin, stack_size,
+				      another_pinfo->work_begin,
+				      another_pinfo->work_size);
+}
+
+static inline int cdsp_aec_program_check(struct coder_firmware *coder_a,
+					 struct coder_firmware *coder_b)
+{
+	u16 prog_loadaddr_a, prog_size_a;
+	u16 data_loadaddr_a, data_size_a;
+	u16 work_begin_a, work_size_a;
+	u16 stack_begin_a, stack_size_a;
+	u32 total_size_a;
+	u16 prog_loadaddr_b, prog_size_b;
+	u16 data_loadaddr_b, data_size_b;
+	u16 work_begin_b, work_size_b;
+	u16 stack_begin_b, stack_size_b;
+	u32 total_size_b;
+	int ret;
+
+	total_size_a = MAKE_HALFWORD(coder_a->firmware[PRG_DESC_PRG_SIZE],
+				     coder_a->firmware[PRG_DESC_PRG_SIZE + 1]);
+	total_size_a += MAKE_HALFWORD(coder_a->firmware[PRG_DESC_DATA_SIZE],
+				      coder_a->firmware[PRG_DESC_DATA_SIZE +
+							1]);
+	total_size_a += PRG_DESC_PROGRAM / 2;
+
+	total_size_b = MAKE_HALFWORD(coder_b->firmware[PRG_DESC_PRG_SIZE],
+				     coder_b->firmware[PRG_DESC_PRG_SIZE + 1]);
+	total_size_b += MAKE_HALFWORD(coder_b->firmware[PRG_DESC_DATA_SIZE],
+				      coder_b->firmware[PRG_DESC_DATA_SIZE +
+							1]);
+	total_size_b += PRG_DESC_PROGRAM / 2;
+
+	/* RAM Check */
+	prog_loadaddr_a =
+	    MAKE_HALFWORD(coder_a->firmware[PRG_DESC_PRG_LOAD_ADR],
+			  coder_a->firmware[PRG_DESC_PRG_LOAD_ADR + 1]);
+	prog_loadaddr_b =
+	    MAKE_HALFWORD(coder_b->firmware[PRG_DESC_PRG_LOAD_ADR],
+			  coder_b->firmware[PRG_DESC_PRG_LOAD_ADR + 1]);
+
+	prog_size_a = MAKE_HALFWORD(coder_a->firmware[PRG_DESC_PRG_SIZE],
+				    coder_a->firmware[PRG_DESC_PRG_SIZE + 1]);
+	prog_size_b = MAKE_HALFWORD(coder_b->firmware[PRG_DESC_PRG_SIZE],
+				    coder_b->firmware[PRG_DESC_PRG_SIZE + 1]);
+
+	data_loadaddr_a =
+	    MAKE_HALFWORD(coder_a->firmware[PRG_DESC_DATA_LOAD_ADR],
+			  coder_a->firmware[PRG_DESC_DATA_LOAD_ADR + 1]);
+	data_loadaddr_b =
+	    MAKE_HALFWORD(coder_b->firmware[PRG_DESC_DATA_LOAD_ADR],
+			  coder_b->firmware[PRG_DESC_DATA_LOAD_ADR + 1]);
+
+	data_size_a = MAKE_HALFWORD(coder_a->firmware[PRG_DESC_DATA_SIZE],
+				    coder_a->firmware[PRG_DESC_DATA_SIZE + 1]);
+	data_size_b = MAKE_HALFWORD(coder_b->firmware[PRG_DESC_DATA_SIZE],
+				    coder_b->firmware[PRG_DESC_DATA_SIZE + 1]);
+
+	work_begin_a = MAKE_HALFWORD(coder_a->firmware[PRG_DESC_WORK_BEGIN_ADR],
+				     coder_a->firmware[PRG_DESC_WORK_BEGIN_ADR +
+						       1]);
+	work_begin_b =
+	    MAKE_HALFWORD(coder_b->firmware[PRG_DESC_WORK_BEGIN_ADR],
+			  coder_b->firmware[PRG_DESC_WORK_BEGIN_ADR + 1]);
+
+	work_size_a = MAKE_HALFWORD(coder_a->firmware[PRG_DESC_WORK_SIZE],
+				    coder_a->firmware[PRG_DESC_WORK_SIZE + 1]);
+	work_size_b = MAKE_HALFWORD(coder_b->firmware[PRG_DESC_WORK_SIZE],
+				    coder_b->firmware[PRG_DESC_WORK_SIZE + 1]);
+
+	stack_begin_a =
+	    MAKE_HALFWORD(coder_a->firmware[PRG_DESC_STACK_BEGIN_ADR],
+			  coder_a->firmware[PRG_DESC_STACK_BEGIN_ADR + 1]);
+	stack_begin_b =
+	    MAKE_HALFWORD(coder_b->firmware[PRG_DESC_STACK_BEGIN_ADR],
+			  coder_b->firmware[PRG_DESC_STACK_BEGIN_ADR + 1]);
+
+	stack_size_a = MAKE_HALFWORD(coder_a->firmware[PRG_DESC_STACK_SIZE],
+				     coder_a->firmware[PRG_DESC_STACK_SIZE +
+						       1]);
+	stack_size_b =
+	    MAKE_HALFWORD(coder_b->firmware[PRG_DESC_STACK_SIZE],
+			  coder_b->firmware[PRG_DESC_STACK_SIZE + 1]);
+
+	/* Program & Program */
+	ret = cdsp_memoryrange_check(prog_loadaddr_a, prog_size_a,
+				     prog_loadaddr_b, prog_size_b);
+	if (ret < 0)
+		return ret;
+
+	/* Data & Data */
+	ret = cdsp_memoryrange_check(data_loadaddr_a, data_size_a,
+				     data_loadaddr_b, data_size_b);
+	if (ret < 0)
+		return ret;
+
+	/* Data & Stack */
+	ret = cdsp_memoryrange_check(data_loadaddr_a, data_size_a,
+				     stack_begin_b, stack_size_b);
+	if (ret < 0)
+		return ret;
+
+	ret = cdsp_memoryrange_check(stack_begin_a, stack_size_a,
+				     data_loadaddr_b, data_size_b);
+	if (ret < 0)
+		return ret;
+
+	/* Work & Work */
+	ret = cdsp_memoryrange_check(work_begin_a, work_size_a,
+				     work_begin_b, work_size_b);
+	if (ret < 0)
+		return ret;
+
+	/* Work & Stack */
+	ret = cdsp_memoryrange_check(work_begin_a, work_size_a,
+				     stack_begin_b, stack_size_b);
+	if (ret < 0)
+		return ret;
+
+	return cdsp_memoryrange_check(stack_begin_a, stack_size_a,
+				      work_begin_b, work_size_b);
+}
+
+static int cdsp_inout_path_check(struct connection_info *conn,
+				 struct connection_info *another_conn)
+{
+	/* Input */
+	switch (conn->src) {
+	case CDSP_IN_SOURCE_OTHER_OUTBUF:
+	case CDSP_IN_SOURCE_NONE:
+		break;
+		/* DFIFO */
+	case CDSP_IN_SOURCE_DFIFO:
+		switch (another_conn->src) {
+		case CDSP_IN_SOURCE_EFIFO:
+		case CDSP_IN_SOURCE_OTHER_OUTBUF:
+		case CDSP_IN_SOURCE_NONE:
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+		/* EFIFO */
+	case CDSP_IN_SOURCE_EFIFO:
+		switch (another_conn->src) {
+		case CDSP_IN_SOURCE_DFIFO:
+		case CDSP_IN_SOURCE_OTHER_OUTBUF:
+		case CDSP_IN_SOURCE_NONE:
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+		/* DFIFO & EFIFO */
+	case CDSP_IN_SOURCE_DFIFO_EFIFO:
+		switch (another_conn->src) {
+		case CDSP_IN_SOURCE_OTHER_OUTBUF:
+		case CDSP_IN_SOURCE_NONE:
+			break;
+		default:
+			return -EINVAL;
+		}
+	default:
+		return -EIO;
+	}
+
+	/* output */
+	switch (conn->dest) {
+	case CDSP_OUT_DEST_OTHER_INBUF:
+	case CDSP_OUT_DEST_NONE:
+		break;
+		/* RFIFO */
+	case CDSP_OUT_DEST_RFIFO:
+		switch (another_conn->dest) {
+		case CDSP_OUT_DEST_OFIFO:
+		case CDSP_OUT_DEST_OTHER_INBUF:
+		case CDSP_OUT_DEST_NONE:
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+		/* OFIFO */
+	case CDSP_OUT_DEST_OFIFO:
+		switch (another_conn->dest) {
+		case CDSP_OUT_DEST_RFIFO:
+		case CDSP_OUT_DEST_OTHER_INBUF:
+		case CDSP_OUT_DEST_NONE:
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+		/* RFIFO & OFIFO */
+	case CDSP_OUT_DEST_OFIFO_RFIFO:
+		switch (another_conn->dest) {
+		case CDSP_OUT_DEST_OTHER_INBUF:
+		case CDSP_OUT_DEST_NONE:
+			break;
+		default:
+			return -EINVAL;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static inline int cdsp_inout_type_check(struct connection_info *conn_info,
+					u16 inout_type)
+{
+	u16 in_type, out_type;
+
+	in_type = inout_type & PRG_PRM_IOTYPE_IN_MASK;
+	out_type = inout_type & PRG_PRM_IOTYPE_OUT_MASK;
+
+	/* Input type check */
+	if (in_type == PRG_PRM_IOTYPE_IN_NOPCM) {
+		switch (conn_info->src) {
+		case CDSP_IN_SOURCE_NONE:
+		case CDSP_IN_SOURCE_DFIFO:
+			break;
+		default:
+			return -EIO;
+		}
+	}
+
+	/* Output type check */
+	if (out_type == PRG_PRM_IOTYPE_OUT_NOPCM) {
+		switch (conn_info->dest) {
+		case CDSP_OUT_DEST_NONE:
+		case CDSP_OUT_DEST_RFIFO:
+			break;
+		default:
+			return -EIO;
+		}
+	}
+
+	return 0;
+}
+
+static inline int cdsp_path_check(enum mc_cdsp_id id, u16 inout_type,
+				  struct connection_info *conn_info)
+{
+	struct coder_info *another_info;
+	u8 state;
+	int ret;
+
+	another_info = cdsp_coder_info_get(cdsp_another_id_get(id));
+
+	state = another_info->state;
+	if (state == STATE_READY_SETUP || state == STATE_READY ||
+	    state == STATE_PLAYING) {
+		/* Check Input/Output path */
+		ret =
+		    cdsp_inout_path_check(conn_info, &another_info->conn_info);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Check Input/Output Type */
+	return cdsp_inout_type_check(conn_info, inout_type);
+}
+
+static int cdsp_data_analyze_coder(enum mc_cdsp_id id,
+				   struct aec_cdsp_info *cdsp_info)
+{
+	struct aec_cdsp_func_info *finfo;
+	struct coder_info *cinfo;
+	struct coder_firmware coder;
+	u8 *data;
+	u32 data_size;
+	u32 top, tag, size, tmp;
+	int ret;
+
+	if (id == CDSP_DECODER)
+		finfo = &cdsp_info->func_info[AEC_FUNC_INFO_A];
+	else
+		finfo = &cdsp_info->func_info[AEC_FUNC_INFO_B];
+
+	data = finfo->data;
+	data_size = finfo->data_size;
+	finfo->fifo_data = NULL;
+	finfo->prog_data = NULL;
+	finfo->prog_size = 0;
+	finfo->param_data = NULL;
+	finfo->param_num = 0;
+	finfo->ext = NULL;
+
+	cinfo = cdsp_coder_info_get(id);
+	finfo->conn_info.src = cinfo->conn_info.src;
+	finfo->conn_info.dest = cinfo->conn_info.dest;
+	finfo->conn_ex_info.efifo_ch = cinfo->conn_ex_info.efifo_ch;
+	finfo->conn_ex_info.ofifo_ch = cinfo->conn_ex_info.ofifo_ch;
+	finfo->bit_width.efifo = cinfo->bit_width.efifo;
+	finfo->bit_width.ofifo = cinfo->bit_width.ofifo;
+	finfo->format.fs = cinfo->format.fs;
+	finfo->format.etobuf = cinfo->format.etobuf;
+
+	if (!data || !data_size)
+		return 0;
+
+	top = 0;
+	while (top < data_size) {
+		if (top + CHUNK_SIZE > data_size)
+			return -EINVAL;
+
+		tag = htonl(*(u32 *) (data + top));
+		size = htonl(*(u32 *) (data + top + 4));
+		if (top + CHUNK_SIZE + size > data_size)
+			return -EINVAL;
+
+		top += CHUNK_SIZE;
+		switch (tag) {
+		case AEC_CDSP_TAG_PROG:
+			if (size < PROG_FIX_SIZE)
+				return -EINVAL;
+
+			tmp = htonl(*(u32 *) (data + top));
+			if (!tmp)
+				return 0;
+			if (tmp + PROG_FIX_SIZE > size)
+				return -EINVAL;
+			if (finfo->prog_data)
+				return -EINVAL;
+
+			finfo->prog_data = &data[top + PROG_FIX_SIZE];
+			finfo->prog_size = tmp;
+			break;
+		case AEC_CDSP_TAG_PRM:
+			if (size < PRM_FIX_SIZE)
+				return -EINVAL;
+
+			tmp = htonl(*(u32 *) (data + top));
+			if (!tmp)
+				return 0;
+			if (tmp % PRM_UNIT_SIZE)
+				return -EINVAL;
+			if (tmp + PRM_FIX_SIZE > size)
+				return -EINVAL;
+			if (finfo->param_data)
+				return -EINVAL;
+
+			finfo->param_data = &data[top + PRM_FIX_SIZE];
+			finfo->param_num = tmp / PRM_UNIT_SIZE;
+			break;
+		case AEC_CDSP_TAG_FIFO:
+			if (size < FIFO_FIX_SIZE)
+				return -EINVAL;
+			if (finfo->fifo_data)
+				return -EINVAL;
+
+			finfo->fifo_data = &data[top];
+			break;
+		case AEC_CDSP_TAG_EXT:
+			if (size < EXT_FIX_SIZE)
+				return -EINVAL;
+
+			if (finfo->ext)
+				return -EINVAL;
+
+			finfo->ext = &data[top];
+			break;
+		default:
+			break;
+		}
+
+		top += size;
+	}
+
+	/* FIFO Check */
+	if (finfo->fifo_data) {
+		ret = cdsp_fifo_check(id, cdsp_info);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Program Check */
+	if (finfo->prog_size && finfo->prog_data) {
+		coder.firmware = finfo->prog_data;
+		coder.size = finfo->prog_size;
+
+		ret = cdsp_program_check(id, &coder);
+		if (ret < 0)
+			return ret;
+
+		cinfo->prog_info.inout_type =
+		    MAKE_HALFWORD(coder.firmware[PRG_DESC_OUTPUT_TYPE],
+				  coder.firmware[PRG_DESC_OUTPUT_TYPE + 1]);
+	}
+
+	return cdsp_path_check(id, cinfo->prog_info.inout_type,
+			       &finfo->conn_info);
+}
+
+static int cdsp_data_analyze(struct aec_cdsp_info *cdsp_info)
+{
+	struct aec_cdsp_func_info *finfo_a;
+	struct aec_cdsp_func_info *finfo_b;
+	struct coder_firmware coder_a;
+	struct coder_firmware coder_b;
+	int ret;
+
+	finfo_a = &cdsp_info->func_info[AEC_FUNC_INFO_A];
+	finfo_b = &cdsp_info->func_info[AEC_FUNC_INFO_B];
+	cdsp_info->dfifo_cb_pos = mc_fifo_info.dfifo_cb_pos;
+	cdsp_info->rfifo_cb_pos = mc_fifo_info.rfifo_cb_pos;
+	cdsp_info->ofifo_buf_sample = mc_fifo_info.ofifo_buf_sample;
+	cdsp_info->rfifo_buf_sample = mc_fifo_info.rfifo_buf_sample;
+	cdsp_info->out0_sel = mc_fifo_info.out0_sel;
+	cdsp_info->out1_sel = mc_fifo_info.out1_sel;
+	cdsp_info->out2_sel = mc_fifo_info.out2_sel;
+	cdsp_info->rdfifo_bit_sel = mc_fifo_info.rdfifo_bit_sel;
+	cdsp_info->efifo01_sel = mc_fifo_info.efifo01_sel;
+	cdsp_info->efifo23_sel = mc_fifo_info.efifo23_sel;
+
+	ret = cdsp_data_analyze_coder(CODER_DEC, cdsp_info);
+	if (ret < 0)
+		return ret;
+
+	ret = cdsp_data_analyze_coder(CODER_ENC, cdsp_info);
+	if (ret < 0)
+		return ret;
+
+	if (finfo_a->fifo_data && finfo_b->fifo_data) {
+		ret = cdsp_inout_path_check(&finfo_a->conn_info,
+					    &finfo_b->conn_info);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (finfo_a->prog_size && finfo_a->prog_data &&
+	    finfo_b->prog_size && finfo_b->prog_data) {
+		coder_a.firmware = finfo_a->prog_data;
+		coder_a.size = finfo_a->prog_size;
+		coder_b.firmware = finfo_b->prog_data;
+		coder_b.size = finfo_b->prog_size;
+		ret = cdsp_aec_program_check(&coder_a, &coder_b);
+	}
+
+	return ret;
+}
+
+static inline void cdsp_output_format_notify_complete(enum mc_cdsp_id id)
+{
+	struct coder_info *another_info;
+	struct coder_params coder;
+
+	another_info = cdsp_coder_info_get(cdsp_another_id_get(id));
+
+	/* Complete NotifyOutFormat */
+	if (another_info->format_propagate) {
+		coder.command = CDSP_CMD_OS2HOST_CMN_NOTIFY_OUT_FORMAT;
+		coder.params[CDSP_CMD_PARAM_RESULT_00] = 0;
+		coder.params[CDSP_CMD_PARAM_RESULT_01] = 0;
+		coder.params[CDSP_CMD_PARAM_RESULT_02] = 0;
+		coder.params[CDSP_CMD_PARAM_RESULT_03] = 0;
+		cdsp_command_write_complete(id, &coder);
+
+		another_info->format_propagate = false;
+	}
+}
+
+static void cdsp_coder_close(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	u32 int_reg;
+	u8 ctl, int_data, ctl_data;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	cdsp_output_format_notify_complete(id);
+
+	/* Reset command */
+	coder.command = CDSP_CMD_HOST2OS_CMN_RESET;
+	ret = cdsp_command_write_host2os(id, &coder);
+
+	/* Command register Initialize */
+	cdsp_command_init(id);
+
+	/* DEC/ENC SFR,EVT Disable */
+	if (id == CDSP_DECODER) {
+		int_reg = MCI_DEC_ENABLE;
+		ctl = MCB_EDEC;
+	} else {
+		int_reg = MCI_ENC_ENABLE;
+		ctl = MCB_EENC;
+	}
+
+	mc_read_c(int_reg, &int_data, 1);
+
+	int_data &= ~(MCB_EDEC_EVT | MCB_EDEC_SFR);
+
+	mc_read_digital(MCI_ECDSP, &ctl_data, 1);
+	ctl_data &= ~ctl;
+	mc_packet_add_force_write_if(MCI_ECDSP, ctl_data);
+
+	mc_packet_add_force_write_c(int_reg, int_data);
+
+	mc_packet_execute();
+
+	info->format.fs = CODER_FMT_FS_48000;
+
+}
+
+static void cdsp_program_terminate(enum mc_cdsp_id id)
+{
+	struct coder_params coder;
+	struct coder_info *info;
+
+	coder.command = CDSP_CMD_HOST2OS_SYS_TERMINATE;
+	cdsp_command_write_host2os(id, &coder);
+
+	info = cdsp_coder_info_get(id);
+	info->prog_info.vendor_id = 0;
+	info->prog_info.function_id = 0;
+}
+
+static int cdsp_program_write(struct fsq_data_info *fsq)
+{
+	u8 data;
+	u16 load_addr, remain;
+	u32 current, writes, i;
+	int ret = 0;
+
+	load_addr = fsq->load_addr;
+	current = 0;
+	remain = fsq->size;
+
+	/* CDSP_MSEL Set */
+	mc_read_c(MCI_CDSP_RESET, &data, 1);
+
+	if (fsq->scramble == PRG_PRM_SCRMBL_DISABLE)
+		data |= MCB_CDSP_FMODE;
+	else
+		data &= ~MCB_CDSP_FMODE;
+
+	data &= ~MCB_CDSP_MSEL;
+
+	if (fsq->msel == MSEL_PROG)
+		data |= MCB_CDSP_MSEL_PROG;
+	else
+		data |= MCB_CDSP_MSEL_DATA;
+
+	mc_packet_add_force_write_c(MCI_CDSP_RESET, data);
+
+	mc_packet_execute();
+
+	while (remain > 0 && !ret) {
+		/* CDSP_MAR Set */
+		mc_packet_add_force_write_c(MCI_CDSP_MAR_H,
+					    HIGH_BYTE(load_addr));
+		mc_packet_add_force_write_c(MCI_CDSP_MAR_L,
+					    LOW_BYTE(load_addr));
+
+		mc_packet_execute();
+
+		/* fill FFIFO */
+		writes = FIFOSIZE_FFIFO / sizeof(u16);
+		if (writes > remain)
+			writes = remain;
+
+		for (i = 0; i < writes * 2; ++i)
+			mc_packet_add_force_write_if(MCI_FSQ_FFIFO,
+						     fsq->data[current * 2 +
+							       i]);
+
+		mc_packet_execute();
+
+		load_addr += writes;
+		current += writes;
+		remain -= writes;
+
+		/* FFIFO_FLG Clear */
+		mc_packet_add_force_write_if(MCI_CDSP, MCB_IRQFLAG_FFIFO);
+
+		/* FSQ_END_FLG Clear */
+		mc_packet_add_force_write_c(MCI_FFIFO_FLG,
+					    MCB_FFIFO_FLG_FSQ_END);
+
+		mc_packet_execute();
+
+		/* FSQ_START Set */
+		mc_read_c(MCI_DEC_START, &data, 1);
+		data |= MCB_DEC_FSQ_START;
+		mc_packet_add_force_write_c(MCI_DEC_START, data);
+
+		mc_packet_execute();
+
+		/* FSQ_END_FLG Polling */
+		mc_packet_add_wait_event(MCDRV_EVT_C_REG_FLAG_SET |
+					 (MCI_FFIFO_FLG << 8) |
+					 MCB_FFIFO_FLG_FSQ_END);
+
+		ret = mc_packet_execute();
+		if (ret < 0)
+			return ret;
+
+		/* FSQ_START Clear */
+		mc_read_c(MCI_DEC_START, &data, 1);
+		data &= ~MCB_DEC_FSQ_START;
+		mc_packet_add_force_write_c(MCI_DEC_START, data);
+
+		mc_packet_execute();
+	}
+
+	/* FFIFO_FLG Clear */
+	mc_packet_add_force_write_if(MCI_CDSP, MCB_IRQFLAG_FFIFO);
+
+	/* FSQ_END_FLG Clear */
+	mc_packet_add_force_write_c(MCI_FFIFO_FLG, MCB_FFIFO_FLG_FSQ_END);
+
+	mc_packet_execute();
+
+	return ret;
+}
+
+static inline int cdsp_program_download(u8 *firmware)
+{
+	struct fsq_data_info fsq[2];
+	u8 data;
+	int ret;
+
+	/* CDSP_SAVEOFF Set */
+	mc_packet_add_force_write_c(MCI_PWM_DIGITAL_CDSP, MCB_PWM_CDSP_SAVEOFF);
+
+	mc_packet_execute();
+
+	/* CDSP_HALT_MODE Check */
+	mc_packet_add_wait_event(MCDRV_EVT_C_REG_FLAG_RESET |
+				 (MCI_CDSP_POWER_MODE << 8) |
+				 MCB_CDSP_HLT_MODE_SLEEP_HALT);
+
+	ret = mc_packet_execute();
+	if (ret < 0) {
+		mc_packet_add_force_write_c(MCI_PWM_DIGITAL_CDSP, 0);
+
+		mc_packet_execute();
+
+		return ret;
+	}
+
+	/* FSQ_SRST */
+	mc_read_c(MCI_CDSP_RESET, &data, 1);
+	data |= MCB_CDSP_FSQ_SRST;
+	mc_packet_add_force_write_c(MCI_CDSP_RESET, data);
+	data &= ~MCB_CDSP_FSQ_SRST;
+	mc_packet_add_force_write_c(MCI_CDSP_RESET, data);
+
+	/* 150ns wait */
+	mc_packet_add_wait(1);
+
+	mc_packet_execute();
+
+	/* FFIFO_RST */
+	mc_read_c(MCI_DEC_FIFO_RST, &data, 1);
+	data |= MCB_DEC_FFIFO_RST;
+	mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+	data &= ~MCB_DEC_FFIFO_RST;
+	mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+
+	mc_packet_execute();
+
+	/* Transfer Program & Data */
+	fsq[0].data = &firmware[PRG_DESC_PROGRAM];
+	fsq[0].size = MAKE_HALFWORD(firmware[PRG_DESC_PRG_SIZE],
+				    firmware[PRG_DESC_PRG_SIZE + 1]);
+	fsq[0].load_addr = MAKE_HALFWORD(firmware[PRG_DESC_PRG_LOAD_ADR],
+					 firmware[PRG_DESC_PRG_LOAD_ADR + 1]);
+	fsq[0].scramble = MAKE_HALFWORD(firmware[PRG_DESC_PRG_SCRAMBLE],
+					firmware[PRG_DESC_PRG_SCRAMBLE + 1]);
+	fsq[0].msel = MSEL_PROG;
+
+	fsq[1].data = &fsq[0].data[(u32) fsq[0].size * 2];
+	fsq[1].size = MAKE_HALFWORD(firmware[PRG_DESC_DATA_SIZE],
+				    firmware[PRG_DESC_DATA_SIZE + 1]);
+	fsq[1].load_addr = MAKE_HALFWORD(firmware[PRG_DESC_DATA_LOAD_ADR],
+					 firmware[PRG_DESC_DATA_LOAD_ADR + 1]);
+	fsq[1].scramble = MAKE_HALFWORD(firmware[PRG_DESC_DATA_SCRAMBLE],
+					firmware[PRG_DESC_DATA_SCRAMBLE + 1]);
+	fsq[1].msel = MSEL_DATA;
+
+	ret = cdsp_program_write(&fsq[0]);
+	if (!ret)
+		ret = cdsp_program_write(&fsq[1]);
+
+	/* CDSP_SAVEOFF Clear */
+	mc_packet_add_force_write_c(MCI_PWM_DIGITAL_CDSP, 0);
+
+	mc_packet_execute();
+
+	return ret;
+}
+
+static inline int cdsp_program_init(enum mc_cdsp_id id,
+				    struct coder_firmware *coderf)
+{
+	struct coder_info *info;
+	struct coder_params coderp;
+	u16 data_loadaddr;
+	u16 work_begin;
+	u16 data_addr;
+	u16 data_size;
+	u8 *firmware;
+	int ret;
+
+	firmware = coderf->firmware;
+	data_loadaddr = MAKE_HALFWORD(firmware[PRG_DESC_DATA_LOAD_ADR],
+				      firmware[PRG_DESC_DATA_LOAD_ADR + 1]);
+	work_begin = MAKE_HALFWORD(firmware[PRG_DESC_WORK_BEGIN_ADR],
+				   firmware[PRG_DESC_WORK_BEGIN_ADR + 1]);
+	if (data_loadaddr < work_begin)
+		data_addr = data_loadaddr;
+	else
+		data_addr = work_begin;
+	data_size = MAKE_HALFWORD(firmware[PRG_DESC_DATA_SIZE],
+				  firmware[PRG_DESC_DATA_SIZE + 1]);
+	data_size = data_size + MAKE_HALFWORD(firmware[PRG_DESC_WORK_SIZE],
+					      firmware[PRG_DESC_WORK_SIZE + 1]);
+
+	/* SetProgramInfo command */
+	coderp.command = CDSP_CMD_HOST2OS_SYS_SET_PRG_INFO;
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_00] = LOW_BYTE(data_addr);
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_01] = HIGH_BYTE(data_addr);
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_02] = LOW_BYTE(data_size);
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_03] = HIGH_BYTE(data_size);
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_04] =
+	    firmware[PRG_DESC_ENTRY_ADR];
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_05] =
+	    firmware[PRG_DESC_ENTRY_ADR + 1];
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_06] =
+	    firmware[PRG_DESC_STACK_BEGIN_ADR];
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_07] =
+	    firmware[PRG_DESC_STACK_BEGIN_ADR + 1];
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_08] =
+	    firmware[PRG_DESC_STACK_SIZE];
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_09] =
+	    firmware[PRG_DESC_STACK_SIZE + 1];
+	coderp.params[CDSP_CMD_PARAM_ARGUMENT_10] =
+	    firmware[PRG_DESC_RESOURCE_FLAG];
+	ret = cdsp_command_write_host2os(id, &coderp);
+	if (ret < 0)
+		return ret;
+
+	/* Reset command */
+	coderp.command = CDSP_CMD_HOST2OS_CMN_RESET;
+	ret = cdsp_command_write_host2os(id, &coderp);
+	if (ret < 0)
+		return ret;
+
+	/* GetProgramVersion command */
+	coderp.command = CDSP_CMD_HOST2OS_CMN_GET_PRG_VER;
+	ret = cdsp_command_write_host2os(id, &coderp);
+	if (ret < 0)
+		return ret;
+
+	info = cdsp_coder_info_get(id);
+	info->program.version_h =
+	    MAKE_HALFWORD(coderp.params[CDSP_CMD_PARAM_RESULT_00],
+			  coderp.params[CDSP_CMD_PARAM_RESULT_01]);
+	info->program.version_l =
+	    MAKE_HALFWORD(coderp.params[CDSP_CMD_PARAM_RESULT_02],
+			  coderp.params[CDSP_CMD_PARAM_RESULT_03]);
+
+	info->prog_info.vendor_id = MAKE_HALFWORD(firmware[PRG_DESC_VENDER_ID],
+						  firmware[PRG_DESC_VENDER_ID +
+							   1]);
+	info->prog_info.function_id =
+	    MAKE_HALFWORD(firmware[PRG_DESC_FUNCTION_ID],
+			  firmware[PRG_DESC_FUNCTION_ID + 1]);
+	info->prog_info.prog_type =
+	    MAKE_HALFWORD(firmware[PRG_DESC_PRG_TYPE],
+			  firmware[PRG_DESC_PRG_TYPE + 1]);
+	info->prog_info.inout_type =
+	    MAKE_HALFWORD(firmware[PRG_DESC_OUTPUT_TYPE],
+			  firmware[PRG_DESC_OUTPUT_TYPE + 1]);
+	info->prog_info.prog_scramble =
+	    MAKE_HALFWORD(firmware[PRG_DESC_PRG_SCRAMBLE],
+			  firmware[PRG_DESC_PRG_SCRAMBLE + 1]);
+	info->prog_info.data_scramble =
+	    MAKE_HALFWORD(firmware[PRG_DESC_DATA_SCRAMBLE],
+			  firmware[PRG_DESC_DATA_SCRAMBLE + 1]);
+	info->prog_info.entry_addr =
+	    MAKE_HALFWORD(firmware[PRG_DESC_ENTRY_ADR],
+			  firmware[PRG_DESC_ENTRY_ADR + 1]);
+	info->prog_info.prog_loadaddr =
+	    MAKE_HALFWORD(firmware[PRG_DESC_PRG_LOAD_ADR],
+			  firmware[PRG_DESC_PRG_LOAD_ADR + 1]);
+	info->prog_info.prog_size =
+	    MAKE_HALFWORD(firmware[PRG_DESC_PRG_SIZE],
+			  firmware[PRG_DESC_PRG_SIZE + 1]);
+	info->prog_info.data_loadaddr =
+	    MAKE_HALFWORD(firmware[PRG_DESC_DATA_LOAD_ADR],
+			  firmware[PRG_DESC_DATA_LOAD_ADR + 1]);
+	info->prog_info.data_size =
+	    MAKE_HALFWORD(firmware[PRG_DESC_DATA_SIZE],
+			  firmware[PRG_DESC_DATA_SIZE + 1]);
+	info->prog_info.work_begin =
+	    MAKE_HALFWORD(firmware[PRG_DESC_WORK_BEGIN_ADR],
+			  firmware[PRG_DESC_WORK_BEGIN_ADR + 1]);
+	info->prog_info.work_size =
+	    MAKE_HALFWORD(firmware[PRG_DESC_WORK_SIZE],
+			  firmware[PRG_DESC_WORK_SIZE + 1]);
+	info->prog_info.stack_begin =
+	    MAKE_HALFWORD(firmware[PRG_DESC_STACK_BEGIN_ADR],
+			  firmware[PRG_DESC_STACK_BEGIN_ADR + 1]);
+	info->prog_info.stack_size =
+	    MAKE_HALFWORD(firmware[PRG_DESC_STACK_SIZE],
+			  firmware[PRG_DESC_STACK_SIZE + 1]);
+	info->prog_info.output_start_mode =
+	    MAKE_HALFWORD(firmware[PRG_DESC_OUTSTARTMODE],
+			  firmware[PRG_DESC_OUTSTARTMODE + 1]);
+	info->prog_info.resource_flag =
+	    MAKE_HALFWORD(firmware[PRG_DESC_RESOURCE_FLAG],
+			  firmware[PRG_DESC_RESOURCE_FLAG + 1]);
+	info->prog_info.max_load =
+	    MAKE_HALFWORD(firmware[PRG_DESC_MAX_LOAD],
+			  firmware[PRG_DESC_MAX_LOAD + 1]);
+
+	return 0;
+}
+
+static void cdsp_fifo_reset(enum mc_cdsp_id id, u32 fifo)
+{
+	u32 fifo_id;
+	u8 data;
+
+	fifo_id = cdsp_fifoid_get_from_coderid(id);
+	mc_read_c(MCI_DEC_FIFO_RST, &data, 1);
+
+	if ((fifo & FIFO_DFIFO_MASK) && (fifo_id & FIFO_DFIFO_MASK)) {
+		/* DFIFO Reset */
+		data |= MCB_DEC_DFIFO_RST;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+		data &= ~MCB_DEC_DFIFO_RST;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+
+		mc_fifo_info.dfifo_write_size = 0;
+	}
+
+	if ((fifo & FIFO_EFIFO_MASK) && (fifo_id & FIFO_EFIFO_MASK)) {
+		/* EFIFO Reset */
+		data |= MCB_DEC_EFIFO_RST;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+		data &= ~MCB_DEC_EFIFO_RST;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+	}
+
+	if ((fifo & FIFO_OFIFO_MASK) && (fifo_id & FIFO_OFIFO_MASK)) {
+		/* OFIFO Reset */
+		data |= MCB_DEC_OFIFO_RST;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+		data &= ~MCB_DEC_OFIFO_RST;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+	}
+
+	if ((fifo & FIFO_RFIFO_MASK) && (fifo_id & FIFO_RFIFO_MASK)) {
+		/* RFIFO Reset */
+		data |= MCB_DEC_RFIFO_RST;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+		data &= ~MCB_DEC_RFIFO_RST;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_RST, data);
+	}
+
+	mc_packet_execute();
+}
+
+static void cdsp_fifo_init(enum mc_cdsp_id id, u32 fifo)
+{
+	u32 fifo_id;
+
+	fifo_id = cdsp_fifoid_get_from_coderid(id);
+
+	if ((fifo & FIFO_DFIFO_MASK) && (fifo_id & FIFO_DFIFO_MASK)) {
+		mc_fifo_info.dfifo_cb_pos = CBPOS_DFIFO_DEF;
+		mc_fifo_info.dfifo_write_size = 0;
+	}
+
+	if ((fifo & FIFO_OFIFO_MASK) && (fifo_id & FIFO_OFIFO_MASK))
+		mc_fifo_info.ofifo_buf_sample = OFIFO_BUF_SAMPLE_DEF;
+
+	if ((fifo & FIFO_RFIFO_MASK) && (fifo_id & FIFO_RFIFO_MASK)) {
+		mc_fifo_info.rfifo_cb_pos = CBPOS_RFIFO_DEF;
+		mc_fifo_info.rfifo_buf_sample = RFIFO_BUF_SAMPLE_DEF;
+	}
+
+	cdsp_fifo_reset(id, fifo);
+}
+
+static u8 cdsp_fifo_set_ch(u32 fifo, u8 ch)
+{
+	u8 data, old_ch = 0;
+
+	mc_read_c(MCI_DEC_FIFO_CH, &data, 1);
+
+	if (fifo & FIFO_EFIFO_MASK) {
+		old_ch |= data & MCB_DEC_EFIFO_CH;
+		data &= ~MCB_DEC_EFIFO_CH;
+		data |= ch & MCB_DEC_EFIFO_CH;
+	}
+
+	if (fifo & FIFO_OFIFO_MASK) {
+		old_ch |= data & MCB_DEC_OFIFO_CH;
+		data &= ~MCB_DEC_OFIFO_CH;
+		data |= ch & MCB_DEC_OFIFO_CH;
+	}
+
+	mc_packet_add_write_c(MCI_DEC_FIFO_CH, data);
+
+	mc_packet_execute();
+
+	return old_ch;
+}
+
+static u8 cdsp_fifo_get_ch_bit(u32 fifo,
+			       struct connection_ex_info *conn_ex_info,
+			       struct bit_width_info *bit_width)
+{
+	u8 data = 0;
+
+	if (fifo & FIFO_EFIFO_MASK) {
+		if (conn_ex_info->efifo_ch == 4) {
+			if (bit_width->efifo == 32)
+				data |= MCB_DEC_EFIFO_CH_4_32;
+			else
+				data |= MCB_DEC_EFIFO_CH_4_16;
+		} else {
+			if (bit_width->efifo == 32)
+				data |= MCB_DEC_EFIFO_CH_2_32;
+			else
+				data |= MCB_DEC_EFIFO_CH_2_16;
+		}
+	}
+
+	if (fifo & FIFO_OFIFO_MASK) {
+		if (conn_ex_info->ofifo_ch == 4) {
+			if (bit_width->ofifo == 32)
+				data |= MCB_DEC_OFIFO_CH_4_32;
+			else
+				data |= MCB_DEC_OFIFO_CH_4_16;
+		} else {
+			if (bit_width->ofifo == 32)
+				data |= MCB_DEC_OFIFO_CH_2_32;
+			else
+				data |= MCB_DEC_OFIFO_CH_2_16;
+		}
+	}
+
+	return data;
+}
+
+static inline u8 cdsp_fifo_reset_ch(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	u32 fifo_id;
+	u8 data;
+
+	info = cdsp_coder_info_get(id);
+
+	fifo_id = cdsp_fifoid_get_from_coderid(id);
+	data =
+	    cdsp_fifo_get_ch_bit(fifo_id, &info->conn_ex_info,
+				 &info->bit_width);
+
+	data = cdsp_fifo_set_ch(fifo_id, data);
+
+	return data;
+}
+
+static int cdsp_connection_reset(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	coder.command = CDSP_CMD_HOST2OS_SYS_SET_CONNECTION;
+	coder.params[CDSP_CMD_PARAM_ARGUMENT_00] = info->conn_info.src;
+	coder.params[CDSP_CMD_PARAM_ARGUMENT_01] = info->conn_info.dest;
+	ret = cdsp_command_write_host2os(id, &coder);
+	if (ret < 0)
+		return ret;
+
+	cdsp_fifo_reset_ch(id);
+
+	return ret;
+}
+
+static int cdsp_coder_open(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	u8 data;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	/* Command register Initialize */
+	cdsp_command_init(id);
+
+	/* TimerReset command (Off) */
+	coder.command = CDSP_CMD_HOST2OS_SYS_TIMER_RESET;
+	coder.params[CDSP_CMD_PARAM_ARGUMENT_00] = TIMERRESET_OFF;
+	ret = cdsp_command_write_host2os(id, &coder);
+	if (ret < 0)
+		return ret;
+
+	/* DEC/ENC SFR,EVT Interrupt flag clear */
+	if (id == CDSP_DECODER) {
+		mc_read_c(MCI_DEC_FLG, &data, 1);
+		data |= MCB_ENC_FLG_SFR | MCB_DEC_EVT_FLG;
+		mc_packet_add_force_write_c(MCI_DEC_FLG, data);
+	} else {
+		mc_read_c(MCI_ENC_FLG, &data, 1);
+		data |= MCB_ENC_FLG_SFR | MCB_ENC_EVT_FLG;
+		mc_packet_add_force_write_c(MCI_ENC_FLG, data);
+	}
+
+	mc_packet_execute();
+
+	mc_read_digital(MCI_CDSP, &data, 1);
+	if (id == CDSP_DECODER)
+		data |= MCB_IRQFLAG_DEC;
+	else
+		data |= MCB_IRQFLAG_ENC;
+	mc_packet_add_force_write_if(MCI_CDSP, data);
+
+	mc_packet_execute();
+
+	/* DEC/ENC SFR,EVT Interrupt Enable */
+	if (id == CDSP_DECODER) {
+		mc_read_c(MCI_DEC_ENABLE, &data, 1);
+		data |= MCB_EDEC_SFR | MCB_EDEC_EVT;
+		mc_packet_add_force_write_c(MCI_DEC_ENABLE, data);
+	} else {
+		mc_read_c(MCI_ENC_ENABLE, &data, 1);
+		data |= MCB_EENC_SFR | MCB_EENC_EVT;
+		mc_packet_add_force_write_c(MCI_ENC_ENABLE, data);
+	}
+
+	mc_packet_execute();
+
+	mc_read_digital(MCI_ECDSP, &data, 1);
+	if (id == CDSP_DECODER)
+		data |= MCB_EDEC;
+	else
+		data |= MCB_EENC;
+	mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+	mc_packet_execute();
+
+	/* Initialize */
+	memset(info, 0, sizeof(struct coder_info));
+	info->format.fs = CODER_FMT_FS_48000;
+	info->format.etobuf = CODER_FMT_ETOBUF_LRMIX;
+	info->conn_info.src = CDSP_IN_SOURCE_NONE;
+	info->conn_info.dest = CDSP_OUT_DEST_NONE;
+	info->conn_ex_info.efifo_ch = 2;
+	info->conn_ex_info.ofifo_ch = 2;
+	info->bit_width.efifo = 16;
+	info->bit_width.ofifo = 16;
+
+	cdsp_fifo_init(id, FIFO_DFIFO | FIFO_EFIFO | FIFO_OFIFO | FIFO_RFIFO);
+
+	return cdsp_connection_reset(id);
+}
+
+static int cdsp_coder_reset(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	/* Reset command */
+	coder.command = CDSP_CMD_HOST2OS_CMN_RESET;
+	ret = cdsp_command_write_host2os(id, &coder);
+	if (ret < 0)
+		return ret;
+
+	cdsp_output_format_notify_complete(id);
+
+	/* Command register Initialize */
+	cdsp_command_init(id);
+
+	/* Input data end flag - release */
+	info->preinput_dataend_set = false;
+	info->input_dataend_set = false;
+
+	info->format.fs = CODER_FMT_FS_48000;
+	info->format.etobuf = CODER_FMT_ETOBUF_LRMIX;
+
+	return 0;
+}
+
+static void cdsp_input_position_clear(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+
+	info = cdsp_coder_info_get(id);
+
+	if (info->conn_info.src != CDSP_IN_SOURCE_EFIFO &&
+	    info->conn_info.src != CDSP_IN_SOURCE_DFIFO_EFIFO)
+		return;
+
+	/* ENC_POS Write (Suitable value) */
+	mc_packet_add_force_write_c(MCI_ENC_POS4, 0);
+
+	mc_packet_execute();
+
+	info->input_pos = 0;
+}
+
+static void cdsp_input_position_reset(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+
+	info = cdsp_coder_info_get(id);
+
+	if (info->conn_info.src != CDSP_IN_SOURCE_OTHER_OUTBUF)
+		return;
+
+	coder.command = CDSP_CMD_HOST2OS_SYS_RESET_INPUT_POS;
+	cdsp_command_write_host2os(id, &coder);
+
+	info->input_pos = 0;
+}
+
+static void cdsp_output_position_clear(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+
+	info = cdsp_coder_info_get(id);
+
+	if (info->conn_info.dest != CDSP_OUT_DEST_OFIFO &&
+	    info->conn_info.dest != CDSP_OUT_DEST_OFIFO_RFIFO)
+		return;
+
+	/* DEC_POS Write (Suitable value) */
+	mc_packet_add_force_write_c(MCI_DEC_POS4, 0);
+
+	mc_packet_execute();
+}
+
+static int cdsp_coder_clear(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	/* State check */
+	if (info->state != STATE_READY_SETUP && info->state != STATE_READY)
+		return -EBUSY;
+
+	/* Clear command */
+	coder.command = CDSP_CMD_HOST2OS_CMN_CLEAR;
+	ret = cdsp_command_write_host2os(id, &coder);
+	if (ret < 0)
+		return ret;
+
+	cdsp_output_format_notify_complete(id);
+
+	/* TimerReset command (Reset) */
+	coder.command = CDSP_CMD_HOST2OS_SYS_TIMER_RESET;
+	coder.params[CDSP_CMD_PARAM_ARGUMENT_00] = TIMERRESET_RESET;
+	ret = cdsp_command_write_host2os(id, &coder);
+	if (ret < 0)
+		return ret;
+
+	/* ChangeOutSamplingRate - Not complete */
+	info->change_output_fs = false;
+
+	/* Input data end state - release */
+	info->preinput_dataend_set = false;
+	info->input_dataend_set = false;
+
+	/* Output Start - clear */
+	switch (info->conn_info.dest) {
+	case CDSP_OUT_DEST_OFIFO:
+		mc_fifo_info.ofifo_output_start = false;
+		break;
+	case CDSP_OUT_DEST_OFIFO_RFIFO:
+		mc_fifo_info.ofifo_output_start = false;
+		mc_fifo_info.rfifo_output_start = false;
+		break;
+	case CDSP_OUT_DEST_RFIFO:
+		mc_fifo_info.rfifo_output_start = false;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+static inline int cdsp_format_set(enum mc_cdsp_id id,
+				  struct coder_params *coder)
+{
+	struct coder_info *info;
+	struct coder_params tmp;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	/* State check */
+	if (info->state != STATE_READY_SETUP)
+		return -EBUSY;
+
+	/* Argument check */
+	switch (coder->params[CDSP_CMD_PARAM_ARGUMENT_00]) {
+	case CODER_FMT_FS_48000:
+	case CODER_FMT_FS_44100:
+	case CODER_FMT_FS_32000:
+	case CODER_FMT_FS_24000:
+	case CODER_FMT_FS_22050:
+	case CODER_FMT_FS_16000:
+	case CODER_FMT_FS_12000:
+	case CODER_FMT_FS_11025:
+	case CODER_FMT_FS_8000:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	switch (coder->params[CDSP_CMD_PARAM_ARGUMENT_01]) {
+	case CODER_FMT_ETOBUF_LRMIX:
+	case CODER_FMT_ETOBUF_LCH:
+	case CODER_FMT_ETOBUF_RCH:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	tmp.command = coder->command;
+	tmp.params[CDSP_CMD_PARAM_ARGUMENT_00] =
+	    coder->params[CDSP_CMD_PARAM_ARGUMENT_00];
+	tmp.params[CDSP_CMD_PARAM_ARGUMENT_01] =
+	    coder->params[CDSP_CMD_PARAM_ARGUMENT_01];
+	ret = cdsp_command_write_host2os(id, &tmp);
+	if (ret < 0)
+		return ret;
+
+	info->format.fs = tmp.params[CDSP_CMD_PARAM_ARGUMENT_00];
+	info->format.etobuf = tmp.params[CDSP_CMD_PARAM_ARGUMENT_01];
+
+	return 0;
+}
+
+static int cdsp_input_dataend_set(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	u8 state, src;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+	state = info->state;
+
+	/* State check */
+	switch (state) {
+	case STATE_READY_SETUP:
+	case STATE_READY:
+	case STATE_PLAYING:
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	/* Path check */
+	src = info->conn_info.src;
+	if (src != CDSP_IN_SOURCE_DFIFO && src != CDSP_IN_SOURCE_DFIFO_EFIFO)
+		return -EIO;
+
+	if (state == STATE_READY_SETUP) {
+		info->preinput_dataend_set = true;
+		return 0;
+	}
+
+	info->preinput_dataend_set = false;
+
+	/* FormatPropagate flag clear */
+	info->format_propagate = false;
+
+	/* InputDataEnd command */
+	ret = cdsp_command_inputdataend(id);
+	if (ret < 0)
+		return ret;
+
+	/* Input data end state - set */
+	info->input_dataend_set = true;
+
+	/* Output Start */
+	cdsp_output_start(info);
+
+	return 0;
+}
+
+static int cdsp_timer_set(enum mc_cdsp_id id, struct coder_params *coder)
+{
+	struct coder_info *info;
+	struct coder_params tmp;
+
+	info = cdsp_coder_info_get(id);
+
+	/* State check */
+	if (info->state != STATE_READY_SETUP && info->state != STATE_READY)
+		return -EBUSY;
+
+	/* SetTimer command */
+	tmp.command = coder->command;
+	tmp.params[CDSP_CMD_PARAM_ARGUMENT_00] =
+	    coder->params[CDSP_CMD_PARAM_ARGUMENT_00];
+	tmp.params[CDSP_CMD_PARAM_ARGUMENT_01] =
+	    coder->params[CDSP_CMD_PARAM_ARGUMENT_01];
+	tmp.params[CDSP_CMD_PARAM_ARGUMENT_02] =
+	    coder->params[CDSP_CMD_PARAM_ARGUMENT_02];
+	tmp.params[CDSP_CMD_PARAM_ARGUMENT_03] =
+	    coder->params[CDSP_CMD_PARAM_ARGUMENT_03];
+	return cdsp_command_write_host2os(id, &tmp);
+}
+
+static inline int cdsp_output_set_dualmono(enum mc_cdsp_id id,
+					   struct coder_params *coder)
+{
+	struct coder_info *info;
+	struct coder_params tmp;
+
+	info = cdsp_coder_info_get(id);
+
+	/* State check */
+	switch (info->state) {
+	case STATE_READY_SETUP:
+	case STATE_READY:
+	case STATE_PLAYING:
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	/* Argument check */
+	switch (coder->params[CDSP_CMD_PARAM_ARGUMENT_00]) {
+	case CODER_DUALMONO_LR:
+	case CODER_DUALMONO_L:
+	case CODER_DUALMONO_R:
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Path check */
+	switch (info->conn_info.dest) {
+	case CDSP_OUT_DEST_OFIFO:
+	case CDSP_OUT_DEST_OFIFO_RFIFO:
+		break;
+	default:
+		return -EIO;
+	}
+
+	/* SetDualMono command */
+	tmp.command = coder->command;
+	tmp.params[CDSP_CMD_PARAM_ARGUMENT_00]
+	    = coder->params[CDSP_CMD_PARAM_ARGUMENT_00];
+	return cdsp_command_write_host2os(id, &tmp);
+}
+
+static int cdsp_input_get_position_sample(enum mc_cdsp_id id,
+					  struct coder_params *coder)
+{
+	struct coder_info *info;
+	struct coder_params tmp;
+	u32 pos;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	/* State check */
+	switch (info->state) {
+	case STATE_READY_SETUP:
+	case STATE_READY:
+	case STATE_PLAYING:
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	/* Path check */
+	if (info->conn_info.src != CDSP_IN_SOURCE_OTHER_OUTBUF)
+		return -EIO;
+
+	/* pcm input ? */
+	if ((info->prog_info.inout_type & PRG_PRM_IOTYPE_IN_MASK) !=
+	    PRG_PRM_IOTYPE_IN_PCM)
+		return -EIO;
+
+	/* GetInputPos command */
+	tmp.command = coder->command;
+	ret = cdsp_command_write_host2os(id, &tmp);
+	if (ret < 0)
+		return ret;
+
+	/* InputPos */
+	pos = (u32) tmp.params[CDSP_CMD_PARAM_RESULT_03] << 24 |
+	    (u32) tmp.params[CDSP_CMD_PARAM_RESULT_02] << 16 |
+	    (u32) tmp.params[CDSP_CMD_PARAM_RESULT_01] << 8 |
+	    (u32) tmp.params[CDSP_CMD_PARAM_RESULT_00];
+
+	pos += info->input_pos;
+
+	return pos;
+}
+
+static inline int cdsp_coder_standby(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	u32 fifo_id;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	/* TimerReset command (Reset) */
+	coder.command = CDSP_CMD_HOST2OS_SYS_TIMER_RESET;
+	coder.params[CDSP_CMD_PARAM_ARGUMENT_00] = TIMERRESET_RESET;
+	ret = cdsp_command_write_host2os(id, &coder);
+	if (ret < 0)
+		return ret;
+
+	/* Standby command */
+	coder.command = CDSP_CMD_HOST2OS_CMN_STANDBY;
+	ret = cdsp_command_write_host2os(id, &coder);
+	if (ret < 0)
+		return ret;
+
+	/* ChangeOutSamplingRate - Not complete */
+	info->change_output_fs = false;
+
+	fifo_id = cdsp_fifoid_get_from_coderid(id);
+	if (fifo_id & FIFO_OFIFO_MASK)
+		mc_fifo_info.ofifo_output_start = false;
+
+	if (fifo_id & FIFO_RFIFO_MASK)
+		mc_fifo_info.rfifo_output_start = false;
+
+	return 0;
+}
+
+static void cdsp_coder_term(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	u32 fifo;
+
+	info = cdsp_coder_info_get(id);
+
+	/* State check */
+	switch (info->state) {
+	case STATE_PLAYING:
+		cdsp_coder_stop(id, MADEVCDSP_VERIFY_COMP_ON);
+		cdsp_fifo_stop(id);
+	case STATE_READY_SETUP:
+	case STATE_READY:
+		cdsp_coder_close(id);
+
+		/* Terminate current program */
+		cdsp_program_terminate(id);
+		break;
+	default:
+		return;
+	}
+
+	fifo = cdsp_fifoid_get_from_coderid(id);
+	if (fifo & FIFO_DFIFO_MASK)
+		mc_fifo_info.dfifo_cb_pos = CBPOS_DFIFO_DEF;
+
+	if (fifo & FIFO_OFIFO_MASK) {
+		mc_fifo_info.ofifo_buf_sample = OFIFO_BUF_SAMPLE_DEF;
+		mc_fifo_info.ofifo_output_start = false;
+	}
+
+	if (fifo & FIFO_RFIFO_MASK) {
+		mc_fifo_info.rfifo_cb_pos = CBPOS_RFIFO_DEF;
+		mc_fifo_info.rfifo_buf_sample = RFIFO_BUF_SAMPLE_DEF;
+		mc_fifo_info.rfifo_output_start = false;
+	}
+
+	cdsp_coder_info_init(info);
+}
+
+static int cdsp_firmware_setup(struct aec_cdsp_func_info *finfo)
+{
+	struct coder_info *info;
+	struct coder_firmware coder;
+	bool download = false;
+	int ret;
+
+	if (!finfo->prog_size || !finfo->prog_data)
+		return 0;
+
+	if (mc_cdsp_info.hw_error_code != CDSP_ERR_NO_ERROR)
+		return -EBUSY;
+
+	coder.firmware = finfo->prog_data;
+	coder.size = finfo->prog_size;
+	info = cdsp_coder_info_get(finfo->id);
+
+	/* State check */
+	switch (info->state) {
+	case STATE_INIT:
+		download = true;
+		break;
+	case STATE_READY_SETUP:
+	case STATE_READY:
+		/* Check Program ID */
+		if (info->prog_info.vendor_id !=
+		    MAKE_HALFWORD(coder.firmware[PRG_DESC_VENDER_ID],
+				  coder.firmware[PRG_DESC_VENDER_ID + 1]))
+			download = true;
+		else if (info->prog_info.function_id !=
+			 MAKE_HALFWORD(coder.firmware[PRG_DESC_FUNCTION_ID],
+				       coder.firmware[PRG_DESC_FUNCTION_ID +
+						      1]))
+			download = true;
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	switch (info->state) {
+	case STATE_READY_SETUP:
+	case STATE_READY:
+		cdsp_coder_close(finfo->id);
+
+		/* Terminate current program */
+		cdsp_program_terminate(finfo->id);
+
+		info->state = STATE_INIT;
+		break;
+	default:
+		break;
+	}
+
+	if (download) {
+		/* Download */
+		ret = cdsp_program_download(coder.firmware);
+		if (ret < 0)
+			return ret;
+	}
+
+	/* Initialize */
+	ret = cdsp_program_init(finfo->id, &coder);
+	if (ret < 0)
+		return ret;
+
+	ret = cdsp_coder_open(finfo->id);
+	if (ret < 0) {
+		/* Terminate current program */
+		cdsp_program_terminate(finfo->id);
+
+		return ret;
+	}
+
+	info->state = STATE_READY_SETUP;
+
+	return 0;
+}
+
+static int cdsp_connection_setup(struct aec_cdsp_func_info *finfo)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	struct connection_info conn_info;
+	struct connection_ex_info conn_ex_info;
+	struct bit_width_info bit_width;
+	u32 prev, fifo;
+	u8 data;
+	int ret;
+
+	info = cdsp_coder_info_get(finfo->id);
+
+	conn_info.src = finfo->conn_info.src;
+	conn_info.dest = finfo->conn_info.dest;
+
+	conn_ex_info.efifo_ch = finfo->conn_ex_info.efifo_ch;
+	conn_ex_info.ofifo_ch = finfo->conn_ex_info.ofifo_ch;
+	bit_width.efifo = finfo->bit_width.efifo;
+	bit_width.ofifo = finfo->bit_width.ofifo;
+
+	if (info->conn_info.src == conn_info.src &&
+	    info->conn_info.dest == conn_info.dest &&
+	    info->bit_width.efifo == bit_width.efifo &&
+	    info->conn_ex_info.efifo_ch == conn_ex_info.efifo_ch &&
+	    info->bit_width.ofifo == bit_width.ofifo &&
+	    info->conn_ex_info.ofifo_ch == conn_ex_info.ofifo_ch)
+		return 0;
+
+	/* State check */
+	switch (info->state) {
+	case STATE_READY_SETUP:
+	case STATE_READY:
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	prev = FIFO_NONE;
+	if (info->conn_info.src != conn_info.src ||
+	    info->conn_info.dest != conn_info.dest) {
+		switch (info->state) {
+		case STATE_READY:
+			ret = cdsp_coder_reset(finfo->id);
+			if (ret < 0)
+				return ret;
+
+			cdsp_input_position_clear(finfo->id);
+			cdsp_input_position_reset(finfo->id);
+			cdsp_output_position_clear(finfo->id);
+
+			info->state = STATE_READY_SETUP;
+			break;
+		default:
+			break;
+		}
+
+		coder.command = CDSP_CMD_HOST2OS_SYS_SET_CONNECTION;
+		coder.params[CDSP_CMD_PARAM_ARGUMENT_00] = conn_info.src;
+		coder.params[CDSP_CMD_PARAM_ARGUMENT_01] = conn_info.dest;
+		ret = cdsp_command_write_host2os(finfo->id, &coder);
+		if (ret < 0)
+			return ret;
+
+		fifo = FIFO_NONE;
+		if (conn_info.src != info->conn_info.src) {
+			switch (conn_info.src) {
+			case CDSP_IN_SOURCE_DFIFO:
+				if (info->conn_info.src !=
+				    CDSP_IN_SOURCE_DFIFO_EFIFO)
+					fifo |= FIFO_DFIFO;
+				break;
+			case CDSP_IN_SOURCE_EFIFO:
+				if (info->conn_info.src !=
+				    CDSP_IN_SOURCE_DFIFO_EFIFO)
+					fifo |= FIFO_EFIFO;
+				break;
+			case CDSP_IN_SOURCE_DFIFO_EFIFO:
+				if (info->conn_info.src != CDSP_IN_SOURCE_DFIFO)
+					fifo |= FIFO_DFIFO;
+
+				if (info->conn_info.src != CDSP_IN_SOURCE_EFIFO)
+					fifo |= FIFO_EFIFO;
+				break;
+			default:
+				break;
+			}
+
+			info->conn_info.src = conn_info.src;
+		}
+
+		if (conn_info.dest != info->conn_info.dest) {
+			switch (conn_info.dest) {
+			case CDSP_OUT_DEST_OFIFO:
+				if (info->conn_info.dest !=
+				    CDSP_OUT_DEST_OFIFO_RFIFO)
+					fifo |= FIFO_OFIFO;
+				break;
+			case CDSP_OUT_DEST_RFIFO:
+				if (info->conn_info.dest !=
+				    CDSP_OUT_DEST_OFIFO_RFIFO)
+					fifo |= FIFO_RFIFO;
+				break;
+			case CDSP_OUT_DEST_OFIFO_RFIFO:
+				if (info->conn_info.dest != CDSP_OUT_DEST_OFIFO)
+					fifo |= FIFO_OFIFO;
+
+				if (info->conn_info.dest != CDSP_OUT_DEST_RFIFO)
+					fifo |= FIFO_RFIFO;
+				break;
+			default:
+				break;
+			}
+
+			info->conn_info.dest = conn_info.dest;
+		}
+
+		if (fifo != FIFO_NONE) {
+			cdsp_fifo_init(finfo->id, fifo);
+			prev = fifo;
+		}
+	}
+
+	fifo = cdsp_fifoid_get_from_coderid(finfo->id);
+	if (info->bit_width.efifo == bit_width.efifo &&
+	    info->conn_ex_info.efifo_ch == conn_ex_info.efifo_ch)
+		fifo &= ~FIFO_EFIFO_MASK;
+
+	if (info->bit_width.ofifo == bit_width.ofifo &&
+	    info->conn_ex_info.ofifo_ch == conn_ex_info.ofifo_ch)
+		fifo &= ~FIFO_OFIFO_MASK;
+
+	if (fifo & (FIFO_EFIFO_MASK | FIFO_OFIFO_MASK)) {
+		data = cdsp_fifo_get_ch_bit(fifo, &conn_ex_info, &bit_width);
+		if (fifo & FIFO_EFIFO_MASK) {
+			/* Clear position */
+			cdsp_input_position_clear(finfo->id);
+
+			info->conn_ex_info.efifo_ch = conn_ex_info.efifo_ch;
+			info->bit_width.efifo = bit_width.efifo;
+		}
+
+		if (fifo & FIFO_OFIFO_MASK) {
+			/* Clear position */
+			cdsp_output_position_clear(finfo->id);
+
+			info->conn_ex_info.ofifo_ch = conn_ex_info.ofifo_ch;
+			info->bit_width.ofifo = bit_width.ofifo;
+		}
+
+		/* Clear FIFO */
+		prev = fifo & ~prev;
+		if (prev)
+			cdsp_fifo_reset(finfo->id, prev);
+
+		cdsp_fifo_set_ch(fifo, data);
+	}
+
+	return 0;
+}
+
+static int cdsp_params_set_one(enum mc_cdsp_id id,
+			       struct coder_params *coder)
+{
+	struct coder_info *info;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+
+	/* State check */
+	switch (info->state) {
+	case STATE_INIT:
+		if (coder->command != CDSP_CMD_HOST2OS_SYS_SET_CLOCK_SOURCE)
+			return -EBUSY;
+		break;
+	case STATE_READY_SETUP:
+	case STATE_READY:
+	case STATE_PLAYING:
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	if (!(coder->command & CDSP_CMD_COMPLETION)) {
+		/* Command check */
+		switch (coder->command) {
+		case CDSP_CMD_HOST2OS_CMN_RESET:
+			/* reset */
+			ret = cdsp_coder_reset(id);
+			if (!ret) {
+				/* Clear position */
+				cdsp_input_position_clear(id);
+				cdsp_input_position_reset(id);
+				cdsp_output_position_clear(id);
+
+				/* Clear FIFO */
+				cdsp_fifo_reset(id,
+						(FIFO_DFIFO | FIFO_EFIFO |
+						 FIFO_OFIFO | FIFO_RFIFO));
+
+				cdsp_connection_reset(id);
+
+				info->state = STATE_READY_SETUP;
+			}
+			break;
+		case CDSP_CMD_HOST2OS_CMN_CLEAR:
+			ret = cdsp_coder_clear(id);
+			if (!ret) {
+				/* Clear position */
+				cdsp_input_position_clear(id);
+				cdsp_input_position_reset(id);
+				cdsp_output_position_clear(id);
+
+				/* Clear FIFO */
+				cdsp_fifo_reset(id,
+						(FIFO_DFIFO | FIFO_EFIFO |
+						 FIFO_OFIFO | FIFO_RFIFO));
+			}
+			break;
+		case CDSP_CMD_HOST2OS_SYS_INPUT_DATA_END:
+			ret = cdsp_input_dataend_set(id);
+			break;
+		case CDSP_CMD_HOST2OS_SYS_SET_TIMER:
+			ret = cdsp_timer_set(id, coder);
+			break;
+
+		case CDSP_CMD_HOST2OS_SYS_SET_DUAL_MONO:
+			ret = cdsp_output_set_dualmono(id, coder);
+			break;
+		case CDSP_CMD_HOST2OS_SYS_GET_INPUT_POS:
+			ret = cdsp_input_get_position_sample(id, coder);
+			break;
+		default:
+			if ((coder->command < CDSP_CMD_HOST2OS_PRG_MIN) ||
+			    (coder->command > CDSP_CMD_HOST2OS_PRG_MAX))
+				return -EINVAL;
+
+			/* Program dependence command */
+			ret = cdsp_command_write_host2os(id, coder);
+			break;
+		}
+	} else {
+		/* Host command notify completion */
+		switch (info->coder.command) {
+		case CDSP_CMD_OS2HOST_CMN_NONE:
+			return -EIO;
+		case CDSP_CMD_OS2HOST_CMN_NOTIFY_OUT_FORMAT:
+			info->change_output_fs = true;
+			cdsp_output_start(info);
+			break;
+		default:
+			break;
+		}
+
+		/* Write complete command */
+		cdsp_command_write_complete(id, coder);
+
+		/* clear */
+		info->coder.command = CDSP_CMD_OS2HOST_CMN_NONE;
+		memset(info->coder.params, 0, CDSP_CMD_PARAM_ARGUMENT_NUM);
+
+		ret = 0;
+	}
+
+	return ret;
+}
+
+static inline int cdsp_params_get_one(enum mc_cdsp_id id,
+				      struct coder_params *coder)
+{
+	struct coder_info *info;
+	int count, i;
+
+	info = cdsp_coder_info_get(id);
+
+	/* State check */
+	switch (info->state) {
+	case STATE_READY_SETUP:
+	case STATE_READY:
+	case STATE_PLAYING:
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	/* Command */
+	coder->command = info->coder.command;
+
+	/* Argument */
+	count = CDSP_CMD_PARAM_ARGUMENT_00;
+	for (i = count; i < count + CDSP_CMD_PARAM_ARGUMENT_NUM; i++)
+		coder->params[i] = info->coder.params[i];
+
+	/* Result */
+	count = CDSP_CMD_PARAM_RESULT_00;
+	for (i = count; i < count + CDSP_CMD_PARAM_RESULT_NUM; i++)
+		coder->params[i] = 0;
+
+	return 0;
+}
+
+static int cdsp_params_set(struct aec_cdsp_func_info *finfo)
+{
+	struct coder_params coder;
+	u8 *data;
+	int i, j, count, ret;
+
+	if (!finfo->param_data || !finfo->param_num)
+		return 0;
+
+	data = finfo->param_data;
+	count = CDSP_CMD_PARAM_ARGUMENT_00;
+
+	for (i = 0; i < finfo->param_num; i++) {
+		coder.command = data[CDSP_PRM_CMD];
+
+		for (j = count; j < count + CDSP_CMD_PARAM_ARGUMENT_NUM; j++)
+			coder.params[j] = data[CDSP_PRM_PRM0 + j];
+
+		ret = cdsp_params_set_one(finfo->id, &coder);
+		if (ret < 0)
+			return ret;
+
+		data += PRM_UNIT_SIZE;
+	}
+
+	return 0;
+}
+
+static void cdsp_callback_set_position(enum mc_cdsp_id id,
+				       struct aec_cdsp_info *cdsp_info)
+{
+	struct coder_info *info;
+	u32 fifo_id;
+
+	if (mc_fifo_info.dfifo_cb_pos == cdsp_info->dfifo_cb_pos &&
+	    mc_fifo_info.rfifo_cb_pos == cdsp_info->rfifo_cb_pos)
+		return;
+
+	info = cdsp_coder_info_get(id);
+
+	fifo_id = cdsp_fifoid_get(&info->conn_info);
+	if (fifo_id & FIFO_DFIFO_MASK)
+		mc_fifo_info.dfifo_cb_pos = cdsp_info->dfifo_cb_pos;
+
+	if (fifo_id & FIFO_RFIFO_MASK)
+		mc_fifo_info.rfifo_cb_pos = cdsp_info->rfifo_cb_pos;
+}
+
+static void cdsp_callback_set_buffering(enum mc_cdsp_id id,
+					struct aec_cdsp_info *cdsp_info)
+{
+	struct coder_info *info;
+	u32 fifo_id;
+
+	if ((mc_fifo_info.ofifo_buf_sample == cdsp_info->ofifo_buf_sample) &&
+	    (mc_fifo_info.rfifo_buf_sample == cdsp_info->rfifo_buf_sample))
+		return;
+
+	info = cdsp_coder_info_get(id);
+	fifo_id = cdsp_fifoid_get(&info->conn_info);
+
+	if (fifo_id & FIFO_OFIFO_MASK)
+		mc_fifo_info.ofifo_buf_sample = cdsp_info->ofifo_buf_sample;
+
+	if (fifo_id & FIFO_RFIFO_MASK)
+		mc_fifo_info.rfifo_buf_sample = cdsp_info->rfifo_buf_sample;
+}
+
+static inline void cdsp_route_set(struct aec_cdsp_info *cdsp_info)
+{
+	if (!cdsp_info->func_info[AEC_FUNC_INFO_A].fifo_data &&
+	    !cdsp_info->func_info[AEC_FUNC_INFO_B].fifo_data)
+		return;
+
+	/* OUT*R/L_SEL */
+	if (cdsp_info->out0_sel != mc_fifo_info.out0_sel) {
+		mc_packet_add_force_write_c(MCI_OUT0_SEL, cdsp_info->out0_sel);
+		mc_fifo_info.out0_sel = cdsp_info->out0_sel;
+	}
+
+	if (cdsp_info->out1_sel != mc_fifo_info.out1_sel) {
+		mc_packet_add_force_write_c(MCI_OUT1_SEL, cdsp_info->out1_sel);
+		mc_fifo_info.out1_sel = cdsp_info->out1_sel;
+	}
+
+	if (cdsp_info->out2_sel != mc_fifo_info.out2_sel) {
+		mc_packet_add_force_write_c(MCI_OUT2_SEL, cdsp_info->out2_sel);
+		mc_fifo_info.out2_sel = cdsp_info->out2_sel;
+	}
+
+	/* RFIFO_BIT/RFIFO_SEL/DFIFO_BIT/DFIFO_SEL */
+	if (cdsp_info->rdfifo_bit_sel != mc_fifo_info.rdfifo_bit_sel) {
+		mc_packet_add_force_write_c(MCI_RDFIFO_BIT_SEL,
+					    cdsp_info->rdfifo_bit_sel);
+		mc_fifo_info.rdfifo_bit_sel = cdsp_info->rdfifo_bit_sel;
+	}
+
+	/* EFIFO0*_SEL */
+	if (cdsp_info->efifo01_sel != mc_fifo_info.efifo01_sel) {
+		mc_packet_add_force_write_c(MCI_EFIFO01_SEL,
+					    cdsp_info->efifo01_sel);
+		mc_fifo_info.efifo01_sel = cdsp_info->efifo01_sel;
+	}
+
+	if (cdsp_info->efifo23_sel != mc_fifo_info.efifo23_sel) {
+		mc_packet_add_force_write_c(MCI_EFIFO23_SEL,
+					    cdsp_info->efifo23_sel);
+		mc_fifo_info.efifo23_sel = cdsp_info->efifo23_sel;
+	}
+
+	mc_packet_execute();
+}
+
+static inline void cdsp_etobuf_set_mode(enum mc_cdsp_id coder_id,
+					struct aec_cdsp_func_info *finfo)
+{
+	struct coder_info *info;
+
+	info = cdsp_coder_info_get(coder_id);
+	info->format.etobuf = finfo->format.etobuf;
+}
+
+static int cdsp_ext_set(enum mc_cdsp_id coder_id,
+			struct aec_cdsp_func_info *finfo)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+	int ret = 0;
+
+	if (!finfo->ext)
+		return ret;
+
+	if (finfo->ext[EXT_COMMAND] == EXT_COMMAND_CLEAR) {
+		coder.command = CDSP_CMD_HOST2OS_CMN_CLEAR;
+
+		info = cdsp_coder_info_get(coder_id);
+		switch (info->state) {
+		case STATE_PLAYING:
+			ret =
+			    cdsp_coder_stop(coder_id, MADEVCDSP_VERIFY_COMP_ON);
+			if (ret < 0)
+				return ret;
+
+			cdsp_fifo_stop(coder_id);
+			info->state = STATE_READY;
+
+			ret = cdsp_params_set_one(coder_id, &coder);
+			if (ret < 0)
+				return ret;
+
+			ret = cdsp_coder_start(coder_id);
+			if (!ret)
+				info->state = STATE_PLAYING;
+			break;
+		case STATE_READY_SETUP:
+		case STATE_READY:
+			ret = cdsp_params_set_one(coder_id, &coder);
+			break;
+		default:
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static int cdsp_set_dsp(struct aec_cdsp_info *cdsp_info)
+{
+	struct aec_cdsp_func_info *finfo_a;
+	struct aec_cdsp_func_info *finfo_b;
+	int ret;
+
+	finfo_a = &cdsp_info->func_info[AEC_FUNC_INFO_A];
+	finfo_b = &cdsp_info->func_info[AEC_FUNC_INFO_B];
+
+	if (finfo_a->func_on) {
+		ret = cdsp_firmware_setup(finfo_a);
+		if (ret < 0)
+			return ret;
+
+		ret = cdsp_connection_setup(finfo_a);
+		if (ret < 0)
+			return ret;
+
+		ret = cdsp_params_set(finfo_a);
+		if (ret < 0)
+			return ret;
+
+		cdsp_etobuf_set_mode(CODER_DEC, finfo_a);
+		cdsp_callback_set_position(CODER_DEC, cdsp_info);
+		cdsp_callback_set_buffering(CODER_DEC, cdsp_info);
+
+		ret = cdsp_ext_set(CODER_DEC, finfo_a);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (finfo_b->func_on) {
+		ret = cdsp_firmware_setup(finfo_b);
+		if (ret < 0)
+			return ret;
+
+		ret = cdsp_connection_setup(finfo_b);
+		if (ret < 0)
+			return ret;
+
+		ret = cdsp_params_set(finfo_b);
+		if (ret < 0)
+			return ret;
+
+		cdsp_etobuf_set_mode(CODER_ENC, finfo_b);
+		cdsp_callback_set_position(CODER_ENC, cdsp_info);
+		cdsp_callback_set_buffering(CODER_ENC, cdsp_info);
+
+		ret = cdsp_ext_set(CODER_ENC, finfo_b);
+		if (ret < 0)
+			return ret;
+	}
+
+	cdsp_route_set(cdsp_info);
+
+	return 0;
+}
+
+static inline void cdsp_dfifo_start(void)
+{
+	u8 ptr_h, ptr_l, data;
+
+	mc_read_c(MCI_DFIFO_ENABLE, &data, 1);
+	mc_read_c(MCI_DFIFO_IRQ_PNT_H, &ptr_h, 1);
+	mc_read_c(MCI_DFIFO_IRQ_PNT_L, &ptr_l, 1);
+
+	if (!(mc_fifo_info.rdfifo_bit_sel & MCB_DFIFO_SEL_HOST) ||
+	    mc_fifo_info.dfifo_cb_pos == CBPOS_DFIFO_NONE) {
+		ptr_h = ptr_l = 0;
+		data &= ~MCB_DFIFO_EDPNT;
+	} else {
+		ptr_h = (mc_fifo_info.dfifo_cb_pos >> 8) & MCB_DFIFO_IRQ_PNT_H;
+		ptr_l = mc_fifo_info.dfifo_cb_pos & MCB_DFIFO_IRQ_PNT_L;
+		data |= MCB_DFIFO_EDPNT;
+	}
+
+	data |= MCB_DFIFO_EDEMP;
+
+	/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt flag clear */
+	mc_packet_add_force_write_c(MCI_DFIFO_FLG, MCB_DFIFO_FLG_ALL);
+	mc_packet_add_force_write_if(MCI_CDSP, MCB_IRQFLAG_DFIFO);
+
+	/* xFIFO_IRQ_PNT Set */
+	mc_packet_add_force_write_c(MCI_DFIFO_IRQ_PNT_H, ptr_h);
+	mc_packet_add_force_write_c(MCI_DFIFO_IRQ_PNT_L, ptr_l);
+
+	/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt Enable */
+	mc_packet_add_force_write_c(MCI_DFIFO_ENABLE, data);
+
+	mc_packet_execute();
+
+	mc_read_digital(MCI_ECDSP, &data, 1);
+	data |= MCB_EDFIFO;
+	mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+	mc_packet_execute();
+}
+
+static inline void cdsp_efifo_start(void)
+{
+	/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt flag clear */
+	mc_packet_add_force_write_c(MCI_EFIFO_FLG, MCB_EFIFO_FLG_ALL);
+	mc_packet_add_force_write_if(MCI_CDSP, MCB_IRQFLAG_EFIFO);
+
+	mc_packet_execute();
+}
+
+static inline void cdsp_ofifo_start(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	u32 sample;
+	u8 ptr_h, ptr_l, data;
+
+	info = cdsp_coder_info_get(id);
+
+	/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt flag clear */
+	mc_packet_add_force_write_c(MCI_OFIFO_FLG, MCB_OFIFO_FLG_ALL);
+	mc_packet_add_force_write_if(MCI_CDSP, MCB_IRQFLAG_OFIFO);
+
+	/* xFIFO_IRQ_PNT Set */
+	sample = (mc_fifo_info.ofifo_buf_sample * info->conn_ex_info.ofifo_ch *
+		  (info->bit_width.ofifo / 8)) / 4;
+	ptr_h = (sample >> 8) & MCB_OFIFO_IRQ_PNT_H;
+	ptr_l = sample & MCB_OFIFO_IRQ_PNT_L;
+
+	mc_packet_add_force_write_c(MCI_OFIFO_IRQ_PNT_H, ptr_h);
+	mc_packet_add_force_write_c(MCI_OFIFO_IRQ_PNT_L, ptr_l);
+
+	/* xFIFO/xPNT Interrupt Enable */
+	mc_packet_add_force_write_c(MCI_OFIFO_ENABLE, MCB_OFIFO_EOPNT);
+
+	mc_packet_execute();
+
+	mc_read_digital(MCI_ECDSP, &data, 1);
+	data |= MCB_EOFIFO;
+	mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+	mc_packet_execute();
+
+	cdsp_output_start(info);
+}
+
+static inline void cdsp_rfifo_start_port(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	u32 sample;
+	u8 ptr_h, ptr_l, data;
+
+	info = cdsp_coder_info_get(id);
+
+	/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt flag clear */
+	mc_packet_add_force_write_c(MCI_RFIFO_FLG, MCB_RFIFO_FLG_ALL);
+	mc_packet_add_force_write_if(MCI_CDSP, MCB_IRQFLAG_RFIFO);
+
+	/* xFIFO_IRQ_PNT Set */
+	sample = (mc_fifo_info.rfifo_buf_sample * RFIFO_CH_NUM *
+		  RFIFO_BIT_WIDTH / 8) / 4;
+	ptr_h = (sample >> 8) & MCB_RFIFO_IRQ_PNT_H;
+	ptr_l = sample & MCB_RFIFO_IRQ_PNT_L;
+
+	mc_packet_add_force_write_c(MCI_RFIFO_IRQ_PNT_H, ptr_h);
+	mc_packet_add_force_write_c(MCI_RFIFO_IRQ_PNT_L, ptr_l);
+
+	/* xFIFO/xPNT/xOVF Interrupt Enable */
+	mc_packet_add_force_write_c(MCI_RFIFO_ENABLE, MCB_RFIFO_ERPNT);
+
+	mc_packet_execute();
+
+	mc_read_digital(MCI_ECDSP, &data, 1);
+	data |= MCB_ERFIFO;
+	mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+	mc_packet_execute();
+
+	cdsp_output_start(info);
+}
+
+static inline void cdsp_rfifo_start_host(void)
+{
+	u8 ptr_h, ptr_l, data, ctrl;
+
+	mc_read_c(MCI_RFIFO_ENABLE, &ctrl, 1);
+	ctrl |= MCB_RFIFO_EROVF;
+
+	if (mc_fifo_info.rfifo_cb_pos != CBPOS_RFIFO_NONE) {
+		ptr_h = (mc_fifo_info.rfifo_cb_pos >> 8) & MCB_RFIFO_IRQ_PNT_H;
+		ptr_l = mc_fifo_info.rfifo_cb_pos & MCB_RFIFO_IRQ_PNT_L;
+		ctrl |= MCB_RFIFO_ERPNT;
+	} else {
+		ptr_h = 0;
+		ptr_l = 0;
+		ctrl &= ~MCB_RFIFO_ERPNT;
+	}
+
+	/* xFIFO/xPNT/xEMP/xUDF/xOVF Interrupt flag clear */
+	mc_packet_add_force_write_c(MCI_RFIFO_FLG, MCB_RFIFO_FLG_ALL);
+	mc_packet_add_force_write_if(MCI_CDSP, MCB_IRQFLAG_RFIFO);
+
+	/* xFIFO_IRQ_PNT Set */
+	mc_packet_add_force_write_c(MCI_RFIFO_IRQ_PNT_H, ptr_h);
+	mc_packet_add_force_write_c(MCI_RFIFO_IRQ_PNT_L, ptr_l);
+
+	/* xFIFO/xPNT/xOVF Interrupt Enable */
+	mc_packet_add_force_write_c(MCI_RFIFO_ENABLE, ctrl);
+
+	mc_packet_execute();
+
+	mc_read_digital(MCI_ECDSP, &data, 1);
+	data |= MCB_ERFIFO;
+	mc_packet_add_force_write_if(MCI_ECDSP, data);
+
+	mc_packet_execute();
+}
+
+static inline void cdsp_rfifo_start(enum mc_cdsp_id id)
+{
+	if (mc_fifo_info.rdfifo_bit_sel & MCB_RFIFO_SEL_HOST)
+		cdsp_rfifo_start_host();
+	else
+		cdsp_rfifo_start_port(id);
+}
+
+static inline void cdsp_fifo_start(enum mc_cdsp_id id)
+{
+	u32 fifo_id;
+
+	fifo_id = cdsp_fifoid_get_from_coderid(id);
+	if (fifo_id & FIFO_DFIFO_MASK)
+		cdsp_dfifo_start();
+
+	if (fifo_id & FIFO_EFIFO_MASK)
+		cdsp_efifo_start();
+
+	if (fifo_id & FIFO_OFIFO_MASK)
+		cdsp_ofifo_start(id);
+
+	if (fifo_id & FIFO_RFIFO_MASK)
+		cdsp_rfifo_start(id);
+}
+
+static inline int cdsp_coder_start(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	u32 fifo_id;
+	u8 data;
+
+	info = cdsp_coder_info_get(id);
+
+	/* Mutual output ? */
+	if (info->conn_info.dest == CDSP_OUT_DEST_OTHER_INBUF) {
+		struct coder_info *another_info;
+		another_info = cdsp_coder_info_get(cdsp_another_id_get(id));
+		switch (another_info->state) {
+		case STATE_READY_SETUP:
+		case STATE_READY:
+		case STATE_PLAYING:
+			break;
+		default:
+			return -EIO;
+		}
+	}
+
+	cdsp_fifo_start(id);
+
+	/* DEC/ENC ERR,END Interrupt flag clear */
+	if (id == CDSP_DECODER) {
+		mc_read_c(MCI_DEC_FLG, &data, 1);
+		data |= MCB_DEC_FLG_ERR | MCB_DEC_FLG_END;
+		mc_packet_add_force_write_c(MCI_DEC_FLG, data);
+	} else {
+		mc_read_c(MCI_ENC_FLG, &data, 1);
+		data |= MCB_ENC_FLG_ERR | MCB_ENC_FLG_END;
+		mc_packet_add_force_write_c(MCI_ENC_FLG, data);
+	}
+
+	mc_packet_execute();
+
+	mc_read_digital(MCI_CDSP, &data, 1);
+	if (id == CDSP_DECODER)
+		data |= MCB_IRQFLAG_DEC;
+	else
+		data |= MCB_IRQFLAG_ENC;
+	mc_packet_add_force_write_if(MCI_CDSP, data);
+
+	mc_packet_execute();
+
+	/* DEC/ENC END,ERR Interrupt Enable */
+	if (id == CDSP_DECODER) {
+		mc_read_c(MCI_DEC_ENABLE, &data, 1);
+		data |= MCB_EDEC_ERR | MCB_EDEC_END;
+		mc_packet_add_force_write_c(MCI_DEC_ENABLE, data);
+	} else {
+		mc_read_c(MCI_ENC_ENABLE, &data, 1);
+		data |= MCB_EENC_ERR | MCB_EENC_END;
+		mc_packet_add_force_write_c(MCI_ENC_ENABLE, data);
+	}
+
+	mc_packet_execute();
+
+	/* DEC/ENC Start */
+	mc_read_c(MCI_DEC_START, &data, 1);
+	if (id == CDSP_DECODER)
+		data |= MCB_DEC_DEC_START;
+	else
+		data |= MCB_DEC_ENC_START;
+	mc_packet_add_force_write_c(MCI_DEC_START, data);
+
+	mc_packet_execute();
+
+	fifo_id = cdsp_fifoid_get(&info->conn_info);
+	if (fifo_id & FIFO_EFIFO) {
+		mc_read_c(MCI_DEC_FIFO_CH, &data, 1);
+		data |= MCB_DEC_EFIFO_START;
+		mc_packet_add_force_write_c(MCI_DEC_FIFO_CH, data);
+
+		mc_packet_execute();
+	}
+
+	if ((fifo_id & FIFO_DFIFO) &&
+	    !(mc_fifo_info.rdfifo_bit_sel & MCB_DFIFO_SEL_HOST)) {
+		mc_read_c(MCI_RDFIFO_BIT_SEL, &data, 1);
+		data |= MCB_RDFIFO_DFIFO_START;
+		mc_packet_add_force_write_c(MCI_RDFIFO_BIT_SEL, data);
+
+		mc_packet_execute();
+	}
+
+	if (!mc_fifo_info.ofifo_buf_sample && (fifo_id & FIFO_OFIFO))
+		cdsp_interrupt_proc_ofifo_core();
+
+	if (!mc_fifo_info.rfifo_buf_sample &&
+	    (fifo_id & FIFO_RFIFO) &&
+	    !(mc_fifo_info.rdfifo_bit_sel & MCB_RFIFO_SEL_HOST))
+		cdsp_interrupt_proc_rfifo_core();
+
+	return 0;
+}
+
+int mc_cdsp_init(void)
+{
+	if (mc_dec_info.state == STATE_PLAYING ||
+	    mc_enc_info.state == STATE_PLAYING)
+		return -EBUSY;
+
+	/* Global Initialize */
+	mc_cdsp_info.hw_error_code = CDSP_ERR_NO_ERROR;
+	mc_cdsp_info.os.version_h = 0;
+	mc_cdsp_info.os.version_l = 0;
+
+	mc_fifo_info.dfifo_cb_pos = CBPOS_DFIFO_DEF;
+	mc_fifo_info.rfifo_cb_pos = CBPOS_RFIFO_DEF;
+	mc_fifo_info.ofifo_buf_sample = OFIFO_BUF_SAMPLE_DEF;
+	mc_fifo_info.ofifo_output_start = false;
+	mc_fifo_info.dfifo_write_size = 0;
+	mc_fifo_info.rfifo_buf_sample = RFIFO_BUF_SAMPLE_DEF;
+	mc_fifo_info.rfifo_output_start = false;
+	mc_fifo_info.out0_sel = MCI_OUT0_SEL_DEF;
+	mc_fifo_info.out1_sel = MCI_OUT1_SEL_DEF;
+	mc_fifo_info.out2_sel = MCI_OUT2_SEL_DEF;
+	mc_fifo_info.rdfifo_bit_sel = 0;
+	mc_fifo_info.efifo01_sel = MCI_EFIFO01_SEL_DEF;
+	mc_fifo_info.efifo23_sel = MCI_EFIFO23_SEL_DEF;
+
+	cdsp_coder_info_init(&mc_dec_info);
+	cdsp_coder_info_init(&mc_enc_info);
+
+	cdsp_registers_init();
+
+	/* CDSP OS Download */
+	cdsp_os_download(mc_cdsp_os);
+
+	/* CDSP OS initialize */
+	return cdsp_os_init();
+}
+
+void mc_cdsp_term(void)
+{
+	u8 data;
+
+	/* CDSP stop */
+	if (mc_dec_info.state != STATE_NOTINIT ||
+	    mc_enc_info.state != STATE_NOTINIT) {
+		mc_read_c(MCI_CDSP_RESET, &data, 1);
+		data |= MCB_CDSP_SRST;
+		mc_packet_add_force_write_c(MCI_CDSP_RESET, data);
+
+		mc_packet_execute();
+	}
+
+	mc_dec_info.state = STATE_NOTINIT;
+	mc_enc_info.state = STATE_NOTINIT;
+}
+
+void mc_cdsp_irq(void)
+{
+	u8 flag;
+
+	if (mc_dec_info.state == STATE_NOTINIT ||
+	    mc_enc_info.state == STATE_NOTINIT)
+		return;
+
+	/* Get interrupt flag */
+	mc_read_digital(MCI_CDSP, &flag, 1);
+
+	if (flag & MCB_IRQFLAG_DEC)
+		cdsp_interrupt_proc_coder(CODER_DEC);
+
+	if (flag & MCB_IRQFLAG_ENC)
+		cdsp_interrupt_proc_coder(CODER_ENC);
+
+	if (flag & MCB_IRQFLAG_DFIFO)
+		cdsp_interrupt_proc_dfifo();
+
+	if (flag & MCB_IRQFLAG_OFIFO)
+		cdsp_interrupt_proc_ofifo();
+
+	if (flag & MCB_IRQFLAG_RFIFO)
+		cdsp_interrupt_proc_rfifo();
+
+	if (flag & MCB_IRQFLAG_CDSP)
+		cdsp_interrupt_proc();
+
+	/* Clear interrupt flag */
+	mc_packet_add_force_write_if(MCI_CDSP, flag);
+
+	mc_packet_execute();
+
+	cdsp_callback_proc();
+}
+
+int mc_cdsp_set_dsp(struct mcdrv_aec_info *aec)
+{
+	struct aec_cdsp_info cdsp_info;
+	struct aec_cdsp_func_info *finfo_a;
+	struct aec_cdsp_func_info *finfo_b;
+	int ret;
+
+	finfo_a = &cdsp_info.func_info[AEC_FUNC_INFO_A];
+	finfo_b = &cdsp_info.func_info[AEC_FUNC_INFO_B];
+
+	if (!aec)
+		return -EINVAL;
+
+	cdsp_get_data(aec, &cdsp_info);
+
+	ret = cdsp_data_analyze(&cdsp_info);
+	if (ret < 0)
+		return ret;
+
+	if (aec->vbox.enable) {
+		if (!finfo_a->func_on)
+			cdsp_coder_term(CODER_DEC);
+
+		if (!finfo_b->func_on)
+			cdsp_coder_term(CODER_ENC);
+	}
+
+	if ((!finfo_a->data || !finfo_a->data_size) &&
+	    (!finfo_b->data || !finfo_b->data_size))
+		return 0;
+
+	if (mc_dec_info.state == STATE_NOTINIT ||
+	    mc_enc_info.state == STATE_NOTINIT)
+		return -EBUSY;
+
+	return cdsp_set_dsp(&cdsp_info);
+}
+
+int mc_cdsp_set_fs(enum mc_cdsp_id id, u8 fs)
+{
+	struct coder_info *info;
+	struct coder_params coder;
+
+	if (mc_dec_info.state == STATE_NOTINIT ||
+	    mc_enc_info.state == STATE_NOTINIT)
+		return -EBUSY;
+
+	info = cdsp_coder_info_get(id);
+
+	coder.command = CDSP_CMD_HOST2OS_SYS_SET_FORMAT;
+	coder.params[CDSP_CMD_PARAM_ARGUMENT_00] = fs;
+	coder.params[CDSP_CMD_PARAM_ARGUMENT_01] = info->format.etobuf;
+
+	return cdsp_format_set(id, &coder);
+}
+
+int mc_cdsp_set_dfifo_sel(enum mc_cdsp_fifo_sel sel)
+{
+	u8 rdfifo_bit_sel;
+
+	if (sel != CDSP_FIFO_SEL_PORT && sel != CDSP_FIFO_SEL_HOST)
+		return -EINVAL;
+
+	if (mc_dec_info.state == STATE_NOTINIT ||
+	    mc_enc_info.state == STATE_NOTINIT)
+		return -EBUSY;
+
+	rdfifo_bit_sel = mc_fifo_info.rdfifo_bit_sel;
+	rdfifo_bit_sel &= ~MCB_DFIFO_SEL;
+	if (sel == CDSP_FIFO_SEL_HOST)
+		rdfifo_bit_sel |= MCB_DFIFO_SEL_HOST;
+
+	if (rdfifo_bit_sel != mc_fifo_info.rdfifo_bit_sel) {
+		mc_packet_add_force_write_c(MCI_RDFIFO_BIT_SEL, rdfifo_bit_sel);
+
+		mc_packet_execute();
+
+		mc_fifo_info.rdfifo_bit_sel = rdfifo_bit_sel;
+	}
+
+	return 0;
+}
+
+int mc_cdsp_set_rfifo_sel(enum mc_cdsp_fifo_sel sel)
+{
+	u8 rdfifo_bit_sel;
+
+	if (sel != CDSP_FIFO_SEL_PORT && sel != CDSP_FIFO_SEL_HOST)
+		return -EINVAL;
+
+	if (mc_dec_info.state == STATE_NOTINIT ||
+	    mc_enc_info.state == STATE_NOTINIT)
+		return -EBUSY;
+
+	rdfifo_bit_sel = mc_fifo_info.rdfifo_bit_sel;
+	rdfifo_bit_sel &= ~MCB_RFIFO_SEL;
+	if (sel == CDSP_FIFO_SEL_HOST)
+		rdfifo_bit_sel |= MCB_RFIFO_SEL_HOST;
+
+	if (rdfifo_bit_sel != mc_fifo_info.rdfifo_bit_sel) {
+		mc_packet_add_force_write_c(MCI_RDFIFO_BIT_SEL, rdfifo_bit_sel);
+
+		mc_packet_execute();
+
+		mc_fifo_info.rdfifo_bit_sel = rdfifo_bit_sel;
+	}
+
+	return 0;
+}
+
+int mc_cdsp_start(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+	switch (info->state) {
+	case STATE_READY_SETUP:
+		ret = cdsp_coder_standby(id);
+		if (ret < 0)
+			return ret;
+
+		cdsp_fifo_reset(id,
+				(FIFO_DFIFO | FIFO_EFIFO | FIFO_OFIFO |
+				 FIFO_RFIFO));
+		info->state = STATE_READY;
+
+		if (info->preinput_dataend_set) {
+			ret = cdsp_input_dataend_set(id);
+			if (ret < 0)
+				return ret;
+		}
+		break;
+	case STATE_READY:
+		cdsp_fifo_reset(id, (FIFO_DFIFO | FIFO_EFIFO));
+		break;
+	default:
+		return -EBUSY;
+	}
+
+	ret = cdsp_coder_start(id);
+	if (!ret)
+		info->state = STATE_PLAYING;
+
+	return ret;
+}
+
+int mc_cdsp_stop(enum mc_cdsp_id id)
+{
+	struct coder_info *info;
+	int ret;
+
+	info = cdsp_coder_info_get(id);
+	if (info->state != STATE_PLAYING)
+		return -EBUSY;
+
+	ret = cdsp_coder_stop(id, MADEVCDSP_VERIFY_COMP_ON);
+	if (ret < 0)
+		return ret;
+
+	cdsp_fifo_stop(id);
+
+	info->state = STATE_READY;
+
+	return ret;
+}
diff --git a/sound/soc/codecs/ymu831/mccdspdrv.h b/sound/soc/codecs/ymu831/mccdspdrv.h
new file mode 100644
index 0000000..11e669c
--- /dev/null
+++ b/sound/soc/codecs/ymu831/mccdspdrv.h
@@ -0,0 +1,57 @@
+/****************************************************************************
+ *
+ * Copyright(c) 2012 Yamaha Corporation. All rights reserved.
+ *
+ * Module	: mccdspdrv.h
+ * Description	: MC C-DSP driver header
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
+#ifndef	_MCCDSPDRV_H
+#define	_MCCDSPDRV_H
+
+#include "mcresctrl.h"
+
+enum mc_cdsp_fifo_sel {
+	CDSP_FIFO_SEL_PORT,
+	CDSP_FIFO_SEL_HOST
+};
+
+enum mc_cdsp_id {
+	CDSP_DECODER,
+	CDSP_ENCODER,
+};
+
+int mc_cdsp_init(void);
+void mc_cdsp_term(void);
+void mc_cdsp_irq(void);
+int mc_cdsp_set_dsp(struct mcdrv_aec_info *aec);
+int mc_cdsp_set_fs(enum mc_cdsp_id id, u8 fs);
+int mc_cdsp_set_dfifo_sel(enum mc_cdsp_fifo_sel sel);
+int mc_cdsp_set_rfifo_sel(enum mc_cdsp_fifo_sel sel);
+int mc_cdsp_start(enum mc_cdsp_id id);
+int mc_cdsp_stop(enum mc_cdsp_id id);
+
+#endif /* _MCCDSPDRV_H */
-- 
1.7.9.5
