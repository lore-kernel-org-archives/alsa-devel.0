From: Warren Turkal <wturkal@cbu.edu>
Subject: refactoring of maestro continues
Date: Sat, 19 Jul 2003 01:59:44 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307190159.44755.wturkal@cbu.edu>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_gxOG/TzgzURBsZ2"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--Boundary-00=_gxOG/TzgzURBsZ2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is a patch against the HEAD of linus' tree. This time there are no AC97 
defines in maestro3.c for the generic AC97 support.

Warren Turkal
-- 
Treasurer, GOLUM, Inc.
http://www.golum.org

--Boundary-00=_gxOG/TzgzURBsZ2
Content-Type: text/x-diff;
  charset="us-ascii";
  name="maestro-refactor3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="maestro-refactor3.diff"

Index: es1968.c
===================================================================
--- es1968.c	(revision 11889)
+++ es1968.c	(working copy)
@@ -108,6 +108,7 @@
 #include <sound/ac97_codec.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
+#include "maestro.h"
 
 #define chip_t es1968_t
 
@@ -280,12 +281,13 @@
 #define READABLE_MAP		0x64003F
 
 /* PCI Register */
-
+#if 0
 #define ESM_LEGACY_AUDIO_CONTROL 0x40
 #define ESM_ACPI_COMMAND	0x54
 #define ESM_CONFIG_A		0x50
 #define ESM_CONFIG_B		0x52
 #define ESM_DDMA		0x60
+#endif
 
 /* Bob Bits */
 #define ESM_BOB_ENABLE		0x0001
@@ -2276,9 +2278,9 @@
 
 	/* DDMA off */
 
-	pci_read_config_word(pci, ESM_DDMA, &w);
+	pci_read_config_word(pci, ESM_DDMA_CONTROL, &w);
 	w &= ~(1 << 0);
