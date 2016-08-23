From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH RESEND 1/3] conf: sklrt286: define module
	private data through tuples in skylake
Date: Tue, 23 Aug 2016 09:38:34 +0530
Message-ID: <1471925316-490-2-git-send-email-vinod.koul@intel.com>
References: <1471925316-490-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B28F266ACF
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2016 06:00:50 +0200 (CEST)
In-Reply-To: <1471925316-490-1-git-send-email-vinod.koul@intel.com>
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
Cc: tiwai@suse.de, patches.audio@intel.com, liam.r.girdwood@linux.intel.com, Vinod Koul <vinod.koul@intel.com>, broonie@kernel.org, Shreyas NC <shreyas.nc@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Shreyas NC <shreyas.nc@intel.com>

In the conf file, module private data can be described through
tuples instead of blobs defined by vendor defined structures.

This patch defines the tuple section and the token list. The
tokens are then used to build the tuple array.

The module data may have both driver data and firmware data. The
driver data is passed using the tuple array and the firmware data
using byte data. A descriptor tuple array is defined to describe
the succeeding data block.

Signed-off-by: Shreyas NC <shreyas.nc@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 src/conf/topology/sklrt286/Makefile.am  |    2 +-
 src/conf/topology/sklrt286/skl_i2s.conf | 2694 ++++++++++++++++++++++++++++++-
 2 files changed, 2659 insertions(+), 37 deletions(-)

diff --git a/src/conf/topology/sklrt286/Makefile.am b/src/conf/topology/sklrt286/Makefile.am
index ed58b775e6eb..4e7a9d017b62 100644
--- a/src/conf/topology/sklrt286/Makefile.am
+++ b/src/conf/topology/sklrt286/Makefile.am
@@ -1,5 +1,5 @@
 alsaconfigdir = @ALSA_CONFIG_DIR@
 SUBDIRS = data
 sklrt286dir = $(alsaconfigdir)/topology/sklrt286
-sklrt286_DATA = skl_i2s.conf media0_in-cpr-0.bin media0_in-mi.bin media0_out-mo.bin media0_out-cpr-6.bin codec0_out-mo.bin codec0_out-cpr-4.bin codec1_out-mo.bin codec1_out-cpr-5.bin codec0_in-cpr-1.bin codec0_in-mi.bin dmic01_hifi_in-cpr-3.bin dmic01_hifi_in-mi.bin hdmi1_pt_out-cpr-7.bin hdmi1_pt_out-cpr-8.bin hdmi2_pt_out-cpr-9.bin hdmi2_pt_out-cpr-10.bin hdmi3_pt_out-cpr-11.bin hdmi3_pt_out-cpr-12.bin 
+sklrt286_DATA = skl_i2s.conf
 EXTRA_DIST = $(sklrt286_DATA)