-	pci_write_config_word(pci, ESM_DDMA, w);
+	pci_write_config_word(pci, ESM_DDMA_CONTROL, w);
 
 	/*
 	 *	Legacy mode
Index: maestro.h
===================================================================
--- maestro.h	(working copy)
+++ maestro.h	(working copy)
@@ -0,0 +1,439 @@
+/*
+ * Common defines for ESS Maestro/Allegro series (ES1968/ES1988) soundcards.
+ * Copyright (c) 2003 by Warren Turkal <wturkal@cbu.edu>
+ *
+ *   This program is free software; you can redistribute it and/or modify
+ *   it under the terms of the GNU General Public License as published by
+ *   the Free Software Foundation; either version 2 of the License, or
+ *   (at your option) any later version.
+ *
+ *   This program is distributed in the hope that it will be useful,
+ *   but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *   GNU General Public License for more details.
+ *
+ *   You should have received a copy of the GNU General Public License
+ *   along with this program; if not, write to the Free Software
+ *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ *
+ * NOTES:
+ *   All define symbols are prefixed by ESM_ since these defines relate to
+ *   ESS Maestro based cards. These are the common defines between all
+ *   Maestro/Allegro class cards from ESS.
+ *
+ * ChangeLog:
+ * Jul. 14, 2003
+ *     - refactored defines for some configuration registers in maestro3.c
+ *       and es1968.c
+ *
+ */
+
+/* PCI configuration register locations */
+#define ESM_LEGACY_AUDIO_CONTROL 0x40
+#define ESM_ACPI_COMMAND         0x54
+#define ESM_CONFIG_A             0x50
+#define ESM_CONFIG_B             0x52
+#define ESM_DDMA_CONTROL         0x60
+
+#if 0
+
+/*
+ * maestro3 registers
+ */
+
+/* Allegro PCI configuration registers */
+#define SOUND_BLASTER_ENABLE    0x00000001
+#define FM_SYNTHESIS_ENABLE     0x00000002
+#define GAME_PORT_ENABLE        0x00000004
+#define MPU401_IO_ENABLE        0x00000008
+#define MPU401_IRQ_ENABLE       0x00000010
+#define ALIAS_10BIT_IO          0x00000020
+#define SB_DMA_MASK             0x000000C0
+#define SB_DMA_0                0x00000040
+#define SB_DMA_1                0x00000040
+#define SB_DMA_R                0x00000080
+#define SB_DMA_3                0x000000C0
+#define SB_IRQ_MASK             0x00000700
+#define SB_IRQ_5                0x00000000
+#define SB_IRQ_7                0x00000100
+#define SB_IRQ_9                0x00000200
+#define SB_IRQ_10               0x00000300
+#define MIDI_IRQ_MASK           0x00003800
+#define SERIAL_IRQ_ENABLE       0x00004000
+#define DISABLE_LEGACY          0x00008000
+
+/* #define PCI_ALLEGRO_CONFIG      0x50     replaced by ESM_CONFIG_A */
+#define SB_ADDR_240             0x00000004
+#define MPU_ADDR_MASK           0x00000018
+#define MPU_ADDR_330            0x00000000
+#define MPU_ADDR_300            0x00000008
+#define MPU_ADDR_320            0x00000010
+#define MPU_ADDR_340            0x00000018
+#define USE_PCI_TIMING          0x00000040
+#define POSTED_WRITE_ENABLE     0x00000080
+#define DMA_POLICY_MASK         0x00000700
+#define DMA_DDMA                0x00000000
+#define DMA_TDMA                0x00000100
+#define DMA_PCPCI               0x00000200
+#define DMA_WBDMA16             0x00000400
+#define DMA_WBDMA4              0x00000500
+#define DMA_WBDMA2              0x00000600
+#define DMA_WBDMA1              0x00000700
+#define DMA_SAFE_GUARD          0x00000800
+#define HI_PERF_GP_ENABLE       0x00001000
+#define PIC_SNOOP_MODE_0        0x00002000
+#define PIC_SNOOP_MODE_1        0x00004000
+#define SOUNDBLASTER_IRQ_MASK   0x00008000
+#define RING_IN_ENABLE          0x00010000
+#define SPDIF_TEST_MODE         0x00020000
+#define CLK_MULT_MODE_SELECT_2  0x00040000
+#define EEPROM_WRITE_ENABLE     0x00080000
+#define CODEC_DIR_IN            0x00100000
+#define HV_BUTTON_FROM_GD       0x00200000
+#define REDUCED_DEBOUNCE        0x00400000
+#define HV_CTRL_ENABLE          0x00800000
+#define SPDIF_ENABLE            0x01000000
+#define CLK_DIV_SELECT          0x06000000
+#define CLK_DIV_BY_48           0x00000000
+#define CLK_DIV_BY_49           0x02000000
+#define CLK_DIV_BY_50           0x04000000
+#define CLK_DIV_RESERVED        0x06000000
+#define PM_CTRL_ENABLE          0x08000000
+#define CLK_MULT_MODE_SELECT    0x30000000
+#define CLK_MULT_MODE_SHIFT     28
+#define CLK_MULT_MODE_0         0x00000000
+#define CLK_MULT_MODE_1         0x10000000
+#define CLK_MULT_MODE_2         0x20000000
+#define CLK_MULT_MODE_3         0x30000000
+#define INT_CLK_SELECT          0x40000000
+#define INT_CLK_MULT_RESET      0x80000000
+
+/* M3 */
+#define INT_CLK_SRC_NOT_PCI     0x00100000
+#define INT_CLK_MULT_ENABLE     0x80000000
+
+/* #define PCI_ACPI_CONTROL        0x54          replaced by ESM_ACPI_COMMAND */
+#define PCI_ACPI_D0             0x00000000
+#define PCI_ACPI_D1             0xB4F70000
+#define PCI_ACPI_D2             0xB4F7B4F7
+
+#define PCI_USER_CONFIG         0x58
+#define EXT_PCI_MASTER_ENABLE   0x00000001
+#define SPDIF_OUT_SELECT        0x00000002
+#define TEST_PIN_DIR_CTRL       0x00000004
+#define AC97_CODEC_TEST         0x00000020
+#define TRI_STATE_BUFFER        0x00000080
+#define IN_CLK_12MHZ_SELECT     0x00000100
+#define MULTI_FUNC_DISABLE      0x00000200
+#define EXT_MASTER_PAIR_SEL     0x00000400
+#define PCI_MASTER_SUPPORT      0x00000800
+#define STOP_CLOCK_ENABLE       0x00001000
+#define EAPD_DRIVE_ENABLE       0x00002000
+#define REQ_TRI_STATE_ENABLE    0x00004000
+#define REQ_LOW_ENABLE          0x00008000
+#define MIDI_1_ENABLE           0x00010000
+#define MIDI_2_ENABLE           0x00020000
+#define SB_AUDIO_SYNC           0x00040000
+#define HV_CTRL_TEST            0x00100000
+#define SOUNDBLASTER_TEST       0x00400000
+
+#define PCI_USER_CONFIG_C       0x5C
+
+#define PCI_DDMA_CTRL           0x60
+#define DDMA_ENABLE             0x00000001
+
+
+/* Allegro registers */
+#define HOST_INT_CTRL           0x18
+#define SB_INT_ENABLE           0x0001
+#define MPU401_INT_ENABLE       0x0002
+#define ASSP_INT_ENABLE         0x0010
+#define RING_INT_ENABLE         0x0020
+#define HV_INT_ENABLE           0x0040
+#define CLKRUN_GEN_ENABLE       0x0100
+#define HV_CTRL_TO_PME          0x0400
+#define SOFTWARE_RESET_ENABLE   0x8000
+
+/*
+ * should be using the above defines, probably.
+ */
+#define REGB_ENABLE_RESET               0x01
+#define REGB_STOP_CLOCK                 0x10
+
+#define HOST_INT_STATUS         0x1A
+#define SB_INT_PENDING          0x01
+#define MPU401_INT_PENDING      0x02
+#define ASSP_INT_PENDING        0x10
+#define RING_INT_PENDING        0x20
+#define HV_INT_PENDING          0x40
+
+#define HARDWARE_VOL_CTRL       0x1B
+#define SHADOW_MIX_REG_VOICE    0x1C
+#define HW_VOL_COUNTER_VOICE    0x1D
+#define SHADOW_MIX_REG_MASTER   0x1E
+#define HW_VOL_COUNTER_MASTER   0x1F
+
+#define CODEC_COMMAND           0x30
+#define CODEC_READ_B            0x80
+
+#define CODEC_STATUS            0x30
+#define CODEC_BUSY_B            0x01
+
+#define CODEC_DATA              0x32
+
+#define RING_BUS_CTRL_A         0x36
+#define RAC_PME_ENABLE          0x0100
+#define RAC_SDFS_ENABLE         0x0200
+#define LAC_PME_ENABLE          0x0400
+#define LAC_SDFS_ENABLE         0x0800
+#define SERIAL_AC_LINK_ENABLE   0x1000
+#define IO_SRAM_ENABLE          0x2000
+#define IIS_INPUT_ENABLE        0x8000
+
+#define RING_BUS_CTRL_B         0x38
+#define SECOND_CODEC_ID_MASK    0x0003
+#define SPDIF_FUNC_ENABLE       0x0010
+#define SECOND_AC_ENABLE        0x0020
+#define SB_MODULE_INTF_ENABLE   0x0040
+#define SSPE_ENABLE             0x0040
+#define M3I_DOCK_ENABLE         0x0080
+
+#define SDO_OUT_DEST_CTRL       0x3A
+#define COMMAND_ADDR_OUT        0x0003
+#define PCM_LR_OUT_LOCAL        0x0000
+#define PCM_LR_OUT_REMOTE       0x0004
+#define PCM_LR_OUT_MUTE         0x0008
+#define PCM_LR_OUT_BOTH         0x000C
+#define LINE1_DAC_OUT_LOCAL     0x0000
+#define LINE1_DAC_OUT_REMOTE    0x0010
+#define LINE1_DAC_OUT_MUTE      0x0020
+#define LINE1_DAC_OUT_BOTH      0x0030
+#define PCM_CLS_OUT_LOCAL       0x0000
+#define PCM_CLS_OUT_REMOTE      0x0040
+#define PCM_CLS_OUT_MUTE        0x0080
+#define PCM_CLS_OUT_BOTH        0x00C0
+#define PCM_RLF_OUT_LOCAL       0x0000
+#define PCM_RLF_OUT_REMOTE      0x0100
+#define PCM_RLF_OUT_MUTE        0x0200
+#define PCM_RLF_OUT_BOTH        0x0300
+#define LINE2_DAC_OUT_LOCAL     0x0000
+#define LINE2_DAC_OUT_REMOTE    0x0400
+#define LINE2_DAC_OUT_MUTE      0x0800
+#define LINE2_DAC_OUT_BOTH      0x0C00
+#define HANDSET_OUT_LOCAL       0x0000
+#define HANDSET_OUT_REMOTE      0x1000
+#define HANDSET_OUT_MUTE        0x2000
+#define HANDSET_OUT_BOTH        0x3000
+#define IO_CTRL_OUT_LOCAL       0x0000
+#define IO_CTRL_OUT_REMOTE      0x4000
+#define IO_CTRL_OUT_MUTE        0x8000
+#define IO_CTRL_OUT_BOTH        0xC000
+
+#define SDO_IN_DEST_CTRL        0x3C
+#define STATUS_ADDR_IN          0x0003
+#define PCM_LR_IN_LOCAL         0x0000
+#define PCM_LR_IN_REMOTE        0x0004
+#define PCM_LR_RESERVED         0x0008
+#define PCM_LR_IN_BOTH          0x000C
+#define LINE1_ADC_IN_LOCAL      0x0000
+#define LINE1_ADC_IN_REMOTE     0x0010
+#define LINE1_ADC_IN_MUTE       0x0020
+#define MIC_ADC_IN_LOCAL        0x0000
+#define MIC_ADC_IN_REMOTE       0x0040
+#define MIC_ADC_IN_MUTE         0x0080
+#define LINE2_DAC_IN_LOCAL      0x0000
+#define LINE2_DAC_IN_REMOTE     0x0400
+#define LINE2_DAC_IN_MUTE       0x0800
+#define HANDSET_IN_LOCAL        0x0000
+#define HANDSET_IN_REMOTE       0x1000
+#define HANDSET_IN_MUTE         0x2000
+#define IO_STATUS_IN_LOCAL      0x0000
+#define IO_STATUS_IN_REMOTE     0x4000
+
+#define SPDIF_IN_CTRL           0x3E
+#define SPDIF_IN_ENABLE         0x0001
+
+#define GPIO_DATA               0x60
+#define GPIO_DATA_MASK          0x0FFF
+#define GPIO_HV_STATUS          0x3000
+#define GPIO_PME_STATUS         0x4000
+
+#define GPIO_MASK               0x64
+#define GPIO_DIRECTION          0x68
+#define GPO_PRIMARY_AC97        0x0001
+#define GPI_LINEOUT_SENSE       0x0004
+#define GPO_SECONDARY_AC97      0x0008
+#define GPI_VOL_DOWN            0x0010
+#define GPI_VOL_UP              0x0020
+#define GPI_IIS_CLK             0x0040
+#define GPI_IIS_LRCLK           0x0080
+#define GPI_IIS_DATA            0x0100
+#define GPI_DOCKING_STATUS      0x0100
+#define GPI_HEADPHONE_SENSE     0x0200
+#define GPO_EXT_AMP_SHUTDOWN    0x1000
+
+#define GPO_EXT_AMP_M3		1	/* default m3 amp */
+#define GPO_EXT_AMP_ALLEGRO	8	/* default allegro amp */
+
+/* M3 */
+#define GPO_M3_EXT_AMP_SHUTDN   0x0002
+
+#define ASSP_INDEX_PORT         0x80
+#define ASSP_MEMORY_PORT        0x82
+#define ASSP_DATA_PORT          0x84
+
+#define MPU401_DATA_PORT        0x98
+#define MPU401_STATUS_PORT      0x99
+
+#define CLK_MULT_DATA_PORT      0x9C
+
+#define ASSP_CONTROL_A          0xA2
+#define ASSP_0_WS_ENABLE        0x01
+#define ASSP_CTRL_A_RESERVED1   0x02
+#define ASSP_CTRL_A_RESERVED2   0x04
+#define ASSP_CLK_49MHZ_SELECT   0x08
+#define FAST_PLU_ENABLE         0x10
+#define ASSP_CTRL_A_RESERVED3   0x20
+#define DSP_CLK_36MHZ_SELECT    0x40
+
+#define ASSP_CONTROL_B          0xA4
+#define RESET_ASSP              0x00
+#define RUN_ASSP                0x01
+#define ENABLE_ASSP_CLOCK       0x00
+#define STOP_ASSP_CLOCK         0x10
+#define RESET_TOGGLE            0x40
+
+#define ASSP_CONTROL_C          0xA6
+#define ASSP_HOST_INT_ENABLE    0x01
+#define FM_ADDR_REMAP_DISABLE   0x02
+#define HOST_WRITE_PORT_ENABLE  0x08
+
+#define ASSP_HOST_INT_STATUS    0xAC
+#define DSP2HOST_REQ_PIORECORD  0x01
+#define DSP2HOST_REQ_I2SRATE    0x02
+#define DSP2HOST_REQ_TIMER      0x04
+
+/*
+ * ASSP control regs
+ */
+#define DSP_PORT_TIMER_COUNT    0x06
+
+#define DSP_PORT_MEMORY_INDEX   0x80
+
+#define DSP_PORT_MEMORY_TYPE    0x82
+#define MEMTYPE_INTERNAL_CODE   0x0002
+#define MEMTYPE_INTERNAL_DATA   0x0003
+#define MEMTYPE_MASK            0x0003
+
+#define DSP_PORT_MEMORY_DATA    0x84
+
+#define DSP_PORT_CONTROL_REG_A  0xA2
+#define DSP_PORT_CONTROL_REG_B  0xA4
+#define DSP_PORT_CONTROL_REG_C  0xA6
+
+#define REV_A_CODE_MEMORY_BEGIN         0x0000
+#define REV_A_CODE_MEMORY_END           0x0FFF
+#define REV_A_CODE_MEMORY_UNIT_LENGTH   0x0040
+#define REV_A_CODE_MEMORY_LENGTH        (REV_A_CODE_MEMORY_END - REV_A_CODE_MEMORY_BEGIN + 1)
+
+#define REV_B_CODE_MEMORY_BEGIN         0x0000
+#define REV_B_CODE_MEMORY_END           0x0BFF
+#define REV_B_CODE_MEMORY_UNIT_LENGTH   0x0040
+#define REV_B_CODE_MEMORY_LENGTH        (REV_B_CODE_MEMORY_END - REV_B_CODE_MEMORY_BEGIN + 1)
+
+#define REV_A_DATA_MEMORY_BEGIN         0x1000
+#define REV_A_DATA_MEMORY_END           0x2FFF
+#define REV_A_DATA_MEMORY_UNIT_LENGTH   0x0080
+#define REV_A_DATA_MEMORY_LENGTH        (REV_A_DATA_MEMORY_END - REV_A_DATA_MEMORY_BEGIN + 1)
+
+#define REV_B_DATA_MEMORY_BEGIN         0x1000
+#define REV_B_DATA_MEMORY_END           0x2BFF
+#define REV_B_DATA_MEMORY_UNIT_LENGTH   0x0080
+#define REV_B_DATA_MEMORY_LENGTH        (REV_B_DATA_MEMORY_END - REV_B_DATA_MEMORY_BEGIN + 1)
+
+
+#define NUM_UNITS_KERNEL_CODE          16
+#define NUM_UNITS_KERNEL_DATA           2
+
+#define NUM_UNITS_KERNEL_CODE_WITH_HSP 16
+#define NUM_UNITS_KERNEL_DATA_WITH_HSP  5
+
+/*
+ * client data area offsets
+ */
+#define CDATA_INSTANCE_READY            0x00
+
+#define CDATA_HOST_SRC_ADDRL            0x01
+#define CDATA_HOST_SRC_ADDRH            0x02
+#define CDATA_HOST_SRC_END_PLUS_1L      0x03
+#define CDATA_HOST_SRC_END_PLUS_1H      0x04
+#define CDATA_HOST_SRC_CURRENTL         0x05
+#define CDATA_HOST_SRC_CURRENTH         0x06
+
+#define CDATA_IN_BUF_CONNECT            0x07
+#define CDATA_OUT_BUF_CONNECT           0x08
+
+#define CDATA_IN_BUF_BEGIN              0x09
+#define CDATA_IN_BUF_END_PLUS_1         0x0A
+#define CDATA_IN_BUF_HEAD               0x0B
+#define CDATA_IN_BUF_TAIL               0x0C
+#define CDATA_OUT_BUF_BEGIN             0x0D
+#define CDATA_OUT_BUF_END_PLUS_1        0x0E
+#define CDATA_OUT_BUF_HEAD              0x0F
+#define CDATA_OUT_BUF_TAIL              0x10
+
+#define CDATA_DMA_CONTROL               0x11
+#define CDATA_RESERVED                  0x12
+
+#define CDATA_FREQUENCY                 0x13
+#define CDATA_LEFT_VOLUME               0x14
+#define CDATA_RIGHT_VOLUME              0x15
+#define CDATA_LEFT_SUR_VOL              0x16
+#define CDATA_RIGHT_SUR_VOL             0x17
+
+#define CDATA_HEADER_LEN                0x18
+
+#define SRC3_DIRECTION_OFFSET           CDATA_HEADER_LEN
+#define SRC3_MODE_OFFSET                (CDATA_HEADER_LEN + 1)
+#define SRC3_WORD_LENGTH_OFFSET         (CDATA_HEADER_LEN + 2)
+#define SRC3_PARAMETER_OFFSET           (CDATA_HEADER_LEN + 3)
+#define SRC3_COEFF_ADDR_OFFSET          (CDATA_HEADER_LEN + 8)
+#define SRC3_FILTAP_ADDR_OFFSET         (CDATA_HEADER_LEN + 10)
+#define SRC3_TEMP_INBUF_ADDR_OFFSET     (CDATA_HEADER_LEN + 16)
+#define SRC3_TEMP_OUTBUF_ADDR_OFFSET    (CDATA_HEADER_LEN + 17)
+
+#define MINISRC_IN_BUFFER_SIZE   ( 0x50 * 2 )
+#define MINISRC_OUT_BUFFER_SIZE  ( 0x50 * 2 * 2)
+#define MINISRC_OUT_BUFFER_SIZE  ( 0x50 * 2 * 2)
+#define MINISRC_TMP_BUFFER_SIZE  ( 112 + ( MINISRC_BIQUAD_STAGE * 3 + 4 ) * 2 * 2 )
+#define MINISRC_BIQUAD_STAGE    2
+#define MINISRC_COEF_LOC          0x175
+
+#define DMACONTROL_BLOCK_MASK           0x000F
+#define  DMAC_BLOCK0_SELECTOR           0x0000
+#define  DMAC_BLOCK1_SELECTOR           0x0001
+#define  DMAC_BLOCK2_SELECTOR           0x0002
+#define  DMAC_BLOCK3_SELECTOR           0x0003
+#define  DMAC_BLOCK4_SELECTOR           0x0004
+#define  DMAC_BLOCK5_SELECTOR           0x0005
+#define  DMAC_BLOCK6_SELECTOR           0x0006
+#define  DMAC_BLOCK7_SELECTOR           0x0007
+#define  DMAC_BLOCK8_SELECTOR           0x0008
+#define  DMAC_BLOCK9_SELECTOR           0x0009
+#define  DMAC_BLOCKA_SELECTOR           0x000A
+#define  DMAC_BLOCKB_SELECTOR           0x000B
+#define  DMAC_BLOCKC_SELECTOR           0x000C
+#define  DMAC_BLOCKD_SELECTOR           0x000D
+#define  DMAC_BLOCKE_SELECTOR           0x000E
+#define  DMAC_BLOCKF_SELECTOR           0x000F
+#define DMACONTROL_PAGE_MASK            0x00F0
+#define  DMAC_PAGE0_SELECTOR            0x0030
+#define  DMAC_PAGE1_SELECTOR            0x0020
+#define  DMAC_PAGE2_SELECTOR            0x0010
+#define  DMAC_PAGE3_SELECTOR            0x0000
+#define DMACONTROL_AUTOREPEAT           0x1000
+#define DMACONTROL_STOPPED              0x2000
+#define DMACONTROL_DIRECTION            0x0100
+
+#endif
Index: maestro3.c
===================================================================
--- maestro3.c	(revision 11889)
+++ maestro3.c	(working copy)
@@ -27,7 +27,7 @@
  *     - Added Canyon3D-2 support by Rob Riggs <rob@pangalactic.org>
  *
  */
- 
+
 #define CARD_NAME "ESS Maestro3/Allegro/Canyon3D-2"
 #define DRIVER_NAME "Maestro3"
 
@@ -46,6 +46,7 @@
 #include <sound/ac97_codec.h>
 #define SNDRV_GET_ID
 #include <sound/initval.h>
+#include "maestro.h"
 
 MODULE_AUTHOR("Zach Brown <zab@zabbo.net>, Takashi Iwai <tiwai@suse.de>");
 MODULE_DESCRIPTION("ESS Maestro3 PCI");
@@ -89,7 +90,6 @@
  */
 
 /* Allegro PCI configuration registers */
-#define PCI_LEGACY_AUDIO_CTRL   0x40
 #define SOUND_BLASTER_ENABLE    0x00000001
 #define FM_SYNTHESIS_ENABLE     0x00000002
 #define GAME_PORT_ENABLE        0x00000004
@@ -110,7 +110,6 @@
 #define SERIAL_IRQ_ENABLE       0x00004000
 #define DISABLE_LEGACY          0x00008000
 
-#define PCI_ALLEGRO_CONFIG      0x50
 #define SB_ADDR_240             0x00000004
 #define MPU_ADDR_MASK           0x00000018
 #define MPU_ADDR_330            0x00000000
@@ -160,7 +159,6 @@
 #define INT_CLK_SRC_NOT_PCI     0x00100000
 #define INT_CLK_MULT_ENABLE     0x80000000
 