diff --git a/src/conf/topology/sklrt286/skl_i2s.conf b/src/conf/topology/sklrt286/skl_i2s.conf
index 6da224fb4d2b..bb1fe4f8435f 100644
--- a/src/conf/topology/sklrt286/skl_i2s.conf
+++ b/src/conf/topology/sklrt286/skl_i2s.conf
@@ -1,58 +1,2608 @@
+SectionVendorTokens."skl_tokens" {
+	SKL_TKN_UUID "1"
+	SKL_TKN_U8_NUM_BLOCKS "2"
+	SKL_TKN_U8_BLOCK_TYPE "3"
+	SKL_TKN_U8_IN_PIN_TYPE "4"
+	SKL_TKN_U8_OUT_PIN_TYPE "5"
+	SKL_TKN_U8_DYN_IN_PIN "6"
+	SKL_TKN_U8_DYN_OUT_PIN "7"
+	SKL_TKN_U8_IN_QUEUE_COUNT "8"
+	SKL_TKN_U8_OUT_QUEUE_COUNT "9"
+	SKL_TKN_U8_TIME_SLOT "10"
+	SKL_TKN_U8_CORE_ID "11"
+	SKL_TKN_U8_MODULE_TYPE "12"
+	SKL_TKN_U8_CONN_TYPE "13"
+	SKL_TKN_U8_DEV_TYPE "14"
+	SKL_TKN_U8_HW_CONN_TYPE "15"
+	SKL_TKN_U16_MOD_INST_ID "16"
+	SKL_TKN_U16_BLOCK_SIZE "17"
+	SKL_TKN_U32_MAX_MCPS "18"
+	SKL_TKN_U32_MEM_PAGES "19"
+	SKL_TKN_U32_OBS "20"
+	SKL_TKN_U32_IBS "21"
+	SKL_TKN_U32_VBUS_ID "22"
+	SKL_TKN_U32_PARAMS_FIXUP "23"
+	SKL_TKN_U32_CONVERTER "24"
+	SKL_TKN_U32_PIPE_ID "25"
+	SKL_TKN_U32_PIPE_CONN_TYPE "26"
+	SKL_TKN_U32_PIPE_PRIORITY "27"
+	SKL_TKN_U32_PIPE_MEM_PGS "28"
+	SKL_TKN_U32_DIR_PIN_COUNT "29"
+	SKL_TKN_U32_FMT_CH "30"
+	SKL_TKN_U32_FMT_FREQ "31"
+	SKL_TKN_U32_FMT_BIT_DEPTH "32"
+	SKL_TKN_U32_FMT_SAMPLE_SIZE "33"
+	SKL_TKN_U32_FMT_CH_CONFIG "34"
+	SKL_TKN_U32_FMT_INTERLEAVE "35"
+	SKL_TKN_U32_FMT_SAMPLE_TYPE "36"
+	SKL_TKN_U32_FMT_CH_MAP "37"
+	SKL_TKN_U32_PIN_MOD_ID "38"
+	SKL_TKN_U32_PIN_INST_ID "39"
+	SKL_TKN_U32_MOD_SET_PARAMS "40"
+	SKL_TKN_U32_MOD_PARAM_ID "41"
+	SKL_TKN_U32_CAPS_SET_PARAMS "42"
+	SKL_TKN_U32_CAPS_PARAMS_ID "43"
+	SKL_TKN_U32_CAPS_SIZE "44"
+}
+
+SectionVendorTuples."media0_in cpr 0 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."media0_in cpr 0_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."media0_in cpr 0" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "1"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "5"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "0"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "1"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."media0_in mi num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."media0_in mi_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "412"
+	}
+}
+
+SectionVendorTuples."media0_in mi" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "178, 110, 101, 57, 113, 59,
+		73, 64, 141, 63, 249, 44, 213, 196, 60, 9"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "1"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "0"
+		SKL_TKN_U8_CONN_TYPE "0"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "6"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "0"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "1"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."media0_out mo num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."media0_out mo_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "1084"
+	}
+}
+
+SectionVendorTuples."media0_out mo" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "90, 80, 86, 60, 215, 36,
+		143, 65, 189, 220, 193, 245, 163, 172, 42, 224"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "8"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "1"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "0"
+		SKL_TKN_U8_CONN_TYPE "0"
+		SKL_TKN_U8_HW_CONN_TYPE "2"
+		SKL_TKN_U8_DEV_TYPE "6"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "2"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "2"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "16"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_2" {
+		SKL_TKN_U32_DIR_PIN_COUNT "32"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_3" {
+		SKL_TKN_U32_DIR_PIN_COUNT "48"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_4" {
+		SKL_TKN_U32_DIR_PIN_COUNT "64"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_5" {
+		SKL_TKN_U32_DIR_PIN_COUNT "80"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_6" {
+		SKL_TKN_U32_DIR_PIN_COUNT "96"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_7" {
+		SKL_TKN_U32_DIR_PIN_COUNT "112"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "16"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_2" {
+		SKL_TKN_U32_DIR_PIN_COUNT "32"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_3" {
+		SKL_TKN_U32_DIR_PIN_COUNT "48"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_4" {
+		SKL_TKN_U32_DIR_PIN_COUNT "64"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_5" {
+		SKL_TKN_U32_DIR_PIN_COUNT "80"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_6" {
+		SKL_TKN_U32_DIR_PIN_COUNT "96"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_7" {
+		SKL_TKN_U32_DIR_PIN_COUNT "112"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."media0_out cpr 6 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."media0_out cpr 6_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."media0_out cpr 6" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "0"
+		SKL_TKN_U8_HW_CONN_TYPE "2"
+		SKL_TKN_U8_DEV_TYPE "5"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "6"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "2"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."codec0_out mo num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."codec0_out mo_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "1084"
+	}
+}
+
+SectionVendorTuples."codec0_out mo" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "90, 80, 86, 60, 215, 36,
+		143, 65, 189, 220, 193, 245, 163, 172, 42, 224"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "8"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "1"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "0"
+		SKL_TKN_U8_CONN_TYPE "0"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "6"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "0"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "3"
+		SKL_TKN_U32_PIPE_CONN_TYPE "2"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "4"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "16"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_2" {
+		SKL_TKN_U32_DIR_PIN_COUNT "32"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_3" {
+		SKL_TKN_U32_DIR_PIN_COUNT "48"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_4" {
+		SKL_TKN_U32_DIR_PIN_COUNT "64"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_5" {
+		SKL_TKN_U32_DIR_PIN_COUNT "80"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_6" {
+		SKL_TKN_U32_DIR_PIN_COUNT "96"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_7" {
+		SKL_TKN_U32_DIR_PIN_COUNT "112"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "16"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_2" {
+		SKL_TKN_U32_DIR_PIN_COUNT "32"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_3" {
+		SKL_TKN_U32_DIR_PIN_COUNT "48"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_4" {
+		SKL_TKN_U32_DIR_PIN_COUNT "64"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_5" {
+		SKL_TKN_U32_DIR_PIN_COUNT "80"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_6" {
+		SKL_TKN_U32_DIR_PIN_COUNT "96"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_7" {
+		SKL_TKN_U32_DIR_PIN_COUNT "112"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."codec0_out cpr 4 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."codec0_out cpr 4_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."codec0_out cpr 4" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "2"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "2"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "4"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0x0"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "3"
+		SKL_TKN_U32_PIPE_CONN_TYPE "2"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "4"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."codec1_out mo num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."codec1_out mo_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "1084"
+	}
+}
+
+SectionVendorTuples."codec1_out mo" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "90, 80, 86, 60, 215, 36,
+		143, 65, 189, 220, 193, 245, 163, 172, 42, 224"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "8"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "1"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "0"
+		SKL_TKN_U8_CONN_TYPE "0"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "6"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "1"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "4"
+		SKL_TKN_U32_PIPE_CONN_TYPE "2"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "16"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_2" {
+		SKL_TKN_U32_DIR_PIN_COUNT "32"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_3" {
+		SKL_TKN_U32_DIR_PIN_COUNT "48"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_4" {
+		SKL_TKN_U32_DIR_PIN_COUNT "64"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_5" {
+		SKL_TKN_U32_DIR_PIN_COUNT "80"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_6" {
+		SKL_TKN_U32_DIR_PIN_COUNT "96"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_fmt_7" {
+		SKL_TKN_U32_DIR_PIN_COUNT "112"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "16"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_2" {
+		SKL_TKN_U32_DIR_PIN_COUNT "32"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_3" {
+		SKL_TKN_U32_DIR_PIN_COUNT "48"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_4" {
+		SKL_TKN_U32_DIR_PIN_COUNT "64"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_5" {
+		SKL_TKN_U32_DIR_PIN_COUNT "80"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_6" {
+		SKL_TKN_U32_DIR_PIN_COUNT "96"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.in_pin_7" {
+		SKL_TKN_U32_DIR_PIN_COUNT "112"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."codec1_out cpr 5 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."codec1_out cpr 5_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."codec1_out cpr 5" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "2"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "2"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "2"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "5"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0x0"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "4"
+		SKL_TKN_U32_PIPE_CONN_TYPE "2"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."codec0_in cpr 1 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."codec0_in cpr 1_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."codec0_in cpr 1" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "2"
+		SKL_TKN_U8_HW_CONN_TYPE "2"
+		SKL_TKN_U8_DEV_TYPE "2"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "1"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0x0"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "5"
+		SKL_TKN_U32_PIPE_CONN_TYPE "2"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."codec0_in mi num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."codec0_in mi_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "412"
+	}
+}
+
+SectionVendorTuples."codec0_in mi" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "178, 110, 101, 57, 113, 59,
+		73, 64, 141, 63, 249, 44, 213, 196, 60, 9"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "1"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "0"
+		SKL_TKN_U8_CONN_TYPE "0"
+		SKL_TKN_U8_HW_CONN_TYPE "2"
+		SKL_TKN_U8_DEV_TYPE "6"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "1"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "5"
+		SKL_TKN_U32_PIPE_CONN_TYPE "2"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."dmic01_hifi_in cpr 3 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."dmic01_hifi_in cpr 3_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."dmic01_hifi_in cpr 3" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "2"
+		SKL_TKN_U8_HW_CONN_TYPE "2"
+		SKL_TKN_U8_DEV_TYPE "1"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "3"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0x0"
+		SKL_TKN_U32_PARAMS_FIXUP "4"
+		SKL_TKN_U32_CONVERTER "4"
+		SKL_TKN_U32_PIPE_ID "6"
+		SKL_TKN_U32_PIPE_CONN_TYPE "2"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."dmic01_hifi_in mi num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."dmic01_hifi_in mi_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "412"
+	}
+}
+
+SectionVendorTuples."dmic01_hifi_in mi" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "178, 110, 101, 57, 113, 59,
+		73, 64, 141, 63, 249, 44, 213, 196, 60, 9"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "1"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "0"
+		SKL_TKN_U8_CONN_TYPE "0"
+		SKL_TKN_U8_HW_CONN_TYPE "2"
+		SKL_TKN_U8_DEV_TYPE "6"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "3"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "0"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "6"
+		SKL_TKN_U32_PIPE_CONN_TYPE "2"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."hdmi1_pt_out cpr 7 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."hdmi1_pt_out cpr 7_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."hdmi1_pt_out cpr 7" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "1"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "5"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "7"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "7"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "7"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."hdmi1_pt_out cpr 8 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."hdmi1_pt_out cpr 8_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."hdmi1_pt_out cpr 8" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "1"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "4"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "8"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "7"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "7"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."hdmi2_pt_out cpr 9 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."hdmi2_pt_out cpr 9_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."hdmi2_pt_out cpr 9" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "1"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "5"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "9"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "7"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "8"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."hdmi2_pt_out cpr 10 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."hdmi2_pt_out cpr 10_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."hdmi2_pt_out cpr 10" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "1"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "4"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "10"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "7"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "8"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."hdmi3_pt_out cpr 11 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."hdmi3_pt_out cpr 11_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."hdmi3_pt_out cpr 11" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "1"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "5"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "11"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "7"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "9"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "32"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+SectionVendorTuples."hdmi3_pt_out cpr 12 num_desc" {
+	tokens "skl_tokens"
+
+	tuples."byte.u8_num_blocks" {
+		SKL_TKN_U8_NUM_BLOCKS "1"
+	}
+}
+
+SectionVendorTuples."hdmi3_pt_out cpr 12_size_desc" {
+	tokens "skl_tokens"
+	tuples."byte.u8_block_type"{
+		SKL_TKN_U8_BLOCK_TYPE "0"
+	}
+	tuples."short.u16_size_desc"{
+		SKL_TKN_U16_BLOCK_SIZE "508"
+	}
+}
+
+SectionVendorTuples."hdmi3_pt_out cpr 12" {
+	tokens "skl_tokens"
+
+	tuples."uuid" {
+		SKL_TKN_UUID "131, 12, 160, 155, 18, 202,
+		131, 74, 148, 60, 31, 162, 232, 47, 157, 218"
+	}
+
+	tuples."byte.u8_data" {
+		SKL_TKN_U8_IN_PIN_TYPE "0"
+		SKL_TKN_U8_OUT_PIN_TYPE "0"
+		SKL_TKN_U8_IN_QUEUE_COUNT "1"
+		SKL_TKN_U8_OUT_QUEUE_COUNT "2"
+		SKL_TKN_U8_DYN_IN_PIN "1"
+		SKL_TKN_U8_DYN_OUT_PIN "1"
+		SKL_TKN_U8_TIME_SLOT "0"
+		SKL_TKN_U8_CORE_ID "0"
+		SKL_TKN_U8_MODULE_TYPE "1"
+		SKL_TKN_U8_CONN_TYPE "1"
+		SKL_TKN_U8_HW_CONN_TYPE "1"
+		SKL_TKN_U8_DEV_TYPE "4"
+	}
+
+	tuples."short.u16_data" {
+		SKL_TKN_U16_MOD_INST_ID "12"
+	}
+
+	tuples."word.u32_data" {
+		SKL_TKN_U32_MAX_MCPS "100000"
+		SKL_TKN_U32_MEM_PAGES "1"
+		SKL_TKN_U32_OBS "384"
+		SKL_TKN_U32_IBS "384"
+		SKL_TKN_U32_VBUS_ID "0xffffffff"
+		SKL_TKN_U32_PARAMS_FIXUP "7"
+		SKL_TKN_U32_CONVERTER "0"
+		SKL_TKN_U32_PIPE_ID "9"
+		SKL_TKN_U32_PIPE_CONN_TYPE "1"
+		SKL_TKN_U32_PIPE_PRIORITY "0"
+		SKL_TKN_U32_PIPE_MEM_PGS "2"
+		SKL_TKN_U32_CAPS_SIZE "0"
+	}
+
+	tuples."word.in_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.out_fmt_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_FMT_CH "2"
+		SKL_TKN_U32_FMT_FREQ "48000"
+		SKL_TKN_U32_FMT_BIT_DEPTH "32"
+		SKL_TKN_U32_FMT_SAMPLE_SIZE "24"
+		SKL_TKN_U32_FMT_INTERLEAVE "0"
+		SKL_TKN_U32_FMT_SAMPLE_TYPE "0"
+		SKL_TKN_U32_FMT_CH_MAP "0xffffff10"
+		SKL_TKN_U32_FMT_CH_CONFIG "0x1"
+	}
+
+	tuples."word.in_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "0"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_0" {
+		SKL_TKN_U32_DIR_PIN_COUNT "1"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+
+	tuples."word.out_pin_1" {
+		SKL_TKN_U32_DIR_PIN_COUNT "17"
+		SKL_TKN_U32_PIN_MOD_ID "0"
+		SKL_TKN_U32_PIN_INST_ID "0"
+	}
+}
+
+
+SectionData."media0_in cpr 0 num_desc" {
+	tuples "media0_in cpr 0 num_desc"
+}
+
+SectionData."media0_in cpr 0_size_desc" {
+	tuples "media0_in cpr 0_size_desc"
+}
+
 SectionData."media0_in cpr 0" {
-	file "sklrt286/media0_in-cpr-0.bin"
+	tuples "media0_in cpr 0"
 }
+
+SectionData."media0_in mi num_desc" {
+	tuples "media0_in mi num_desc"
+}
+
+SectionData."media0_in mi_size_desc" {
+	tuples "media0_in mi_size_desc"
+}
+
 SectionData."media0_in mi" {
-	file "sklrt286/media0_in-mi.bin"
+	tuples "media0_in mi"
+}
+
+SectionData."media0_out mo num_desc" {
+	tuples "media0_out mo num_desc"
+}
+
+SectionData."media0_out mo_size_desc" {
+	tuples "media0_out mo_size_desc"
 }
+
 SectionData."media0_out mo" {
-	file "sklrt286/media0_out-mo.bin"
+	tuples "media0_out mo"
+}
+
+SectionData."media0_out cpr 6 num_desc" {
+	tuples "media0_out cpr 6 num_desc"
 }
+
+SectionData."media0_out cpr 6_size_desc" {
+	tuples "media0_out cpr 6_size_desc"
+}
+
 SectionData."media0_out cpr 6" {
-	file "sklrt286/media0_out-cpr-6.bin"
+	tuples "media0_out cpr 6"
+}
+
+SectionData."codec0_out mo num_desc" {
+	tuples "codec0_out mo num_desc"
+}
+
+SectionData."codec0_out mo_size_desc" {
+	tuples "codec0_out mo_size_desc"
 }