-#define PCI_ACPI_CONTROL        0x54
 #define PCI_ACPI_D0             0x00000000
 #define PCI_ACPI_D1             0xB4F70000
 #define PCI_ACPI_D2             0xB4F7B4F7
@@ -187,7 +185,6 @@
 
 #define PCI_USER_CONFIG_C       0x5C
 
-#define PCI_DDMA_CTRL           0x60
 #define DDMA_ENABLE             0x00000001
 
 
@@ -361,74 +358,6 @@
 #define DSP2HOST_REQ_I2SRATE    0x02
 #define DSP2HOST_REQ_TIMER      0x04
 
-/* AC97 registers */
-/* XXX fix this crap up */
-/*#define AC97_RESET              0x00*/
-
-#define AC97_VOL_MUTE_B         0x8000
-#define AC97_VOL_M              0x1F
-#define AC97_LEFT_VOL_S         8
-
-#define AC97_MASTER_VOL         0x02
-#define AC97_LINE_LEVEL_VOL     0x04
-#define AC97_MASTER_MONO_VOL    0x06
-#define AC97_PC_BEEP_VOL        0x0A
-#define AC97_PC_BEEP_VOL_M      0x0F
-#define AC97_SROUND_MASTER_VOL  0x38
-#define AC97_PC_BEEP_VOL_S      1
-
-/*#define AC97_PHONE_VOL          0x0C
-#define AC97_MIC_VOL            0x0E*/
-#define AC97_MIC_20DB_ENABLE    0x40
-
-/*#define AC97_LINEIN_VOL         0x10
-#define AC97_CD_VOL             0x12
-#define AC97_VIDEO_VOL          0x14
-#define AC97_AUX_VOL            0x16*/
-#define AC97_PCM_OUT_VOL        0x18
-/*#define AC97_RECORD_SELECT      0x1A*/
-#define AC97_RECORD_MIC         0x00
-#define AC97_RECORD_CD          0x01
-#define AC97_RECORD_VIDEO       0x02
-#define AC97_RECORD_AUX         0x03
-#define AC97_RECORD_MONO_MUX    0x02
-#define AC97_RECORD_DIGITAL     0x03
-#define AC97_RECORD_LINE        0x04
-#define AC97_RECORD_STEREO      0x05
-#define AC97_RECORD_MONO        0x06
-#define AC97_RECORD_PHONE       0x07
-
-/*#define AC97_RECORD_GAIN        0x1C*/
-#define AC97_RECORD_VOL_M       0x0F
-
-/*#define AC97_GENERAL_PURPOSE    0x20*/
-#define AC97_POWER_DOWN_CTRL    0x26
-#define AC97_ADC_READY          0x0001
-#define AC97_DAC_READY          0x0002
-#define AC97_ANALOG_READY       0x0004
-#define AC97_VREF_ON            0x0008
-#define AC97_PR0                0x0100
-#define AC97_PR1                0x0200
-#define AC97_PR2                0x0400
-#define AC97_PR3                0x0800
-#define AC97_PR4                0x1000
-
-#define AC97_RESERVED1          0x28
-
-#define AC97_VENDOR_TEST        0x5A
-
-#define AC97_CLOCK_DELAY        0x5C
-#define AC97_LINEOUT_MUX_SEL    0x0001
-#define AC97_MONO_MUX_SEL       0x0002
-#define AC97_CLOCK_DELAY_SEL    0x1F
-#define AC97_DAC_CDS_SHIFT      6
-#define AC97_ADC_CDS_SHIFT      11
-
-#define AC97_MULTI_CHANNEL_SEL  0x74
-
-/*#define AC97_VENDOR_ID1         0x7C
-#define AC97_VENDOR_ID2         0x7E*/
-
 /*
  * ASSP control regs
  */