+
 SectionData."codec0_out mo" {
-	file "sklrt286/codec0_out-mo.bin"
+	tuples "codec0_out mo"
+}
+
+SectionData."codec0_out cpr 4 num_desc" {
+	tuples "codec0_out cpr 4 num_desc"
+}
+
+SectionData."codec0_out cpr 4_size_desc" {
+	tuples "codec0_out cpr 4_size_desc"
 }
+
 SectionData."codec0_out cpr 4" {
-	file "sklrt286/codec0_out-cpr-4.bin"
+	tuples "codec0_out cpr 4"
+}
+
+SectionData."codec1_out mo num_desc" {
+	tuples "codec1_out mo num_desc"
+}
+
+SectionData."codec1_out mo_size_desc" {
+	tuples "codec1_out mo_size_desc"
 }
+
 SectionData."codec1_out mo" {
-	file "sklrt286/codec1_out-mo.bin"
+	tuples "codec1_out mo"
+}
+
+SectionData."codec1_out cpr 5 num_desc" {
+	tuples "codec1_out cpr 5 num_desc"
 }
+
+SectionData."codec1_out cpr 5_size_desc" {
+	tuples "codec1_out cpr 5_size_desc"
+}
+
 SectionData."codec1_out cpr 5" {
-	file "sklrt286/codec1_out-cpr-5.bin"
+	tuples "codec1_out cpr 5"
+}
+
+SectionData."codec0_in cpr 1 num_desc" {
+	tuples "codec0_in cpr 1 num_desc"
+}
+
+SectionData."codec0_in cpr 1_size_desc" {
+	tuples "codec0_in cpr 1_size_desc"
 }
+
 SectionData."codec0_in cpr 1" {
-	file "sklrt286/codec0_in-cpr-1.bin"
+	tuples "codec0_in cpr 1"
 }
+
+SectionData."codec0_in mi num_desc" {
+	tuples "codec0_in mi num_desc"
+}
+
+SectionData."codec0_in mi_size_desc" {
+	tuples "codec0_in mi_size_desc"
+}
+
 SectionData."codec0_in mi" {
-	file "sklrt286/codec0_in-mi.bin"
+	tuples "codec0_in mi"
+}
+
+SectionData."dmic01_hifi_in cpr 3 num_desc" {
+	tuples "dmic01_hifi_in cpr 3 num_desc"
+}
+
+SectionData."dmic01_hifi_in cpr 3_size_desc" {
+	tuples "dmic01_hifi_in cpr 3_size_desc"
 }
+
 SectionData."dmic01_hifi_in cpr 3" {
-	file "sklrt286/dmic01_hifi_in-cpr-3.bin"
+	tuples "dmic01_hifi_in cpr 3"
+}
+
+SectionData."dmic01_hifi_in mi num_desc" {
+	tuples "dmic01_hifi_in mi num_desc"
 }
+
+SectionData."dmic01_hifi_in mi_size_desc" {
+	tuples "dmic01_hifi_in mi_size_desc"
+}
+
 SectionData."dmic01_hifi_in mi" {
-	file "sklrt286/dmic01_hifi_in-mi.bin"
+	tuples "dmic01_hifi_in mi"
+}
+
+SectionData."hdmi1_pt_out cpr 7 num_desc" {
+	tuples "hdmi1_pt_out cpr 7 num_desc"
+}
+
+SectionData."hdmi1_pt_out cpr 7_size_desc" {
+	tuples "hdmi1_pt_out cpr 7_size_desc"
 }