@@ -2300,20 +2229,20 @@
 	u32 n;
 	u8 t; /* makes as much sense as 'n', no? */
 
-	pci_read_config_dword(pcidev, PCI_ALLEGRO_CONFIG, &n);
+	pci_read_config_dword(pcidev, ESM_CONFIG_A, &n);
 	n &= REDUCED_DEBOUNCE;
 	n |= PM_CTRL_ENABLE | CLK_DIV_BY_49 | USE_PCI_TIMING;
-	pci_write_config_dword(pcidev, PCI_ALLEGRO_CONFIG, n);
+	pci_write_config_dword(pcidev, ESM_CONFIG_A, n);
 
 	outb(RESET_ASSP, chip->iobase + ASSP_CONTROL_B);
-	pci_read_config_dword(pcidev, PCI_ALLEGRO_CONFIG, &n);
+	pci_read_config_dword(pcidev, ESM_CONFIG_A, &n);
 	n &= ~INT_CLK_SELECT;
 	if (!chip->allegro_flag) {
 		n &= ~INT_CLK_MULT_ENABLE; 
 		n |= INT_CLK_SRC_NOT_PCI;
 	}
 	n &=  ~( CLK_MULT_MODE_SELECT | CLK_MULT_MODE_SELECT_2 );
-	pci_write_config_dword(pcidev, PCI_ALLEGRO_CONFIG, n);
+	pci_write_config_dword(pcidev, ESM_CONFIG_A, n);
 
 	if (chip->allegro_flag) {
 		pci_read_config_dword(pcidev, PCI_USER_CONFIG, &n);

--Boundary-00=_gxOG/TzgzURBsZ2--



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