+
 SectionData."hdmi1_pt_out cpr 7" {
-	file "sklrt286/hdmi1_pt_out-cpr-7.bin"
+	tuples "hdmi1_pt_out cpr 7"
+}
+
+SectionData."hdmi1_pt_out cpr 8 num_desc" {
+	tuples "hdmi1_pt_out cpr 8 num_desc"
+}
+
+SectionData."hdmi1_pt_out cpr 8_size_desc" {
+	tuples "hdmi1_pt_out cpr 8_size_desc"
 }
+
 SectionData."hdmi1_pt_out cpr 8" {
-	file "sklrt286/hdmi1_pt_out-cpr-8.bin"
+	tuples "hdmi1_pt_out cpr 8"
+}
+
+SectionData."hdmi2_pt_out cpr 9 num_desc" {
+	tuples "hdmi2_pt_out cpr 9 num_desc"
+}
+
+SectionData."hdmi2_pt_out cpr 9_size_desc" {
+	tuples "hdmi2_pt_out cpr 9_size_desc"
 }
+
 SectionData."hdmi2_pt_out cpr 9" {
-	file "sklrt286/hdmi2_pt_out-cpr-9.bin"
+	tuples "hdmi2_pt_out cpr 9"
+}
+
+SectionData."hdmi2_pt_out cpr 10 num_desc" {
+	tuples "hdmi2_pt_out cpr 10 num_desc"
 }
+
+SectionData."hdmi2_pt_out cpr 10_size_desc" {
+	tuples "hdmi2_pt_out cpr 10_size_desc"
+}
+
 SectionData."hdmi2_pt_out cpr 10" {
-	file "sklrt286/hdmi2_pt_out-cpr-10.bin"
+	tuples "hdmi2_pt_out cpr 10"
+}
+
+SectionData."hdmi3_pt_out cpr 11 num_desc" {
+	tuples "hdmi3_pt_out cpr 11 num_desc"
+}
+
+SectionData."hdmi3_pt_out cpr 11_size_desc" {
+	tuples "hdmi3_pt_out cpr 11_size_desc"
 }
+
 SectionData."hdmi3_pt_out cpr 11" {
-	file "sklrt286/hdmi3_pt_out-cpr-11.bin"
+	tuples "hdmi3_pt_out cpr 11"
 }
+
+SectionData."hdmi3_pt_out cpr 12 num_desc" {
+	tuples "hdmi3_pt_out cpr 12 num_desc"
+}
+
+SectionData."hdmi3_pt_out cpr 12_size_desc" {
+	tuples "hdmi3_pt_out cpr 12_size_desc"
+}
+
 SectionData."hdmi3_pt_out cpr 12" {
-	file "sklrt286/hdmi3_pt_out-cpr-12.bin"
+	tuples "hdmi3_pt_out cpr 12"
 }
 
+
 SectionControlMixer."media0_in mi Switch" {
 	index"1"
 	invert "false"
@@ -121,7 +2671,11 @@ SectionWidget."media0_in cpr 0" {
 	no_pm "true"
 	event_type "3"
 	event_flags "9"
-	data "media0_in cpr 0"
+	data [
+		"media0_in cpr 0 num_desc"
+		"media0_in cpr 0_size_desc"
+		"media0_in cpr 0"
+	]
 }
 SectionWidget."media0_in mi" {
 	index"1"
@@ -130,7 +2684,11 @@ SectionWidget."media0_in mi" {
 	event_type "4"
 	event_flags "9"
 	subseq "10"
-	data "media0_in mi"
+	data [
+		"media0_in mi num_desc"
+		"media0_in mi_size_desc"
+		"media0_in mi"
+	]
 }
 SectionWidget."media0_out mo" {
 	index"1"
@@ -139,7 +2697,11 @@ SectionWidget."media0_out mo" {
 	event_type "1"
 	event_flags "15"
 	subseq "10"
-	data "media0_out mo"
+	data [
+		"media0_out mo num_desc"
+		"media0_out mo_size_desc"
+		"media0_out mo"
+	]
 	mixer [
 		"media0_in mi Switch"
 		"codec0_in mi Switch"
@@ -151,7 +2713,11 @@ SectionWidget."media0_out cpr 6" {
 	type"pga"
 	no_pm "true"
 	event_type "4"
-	data "media0_out cpr 6"
+	data [
+		"media0_out cpr 6 num_desc"
+		"media0_out cpr 6_size_desc"
+		"media0_out cpr 6"
+	]
 }
 SectionWidget."codec0_out mo" {
 	index"1"
@@ -160,7 +2726,11 @@ SectionWidget."codec0_out mo" {
 	event_type "1"
 	event_flags "15"
 	subseq "10"
-	data "codec0_out mo"
+	data [
+		"codec0_out mo num_desc"
+		"codec0_out mo_size_desc"
+		"codec0_out mo"
+	]
 	mixer [
 		"media0_in mi Switch"
 		"codec0_in mi Switch"
@@ -172,7 +2742,11 @@ SectionWidget."codec0_out cpr 4" {
 	type"pga"
 	no_pm "true"
 	event_type "4"
-	data "codec0_out cpr 4"
+	data [
+		"codec0_out cpr 4 num_desc"
+		"codec0_out cpr 4_size_desc"
+		"codec0_out cpr 4"
+	]
 }
 SectionWidget."codec0_out" {
 	index"1"
@@ -186,7 +2760,11 @@ SectionWidget."codec1_out mo" {
 	event_type "1"
 	event_flags "15"
 	subseq "10"
-	data "codec1_out mo"
+	data [
+		"codec1_out mo num_desc"
+		"codec1_out mo_size_desc"
+		"codec1_out mo"
+	]
 	mixer [
 		"media0_in mi Switch"
 		"codec0_in mi Switch"
@@ -198,7 +2776,11 @@ SectionWidget."codec1_out cpr 5" {
 	type"pga"
 	no_pm "true"
 	event_type "4"
-	data "codec1_out cpr 5"
+	data [
+		"codec1_out cpr 5 num_desc"
+		"codec1_out cpr 5_size_desc"
+		"codec1_out cpr 5"
+	]
 }
 SectionWidget."codec1_out" {
 	index"1"
@@ -211,7 +2793,11 @@ SectionWidget."codec0_in cpr 1" {
 	no_pm "true"
 	event_type "3"
 	event_flags "9"
-	data "codec0_in cpr 1"
+	data [
+		"codec0_in cpr 1 num_desc"
+		"codec0_in cpr 1_size_desc"
+		"codec0_in cpr 1"
+	]
 }
 SectionWidget."codec0_in mi" {
 	index"1"
@@ -220,7 +2806,11 @@ SectionWidget."codec0_in mi" {
 	event_type "4"
 	event_flags "9"
 	subseq "10"
-	data "codec0_in mi"
+	data [
+		"codec0_in mi num_desc"
+		"codec0_in mi_size_desc"
+		"codec0_in mi"
+	]
 }
 SectionWidget."codec0_in" {
 	index"1"
@@ -233,7 +2823,11 @@ SectionWidget."dmic01_hifi_in cpr 3" {
 	no_pm "true"
 	event_type "3"
 	event_flags "9"
-	data "dmic01_hifi_in cpr 3"
+	data [
+		"dmic01_hifi_in cpr 3 num_desc"
+		"dmic01_hifi_in cpr 3_size_desc"
+		"dmic01_hifi_in cpr 3"
+	]
 }
 SectionWidget."dmic01_hifi_in mi" {
 	index"1"
@@ -242,7 +2836,11 @@ SectionWidget."dmic01_hifi_in mi" {
 	event_type "4"
 	event_flags "9"
 	subseq "10"
-	data "dmic01_hifi_in mi"
+	data [
+		"dmic01_hifi_in mi num_desc"
+		"dmic01_hifi_in mi_size_desc"
+		"dmic01_hifi_in mi"
+	]
 }
 SectionWidget."dmic01_hifi" {
 	index"1"
@@ -255,14 +2853,22 @@ SectionWidget."hdmi1_pt_out cpr 7" {
 	no_pm "true"
 	event_type "3"
 	event_flags "9"
-	data "hdmi1_pt_out cpr 7"
+	data [
+		"hdmi1_pt_out cpr 7 num_desc"
+		"hdmi1_pt_out cpr 7_size_desc"
+		"hdmi1_pt_out cpr 7"
+	]
 }
 SectionWidget."hdmi1_pt_out cpr 8" {
 	index"1"
 	type"pga"
 	no_pm "true"
 	event_type "4"
-	data "hdmi1_pt_out cpr 8"
+	data [
+		"hdmi1_pt_out cpr 8 num_desc"
+		"hdmi1_pt_out cpr 8_size_desc"
+		"hdmi1_pt_out cpr 8"
+	]
 }
 SectionWidget."iDisp1_out" {
 	index"1"
@@ -275,14 +2881,22 @@ SectionWidget."hdmi2_pt_out cpr 9" {
 	no_pm "true"
 	event_type "3"
 	event_flags "9"
-	data "hdmi2_pt_out cpr 9"
+	data [
+		"hdmi2_pt_out cpr 9 num_desc"
+		"hdmi2_pt_out cpr 9_size_desc"
+		"hdmi2_pt_out cpr 9"
+	]
 }
 SectionWidget."hdmi2_pt_out cpr 10" {
 	index"1"
 	type"pga"
 	no_pm "true"
 	event_type "4"
-	data "hdmi2_pt_out cpr 10"
+	data [
+		"hdmi2_pt_out cpr 10 num_desc"
+		"hdmi2_pt_out cpr 10_size_desc"
+		"hdmi2_pt_out cpr 10"
+	]
 }
 SectionWidget."iDisp2_out" {
 	index"1"
@@ -295,14 +2909,22 @@ SectionWidget."hdmi3_pt_out cpr 11" {
 	no_pm "true"
 	event_type "3"
 	event_flags "9"
-	data "hdmi3_pt_out cpr 11"
+	data [
+		"hdmi3_pt_out cpr 11 num_desc"
+		"hdmi3_pt_out cpr 11_size_desc"
+		"hdmi3_pt_out cpr 11"
+	]
 }
 SectionWidget."hdmi3_pt_out cpr 12" {
 	index"1"
 	type"pga"
 	no_pm "true"
 	event_type "4"
-	data "hdmi3_pt_out cpr 12"
+	data [
+		"hdmi3_pt_out cpr 12 num_desc"
+		"hdmi3_pt_out cpr 12_size_desc"
+		"hdmi3_pt_out cpr 12"
+	]
 }
 SectionGraph."Pipeline 1 Graph" {
 	index"1"
-- 
1.9.1
