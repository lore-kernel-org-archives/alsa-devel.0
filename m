From: "Le Gall, Louis" <louis.le.gall@intel.com>
Subject: PATCH[1/1] Add I2S common driver for Intel MID platform
Date: Mon, 18 Oct 2010 12:39:56 +0100
Message-ID: <2A84145621092446B6659B8A0F28E26F46FE77084A@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="_002_2A84145621092446B6659B8A0F28E26F46FE77084Airsmsx501gerc_"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id A683B10380C
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Oct 2010 13:41:03 +0200 (CEST)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--_002_2A84145621092446B6659B8A0F28E26F46FE77084Airsmsx501gerc_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi,
        This patch set is for new I2S SSP common driver that supports I2S a=
udio on Intel MID platforms.

        It is used for sending/receving I2S audio samples on Intel MID plat=
form.

        This interface is mostly used on Intel MID platforms and provide th=
e low level interface for some upper layer drivers such as Alsa sound card =
driver for Bluetooth/FM peripherals, char device interfaces for modem (cmt_=
speech),...
        As this is used to transfer speech frames from/to cellular modem th=
at have specific timing constraints (and modem also uses the I2S path to se=
nd some side-info), the Alsa SoC interface cannot be used.
        It is based on low level part of cmt_speech driver that can be foun=
d in N900 (see http://lists.meego.com/pipermail/meego-kernel/2010-September=
/000078.html ). The intel_mid_i2s have been separated from cmt_speech in or=
der to be more generic and to be used on other ports (for instance, to prov=
ide Alsa sound card driver for Bluetooth and FM).
        Upper level drivers cmt_speech and Alsa sound card driver that uses=
 intel_mid_i2s will be up-streamed in coming days and is planned to use the=
 same folder path (sound/pci/intel_mid_i2s/). So once these files will be u=
pstream, this will provides Alsa sound driver interface for Bluetooth and F=
M for Intel Mid platform, and specific speech audio interface (char device)=
 that is used by lib cmt speech data.

        I will provide soon some draft version of example driver that uses =
intel_mid_i2s so reviewers can have better understanding of how it is used =
and how it fits together.

Best Regards,
Louis Le Gall


Here is a simple diagram that explain where is the intel_mid_i2s in softwar=
e architecture.

             +-----------+
             |           |
             |Pulse Audio|
             |           |
             |           |
             +-----------+
                   |
                   |
      +------------+------------+
      |                         |
      |                         |
      |                         |
+-----------+             +-----------+
|           |             |Lib cmt    |
|Alsa Lib   |------+      |speech     |------+
|           |      |      |data       |      |
|           |      |      |           |      |
+-----------+      |      +-----------+      |
      |            |                         |
      |            |                         |                          User
......|............|.........................|.............................=
....
      |            |                         |                         Kern=
el
      |            |                         |
      |            |                         |
      |            |                         |
      |            |                         |
      |            |                         |
      |            |                         |
     \|/          \|/                       \|/
      V            V                         V
+---------+  ++---------++             ++---------++
|         |  ||Alsa snd ||             ||cmt      ||
|Intel SST|  ||driver   ||             ||speech   ||
| "MAD"   |  ||SSP      ||             ||driver   ||
|         |  ||BT/FM    ||             ||         ||
+---------+  ++---------++             ++---------++
      |            |                         |
      |            |                         |
      |            |                         |
      |            |                         |
     \|/           |                        \|/
      V            |                         V
+-----------+      |                   ++---------++
|           |      |                 \ ||intel mid||
|LPE        |      +------------------>||i2s      ||
|           |                        / ||unified  ||
|           |                          ||driver   ||
+-----------+                          ++---------++
      |                                      |
      |                                      |                         Kern=
el
......|......................................|.............................=
....
      |                                      |                        Hardw=
are
     \|/                                    \|/
      V                                      V
+--       --+                          +--       --+
|           |                          |           |
|MISC       |                          |SSP in I2S |
|           |                          |config     |
|           |                          |           |
+--       --+                          +--       --+



>From 16da3ebffad026e44d74538b7773a51044254920 Mon Sep 17 00:00:00 2001
From: Louis LE GALL <louis.le.gall@intel.com>
Date: Fri, 15 Oct 2010 15:30:49 +0200
Subject: [PATCH] New low level driver "Intel_mid_i2s" provide support for I=
2S SSP device on Intel MID Platforms
 Signed-off-by: Louis LE GALL <louis.le.gall@intel.com>

Change-Id: I17052a3b464c5682d2ab17a9b6e0fad30137243f

Signed-off-by: Louis LE GALL <louis.le.gall@intel.com>
---
 include/linux/intel_mid_i2s_if.h        |  280 ++++++
 sound/pci/Kconfig                       |   18 +
 sound/pci/Makefile                      |    4 +-
 sound/pci/intel_mid_i2s/Makefile        |   18 +
 sound/pci/intel_mid_i2s/intel_mid_i2s.c | 1428 +++++++++++++++++++++++++++=
++++
 sound/pci/intel_mid_i2s/intel_mid_i2s.h |  500 +++++++++++
 6 files changed, 2247 insertions(+), 1 deletions(-)
 create mode 100644 include/linux/intel_mid_i2s_if.h
 create mode 100644 sound/pci/intel_mid_i2s/Makefile
 create mode 100644 sound/pci/intel_mid_i2s/intel_mid_i2s.c
 create mode 100644 sound/pci/intel_mid_i2s/intel_mid_i2s.h

diff --git a/include/linux/intel_mid_i2s_if.h b/include/linux/intel_mid_i2s=
_if.h
new file mode 100644
index 0000000..1563577
--- /dev/null
+++ b/include/linux/intel_mid_i2s_if.h
@@ -0,0 +1,280 @@
+/*
+  * <Driver for I2S protocol on SSP (Moorestown and Medfield hardware)>
+  * Copyright (c) 2010, Intel Corporation.
+  * Louis LE GALL <louis.le.gall intel.com>
+  *
+  * This program is free software; you can redistribute it and/or modify it
+  * under the terms and conditions of the GNU General Public License,
+  * version 2, as published by the Free Software Foundation.
+  *
+  * This program is distributed in the hope it will be useful, but WITHOUT
+  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License =
for
+  * more details.
+  *
+  * You should have received a copy of the GNU General Public License alon=
g with
+  * this program; if not, write to the Free Software Foundation, Inc.,
+  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+  */
+
+#ifndef MID_I2S_EXTERNAL_H_
+#define MID_I2S_EXTERNAL_H_
+
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/intel_mid_dma.h>
+
+#include <linux/interrupt.h>
+
+/*
+ *     Structures Definition
+ */
+
+
+/*
+ *     SSCR0 settings
+ */
+enum mrst_ssp_mode {
+       SSP_IN_NORMAL_MODE =3D 0x0,
+       SSP_IN_NETWORK_MODE
+};
+
+enum mrst_ssp_rx_fifo_over_run_int_mask {
+       SSP_RX_FIFO_OVER_INT_ENABLE =3D 0x0,
+       SSP_RX_FIFO_OVER_INT_DISABLE
+};
+
+enum mrst_ssp_tx_fifo_under_run_int_mask {
+       SSP_TX_FIFO_UNDER_INT_ENABLE =3D 0x0,
+       SSP_TX_FIFO_UNDER_INT_DISABLE
+};
+
+enum mrst_ssp_frame_format {
+       MOTOROLA_SPI_FORMAT =3D 0x0,
+       TI_SSP_FORMAT,
+       MICROWIRE_FORMAT,
+       PSP_FORMAT
+
+};
+
+enum mrst_ssp_master_mode_clock_selection {
+       SSP_ONCHIP_CLOCK =3D 0x0,
+       SSP_NETWORK_CLOCK,
+       SSP_EXTERNAL_CLOCK,
+       SSP_ONCHIP_AUDIO_CLOCK,
+       SSP_MASTER_CLOCK_UNDEFINED =3D 0xFF
+};
+
+/*
+ *     SSCR1 settings
+ */
+enum mrst_ssp_txd_tristate_last_phase {
+       TXD_TRISTATE_LAST_PHASE_OFF =3D  0x0,
+       TXD_TRISTATE_LAST_PHASE_ON
+};
+
+enum mrst_ssp_txd_tristate_enable {
+       TXD_TRISTATE_OFF =3D  0x0,
+       TXD_TRISTATE_ON
+};
+
+enum mrst_ssp_slave_sspclk_free_running {
+       SLAVE_SSPCLK_ON_ALWAYS =3D  0x0,
+       SLAVE_SSPCLK_ON_DURING_TRANSFER_ONLY
+};
+
+enum mrst_ssp_sspsclk_direction {
+       SSPSCLK_MASTER_MODE =3D 0x0,
+       SSPSCLK_SLAVE_MODE
+};
+
+enum mrst_ssp_sspsfrm_direction {
+       SSPSFRM_MASTER_MODE =3D 0x0,
+       SSPSFRM_SLAVE_MODE
+};
+
+enum mrst_ssp_rx_without_tx {
+       RX_AND_TX_MODE =3D 0x0,
+       RX_WITHOUT_TX_MODE
+};
+
+enum mrst_trailing_byte_mode {
+       SSP_TRAILING_BYTE_HDL_BY_IA =3D 0x0,
+       SSP_TRAILING_BYTE_HDL_BY_DMA
+};
+
+enum mrst_ssp_tx_dma_status {
+       SSP_TX_DMA_MASK =3D 0x0,
+       SSP_TX_DMA_ENABLE
+};
+
+enum mrst_ssp_rx_dma_status {
+       SSP_RX_DMA_MASK =3D 0x0,
+       SSP_RX_DMA_ENABLE
+};
+
+enum mrst_ssp_rx_timeout_int_status {
+       SSP_RX_TIMEOUT_INT_DISABLE =3D 0x0,
+       SSP_RX_TIMEOUT_INT_ENABLE
+};
+
+enum mrst_ssp_trailing_byte_int_status {
+       SSP_TRAILING_BYTE_INT_DISABLE =3D 0x0,
+       SSP_TRAILING_BYTE_INT_ENABLE
+};
+
+enum mrst_ssp_loopback_mode_status {
+       SSP_LOOPBACK_OFF =3D 0x0,
+       SSP_LOOPBACK_ON
+};
+
+
+/*
+ *     SSPSP settings: for PSP Format ONLY!!!!!!!!
+ */
+
+enum mrst_ssp_frame_sync_relative_timing_bit {
+       NEXT_FRMS_ASS_AFTER_END_OF_T4 =3D  0x0,
+       NEXT_FRMS_ASS_WITH_LSB_PREVIOUS_FRM
+};
+
+enum mrst_ssp_frame_sync_polarity_bit {
+       SSP_FRMS_ACTIVE_LOW =3D  0x0,
+       SSP_FRMS_ACTIVE_HIGH
+};
+
+enum mrst_ssp_end_of_transfer_data_state {
+       SSP_END_DATA_TRANSFER_STATE_LOW =3D 0x0,
+       SSP_END_DATA_TRANSFER_STATE_PEVIOUS_BIT
+};
+
+enum mrst_ssp_clk_mode {
+       SSP_CLK_MODE_0 =3D 0x0,
+       SSP_CLK_MODE_1,
+       SSP_CLK_MODE_2,
+       SSP_CLK_MODE_3
+};
+
+
+/*
+ *     list of differents types of SSP, value depends of adid entry of
+ *     capability ID of the PCI
+ */
+
+/*
+ *
+ * The PCI header associated to SSP devices now includes a configuration
+ * register. It provides information to a driver which is probed for the
+ * SSP, specifying in which way the SSP is supposed to be used. Here is
+ * the format of this byte register:
+ *
+ *     bits 2..0: Mode
+ *             000=3D0x0 : Invalid, the register should be ignored
+ *             001=3D0x1 : SSP to be used as SPI controller
+ *             010=3D0x2: SSP to be used in I2S/ISS mode
+ *             other: Reserved
+ *
+ *     bits 5..3: Configuration
+ *     In I2S/ISS mode:
+ *             000=3D0x0: Invalid
+ *             001=3D0x1: Bluetooth
+ *             010=3D0x2: Modem
+ *             other: Reserved
+ *     In SPI mode:
+ *             Value is the SPI bus number connected to the SSP.
+ *             To be used for registration to the Linux SPI
+ *             framework.
+ *     bit 6: SPI slave
+ *     Relevant in SPI mode only. If set, indicates the SPI clock
+ *     is not provided by the SSP: SPI slave mode.
+ *
+ *     bit 7: Reserved (0)
+ *
+ * This configuration register is implemented in the adid field of the
+ * Vendor Specific PCI capability associated to the SSP.
+ *
+ */
+
+#define PCI_ADID_SSP_MODE_SPI  (1)
+#define PCI_ADID_SSP_MODE_I2S  (2)
+
+#define PCI_ADID_SSP_CONF_BT_FM  (1<<3)
+#define PCI_ADID_SSP_CONF_MODEM  (2<<3)
+
+
+#define PCI_CAP_ADID_I2S_BT_FM  ((PCI_ADID_SSP_CONF_BT_FM) | (PCI_ADID_SSP=
_MODE_I2S))
+#define PCI_CAP_ADID_I2S_MODEM  ((PCI_ADID_SSP_CONF_MODEM) | (PCI_ADID_SSP=
_MODE_I2S))
+
+enum intel_mid_i2s_ssp_usage {
+       SSP_USAGE_UNASSIGNED =3D 0x00,
+       SSP_USAGE_BLUETOOTH_FM =3D 0x01,
+       SSP_USAGE_MODEM =3D 0x02
+};
+
+/*
+ *     Structure used to configure the SSP Port
+ *     Please note that only the PSP format and the DMA transfer are suppo=
rted
+ */
+
+struct intel_mid_i2s_settings {
+       enum mrst_ssp_mode                         mode;
+       enum mrst_ssp_rx_fifo_over_run_int_mask    rx_fifo_interrupt;
+       enum mrst_ssp_tx_fifo_under_run_int_mask   tx_fifo_interrupt;
+       enum mrst_ssp_frame_format                 frame_format;
+       enum mrst_ssp_master_mode_clock_selection  master_mode_clk_selectio=
n;              /* for Master Mode Only */
+       u8                                         frame_rate_divider_contr=
ol;
+       u16                                        master_mode_serial_clock=
_rate;          /* for Master Mode Only */
+       u16                                        data_size;
+
+       enum mrst_ssp_txd_tristate_last_phase      tx_tristate_phase;
+       enum mrst_ssp_txd_tristate_enable          tx_tristate_enable;
+       enum mrst_ssp_slave_sspclk_free_running    slave_clk_free_running_s=
tatus;
+       enum mrst_ssp_sspsclk_direction            sspslclk_direction;
+       enum mrst_ssp_sspsfrm_direction            sspsfrm_direction;
+       enum mrst_ssp_rx_without_tx                ssp_duplex_mode;
+       enum mrst_trailing_byte_mode               ssp_trailing_byte_mode;
+       enum mrst_ssp_tx_dma_status                ssp_tx_dma;
+       enum mrst_ssp_rx_dma_status                ssp_rx_dma;
+       enum mrst_ssp_rx_timeout_int_status        ssp_rx_timeout_interrupt=
_status;
+       enum mrst_ssp_trailing_byte_int_status     ssp_trailing_byte_interr=
upt_status;
+       enum mrst_ssp_loopback_mode_status         ssp_loopback_mode_status;
+       u8                                         ssp_rx_fifo_threshold;
+       u8                                         ssp_tx_fifo_threshold;
+
+
+       enum mrst_ssp_frame_sync_relative_timing_bit  ssp_frmsync_timing_bi=
t;
+       enum mrst_ssp_frame_sync_polarity_bit      ssp_frmsync_pol_bit;
+       enum mrst_ssp_end_of_transfer_data_state   ssp_end_transfer_state;
+       enum mrst_ssp_clk_mode                     ssp_serial_clk_mode;
+       u8                                         ssp_psp_T1;
+       u8                                         ssp_psp_T2;
+       u8                                         ssp_psp_T4;   /* DMYSTOP=
 */
+       u8                                         ssp_psp_T5;   /* SFRMDLY=
 */
+       u8                                         ssp_psp_T6;   /* SFRMWDT=
H */
+
+       u8                                         ssp_active_tx_slots_map;
+       u8                                         ssp_active_rx_slots_map;
+};
+
+/*
+ *     Provided Interface
+ */
+
+
+struct intel_mid_i2s_hdl *intel_mid_i2s_open(enum intel_mid_i2s_ssp_usage =
usage, const struct intel_mid_i2s_settings *ps_settings);
+void  intel_mid_i2s_close(struct intel_mid_i2s_hdl *handle);
+
+int intel_mid_i2s_rd_req(struct intel_mid_i2s_hdl *handle, u32 *dst, size_=
t len, void *param);
+int intel_mid_i2s_wr_req(struct intel_mid_i2s_hdl *handle, u32 *src, size_=
t len, void *param);
+int intel_mid_i2s_enable_ssp(struct intel_mid_i2s_hdl *handle);
+
+
+int intel_mid_i2s_set_wr_cb(struct intel_mid_i2s_hdl *handle, int (*write_=
callback)(void *param));
+int intel_mid_i2s_set_rd_cb(struct intel_mid_i2s_hdl *handle, int (*read_c=
allback)(void *param));
+
+
+int intel_mid_i2s_get_tx_fifo_level(struct intel_mid_i2s_hdl *handle);
+int intel_mid_i2s_get_rx_fifo_level(struct intel_mid_i2s_hdl *handle);
+int intel_mid_i2s_flush(struct intel_mid_i2s_hdl *handle);
+
+#endif /*MID_I2S_EXTERNAL_H_*/
diff --git a/sound/pci/Kconfig b/sound/pci/Kconfig
index 12e3465..0b0a524 100644
--- a/sound/pci/Kconfig
+++ b/sound/pci/Kconfig
@@ -853,4 +853,22 @@ config SND_YMFPCI
          To compile this driver as a module, choose M here: the module
          will be called snd-ymfpci.

+config SND_INTEL_MID_I2S
+       tristate "Intel mid I2S hardware driver"
+       depends on EXPERIMENTAL && PCI && INTEL_MID_DMAC
+       default n
+       help
+         Say Y here if you want to build low level driver to support
+         sending/receving I2S audio samples on Intel MID SSP device.
+         This interface is mostly used on Intel MID platforms and provide
+         the low level interface for some upper layer drivers such as
+         Alsa SoC, char device interfaces... depending of peripheral conne=
cted.
+         PCI Header should have ADID field set to I2S BT_FM or
+         I2S MODEM to be used by this driver (so it know connected periphe=
ral).
+         Note this is a prototype driver and support for continuous
+         flow is still working-in-progress.
+         This driver can also be built as a module. If so, the module
+         will be called intel_mid_i2s.ko
+         If unsure, say N here.
+
 endif  # SND_PCI
diff --git a/sound/pci/Makefile b/sound/pci/Makefile
index 9cf4348..46613a2 100644
--- a/sound/pci/Makefile
+++ b/sound/pci/Makefile
@@ -78,4 +78,6 @@ obj-$(CONFIG_SND) +=3D \
        rme9652/ \
        trident/ \
        ymfpci/ \
-       vx222/
+       vx222/ \
+       intel_mid_i2s/
+
diff --git a/sound/pci/intel_mid_i2s/Makefile b/sound/pci/intel_mid_i2s/Mak=
efile
new file mode 100644
index 0000000..bebac1c
--- /dev/null
+++ b/sound/pci/intel_mid_i2s/Makefile
@@ -0,0 +1,18 @@
+# SSP audio driver
+# Copyright (c) 2010, Intel Corporation.
+
+# This program is free software; you can redistribute it and/or modify it
+# under the terms and conditions of the GNU General Public License,
+# version 2, as published by the Free Software Foundation.
+
+# This program is distributed in the hope it will be useful, but WITHOUT
+# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+# FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+# more details.
+
+# You should have received a copy of the GNU General Public License along =
with
+# this program; if not, write to the Free Software Foundation, Inc.,
+# 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+
+obj-$(CONFIG_SND_INTEL_MID_I2S)    +=3D  intel_mid_i2s.o
+
diff --git a/sound/pci/intel_mid_i2s/intel_mid_i2s.c b/sound/pci/intel_mid_=
i2s/intel_mid_i2s.c
new file mode 100644
index 0000000..572abde
--- /dev/null
+++ b/sound/pci/intel_mid_i2s/intel_mid_i2s.c
@@ -0,0 +1,1428 @@
+/*
+  * <Driver for I2S protocol on SSP (Moorestown and Medfield hardware)>
+  * Copyright (c) 2010, Intel Corporation.
+  * Louis LE GALL <louis.le.gall intel.com>
+  *
+  * This program is free software; you can redistribute it and/or modify it
+  * under the terms and conditions of the GNU General Public License,
+  * version 2, as published by the Free Software Foundation.
+  *
+  * This program is distributed in the hope it will be useful, but WITHOUT
+  * ANY WARRANTY; without evenp the implied warranty of MERCHANTABILITY or
+  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License =
for
+  * more details.
+  *
+  * You should have received a copy of the GNU General Public License alon=
g with
+  * this program; if not, write to the Free Software Foundation, Inc.,
+  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+  */
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/pm_runtime.h>
+#include <linux/pci_regs.h>
+#include <linux/wait.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+
+#include <linux/device.h>
+
+#include <linux/intel_mid_i2s_if.h>
+#include "intel_mid_i2s.h"
+
+MODULE_AUTHOR("Louis LE GALL <louis.le.gall intel.com>");
+MODULE_DESCRIPTION("Intel MID I2S/PCM SSP Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0.0");
+
+
+/*
+ * structures for pci probing
+ */
+static const struct dev_pm_ops intel_mid_i2s_pm_ops =3D {
+       .runtime_suspend =3D intel_mid_i2s_runtime_suspend,
+       .runtime_resume =3D intel_mid_i2s_runtime_resume,
+};
+static DEFINE_PCI_DEVICE_TABLE(pci_ids) =3D {
+       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, MFLD_SSP1_DEVICE_ID) },
+       { PCI_DEVICE(PCI_VENDOR_ID_INTEL, MFLD_SSP0_DEVICE_ID) },
+       { 0, }, /* terminate list */
+};
+static struct pci_driver intel_mid_i2s_driver =3D {
+       .driver =3D {
+               .pm =3D &intel_mid_i2s_pm_ops,
+       },
+       .name =3D DRIVER_NAME,
+       .id_table =3D pci_ids,
+       .probe =3D intel_mid_i2s_probe,
+       .remove =3D __devexit_p(intel_mid_i2s_remove),
+#ifdef CONFIG_PM
+       .suspend =3D intel_mid_i2s_driver_suspend,
+       .resume =3D intel_mid_i2s_driver_resume,
+#endif
+};
+
+
+/*
+ * POWER MANAGEMENT FUNCTIONS
+ */
+
+#ifdef CONFIG_PM
+/**
+ * intel_mid_i2s_driver_suspend - driver power management suspend activity
+ * @device_ptr : pointer of the device to resume
+ *
+ * Output parameters
+ *      error : 0 means no error
+ */
+static int  intel_mid_i2s_driver_suspend(struct pci_dev *dev, pm_message_t=
 state)
+{
+       struct intel_mid_i2s_hdl *drv_data =3D pci_get_drvdata(dev);
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return 0;
+       dev_dbg(&drv_data->pdev->dev, "SUSPEND SSP ID %d\n", drv_data->pdev=
->device);
+       pci_save_state(dev);
+       pci_disable_device(dev);
+       pci_set_power_state(dev, PCI_D3hot);
+       return 0;
+}
+
+/**
+ * intel_mid_i2s_driver_resume - driver power management suspend activity
+ * @device_ptr : pointer of the device to resume
+ *
+ * Output parameters
+ *      error : 0 means no error
+ */
+static int intel_mid_i2s_driver_resume(struct pci_dev *dev)
+{
+       int err;
+       int ret =3D 0;
+       struct intel_mid_i2s_hdl *drv_data =3D pci_get_drvdata(dev);
+
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return -EFAULT;
+       dev_dbg(&drv_data->pdev->dev, "RESUME SSP ID %d\n", drv_data->pdev-=
>device);
+
+       err =3D pci_enable_device(dev);
+       if (err)
+               dev_err(&drv_data->pdev->dev, "Unable to re-enable device, =
trying to continue.\n");
+       dev_dbg(&drv_data->pdev->dev, "resuming\n");
+       pci_set_power_state(dev, PCI_D0);
+       pci_restore_state(dev);
+       ret =3D pci_enable_device(dev);
+       if (ret)
+               dev_err(&drv_data->pdev->dev, "I2S: device can't be enabled=
");
+       dev_dbg(&drv_data->pdev->dev, "resumed in D3\n");
+       return ret;
+}
+
+/**
+ * intel_mid_i2s_runtime_suspend - runtime power management suspend activi=
ty
+ * @device_ptr : pointer of the device to resume
+ *
+ * Output parameters
+ *      error : 0 means no error
+ */
+static int intel_mid_i2s_runtime_suspend(struct device *device_ptr)
+{
+       struct pci_dev *pdev;
+       struct intel_mid_i2s_hdl *drv_data;
+       void __iomem *reg;
+
+       pdev =3D to_pci_dev(device_ptr);
+       WARN(!pdev, "Pci dev=3DNULL\n");
+       if (!pdev)
+               return -EFAULT;
+       drv_data =3D (struct intel_mid_i2s_hdl *) pci_get_drvdata(pdev);
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return -EFAULT;
+       if (test_bit(I2S_PORT_OPENED, &drv_data->flags)) {
+               dev_err(device_ptr, "Trying to suspend a device that is ope=
ned\n");
+               return -ENODEV;
+       }
+       reg =3D drv_data->ioaddr;
+       dev_dbg(&drv_data->pdev->dev, "Suspend of SSP requested !!\n");
+       return intel_mid_i2s_driver_suspend(to_pci_dev(device_ptr), PMSG_SU=
SPEND);
+}
+#endif
+
+/**
+ * intel_mid_i2s_runtime_resume - runtime power management resume activity
+ * @device_ptr : pointer of the device to resume
+ *
+ * Output parameters
+ *      error : 0 means no error
+ */
+static int intel_mid_i2s_runtime_resume(struct device *device_ptr)
+{
+       struct pci_dev *pdev;
+       struct intel_mid_i2s_hdl *drv_data;
+       pdev =3D to_pci_dev(device_ptr);
+       WARN(!pdev, "Pci dev=3DNULL\n");
+       if (!pdev)
+               return -EFAULT;
+       drv_data =3D (struct intel_mid_i2s_hdl *) pci_get_drvdata(pdev);
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return -EFAULT;
+       dev_dbg(&drv_data->pdev->dev, "RT RESUME SSP ID\n");
+       return intel_mid_i2s_driver_resume(to_pci_dev(device_ptr));
+}
+
+/*
+ * INTERFACE FUNCTIONS
+ */
+
+/**
+ * intel_mid_i2s_flush - This is the I2S flush request
+ * @drv_data : pointer on private i2s driver data (by i2s_open function)
+ *
+ * It will flush the TX FIFO
+ * WARNING: this function is used in a Burst Mode context where it is call=
ed
+ * between Bursts i.e. when there is no FMSYNC, no transfer ongoing at
+ * that time
+ * If you need a flush while SSP configured in I2S is BUSY and FMSYNC are
+ * generated, you have to write another function
+ * (loop on BUSY bit and do not limit the flush to at most 16 samples)
+ *
+ * Output parameters
+ *      int : number of samples flushed
+ */
+int intel_mid_i2s_flush(struct intel_mid_i2s_hdl *drv_data)
+{
+       u32 sssr, data;
+       u32 num =3D 0;
+       void __iomem *reg;
+
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return 0;
+       reg =3D drv_data->ioaddr;
+       sssr =3D read_SSSR(reg);
+       dev_dbg(&drv_data->pdev->dev, "in flush sssr=3D0x%08X\n", sssr);
+       /*
+        * Flush "by hand" was generating spurious DMA SERV REQUEST
+        * from SSP to DMA =3D> then buggy retrieval of data for next dma_r=
eq
+        * Disable: RX Service Request from RX fifo to DMA
+        * as we will flush by hand
+        */
+       clear_SSCR1_reg(reg, RSRE);
+       /* i2s_flush is called in between 2 bursts
+        * =3D> no FMSYNC at that time (i.e. SSP not busy)
+        * =3D> at most 16 samples in the FIFO */
+       while ((read_SSSR(reg) & (SSSR_RNE_MASK<<SSSR_RNE_SHIFT))
+                       && (num < FIFO_SIZE)) {
+               data =3D read_SSDR(reg);
+               num++;
+               dev_warn(&drv_data->pdev->dev, "flush(%u)=3D%u\n", num, dat=
a);
+       }
+       /* Enable: RX Service Request from RX fifo to DMA
+        * as flush by hand is done
+        */
+       set_SSCR1_reg(reg, RSRE);
+       sssr =3D read_SSSR(reg);
+       dev_dbg(&drv_data->pdev->dev, "out flush sssr=3D0x%08X\n", sssr);
+       return num;
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_flush);
+
+/**
+ * intel_mid_i2s_get_rx_fifo_level - returns I2S rx fifo level
+ * @drv_data : pointer on private i2s driver data (by i2s_open function)
+ *
+ * Output parameters
+ *      int : Number of samples currently in the RX FIFO (negative =3D err=
or)
+ */
+int intel_mid_i2s_get_rx_fifo_level(struct intel_mid_i2s_hdl *drv_data)
+{
+       u32 sssr;
+       u32 rne, rfl;
+       void __iomem *reg;
+
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return -EFAULT;
+       reg =3D drv_data->ioaddr;
+       sssr =3D read_SSSR(reg);
+       rfl =3D GET_SSSR_val(sssr, RFL);
+       rne =3D GET_SSSR_val(sssr, RNE);
+       if (!rne)
+               return 0;
+       else
+               return rfl+1;
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_get_rx_fifo_level);
+
+/**
+ * intel_mid_i2s_get_tx_fifo_level - returns I2S tx fifo level
+ * @drv_data : pointer on private i2s driver data (by i2s_open function)
+ *
+ * Output parameters
+ *      int : number of samples currently in the TX FIFO (negative =3D err=
or)
+ */
+int intel_mid_i2s_get_tx_fifo_level(struct intel_mid_i2s_hdl *drv_data)
+{
+       u32 sssr;
+       u32 tnf, tfl;
+       void __iomem *reg;
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return -EFAULT;
+       reg =3D drv_data->ioaddr;
+       sssr =3D read_SSSR(reg);
+       tfl =3D GET_SSSR_val(sssr, TFL);
+       tnf =3D GET_SSSR_val(sssr, TFN);
+       if (!tnf)
+               return 16;
+       else
+               return tfl;
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_get_tx_fifo_level);
+
+/**
+ * intel_mid_i2s_set_rd_cb - set the callback function after read is done
+ * @drv_data : handle of corresponding ssp i2s (given by i2s_open function)
+ * @read_callback : pointer of callback function
+ *
+ * Output parameters
+ *      error : 0 means no error
+ */
+int intel_mid_i2s_set_rd_cb(struct intel_mid_i2s_hdl *drv_data, int (*read=
_callback)(void *param))
+{
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return -EFAULT;
+       mutex_lock(&drv_data->mutex);
+       if (!test_bit(I2S_PORT_OPENED, &drv_data->flags)) {
+               dev_WARN(&drv_data->pdev->dev, "set WR CB I2S_PORT NOT_OPEN=
ED");
+               mutex_unlock(&drv_data->mutex);
+               return -EPERM;
+       }
+       /* Do not change read parameters in the middle of a READ request */
+       if (test_bit(I2S_PORT_READ_BUSY, &drv_data->flags)) {
+               dev_WARN(&drv_data->pdev->dev, "CB reject I2S_PORT_READ_BUS=
Y");
+               mutex_unlock(&drv_data->mutex);
+               return -EBUSY;
+       }
+       drv_data->read_callback =3D read_callback;
+       drv_data->read_len =3D 0;
+       mutex_unlock(&drv_data->mutex);
+       return 0;
+
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_set_rd_cb);
+
+/**
+ * intel_mid_i2s_set_wr_cb - set the callback function after write is done
+ * @drv_data : handle of corresponding ssp i2s (given by i2s_open  functio=
n)
+ * @write_callback : pointer of callback function
+ *
+ * Output parameters
+ *      error : 0 means no error
+ */
+int intel_mid_i2s_set_wr_cb(struct intel_mid_i2s_hdl *drv_data, int (*writ=
e_callback)(void *param))
+{
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return -EFAULT;
+       mutex_lock(&drv_data->mutex);
+       if (!test_bit(I2S_PORT_OPENED, &drv_data->flags)) {
+               dev_warn(&drv_data->pdev->dev, "set WR CB I2S_PORT NOT_OPEN=
ED");
+               mutex_unlock(&drv_data->mutex);
+               return -EPERM;
+       }
+       /* Do not change write parameters in the middle of a WRITE request =
*/
+       if (test_bit(I2S_PORT_WRITE_BUSY, &drv_data->flags)) {
+               dev_warn(&drv_data->pdev->dev, "CB reject I2S_PORT_WRITE_BU=
SY");
+               mutex_unlock(&drv_data->mutex);
+               return -EBUSY;
+       }
+       drv_data->write_callback =3D write_callback;
+       drv_data->write_len =3D 0;
+       mutex_unlock(&drv_data->mutex);
+       return 0;
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_set_wr_cb);
+
+/**
+ * intel_mid_i2s_enable_ssp() : start the ssp right after the read/write r=
eq
+ * @drv_data : handle of corresponding ssp i2s (given by i2s_open function)
+ *
+ * This enable the read/write to be started synchronously
+ *
+ * Output parameters
+ *      error : 0 means no error
+ */
+int intel_mid_i2s_enable_ssp(struct intel_mid_i2s_hdl *drv_data)
+{
+       void __iomem *reg =3D drv_data->ioaddr;
+       set_SSCR0_reg(reg, SSE);
+       return 0;
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_enable_ssp);
+
+/**
+ * intel_mid_i2s_rd_req - request a read from i2s peripheral
+ * @drv_data : handle of corresponding ssp i2s (given by i2s_open function)
+ * @dst : destination buffer where the read sample should be put
+ * @len : number of sample to be read (160 samples only right now)
+ * @param : private context parameter to give back to read callback
+ *
+ * Output parameters
+ *      error : 0 means no error
+ */
+int intel_mid_i2s_rd_req(struct intel_mid_i2s_hdl *drv_data, u32 *destinat=
ion, size_t len, void *param)
+{
+       struct dma_async_tx_descriptor *rxdesc =3D NULL;
+       struct dma_chan *rxchan =3D drv_data->rxchan;
+       enum dma_ctrl_flags flag;
+       dma_addr_t ssdr_addr;
+       dma_addr_t dst;
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return -EFAULT;
+       mutex_lock(&drv_data->mutex);
+       if (!rxchan) {
+               dev_WARN(&(drv_data->pdev->dev), "rd_req FAILED no rxchan\n=
");
+               mutex_unlock(&drv_data->mutex);
+               return -EINVAL;
+       }
+       if (!len) {
+               dev_WARN(&drv_data->pdev->dev, "rd req invalid len=3D0");
+               mutex_unlock(&drv_data->mutex);
+               return -EINVAL;
+       }
+       if (!test_bit(I2S_PORT_OPENED, &drv_data->flags)) {
+               dev_WARN(&drv_data->pdev->dev, "RD reject I2S_PORT NOT_OPEN=
ED");
+               mutex_unlock(&drv_data->mutex);
+               return -EPERM;
+       }
+       if (test_bit(I2S_PORT_CLOSING, &drv_data->flags)) {
+               dev_WARN(&drv_data->pdev->dev, "RD reject I2S_PORT CLOSING"=
);
+               mutex_unlock(&drv_data->mutex);
+               return -EPIPE;
+       }
+
+       dev_dbg(&drv_data->pdev->dev, "I2S_READ() dst=3D%p, len=3D%d, drv_d=
ata=3D%p", destination, len, drv_data);
+       dst =3D dma_map_single(NULL, destination, len, DMA_FROM_DEVICE);
+       if (!dst) {
+               dev_WARN(&drv_data->pdev->dev, "can't map DMA address %p", =
destination);
+               mutex_unlock(&drv_data->mutex);
+               return -ENOMEM;
+       }
+
+       drv_data->read_dst =3D dst;
+       drv_data->read_len =3D len;
+       /* get Data Read/Write address */
+       ssdr_addr =3D (drv_data->paddr + OFFSET_SSDR);
+       set_SSCR1_reg((drv_data->ioaddr), RSRE);
+       change_SSCR0_reg((drv_data->ioaddr), RIM,
+                        ((drv_data->current_settings).rx_fifo_interrupt));
+       flag =3D DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+       /* Start the RX dma transfer */
+       rxdesc =3D rxchan->device->device_prep_dma_memcpy(
+                       rxchan,         /* DMA Channel */
+                       dst,            /* DAR */
+                       ssdr_addr,      /* SAR */
+                       len,            /* Data Length */
+                       flag);          /* Flag */
+       if (!rxdesc) {
+               dev_WARN(&drv_data->pdev->dev, "can not prep dma memcpy");
+               mutex_unlock(&drv_data->mutex);
+               return -EFAULT;
+       }
+       /* Only 1 READ at a time allowed. do it at end to avoid clear&wakeu=
p*/
+       if (test_and_set_bit(I2S_PORT_READ_BUSY, &drv_data->flags)) {
+               dma_unmap_single(NULL, dst, len, DMA_FROM_DEVICE);
+               dev_WARN(&drv_data->pdev->dev, "RD reject I2S_PORT READ_BUS=
Y");
+               mutex_unlock(&drv_data->mutex);
+               return -EBUSY;
+       }
+       dev_dbg(&(drv_data->pdev->dev), "RD dma tx submit\n");
+       rxdesc->callback =3D i2s_read_done;
+       drv_data->read_param =3D param;
+       rxdesc->callback_param =3D drv_data;
+       rxdesc->tx_submit(rxdesc);
+       mutex_unlock(&drv_data->mutex);
+       return 0;
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_rd_req);
+
+/**
+ * intel_mid_i2s_wr_req - request a write to i2s peripheral
+ * @drv_data : handle of corresponding ssp i2s (given by i2s_open function)
+ * @src : source buffer where the samples to wrote should be get
+ * @len : number of sample to be read (160 samples only right now)
+ * @param : private context parameter to give back to write callback
+ *
+ * Output parameters
+ *      error : 0 means no error
+ */
+int intel_mid_i2s_wr_req(struct intel_mid_i2s_hdl *drv_data, u32 *source, =
size_t len, void *param)
+{
+       dma_addr_t ssdr_addr;
+       struct dma_async_tx_descriptor *txdesc =3D NULL;
+       struct dma_chan *txchan =3D drv_data->txchan;
+       enum dma_ctrl_flags flag;
+       dma_addr_t src;
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return -EFAULT;
+       mutex_lock(&drv_data->mutex);
+       if (!txchan) {
+               dev_WARN(&(drv_data->pdev->dev), "wr_req but no txchan\n");
+               mutex_unlock(&drv_data->mutex);
+               return -EINVAL;
+       }
+       if (!len) {
+               dev_WARN(&drv_data->pdev->dev, "invalid len 0");
+               mutex_unlock(&drv_data->mutex);
+               return -EINVAL;
+       }
+       if (!test_bit(I2S_PORT_OPENED, &drv_data->flags)) {
+               dev_WARN(&drv_data->pdev->dev, "WR reject I2S_PORT NOT_OPEN=
ED");
+               mutex_unlock(&drv_data->mutex);
+               return -EPERM;
+       }
+       if (test_bit(I2S_PORT_CLOSING, &drv_data->flags)) {
+               dev_WARN(&drv_data->pdev->dev, "WR reject I2S_PORT CLOSING"=
);
+               mutex_unlock(&drv_data->mutex);
+               return -EPIPE;
+       }
+
+       dev_dbg(&drv_data->pdev->dev, "I2S_WRITE() src=3D%p, len=3D%d, drv_=
data=3D%p", source, len, drv_data);
+
+       src =3D dma_map_single(NULL, source, len, DMA_TO_DEVICE);
+       if (!src) {
+               dev_WARN(&drv_data->pdev->dev, "can't map DMA address %p", =
source);
+               mutex_unlock(&drv_data->mutex);
+               return -EFAULT;
+       }
+       drv_data->write_src =3D src;
+       drv_data->write_len =3D len;
+       /* get Data Read/Write address */
+       ssdr_addr =3D (dma_addr_t)(u32)(drv_data->paddr + OFFSET_SSDR);
+       set_SSCR1_reg((drv_data->ioaddr), TSRE);
+       change_SSCR0_reg((drv_data->ioaddr), TIM,
+                        ((drv_data->current_settings).tx_fifo_interrupt));
+       flag =3D DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
+       txdesc =3D txchan->device->device_prep_dma_memcpy(
+                       txchan,         /* DMA Channel */
+                       ssdr_addr,      /* DAR */
+                       src,            /* SAR */
+                       len,            /* Data Length */
+                       flag);          /* Flag */
+       if (!txdesc) {
+               dev_WARN(&(drv_data->pdev->dev),
+                       "wr_req dma memcpy FAILED(src=3D%08x,len=3D%d,txcha=
n=3D%p)\n",
+                       src, len, txchan);
+               mutex_unlock(&drv_data->mutex);
+               return -1;
+       }
+       dev_dbg(&(drv_data->pdev->dev), "WR dma tx summit\n");
+       /* Only 1 WRITE at a time allowed */
+       if (test_and_set_bit(I2S_PORT_WRITE_BUSY, &drv_data->flags)) {
+               dma_unmap_single(NULL, src, len, DMA_TO_DEVICE);
+               dev_WARN(&drv_data->pdev->dev, "WR reject I2S_PORT WRITE_BU=
SY");
+               mutex_unlock(&drv_data->mutex);
+               return -EBUSY;
+       }
+       txdesc->callback =3D i2s_write_done;
+       drv_data->write_param =3D param;
+       txdesc->callback_param =3D drv_data;
+       txdesc->tx_submit(txdesc);
+       dev_dbg(&(drv_data->pdev->dev), "wr dma req programmed\n");
+       mutex_unlock(&drv_data->mutex);
+       return 0;
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_wr_req);
+
+/**
+ * intel_mid_i2s_open - reserve and start a SSP depending of it's usage
+ * @usage : select which ssp i2s you need by giving usage (BT,MODEM...)
+ * @ps_settings : hardware settings to configure the SSP module
+ *
+ * May sleep (driver_find_device) : no lock permitted when called.
+ *
+ * Output parameters
+ *      handle : handle of the selected SSP, or NULL if not found
+ */
+struct intel_mid_i2s_hdl *intel_mid_i2s_open(enum intel_mid_i2s_ssp_usage =
usage,
+                        const struct intel_mid_i2s_settings *ps_settings)
+{
+       struct pci_dev *pdev;
+       struct intel_mid_i2s_hdl *drv_data =3D NULL;
+       struct device *found_device =3D NULL;
+       pr_debug("%s : open called,searching for device with usage=3D%x !\n=
", DRIVER_NAME, usage);
+       found_device =3D driver_find_device(&(intel_mid_i2s_driver.driver),=
 NULL, &usage, check_device);
+       if (!found_device) {
+               pr_debug("%s : open can not found with usage=3D0x%02X\n", D=
RIVER_NAME, (int)usage);
+               return NULL;
+       }
+       pdev =3D to_pci_dev(found_device);
+       drv_data =3D pci_get_drvdata(pdev);
+
+       if (!drv_data) {
+               dev_err(found_device, "no drv_data in open pdev=3D%p\n", pd=
ev);
+               put_device(found_device);
+               return NULL;
+       }
+       mutex_lock(&drv_data->mutex);
+       dev_dbg(found_device, "Open found pdevice=3D0x%p\n", pdev);
+       /* pm_runtime */
+       pm_runtime_get_sync(&drv_data->pdev->dev);
+       /* dmac1 is already set during probe */
+       if (i2s_dma_start(drv_data) !=3D 0) {
+               dev_err(found_device, "Can not start DMA\n");
+               goto open_error;
+       }
+       /* if we restart after stop without suspend, we start ssp faster */
+       drv_data->current_settings =3D *ps_settings;
+       set_ssp_i2s_hw(drv_data, ps_settings);
+
+       drv_data->mask_sr =3D ((SSSR_BCE_MASK << SSSR_BCE_SHIFT) |
+                       (SSSR_EOC_MASK << SSSR_EOC_SHIFT) |
+                       (SSSR_ROR_MASK << SSSR_ROR_SHIFT) |
+                       (SSSR_TUR_MASK << SSSR_TUR_SHIFT) |
+                       (SSSR_TINT_MASK << SSSR_TINT_SHIFT) |
+                       (SSSR_PINT_MASK << SSSR_PINT_SHIFT));
+       if (test_bit(I2S_PORT_CLOSING, &drv_data->flags)) {
+               dev_err(&drv_data->pdev->dev, "Opening a closing I2S!");
+               goto open_error;
+       }
+       /* there is no need to "wake up" as we can not close an opening i2s=
 */
+       clear_bit(I2S_PORT_WRITE_BUSY, &drv_data->flags);
+       clear_bit(I2S_PORT_READ_BUSY, &drv_data->flags);
+       mutex_unlock(&drv_data->mutex);
+       return drv_data;
+
+open_error:
+       put_device(found_device);
+       mutex_unlock(&drv_data->mutex);
+       return NULL;
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_open);
+
+/**
+ * intel_mid_i2s_close - release and stop the SSP
+ * @drv_data : handle of corresponding ssp i2s (given by i2s_open function)
+ *
+ * WARNING: This is not -yet- allowed to call close from a read/write call=
back !
+ *
+ * Output parameters
+ *      none
+ */
+void intel_mid_i2s_close(struct intel_mid_i2s_hdl *drv_data)
+{
+       void __iomem *reg;
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return;
+       mutex_lock(&drv_data->mutex);
+       if (!test_bit(I2S_PORT_OPENED, &drv_data->flags)) {
+               dev_err(&drv_data->pdev->dev, "not opened but closing?");
+               mutex_unlock(&drv_data->mutex);
+               return;
+       }
+       /* to be modified to wait_event_interruptible_timeout */
+       set_bit(I2S_PORT_CLOSING, &drv_data->flags);
+       dev_dbg(&drv_data->pdev->dev, "Status bit pending write=3D%d read=
=3D%d\n",
+                       test_bit(I2S_PORT_WRITE_BUSY, &drv_data->flags),
+                       test_bit(I2S_PORT_READ_BUSY, &drv_data->flags));
+       if (test_bit(I2S_PORT_WRITE_BUSY, &drv_data->flags) ||
+            test_bit(I2S_PORT_READ_BUSY, &drv_data->flags)) {
+               dev_dbg(&drv_data->pdev->dev, "Pending callback in close...=
\n");
+       }
+
+       /* waiting below. To be replaced when "DMA_TERMINATE_ALL" fix avail=
able */
+       wait_event(drv_data->wq_chan_closing,
+               ((!test_bit(I2S_PORT_WRITE_BUSY, &drv_data->flags)) &&
+                (!test_bit(I2S_PORT_READ_BUSY,  &drv_data->flags))));
+       /* release DMA Channel.. */
+       i2s_dma_stop(drv_data);
+       reg =3D drv_data->ioaddr;
+       dev_dbg(&drv_data->pdev->dev, "Stopping the SSP\n");
+       i2s_ssp_stop(drv_data);
+       put_device(&drv_data->pdev->dev);
+       write_SSCR0(0, reg);
+       /* pm runtime */
+       pm_runtime_put(&drv_data->pdev->dev);
+       dev_dbg(&(drv_data->pdev->dev), "SSP Stopped.\n");
+       clear_bit(I2S_PORT_CLOSING, &drv_data->flags);
+       clear_bit(I2S_PORT_OPENED, &drv_data->flags);
+       mutex_unlock(&drv_data->mutex);
+}
+EXPORT_SYMBOL_GPL(intel_mid_i2s_close);
+/*
+ * INTERNAL FUNCTIONS
+ */
+
+/**
+ * check_device -  return if the device is the usage we want (usage =3D*da=
ta)
+ * @device_ptr : pointer on device struct
+ * @data : pointer pointer on usage we are looking for
+ *
+ * this is called for each device by find_device() from intel_mid_i2s_open=
()
+ * Info : when found, the flag of driver is set to I2S_PORT_OPENED
+ *
+ * Output parameters
+ *      integer : return 0 means not the device or already started. go next
+ *               return !=3D 0 means stop the search and return this device
+ */
+static int
+check_device(struct device *device_ptr, void *data)
+{
+       struct pci_dev *pdev;
+       struct intel_mid_i2s_hdl *drv_data;
+       enum intel_mid_i2s_ssp_usage usage;
+       enum intel_mid_i2s_ssp_usage usage_to_find;
+
+       pdev =3D to_pci_dev(device_ptr);
+       WARN(!pdev, "Pci device=3DNULL\n");
+       if (!pdev)
+               return 0;
+       drv_data =3D (struct intel_mid_i2s_hdl *) pci_get_drvdata(pdev);
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return 0;
+       dev_dbg(&(pdev->dev), "Check device pci_dev ptr =3D 0X%p\n", pdev);
+       usage_to_find =3D *((enum intel_mid_i2s_ssp_usage *) data);
+       usage =3D drv_data->usage;
+
+       /* Can be done in one "if" but separated in purpose : take care of
+        * test_and_set_bit that need to be done AFTER the check on usage.
+        */
+       if (usage =3D=3D usage_to_find) {
+               if (!test_and_set_bit(I2S_PORT_OPENED, &drv_data->flags))
+                       return 1;  /* Already opened, do not use this resul=
t */
+       };
+       return 0; /* not usage we look for, or already opened */
+}
+
+/**
+ * i2s_read_done - callback from the _dma tasklet_ after read
+ * @arg : void pointer to that should be driver data (context)
+ *
+ * Output parameters
+ *      none
+ */
+static void i2s_read_done(void *arg)
+{
+       int status =3D 0;
+
+       struct intel_mid_i2s_hdl *drv_data =3D arg;
+       void *param_complete;
+       void __iomem *reg ;
+
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return;
+       mutex_lock(&drv_data->mutex);
+       if (!test_bit(I2S_PORT_READ_BUSY, &drv_data->flags))
+               dev_WARN(&drv_data->pdev->dev, "spurious read dma complete"=
);
+
+       dma_unmap_single(NULL, drv_data->read_dst,
+                        drv_data->read_len, DMA_FROM_DEVICE);
+       drv_data->read_len =3D 0;
+       reg =3D drv_data->ioaddr;
+       /* Rx fifo overrun Interrupt */
+       change_SSCR0_reg(reg, RIM, SSP_RX_FIFO_OVER_INT_DISABLE);
+       param_complete =3D drv_data->read_param;
+       /* Do not change order sequence:
+        * READ_BUSY clear, then test PORT_CLOSING
+        * wakeup for close() function
+        */
+       clear_bit(I2S_PORT_READ_BUSY, &drv_data->flags);
+       wake_up(&drv_data->wq_chan_closing);
+       if (test_bit(I2S_PORT_CLOSING, &drv_data->flags)) {
+               dev_dbg(&drv_data->pdev->dev, "read done waking up close");
+               mutex_unlock(&drv_data->mutex);
+               return;
+       }
+       mutex_unlock(&drv_data->mutex);
+       if (drv_data->read_callback !=3D NULL)
+               status =3D drv_data->read_callback(param_complete);
+       else
+               dev_warn(&drv_data->pdev->dev, "RD done but not callback se=
t");
+
+}
+
+/**
+ * i2s_write_done() : callback from the _dma tasklet_ after write
+ * @arg : void pointer to that should be driver data (context)
+ *
+ * Output parameters
+ *      none
+ */
+static void i2s_write_done(void *arg)
+{
+       int status =3D 0;
+       void *param_complete;
+       struct intel_mid_i2s_hdl *drv_data =3D arg;
+       void __iomem *reg ;
+
+       WARN(!drv_data, "Driver data=3DNULL\n");
+       if (!drv_data)
+               return;
+       mutex_lock(&drv_data->mutex);
+       if (!test_bit(I2S_PORT_WRITE_BUSY, &drv_data->flags))
+               dev_warn(&drv_data->pdev->dev, "spurious write dma complete=
");
+       dma_unmap_single(NULL, drv_data->read_dst,
+                        drv_data->read_len, DMA_TO_DEVICE);
+       drv_data->read_len =3D 0;
+       reg =3D drv_data->ioaddr;
+       change_SSCR0_reg(reg, TIM, SSP_TX_FIFO_UNDER_INT_DISABLE);
+       dev_dbg(&(drv_data->pdev->dev), "DMA channel disable..\n");
+       param_complete =3D drv_data->write_param;
+       /* Do not change order sequence:
+        * WRITE_BUSY clear, then test PORT_CLOSING
+        * wakeup for close() function
+        */
+       clear_bit(I2S_PORT_WRITE_BUSY, &drv_data->flags);
+       wake_up(&drv_data->wq_chan_closing);
+       if (test_bit(I2S_PORT_CLOSING, &drv_data->flags)) {
+               mutex_unlock(&drv_data->mutex);
+               dev_dbg(&drv_data->pdev->dev, "write done waking up close");
+               return;
+       }
+       mutex_unlock(&drv_data->mutex);
+       if (drv_data->write_callback !=3D NULL)
+               status =3D drv_data->write_callback(param_complete);
+       else
+               dev_warn(&drv_data->pdev->dev, "WR done but no callback set=
");
+}
+
+static bool chan_filter(struct dma_chan *chan, void *param)
+{
+       struct intel_mid_i2s_hdl *drv_data =3D (struct intel_mid_i2s_hdl *)=
param;
+       bool ret =3D false;
+
+       if (!drv_data->dmac1)
+               goto out;
+       if (chan->device->dev =3D=3D &drv_data->dmac1->dev)
+               ret =3D true;
+out:
+       return ret;
+}
+
+/**
+ * i2s_dma_start - prepare and reserve dma channels
+ * @arg : intel_mid_i2s_hdl pointer to that should be driver data (context)
+ *
+ * "ssp open" context and dmac1 should already be filled in drv_data
+ *
+ * Output parameters
+ *      int : should be zero, else it means error code
+ */
+static int i2s_dma_start(struct intel_mid_i2s_hdl *drv_data)
+{
+       struct intel_mid_dma_slave *rxs, *txs;
+       dma_cap_mask_t mask;
+       int retval =3D 0;
+       struct pci_dev *l_pdev;
+
+       dev_dbg(&drv_data->pdev->dev, "DMAC1 start\n");
+       drv_data->txchan =3D NULL;
+       drv_data->rxchan =3D NULL;
+       l_pdev =3D drv_data->pdev;
+       /* 1. init rx channel */
+       rxs =3D &drv_data->dmas_rx;
+       rxs->dirn =3D DMA_FROM_DEVICE;
+       rxs->hs_mode =3D LNW_DMA_HW_HS;
+       rxs->cfg_mode =3D LNW_DMA_PER_TO_MEM;
+       rxs->src_width =3D LNW_DMA_WIDTH_16BIT;
+       rxs->dst_width =3D LNW_DMA_WIDTH_32BIT;
+       rxs->src_msize =3D LNW_DMA_MSIZE_8;
+       rxs->dst_msize =3D LNW_DMA_MSIZE_8;
+       rxs->device_instance =3D drv_data->device_instance;
+       dma_cap_zero(mask);
+       dma_cap_set(DMA_MEMCPY, mask);
+       dma_cap_set(DMA_SLAVE, mask);
+       drv_data->rxchan =3D dma_request_channel(mask, chan_filter, drv_dat=
a);
+       if (!drv_data->rxchan) {
+               dev_err(&(drv_data->pdev->dev),
+                       "Could not get Rx channel\n");
+               retval =3D -2;
+               goto err_exit;
+       }
+       drv_data->rxchan->private =3D rxs;
+       /* 2. init tx channel */
+       txs =3D &drv_data->dmas_tx;
+       txs->dirn =3D DMA_TO_DEVICE;
+       txs->hs_mode =3D LNW_DMA_HW_HS;
+       txs->cfg_mode =3D LNW_DMA_MEM_TO_PER;
+       txs->src_width =3D LNW_DMA_WIDTH_32BIT;
+       txs->dst_width =3D LNW_DMA_WIDTH_16BIT;
+       txs->src_msize =3D LNW_DMA_MSIZE_8;
+       txs->dst_msize =3D LNW_DMA_MSIZE_8;
+       txs->device_instance =3D drv_data->device_instance;
+       dma_cap_set(DMA_SLAVE, mask);
+       dma_cap_set(DMA_MEMCPY, mask);
+       drv_data->txchan =3D dma_request_channel(mask, chan_filter, drv_dat=
a);
+       if (!drv_data->txchan) {
+               dev_err(&(drv_data->pdev->dev),
+                       "Could not get Tx channel\n");
+               retval =3D -3;
+               goto free_rxchan;
+       }
+       drv_data->txchan->private =3D txs;
+       return retval;
+free_rxchan:
+       dma_release_channel(drv_data->rxchan);
+err_exit:
+       return retval;
+}
+
+/**
+ * i2s_dma_stop - release dma channels
+ * @arg : struct intel_mid_i2s_hdl pointer to that should be driver data (=
context)
+ *
+ * called by intel_mid_i2s_close() context
+ *
+ * Output parameters
+ *      none
+ */
+static void i2s_dma_stop(struct intel_mid_i2s_hdl *drv_data)
+{
+       dev_dbg(&drv_data->pdev->dev, "DMAC1 stop\n");
+       dma_release_channel(drv_data->txchan);
+       dma_release_channel(drv_data->rxchan);
+}
+
+static void i2s_ssp_stop(struct intel_mid_i2s_hdl *drv_data)
+{
+       void __iomem *reg =3D drv_data->ioaddr;
+       dev_dbg(&drv_data->pdev->dev, "Stop SSP\n");
+       clear_SSCR0_reg(reg, SSE);
+}
+
+static void ssp1_dump_registers(struct intel_mid_i2s_hdl *drv_data)
+{
+       u32 irq_status;
+       void __iomem *reg =3D drv_data->ioaddr;
+       struct device *ddbg =3D &(drv_data->pdev->dev);
+       u32 status;
+       irq_status =3D read_SSSR(reg);
+       dev_dbg(ddbg, "dump SSSR=3D0x%08X\n", irq_status);
+       status =3D read_SSCR0(reg);
+       dev_dbg(ddbg, "dump SSCR0=3D0x%08X\n", status);
+       status =3D read_SSCR1(reg);
+       dev_dbg(ddbg, "dump SSCR1=3D0x%08X\n", status);
+       status =3D read_SSPSP(reg);
+       dev_dbg(ddbg, "dump SSPSP=3D0x%08X\n", status);
+       status =3D read_SSTSA(reg);
+       dev_dbg(ddbg, "dump SSTSA=3D0x%08X\n", status);
+       status =3D read_SSRSA(reg);
+       dev_dbg(ddbg, "dump SSRSA=3D0x%08X\n", status);
+       status =3D read_SSTO(reg);
+       dev_dbg(ddbg, "dump SSTO=3D0x%08X\n", status);
+       status =3D read_SSITR(reg);
+       dev_dbg(ddbg, "dump SSITR=3D0x%08X\n", status);
+       status =3D read_SSTSS(reg);
+       dev_dbg(ddbg, "dump SSTSS=3D0x%08X\n", status);
+       status =3D read_SSACD(reg);
+       dev_dbg(ddbg, "dump SSACD=3D0x%08X\n", status);
+}
+
+/**
+ * i2s_int(): function that handles the SSP Interrupts (errors)
+ * @irq : IRQ Number
+ * @dev_id : structure that contains driver information
+ *
+ * This interrupts do nothing but warnings in case there is some problems
+ * in I2S connection (underruns, overruns...). This may be reported by add=
ing a
+ * new interface to the driver, but not yet requested by "users" of this d=
river
+ *
+ * Output parameters
+ *      NA
+ */
+static irqreturn_t i2s_int(int irq, void *dev_id)
+{
+       struct intel_mid_i2s_hdl *drv_data =3D dev_id;
+       void __iomem *reg;
+       u32 irq_status =3D 0;
+       u32 mask_status =3D 0;
+       struct device *ddbg =3D &(drv_data->pdev->dev);
+       reg =3D drv_data->ioaddr;
+       irq_status =3D read_SSSR(reg);
+
+       if (!(irq_status & (drv_data->mask_sr))) {
+               return IRQ_NONE;
+       } else {
+               /* may be improved by using a tasklet to send the error
+                * (underrun,...) to client by using callback
+                */
+               if (irq_status & (SSSR_ROR_MASK << SSSR_ROR_SHIFT)) {
+                       dev_warn(ddbg,
+                               "ssp_int RX FIFO OVER RUN SSSR=3D0x%08X\n",
+                               irq_status);
+                       mask_status |=3D (SSSR_ROR_MASK << SSSR_ROR_SHIFT);
+
+               }
+               if (irq_status & (SSSR_TUR_MASK << SSSR_TUR_SHIFT)) {
+                       dev_warn(ddbg,
+                               "ssp_int TX FIFO UNDER RUN SSSR=3D0x%08X\n",
+                               irq_status);
+                       mask_status |=3D (SSSR_TUR_MASK << SSSR_TUR_SHIFT);
+
+               }
+               if (irq_status & (SSSR_TINT_MASK << SSSR_TINT_SHIFT)) {
+                       dev_warn(ddbg,
+                               "ssp_int RX TIME OUT SSSR=3D0x%08X\n",
+                               irq_status);
+                       mask_status |=3D (SSSR_TINT_MASK << SSSR_TINT_SHIFT=
);
+
+               }
+               if (irq_status & (SSSR_PINT_MASK << SSSR_PINT_SHIFT)) {
+                       dev_warn(ddbg,
+                               "ssp_int TRAILING BYTE SSSR=3D0x%08X\n",
+                               irq_status);
+                       mask_status |=3D (SSSR_PINT_MASK << SSSR_PINT_SHIFT=
);
+               }
+               if (irq_status & (SSSR_EOC_MASK << SSSR_EOC_SHIFT)) {
+                       dev_warn(ddbg,
+                               "ssp_int END OF CHAIN SSSR=3D0x%08X\n",
+                               irq_status);
+                       mask_status |=3D (SSSR_EOC_MASK << SSSR_EOC_SHIFT);
+               }
+               /* clear sticky bits */
+               write_SSSR((irq_status & mask_status), reg);
+       }
+       return IRQ_HANDLED;
+}
+
+/**
+ * calculate_sspsp_psp - separate function that calculate sspsp register
+ * @ps_settings : pointer of the settings struct
+ *
+ * this function is to simplify/clarify set_ssp_i2s_hw function
+ *
+ *
+ * Output parameters
+ *      u32 : calculated SSPSP register
+ */
+u32 calculate_sspsp_psp(const struct intel_mid_i2s_settings *ps_settings)
+{
+       u32 sspsp;
+       sspsp =3D SSPSP_reg(FSRT, ps_settings->ssp_frmsync_timing_bit)
+               |SSPSP_reg(ETDS,        ps_settings->ssp_end_transfer_state)
+               |SSPSP_reg(SCMODE,      ps_settings->ssp_serial_clk_mode)
+               |SSPSP_reg(DMYSTOP,     ps_settings->ssp_psp_T4)
+               |SSPSP_reg(SFRMDLY,     ps_settings->ssp_psp_T5)
+               |SSPSP_reg(SFRMWDTH,    ps_settings->ssp_psp_T6)
+               |SSPSP_reg(SFRMP,       ps_settings->ssp_frmsync_pol_bit);
+       return sspsp;
+}
+
+/*
+ * calculate_sscr0_psp: separate function that calculate sscr0 register
+ * @ps_settings : pointer of the settings struct
+ *
+ * this function is to simplify/clarify set_ssp_i2s_hw function
+ *
+ * Output parameters
+ *      u32 : calculated SSCR0 register
+ */
+u32 calculate_sscr0_psp(const struct intel_mid_i2s_settings *ps_settings)
+{
+       u16 l_ssp_data_size =3D ps_settings->data_size;
+       u32 sscr0;
+       if (l_ssp_data_size > 16) {
+               sscr0 =3D   SSCR0_reg(DSS, SSCR0_DataSize(l_ssp_data_size -=
 16))
+                       | SSCR0_reg(EDSS, 1);
+       } else {
+               sscr0 =3D   SSCR0_reg(DSS, SSCR0_DataSize(l_ssp_data_size))
+                       | SSCR0_reg(EDSS, 0);
+       }
+/*
+Can be replaced by code below :
+sscr0 =3D SSCR0_reg(DSS, (l_ssp_data_size - 1) & 0x0F)
+| SSCR0_reg(EDSS, ((l_ssp_data_size - 1) & 0x10) >> 8);
+*/
+       sscr0 |=3D SSCR0_reg(MOD, ps_settings->mode)
+               |SSCR0_reg(FRF, ps_settings->frame_format)
+               |SSCR0_reg(RIM, SSP_RX_FIFO_OVER_INT_DISABLE)
+               |SSCR0_reg(TIM, SSP_TX_FIFO_UNDER_INT_DISABLE);
+       return sscr0;
+}
+
+/**
+ * calculate_sscr1_psp - separate function that calculate sscr1 register
+ * @ps_settings : pointer of the settings struct
+ *
+ * this function is to simplify/clarify set_ssp_i2s_hw function
+ *
+ * Output parameters
+ *      u32 : calculated SSCR1 register
+ */
+u32 calculate_sscr1_psp(const struct intel_mid_i2s_settings *ps_settings)
+{
+       u32 sscr1;
+       sscr1 =3D SSCR1_reg(SFRMDIR,      ps_settings->sspsfrm_direction)
+               |SSCR1_reg(SCLKDIR,     ps_settings->sspslclk_direction)
+               |SSCR1_reg(TTELP,       ps_settings->tx_tristate_phase)
+               |SSCR1_reg(TTE, ps_settings->tx_tristate_enable)
+               |SSCR1_reg(TRAIL,       ps_settings->ssp_trailing_byte_mode)
+               |SSCR1_reg(TINTE,       ps_settings->ssp_rx_timeout_interru=
pt_status)
+               |SSCR1_reg(PINTE,       ps_settings->ssp_trailing_byte_inte=
rrupt_status)
+               |SSCR1_reg(LBM, ps_settings->ssp_loopback_mode_status)
+               |SSCR1_reg(RWOT,        ps_settings->ssp_duplex_mode)
+               |SSCR1_reg(RFT, SSCR1_RxTresh(ps_settings->ssp_rx_fifo_thre=
shold))
+               |SSCR1_reg(TFT, SSCR1_TxTresh(ps_settings->ssp_tx_fifo_thre=
shold));
+       return sscr1;
+}
+
+/**
+ * set_ssp_i2s_hw - configure the SSP driver according to the ps_settings
+ * @drv_data : structure that contains all details about the SSP Driver
+ * @ps_settings : structure that contains SSP Hardware settings
+ *
+ * it also store ps_settings the drv_data
+ *
+ * Output parameters
+ *      NA
+ */
+static void set_ssp_i2s_hw(struct intel_mid_i2s_hdl *drv_data,
+                       const struct intel_mid_i2s_settings *ps_settings)
+{
+       u32 sscr0 =3D 0;
+       u32 sscr1 =3D 0;
+       u32 sstsa =3D 0;
+       u32 ssrsa =3D 0;
+       u32 sspsp =3D 0;
+       u32 sssr =3D 0;
+       /* Get the SSP Settings */
+       u16 l_ssp_clk_frm_mode =3D 0xFF;
+       void __iomem *reg =3D drv_data->ioaddr;
+       struct device *ddbg =3D &(drv_data->pdev->dev);
+       dev_dbg(ddbg,
+               "setup SSP I2S PCM1 configuration\n");
+       if ((ps_settings->sspsfrm_direction =3D=3D SSPSFRM_MASTER_MODE)
+          && (ps_settings->sspslclk_direction =3D=3D SSPSCLK_MASTER_MODE))=
 {
+               l_ssp_clk_frm_mode =3D SSP_IN_MASTER_MODE;
+       } else if ((ps_settings->sspsfrm_direction =3D=3D SSPSFRM_SLAVE_MOD=
E)
+          && (ps_settings->sspslclk_direction =3D=3D SSPSCLK_SLAVE_MODE)) {
+               l_ssp_clk_frm_mode =3D SSP_IN_SLAVE_MODE;
+       } else {
+               dev_err(ddbg, "Unsupported I2S PCM1 configuration\n");
+               goto leave;
+       }
+       dev_dbg(ddbg, "SSPSFRM_DIRECTION:%d:\n",
+               ps_settings->sspsfrm_direction);
+       dev_dbg(ddbg, "SSPSCLK_DIRECTION:%d:\n",
+               ps_settings->sspslclk_direction);
+       if (ps_settings->frame_format !=3D PSP_FORMAT) {
+               dev_err(ddbg, "UNSUPPORTED FRAME FORMAT:%d:\n", ps_settings=
->frame_format);
+               goto leave;
+       }
+       if ((ps_settings->ssp_tx_dma !=3D SSP_TX_DMA_ENABLE)
+       || (ps_settings->ssp_rx_dma !=3D SSP_RX_DMA_ENABLE)) {
+               dev_err(ddbg, "ONLY DMA MODE IS SUPPORTED");
+               goto leave;
+       }
+       /*********** DMA Transfer Mode ***********/
+       dev_dbg(ddbg, "FORMAT :%d:\n", ps_settings->frame_format);
+       sscr0 =3D calculate_sscr0_psp(ps_settings);
+       dev_dbg(ddbg, " sscr0 :0x%08X\n", sscr0);
+       sscr1 =3D calculate_sscr1_psp(ps_settings);
+       dev_dbg(ddbg, " sscr1 :0x%08X\n", sscr1);
+       if (ps_settings->mode =3D=3D SSP_IN_NETWORK_MODE) {
+               dev_dbg(ddbg, "MODE :%d:\n", ps_settings->mode);
+               sscr0 |=3D SSCR0_reg(FRDC, SSCR0_SlotsPerFrm(ps_settings->f=
rame_rate_divider_control));
+               dev_dbg(ddbg, "sscr0 :0x%08X\n", sscr0);
+               sspsp =3D calculate_sspsp_psp(ps_settings);
+               dev_dbg(ddbg, "sspsp :0x%08X\n", sspsp);
+               /* set the active TX time slot (bitmap) */
+               sstsa =3D SSTSA_reg(TTSA, ps_settings->ssp_active_tx_slots_=
map);
+               /* set the active RX time slot (bitmap) */
+               ssrsa =3D SSRSA_reg(RTSA, ps_settings->ssp_active_rx_slots_=
map);
+               if (l_ssp_clk_frm_mode =3D=3D SSP_IN_MASTER_MODE) {
+                       switch (ps_settings->master_mode_clk_selection) {
+                       case SSP_ONCHIP_CLOCK:
+                               break;
+                       case SSP_NETWORK_CLOCK:
+                               sscr0 |=3D SSCR0_reg(NCS, 1);
+                               break;
+                       case SSP_EXTERNAL_CLOCK:
+                               sscr0 |=3D SSCR0_reg(ECS, 1);
+                               break;
+                       case SSP_ONCHIP_AUDIO_CLOCK:
+                               sscr0 |=3D SSCR0_reg(ACS, 1);
+                               break;
+                       default:
+                               dev_err(ddbg, "Master Mode clk selection UN=
KNOWN");
+                               break;
+                       }
+                       sspsp |=3D SSPSP_reg(STRTDLY, ps_settings->ssp_psp_=
T1)
+                               |SSPSP_reg(DMYSTRT, ps_settings->ssp_psp_T2=
);
+               } else {        /* Set the Slave Clock Free Running Status =
*/
+                       sscr1 |=3D SSCR1_reg(SCFR, ps_settings->slave_clk_f=
ree_running_status);
+               }
+       } else {  /* SSP_IN_NORMAL_MODE */
+               dev_err(ddbg, "UNSUPPORTED MODE");
+               goto leave;
+       }
+
+       /* Clear status */
+       sssr =3D (SSSR_BCE_MASK << SSSR_BCE_SHIFT)
+            | (SSSR_TUR_MASK << SSSR_TUR_SHIFT)
+            | (SSSR_TINT_MASK << SSSR_TINT_SHIFT)
+            | (SSSR_PINT_MASK << SSSR_PINT_SHIFT)
+            | (SSSR_ROR_MASK << SSSR_ROR_SHIFT);
+       /* disable SSP */
+       clear_SSCR0_reg(reg, SSE);
+       dev_dbg(ddbg, "WRITE SSCR0 DISABLE\n");
+       /* Clear status */
+       write_SSSR(sssr, reg);
+       dev_dbg(ddbg, "WRITE SSSR: 0x%08X\n", sssr);
+       write_SSCR0(sscr0, reg);
+       dev_dbg(ddbg, "WRITE SSCR0\n");
+       /* first set CR1 without interrupt and service enables */
+       write_SSCR1(sscr1, reg);
+       write_SSPSP(sspsp, reg);
+       write_SSTSA(sstsa, reg);
+       write_SSRSA(ssrsa, reg);
+       /* set the time out for the reception */
+       write_SSTO(0, reg);
+       ssp1_dump_registers(drv_data);
+leave:
+       return;
+}
+
+static int
+intel_mid_i2s_find_usage(struct pci_dev *pdev,
+                        struct intel_mid_i2s_hdl *drv_data,
+                        enum intel_mid_i2s_ssp_usage *usage)
+{
+       int pos;
+       u8  adid;
+       int status =3D 0;
+
+       *usage =3D SSP_USAGE_UNASSIGNED;
+       pos =3D pci_find_capability(pdev, PCI_CAP_ID_VNDR);
+       dev_info((&pdev->dev),
+               "Probe/find capability (VNDR %d pos=3D0x%x)\n",
+               PCI_CAP_ID_VNDR, pos);
+       if (pos > 0) {
+               pos +=3D PCI_CAP_OFFSET_ADID;
+               pci_read_config_byte(pdev, pos, &adid);
+               dev_info(&(pdev->dev), "Vendor capability adid =3D 0x%x\n",=
 adid);
+               if (adid =3D=3D PCI_CAP_ADID_I2S_BT_FM)
+                       *usage  =3D SSP_USAGE_BLUETOOTH_FM;
+               else if (adid =3D=3D PCI_CAP_ADID_I2S_MODEM)
+                       *usage  =3D SSP_USAGE_MODEM;
+               else
+                       *usage  =3D SSP_USAGE_UNASSIGNED;
+       }
+       /* If there is no capability, check with old PCI_ID */
+#ifdef BYPASS_ADID
+       if (*usage =3D=3D SSP_USAGE_UNASSIGNED) {
+               dev_warn(&(pdev->dev), "Vendor capability not present/inval=
id\n");
+               switch (pdev->device) {
+               case MFLD_SSP1_DEVICE_ID:
+                       *usage  =3D SSP_USAGE_BLUETOOTH_FM;
+                       break;
+               case MFLD_SSP0_DEVICE_ID:
+                       *usage  =3D SSP_USAGE_MODEM;
+                       break;
+               }
+       }
+#endif
+       if (*usage =3D=3D SSP_USAGE_UNASSIGNED) {
+               dev_info((&pdev->dev),
+                       "No probe for I2S PCI-ID: %04x:%04x, ADID(0x%x)=3D0=
x%x\n",
+                       pdev->vendor, pdev->device, pos, adid);
+               status =3D -ENODEV;
+               goto err_find_usage;
+       }
+       dev_dbg(&(pdev->dev),
+               "Detected PCI SSP (ID: %04x:%04x) usage =3D%x\n",
+               pdev->vendor, pdev->device, *usage);
+       dev_dbg(&(pdev->dev),
+               " found PCI SSP controller(ID: %04x:%04x)\n",
+               pdev->vendor, pdev->device);
+       /* Init the driver data structure fields*/
+       switch (pdev->device) {
+       case MFLD_SSP1_DEVICE_ID:
+               drv_data->device_instance =3D DMA1C_DEVICE_INSTANCE_SSP1;
+               break;
+       case MFLD_SSP0_DEVICE_ID:
+               drv_data->device_instance =3D DMA1C_DEVICE_INSTANCE_SSP0;
+               break;
+       default:
+               dev_err(&(pdev->dev),
+                       "Can not determine dma device instance (PCI ID:%04x=
)\n",
+                       pdev->device);
+               status =3D -ENODEV;
+               goto err_find_usage;
+       }
+       status =3D pci_enable_device(pdev);
+       if (status)
+               dev_err((&pdev->dev), "Can not enable device.Err=3D%d\n", s=
tatus);
+err_find_usage:
+       return status;
+}
+
+/**
+ * intel_mid_i2s_probe - probing function for the pci selected
+ * @pdev : pci_dev pointer that is probed
+ * @ent : pci_device_id
+ *
+ * Output parameters
+ *      NA
+ */
+static int intel_mid_i2s_probe(struct pci_dev *pdev,
+                               const struct pci_device_id *ent)
+{
+       struct intel_mid_i2s_hdl *drv_data;
+       int status =3D 0;
+       enum intel_mid_i2s_ssp_usage usage;
+
+       drv_data =3D kzalloc(sizeof(struct intel_mid_i2s_hdl), GFP_KERNEL);
+       dev_dbg(&(pdev->dev), "%s Probe, drv_data =3D%p\n", DRIVER_NAME, dr=
v_data);
+       if (!drv_data) {
+               dev_err((&pdev->dev), "Can't alloc driver data in probe\n");
+               status =3D -ENOMEM;
+               goto leave;
+       }
+       dev_info((&pdev->dev), "Detected PCI SSP (ID: %04x:%04x)\n", pdev->=
vendor, pdev->device);
+       status =3D intel_mid_i2s_find_usage(pdev, drv_data, &usage);
+       if (status)
+               goto err_i2s_probe0;
+       mutex_init(&drv_data->mutex);
+       drv_data->pdev =3D pdev;
+       drv_data->usage =3D usage;
+       /*
+        * Get basic io resource and map it for SSP1 [BAR=3D0]
+        */
+       if ((pdev->device =3D=3D MFLD_SSP1_DEVICE_ID) ||
+           (pdev->device =3D=3D MFLD_SSP0_DEVICE_ID)) {
+               drv_data->paddr =3D pci_resource_start(pdev, MRST_SSP_BAR);
+               drv_data->iolen =3D pci_resource_len(pdev, MRST_SSP_BAR);
+               status =3D pci_request_region(pdev, MRST_SSP_BAR, dev_name(=
&pdev->dev));
+               /* map bus memory into CPU space */
+               drv_data->ioaddr =3D pci_ioremap_bar(pdev, MRST_SSP_BAR);
+       } else {
+               dev_err(&pdev->dev,
+                       "Don't know which BAR to usefor this SSP PCDID=3D%x=
\n",
+                       pdev->device);
+               status =3D -ENODEV;
+               goto err_i2s_probe1;
+       }
+       dev_dbg(&(pdev->dev), "paddr =3D : %x\n", drv_data->paddr);
+       dev_dbg(&(pdev->dev), "iolen =3D : %d\n", drv_data->iolen);
+       if (status) {
+               dev_err((&pdev->dev), "Can't request region. err=3D%d\n", s=
tatus);
+               goto err_i2s_probe1;
+       }
+       if (!drv_data->ioaddr) {
+               dev_err((&pdev->dev), "ioremap_nocache error\n");
+               status =3D -ENOMEM;
+               goto err_i2s_probe2;
+       }
+       dev_dbg(&(pdev->dev), "ioaddr =3D : %p\n", drv_data->ioaddr);
+       /* prepare for DMA channel allocation */
+       /* get the pci_dev structure pointer */
+       /* Check the SSP, if SSP3, then another DMA is used (GPDMA..) */
+       if ((pdev->device =3D=3D MFLD_SSP1_DEVICE_ID) ||
+           (pdev->device =3D=3D MFLD_SSP0_DEVICE_ID)) {
+               drv_data->dmac1 =3D pci_get_device(PCI_VENDOR_ID_INTEL,
+                                                MFLD_LPE_DMA_DEVICE_ID,
+                                                NULL);
+       } else {
+               dev_err(&pdev->dev,
+                       "Don't know dma device ID for this SSP PCDID=3D%x\n=
",
+                       pdev->device);
+               goto err_i2s_probe3;
+       }
+       /* in case the stop dma have to wait for end of callbacks   */
+       /* This will be removed when TERMINATE_ALL available in DMA */
+       init_waitqueue_head(&drv_data->wq_chan_closing);
+       if (!drv_data->dmac1) {
+               dev_err(&(drv_data->pdev->dev), "Can't find DMAC1, dma init=
 failed\n");
+               status =3D -ENODEV;
+               goto err_i2s_probe3;
+       }
+       /* increment ref count of pci device structure already done by */
+       /* pci_get_device. will do a pci_dev_put when exiting the module */
+       pci_set_drvdata(pdev, drv_data);
+       /* set SSP FrameSync and CLK direction in INPUT mode in order
+        * to avoid disturbing peripherals
+        */
+       write_SSCR1((SSCR1_SFRMDIR_MASK<<SSCR1_SFRMDIR_SHIFT)
+                 | (SSCR1_SCLKDIR_MASK<<SSCR1_SCLKDIR_SHIFT),
+       drv_data->ioaddr);
+       /* Attach to IRQ */
+       drv_data->irq =3D pdev->irq;
+       dev_dbg(&(pdev->dev), "attaching to IRQ: %04x\n", pdev->irq);
+       status =3D request_irq(drv_data->irq, i2s_int, IRQF_SHARED, "i2s ss=
p", drv_data);
+       if (status < 0) {
+               dev_err(&pdev->dev, "can not get IRQ. status err=3D%d\n", s=
tatus);
+               goto err_i2s_probe3;
+       }
+       pm_runtime_enable(&(drv_data->pdev->dev));
+       goto leave;
+err_i2s_probe3:
+       iounmap(drv_data->ioaddr);
+err_i2s_probe2:
+       pci_release_region(pdev, MRST_SSP_BAR);
+err_i2s_probe1:
+       pci_disable_device(pdev);
+err_i2s_probe0:
+       kfree(drv_data);
+leave:
+       return status;
+}
+
+static void __devexit intel_mid_i2s_remove(struct pci_dev *pdev)
+{
+       struct intel_mid_i2s_hdl *drv_data;
+
+       drv_data =3D pci_get_drvdata(pdev);
+       if (!drv_data) {
+               dev_err(&pdev->dev, "no drv_data in pci device to remove!\n=
");
+               goto leave;
+       }
+       if (test_bit(I2S_PORT_OPENED, &drv_data->flags)) {
+               dev_warn(&pdev->dev, "Not closed before removing pci_dev!\n=
");
+               intel_mid_i2s_close(drv_data);
+       }
+       pci_set_drvdata(pdev, NULL);
+       /* Stop DMA is already done during close()  */
+       pci_dev_put(drv_data->dmac1);
+       /* Disable the SSP at the peripheral and SOC level */
+       write_SSCR0(0, drv_data->ioaddr);
+       free_irq(drv_data->irq, drv_data);
+       iounmap(drv_data->ioaddr);
+       pci_release_region(pdev, MRST_SSP_BAR);
+       pci_release_region(pdev, MRST_LPE_BAR);
+       pci_disable_device(pdev);
+       kfree(drv_data);
+leave:
+       return;
+}
+
+/**
+ * intel_mid_i2s_init - register pci driver
+ *
+ */
+static int __init intel_mid_i2s_init(void)
+{
+       return pci_register_driver(&intel_mid_i2s_driver);
+}
+
+static void __exit intel_mid_i2s_exit(void)
+{
+       pci_unregister_driver(&intel_mid_i2s_driver);
+}
+
+
+module_init(intel_mid_i2s_init);
+module_exit(intel_mid_i2s_exit);
+
+
+
diff --git a/sound/pci/intel_mid_i2s/intel_mid_i2s.h b/sound/pci/intel_mid_=
i2s/intel_mid_i2s.h
new file mode 100644
index 0000000..ef29ce7
--- /dev/null
+++ b/sound/pci/intel_mid_i2s/intel_mid_i2s.h
@@ -0,0 +1,500 @@
+/*
+  * <Driver for I2S protocol on SSP (Moorestown and Medfield hardware)>
+  * Copyright (c) 2010, Intel Corporation.
+  * Louis LE GALL <louis.le.gall intel.com>
+  *
+  * This program is free software; you can redistribute it and/or modify it
+  * under the terms and conditions of the GNU General Public License,
+  * version 2, as published by the Free Software Foundation.
+  *
+  * This program is distributed in the hope it will be useful, but WITHOUT
+  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License =
for
+  * more details.
+  *
+  * You should have received a copy of the GNU General Public License alon=
g with
+  * this program; if not, write to the Free Software Foundation, Inc.,
+  * 51 Franklin St - Fifth Floor, Boston, MA 02110-1301 USA.
+  */
+#define DRIVER_NAME "I2S SSP Driver"
+/*
+ * Defines
+ */
+#define MFLD_SSP1_DEVICE_ID 0x0825     /* FOR MFLD */
+#define MRST_SSP0_DEVICE_ID 0x0815     /* FOR MRST */
+#define MFLD_SSP0_DEVICE_ID 0x0832     /* FOR MFLD */
+
+#define MRST_LPE_DMA_DEVICE_ID 0x0814
+#define MFLD_LPE_DMA_DEVICE_ID 0x0830
+
+/* SSP1 PCI device Base Address Register */
+#define MRST_SSP_BAR   0
+#define MRST_LPE_BAR   1
+#define DMA1C_DEVICE_INSTANCE_SSP0 0
+#define DMA1C_DEVICE_INSTANCE_SSP1 1
+#define OFFSET_SSCR0   0x00
+#define OFFSET_SSCR1   0x04
+#define OFFSET_SSSR            0x08
+#define OFFSET_SSITR   0x0c
+#define OFFSET_SSDR            0x10
+#define OFFSET_SSTO            0x28
+#define OFFSET_SSPSP   0x2c
+#define OFFSET_SSTSA   0x30    /* SSP Tx Timeslot Active */
+#define OFFSET_SSRSA   0x34    /* SSP Rx Timeslot Active */
+/* SST register map */
+#define OFFSET_LPE_CSR                 0x00
+#define OFFSET_LPE_PISR                        0x08
+#define OFFSET_LPE_PIMR                        0x10
+#define OFFSET_LPE_ISRX                        0x18
+#define OFFSET_LPE_IMRX                        0x28
+#define OFFSET_LPE_IPCX                        0x38    /* IPC IA-SST */
+#define OFFSET_LPE_IPCD                        0x40    /* IPC SST-IA */
+#define OFFSET_LPE_ISRD                        0x20    /* dummy register f=
or*/
+                                               /* shim workaround   */
+#define OFFSET_LPE_SHIM_SIZE   0X44
+
+#define SSP_IN_MASTER_MODE             0x0
+#define SSP_IN_SLAVE_MODE              0x1
+
+/*
+ *     Macros
+ */
+#define DEFINE_SSP_REG(reg, off) \
+static inline u32 read_##reg(void *p) { return __raw_readl(p + (off)); } \
+static inline void write_##reg(u32 v, void *p) { __raw_writel(v, p + (off)=
); }
+DEFINE_SSP_REG(SSCR0, 0x00)
+DEFINE_SSP_REG(SSCR1, 0x04)
+DEFINE_SSP_REG(SSSR, 0x08)
+DEFINE_SSP_REG(SSITR, 0x0c)
+DEFINE_SSP_REG(SSDR, 0x10)
+DEFINE_SSP_REG(SSTO, 0x28)
+DEFINE_SSP_REG(SSPSP, 0x2c)
+DEFINE_SSP_REG(SSTSA, 0x30)
+DEFINE_SSP_REG(SSRSA, 0x34)
+DEFINE_SSP_REG(SSTSS, 0x38)
+DEFINE_SSP_REG(SSACD, 0x3C)
+DEFINE_SSP_REG(I2CCTRL, 0x00);
+DEFINE_SSP_REG(I2CDATA, 0x04);
+/*
+ * Langwell SSP serial port register definitions
+ */
+#define SSCR0_DSS_MASK   0x0F  /* Data Size Select [4..16] */
+#define SSCR0_DSS_SHIFT  0
+#define SSCR0_FRF_MASK   0x03  /* FRame Format */
+#define SSCR0_FRF_SHIFT  4
+#define SSCR0_ECS_MASK   0x01  /* External clock select */
+#define SSCR0_ECS_SHIFT  6
+#define SSCR0_SSE_MASK   0x01  /* Synchronous Serial Port Enable */
+#define SSCR0_SSE_SHIFT  7
+#define SSCR0_SCR_MASK   0xFFF /* Not implemented */
+#define SSCR0_SCR_SHIFT  8
+#define SSCR0_EDSS_MASK  0x1   /* Extended data size select */
+#define SSCR0_EDSS_SHIFT 20
+#define SSCR0_NCS_MASK   0x1   /* Network clock select */
+#define SSCR0_NCS_SHIFT  21
+#define SSCR0_RIM_MASK   0x1   /* Receive FIFO overrrun int mask */
+#define SSCR0_RIM_SHIFT  22
+#define SSCR0_TIM_MASK   0x1   /* Transmit FIFO underrun int mask */
+#define SSCR0_TIM_SHIFT  23
+#define SSCR0_FRDC_MASK  0x7   /* Frame Rate Divider Control */
+#define SSCR0_FRDC_SHIFT 24
+#define SSCR0_ACS_MASK   0x1   /* Audio clock select */
+#define SSCR0_ACS_SHIFT  30
+#define SSCR0_MOD_MASK   0x1   /* Mode (normal or network) */
+#define SSCR0_MOD_SHIFT  31
+
+#define SSCR0_DataSize(x)     ((x) - 1)        /* Data Size Select [4..16]=
 */
+#define SSCR0_SlotsPerFrm(x)  ((x) - 1)        /* Time slots per frame */
+#define SSCR0_SerClkDiv(x)    ((x) - 1)        /* Divisor [1..4096],... */
+                                        /*...not implemented on Langwell */
+#define SSCR1_TTELP_MASK     0x1       /* TXD Tristate Enable on Last Phas=
e */
+#define SSCR1_TTELP_SHIFT    31
+#define SSCR1_TTE_MASK      0x1        /* TXD Tristate Enable */
+#define SSCR1_TTE_SHIFT      30
+#define SSCR1_EBCEI_MASK     0x1       /* Enable Bit Count Error Interrupt=
 */
+#define SSCR1_EBCEI_SHIFT    29
+#define SSCR1_SCFR_MASK      0x1       /* Slave Clock Running */
+#define SSCR1_SCFR_SHIFT     28
+#define SSCR1_ECRA_MASK      0x1       /* Enable Clock Request A */
+#define SSCR1_ECRA_SHIFT     27
+#define SSCR1_ECRB_MASK      0x1       /* Enable Clock Request B */
+#define SSCR1_ECRB_SHIFT     26
+#define SSCR1_SCLKDIR_MASK   0x1       /* SSPCLK Direction */
+#define SSCR1_SCLKDIR_SHIFT  25
+#define SSCR1_SFRMDIR_MASK   0x1       /* SSPFRM Direction */
+#define SSCR1_SFRMDIR_SHIFT  24
+#define SSCR1_RWOT_MASK      0x1       /* Receive without Transmit */
+#define SSCR1_RWOT_SHIFT     23
+#define SSCR1_TRAIL_MASK     0x1       /* Trailing Byte */
+#define SSCR1_TRAIL_SHIFT    22
+#define SSCR1_TSRE_MASK      0x1       /* DMA Transmit Service Request Ena=
ble*/
+#define SSCR1_TSRE_SHIFT     21
+#define SSCR1_RSRE_MASK      0x1       /* DMA Receive Service Request Enab=
le */
+#define SSCR1_RSRE_SHIFT     20
+#define SSCR1_TINTE_MASK     0x1       /* Receiver Time-out Interrupt Enab=
le */
+#define SSCR1_TINTE_SHIFT    19
+#define SSCR1_PINTE_MASK     0x1       /* Periph. Trailing Byte Int. Enabl=
e */
+#define SSCR1_PINTE_SHIFT    18
+#define SSCR1_IFS_MASK       0x1       /* Invert Frame Signal */
+#define SSCR1_IFS_SHIFT      16
+#define SSCR1_STFR_MASK      0x1       /* Select FIFO for EFWR: test mode =
*/
+#define SSCR1_STFR_SHIFT     15
+#define SSCR1_EFWR_MASK      0x1       /* Enable FIFO Write/Read: test mod=
e */
+#define SSCR1_EFWR_SHIFT     14
+#define SSCR1_RFT_MASK       0xF       /* Receive FIFO Trigger Threshold */
+#define SSCR1_RFT_SHIFT      10
+#define SSCR1_TFT_MASK       0xF       /* Transmit FIFO Trigger Threshold =
*/
+#define SSCR1_TFT_SHIFT      6
+#define SSCR1_MWDS_MASK      0x1       /* Microwire Transmit Data Size */
+#define SSCR1_MWDS_SHIFT     5
+#define SSCR1_SPH_MASK       0x1       /* Motorola SPI SSPSCLK phase setti=
ng */
+#define SSCR1_SPH_SHIFT      4
+#define SSCR1_SPO_MASK       0x1       /* Motorola SPI SSPSCLK polarity */
+#define SSCR1_SPO_SHIFT      3
+#define SSCR1_LBM_MASK       0x1       /* Loopback mode: test mode */
+#define SSCR1_LBM_SHIFT      2
+#define SSCR1_TIE_MASK       0x1       /* Transmit FIFO Interrupt Enable */
+#define SSCR1_TIE_SHIFT      1
+#define SSCR1_RIE_MASK       0x1       /* Receive FIFO Interrupt Enable */
+#define SSCR1_RIE_SHIFT      0
+
+#define SSCR1_RxTresh(x) ((x) - 1)     /* level [1..16] */
+#define SSCR1_TxTresh(x) ((x) - 1)     /* level [1..16] */
+
+#define SSPSP_FSRT_MASK      0x1       /* Frame Sync Relative Timing Bit */
+#define SSPSP_FSRT_SHIFT     25
+#define SSPSP_DMYSTOP_MASK   0x3       /* Dummy Stop in Number of SSPSCLKs=
:T4*/
+#define SSPSP_DMYSTOP_SHIFT  23
+#define SSPSP_SFRMWDTH_MASK  0x3F      /* Serial Frame width : T6 */
+#define SSPSP_SFRMWDTH_SHIFT 16
+#define SSPSP_SFRMDLY_MASK   0x7F      /* Serial Fr. Delay in 1/2SSPSCLKs:=
T5 */
+#define SSPSP_SFRMDLY_SHIFT  9
+#define SSPSP_DMYSTRT_MASK   0x3       /* Dummy Start in Number of SSPSCLK=
s..*/
+#define SSPSP_DMYSTRT_SHIFT  7     /*...after STRTDLY, T2 (master mode onl=
y) */
+#define SSPSP_STRTDLY_MASK   0x7       /* Start Delay, T1 (master mode onl=
y) */
+#define SSPSP_STRTDLY_SHIFT  4
+#define SSPSP_ETDS_MASK      0x1       /* End of Transfer Data State */
+#define SSPSP_ETDS_SHIFT     3
+#define SSPSP_SFRMP_MASK     0x1       /* Serial Frame Polarity */
+#define SSPSP_SFRMP_SHIFT    2
+#define SSPSP_SCMODE_MASK    0x3       /* Serial bit-rate Clock Mode */
+#define SSPSP_SCMODE_SHIFT   0
+
+#define SSTSA_TTSA_MASK      0xFF
+#define SSTSA_TTSA_SHIFT     0
+
+#define SSRSA_RTSA_MASK      0xFF
+#define SSRSA_RTSA_SHIFT     0
+
+#define SSSR_BCE_MASK   0x1    /* Bit Count Error: Read/Write 1 to Clear */
+#define SSSR_BCE_SHIFT  23
+#define SSSR_CSS_MASK   0x1    /* Clock Synchronization Status */
+#define SSSR_CSS_SHIFT  22
+#define SSSR_TUR_MASK   0x1    /* Transmit FIFO UnderRun: Rd/Wr 1 to Clear=
 */
+#define SSSR_TUR_SHIFT  21
+#define SSSR_EOC_MASK   0x1    /* End Of Chain: Read/Write 1 to Clear */
+#define SSSR_EOC_SHIFT  20
+#define SSSR_TINT_MASK  0x1    /* Receiver Time-out Interrupt:... */
+#define SSSR_TINT_SHIFT 19     /* ...Read/Write 1 to Clear */
+#define SSSR_PINT_MASK  0x1    /* Peripheral Trailing Byte Interrupt:... */
+#define SSSR_PINT_SHIFT 18     /* ...Read/Write 1 to Clear */
+#define SSSR_RFL_MASK   0xF    /* Receive FIFO Level */
+#define SSSR_RFL_SHIFT  12
+#define SSSR_TFL_MASK   0xF    /* Transmit FIFO Level */
+#define SSSR_TFL_SHIFT  8
+#define SSSR_ROR_MASK   0x1    /* Receive FIFO Overrun: Read/Write 1 to Cl=
ear*/
+#define SSSR_ROR_SHIFT  7
+#define SSSR_RFS_MASK   0x1    /* Receive FIFO Service Request */
+#define SSSR_RFS_SHIFT  6
+#define SSSR_TFS_MASK   0x1    /* Transmit FIFO Service Request */
+#define SSSR_TFS_SHIFT  5
+#define SSSR_BSY_MASK   0x1    /* SSP Busy */
+#define SSSR_BSY_SHIFT  4
+#define SSSR_RNE_MASK   0x1    /* Receive FIFO not empty */
+#define SSSR_RNE_SHIFT  3
+#define SSSR_TFN_MASK   0x1    /* Transmit FIFO not Full */
+#define SSSR_TFN_SHIFT  2
+
+
+#define SSP_OFF 0
+#define SSP_ON  1
+
+/* bit I2S_PORT_OPENED lock for open/close
+ * bit I2S_PORT_READ_BUSY lock for read requests (serialized)
+ * bit I2S_PORT_WRITE_BUSY lock for write requests (serialized)
+ * bit I2S_PORT_CLOSING means close on going, waiting for pending callback=
s.
+ */
+
+enum i2s_flags {
+       I2S_PORT_OPENED,
+       I2S_PORT_WRITE_BUSY,
+       I2S_PORT_READ_BUSY,
+       I2S_PORT_CLOSING
+};
+
+#define FIFO_SIZE 16
+/*
+ *     Structures Definition
+ */
+
+/**
+ * struct intel_mid_i2s_data - context struct to keep SSP I2S data
+ * @pdev: pci dev pointer corresponding to context
+ * @paddr:
+ * @ioaddr:
+ * @iolen:
+ * @irq:
+ * @clear_sr:
+ * @mask_sr:
+ * @dmac1:
+ * @dmas_tx: dma slave structure for transmit
+ * @dmas_rx: dma slave structure for receive
+ * @txchan: Dma channel for transmit
+ * @rxchan: Dma channel for receive
+ *
+ * @read_done:
+ * @read_dst:
+ * @read_len:
+ *
+ * @write_done:
+ * @write_src:
+ * @write_len:
+ *
+ * @mutex:  a mutex to make sure we have once-at-time critical functions.
+ *
+ * Longer description
+ */
+
+/* Locking rules:
+ *
+ * All the fields, not listed below, are set during probe, and then read o=
nly
+ * So they do not require locking
+ *
+ * The fields that require locking are related to the I2S read and write
+ * requests.
+ *
+ * We allow only 1 read at a time, and 1 write at a time.
+ * We allow read in parallel of write but use separate variables.
+ * We allow only 1 user per SSP/I2S port.
+ * Typically this user will be a dedicated PulseAudio RT thread communicat=
ing
+ * with cmt-speech driver which in turns communicates with intel_mid_ssp
+ * driver.
+ * PCM mixing is done before access to kernel drivers;typically within
+ * PulseAudio or after; typically within the modem.
+ * So no concurrent users, per I2S channel, to this driver are allowed
+ * The read & write are triggered from a USER context
+ * The read & write callbacks are called from a BH context
+ * You should have not callback pending before calling close, close will w=
ait
+ * for remaining callback calls.
+ * It is not allowed to call close function from read/write callback threa=
ds.
+ *
+ * Locking is handled via drv_data->flags & atomic bitwise operations
+ *
+ * I2S0 is dedicated for PCM transfer to/from the modem module
+ * I2S1 is dedicated for PCM transfer to/from the Bluetooth or FM module
+ *
+ * read_done:
+ * read_len:
+ * read_dst:
+ *
+ * write_done:
+ * write_src:
+ * write_len:
+ *
+ * mutex:  a mutex to make sure we have once-at-time critical functions.
+ *             once-at-a-time actions functions are:
+ *                     -intel_mid_i2s_open
+ *                     -intel_mid_i2s_close
+ *                     -intel_mid_i2s_rd_req
+ *                     -intel_mid_i2s_wr_req
+ *                     -intel_mid_i2s_set_rd_cb
+ *                     -intel_mid_i2s_set_wr_cb
+ * These functions should not be called during a lock() neither in interru=
pt.
+ */
+
+struct intel_mid_i2s_hdl {
+       /* Driver model hookup */
+       struct pci_dev *pdev;
+       /* register addresses */
+       dma_addr_t paddr;
+       void __iomem *ioaddr;
+       u32 iolen;
+       int irq;
+
+       /* SSP masks */
+       u32 clear_sr;
+       u32 mask_sr;
+
+       /* SSP Configuration */
+       /* DMA info */
+       struct pci_dev *dmac1;
+       wait_queue_head_t wq_chan_closing;
+
+       struct intel_mid_dma_slave dmas_tx;
+       struct intel_mid_dma_slave dmas_rx;
+       struct dma_chan *txchan;
+       struct dma_chan *rxchan;
+
+       unsigned int device_instance;
+       /* Call back functions */
+       int (*read_callback)(void *param);
+       dma_addr_t read_dst;
+       size_t read_len;     /* read_len > 0 <=3D> read_dma_running */
+       void *read_param;        /* context param for callback */
+       int (*write_callback)(void *param);
+       dma_addr_t write_src;
+       size_t write_len;       /* write_len > 0 <=3D> read_dma_running */
+       void *write_param;      /* context param for callback */
+
+       unsigned long flags;
+       struct mutex mutex;
+       enum intel_mid_i2s_ssp_usage usage;
+
+       struct intel_mid_i2s_settings current_settings;
+
+};
+
+static void i2s_read_done(void *arg);
+static void i2s_write_done(void *arg);
+static bool chan_filter(struct dma_chan *chan, void *param);
+static void i2s_dma_stop(struct intel_mid_i2s_hdl *drv_data);
+static int i2s_dma_start(struct intel_mid_i2s_hdl *drv_data);
+static void ssp1_dump_registers(struct intel_mid_i2s_hdl *);
+static irqreturn_t i2s_int(int irq, void *dev_id);
+static void set_ssp_i2s_hw(struct intel_mid_i2s_hdl *drv_data,
+               const struct intel_mid_i2s_settings *ps_settings);
+static int check_device(struct device *device_ptr, void *data);
+static int intel_mid_i2s_runtime_resume(struct device *device_ptr);
+static int intel_mid_i2s_runtime_suspend(struct device *device_ptr);
+static int intel_mid_i2s_probe(struct pci_dev *pdev,
+               const struct pci_device_id *ent);
+static void intel_mid_i2s_remove(struct pci_dev *pdev);
+static void i2s_ssp_stop(struct intel_mid_i2s_hdl *drv_data);
+/*static int bt_pcm_dma_init(struct intel_mid_i2s_hdl *drv_data);*/
+
+
+#ifdef CONFIG_PM
+static int  intel_mid_i2s_driver_suspend(struct pci_dev *dev,
+                                         pm_message_t state);
+static int intel_mid_i2s_driver_resume(struct pci_dev *dev);
+#endif
+
+/*
+ * These define will clarify source code when accessing SSCRx registers
+ */
+
+#define SSCR0_reg(regbit, value)                                       \
+       (((value) & SSCR0_##regbit##_MASK) << SSCR0_##regbit##_SHIFT)
+
+#define SSCR1_reg(regbit, value)                                       \
+       (((value) & SSCR1_##regbit##_MASK) << SSCR1_##regbit##_SHIFT)
+
+#define SSPSP_reg(regbit, value)                                       \
+       (((value) & SSPSP_##regbit##_MASK) << SSPSP_##regbit##_SHIFT)
+
+#define SSRSA_reg(regbit, value)                                       \
+       (((value) & SSRSA_##regbit##_MASK) << SSRSA_##regbit##_SHIFT)
+#define SSTSA_reg(regbit, value)                                       \
+       (((value) & SSTSA_##regbit##_MASK) << SSTSA_##regbit##_SHIFT)
+
+
+#define change_SSCR0_reg(reg_pointer, regbit, value)                     \
+       write_SSCR0((read_SSCR0(reg_pointer)                              \
+       & (~((SSCR0_##regbit##_MASK << SSCR0_##regbit##_SHIFT))))         \
+       | (((value) & SSCR0_##regbit##_MASK) << SSCR0_##regbit##_SHIFT),  \
+       reg_pointer);
+
+#define set_SSCR0_reg(reg_pointer, regbit)                               \
+       write_SSCR0(read_SSCR0(reg_pointer)                               \
+       | (SSCR0_##regbit##_MASK << SSCR0_##regbit##_SHIFT),            \
+       reg_pointer);
+
+#define clear_SSCR0_reg(reg_pointer, regbit)                             \
+       write_SSCR0((read_SSCR0(reg_pointer)                              \
+       & (~((SSCR0_##regbit##_MASK << SSCR0_##regbit##_SHIFT)))),        \
+       reg_pointer);
+
+#define change_SSCR1_reg(reg_pointer, regbit, value)                     \
+       write_SSCR1((read_SSCR1(reg_pointer)                              \
+       & (~((SSCR1_##regbit##_MASK << SSCR1_##regbit##_SHIFT))))         \
+       | (((value) & SSCR1_##regbit##_MASK) << SSCR1_##regbit##_SHIFT),  \
+       reg_pointer);
+
+#define set_SSCR1_reg(reg_pointer, regbit)                               \
+       write_SSCR1(read_SSCR1(reg_pointer)                               \
+       | (SSCR1_##regbit##_MASK << SSCR1_##regbit##_SHIFT),              \
+       reg_pointer);
+
+#define clear_SSCR1_reg(reg_pointer, regbit)                             \
+       write_SSCR1((read_SSCR1(reg_pointer)                              \
+       & (~((SSCR1_##regbit##_MASK << SSCR1_##regbit##_SHIFT)))),        \
+       reg_pointer);
+
+/* RX FIFO level */
+#define GET_SSSR_val(x, regb)                                            \
+       ((x & (SSSR_##regb##_MASK<<SSSR_##regb##_SHIFT))>>SSSR_##regb##_SHI=
FT)
+
+
+/*
+ * SSP hardware can be configured as I2S, PCM, SPI...
+ * In order to allow flexibility without modifying the software driver, the
+ * PCI header uses the configuration register 'adid':
+ *
+ * The PCI header associated to SSP devices includes a configuration regis=
ter.
+ * It provides information to a driver which is probed for the SSP, specif=
ying
+ * in which way the SSP is supposed to be used.
+ * Here is the format of this configuration register (8 bits):
+ *
+ *   bits 2..0: Mode
+ *       000: Invalid, the register should be ignored
+ *       001: SSP to be used as SPI controller
+ *       010: SSP to be used in I2S/ISS mode
+ *       other: Reserved
+ *
+ *   bits 5..3: Configuration
+ *       In I2S/ISS mode:
+ *               000: Invalid
+ *               001: Bluetooth
+ *               010: Modem
+ *               other: Reserved
+ *       In SPI mode:
+ *               Value is the SPI bus number connected to the SSP.
+ *               To be used for registration to the Linux SPI
+ *               framework.
+ *
+ *   bit 6: SPI slave
+ *       Relevant in SPI mode only. If set, indicates the SPI clock
+ *       is not provided by the SSP: SPI slave mode.
+ *
+ *   bit 7: Reserved (0)
+ *
+ *   This configuration register is implemented in the adid field of the
+ *   Vendor Specific PCI capability associated to the SSP. The format of
+ *   this capability is:
+ *
+ *   uint8_t     capId;              < Capability ID (vendor-specific)
+ *   uint8_t     nextCap;            < Next Item Ptr
+ *   uint8_t     length;             < Size of this capability (7)
+ *   uint8_t     version;            < Version of this capability (1)
+ *   uint8_t     lss;                < Logical subsystem info
+ *                                         Bit 7 =3D PMU (0 =3D NC, 1 =3D =
SC)
+ *                                         Bits 6:0 =3D LSS ID
+ *   uint8_t     apmc;               < Additional PM capabilities
+ *                                         Bit 7 =3D Rsvd
+ *                                         Bit 6 =3D Wake capable
+ *                                         Bit 5 =3D D3 support
+ *                                         Bit 4 =3D D2 support
+ *                                         Bit 3 =3D D1 support
+ *                                         Bit 2 =3D D0i3 support
+ *                                         Bit 1 =3D D0i2 support
+ *                                         Bit 0 =3D D0i1 support
+ *   uint8_t     adid;               < Additional device ID (dev-specific)
+ *   uint8_t     rsvd;               < Reserved for future use
+ *
+ *   The capability data are in the PCI configuration space and the
+ *   adid field can be modified using BMP tool.
+ */
+/* ADDID =3D Additional Device ID */
+#define PCI_CAP_OFFSET_ADID 6
+
+
--
1.6.6.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris,=20
92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--_002_2A84145621092446B6659B8A0F28E26F46FE77084Airsmsx501gerc_
Content-Type: application/octet-stream;
	name="0001-New-low-level-driver-Intel_mid_i2s-provide-support-alsa.patch"
Content-Description: 0001-New-low-level-driver-Intel_mid_i2s-provide-support-alsa.patch
Content-Disposition: attachment; filename=
	"0001-New-low-level-driver-Intel_mid_i2s-provide-support-alsa.patch";
	size=77099; creation-date="Fri, 15 Oct 2010 16:02:59 GMT";
	modification-date="Fri, 15 Oct 2010 14:45:31 GMT"
Content-Transfer-Encoding: base64

RnJvbSAxNmRhM2ViZmZhZDAyNmU0NGQ3NDUzOGI3NzczYTUxMDQ0MjU0OTIwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMb3VpcyBMRSBHQUxMIDxsb3Vpcy5sZS5nYWxsQGludGVsLmNv
bT4KRGF0ZTogRnJpLCAxNSBPY3QgMjAxMCAxNTozMDo0OSArMDIwMApTdWJqZWN0OiBbUEFUQ0hd
IE5ldyBsb3cgbGV2ZWwgZHJpdmVyICJJbnRlbF9taWRfaTJzIiBwcm92aWRlIHN1cHBvcnQgZm9y
IEkyUyBTU1AgZGV2aWNlIG9uIEludGVsIE1JRCBQbGF0Zm9ybXMKIFNpZ25lZC1vZmYtYnk6IExv
dWlzIExFIEdBTEwgPGxvdWlzLmxlLmdhbGxAaW50ZWwuY29tPgoKQ2hhbmdlLUlkOiBJMTcwNTJh
M2I0NjRjNTY4MmQyYWIxN2E5YjZlMGZhZDMwMTM3MjQzZgoKU2lnbmVkLW9mZi1ieTogTG91aXMg
TEUgR0FMTCA8bG91aXMubGUuZ2FsbEBpbnRlbC5jb20+Ci0tLQogaW5jbHVkZS9saW51eC9pbnRl
bF9taWRfaTJzX2lmLmggICAgICAgIHwgIDI4MCArKysrKysKIHNvdW5kL3BjaS9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMTggKwogc291bmQvcGNpL01ha2VmaWxlICAgICAgICAg
ICAgICAgICAgICAgIHwgICAgNCArLQogc291bmQvcGNpL2ludGVsX21pZF9pMnMvTWFrZWZpbGUg
ICAgICAgIHwgICAxOCArCiBzb3VuZC9wY2kvaW50ZWxfbWlkX2kycy9pbnRlbF9taWRfaTJzLmMg
fCAxNDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIHNvdW5kL3BjaS9pbnRlbF9t
aWRfaTJzL2ludGVsX21pZF9pMnMuaCB8ICA1MDAgKysrKysrKysrKysKIDYgZmlsZXMgY2hhbmdl
ZCwgMjI0NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9ucygtKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IGluY2x1ZGUvbGludXgvaW50ZWxfbWlkX2kyc19pZi5oCiBjcmVhdGUgbW9kZSAxMDA2NDQgc291
bmQvcGNpL2ludGVsX21pZF9pMnMvTWFrZWZpbGUKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3VuZC9w
Y2kvaW50ZWxfbWlkX2kycy9pbnRlbF9taWRfaTJzLmMKIGNyZWF0ZSBtb2RlIDEwMDY0NCBzb3Vu
ZC9wY2kvaW50ZWxfbWlkX2kycy9pbnRlbF9taWRfaTJzLmgKCmRpZmYgLS1naXQgYS9pbmNsdWRl
L2xpbnV4L2ludGVsX21pZF9pMnNfaWYuaCBiL2luY2x1ZGUvbGludXgvaW50ZWxfbWlkX2kyc19p
Zi5oCm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjE1NjM1NzcKLS0tIC9kZXYv
bnVsbAorKysgYi9pbmNsdWRlL2xpbnV4L2ludGVsX21pZF9pMnNfaWYuaApAQCAtMCwwICsxLDI4
MCBAQAorLyoKKyAgKiA8RHJpdmVyIGZvciBJMlMgcHJvdG9jb2wgb24gU1NQIChNb29yZXN0b3du
IGFuZCBNZWRmaWVsZCBoYXJkd2FyZSk+CisgICogQ29weXJpZ2h0IChjKSAyMDEwLCBJbnRlbCBD
b3Jwb3JhdGlvbi4KKyAgKiBMb3VpcyBMRSBHQUxMIDxsb3Vpcy5sZS5nYWxsIGludGVsLmNvbT4K
KyAgKgorICAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJp
YnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CisgICogdW5kZXIgdGhlIHRlcm1zIGFuZCBjb25kaXRp
b25zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSwKKyAgKiB2ZXJzaW9uIDIsIGFz
IHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICAqCisgICogVGhp
cyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIGl0IHdpbGwgYmUgdXNlZnVsLCBi
dXQgV0lUSE9VVAorICAqIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdh
cnJhbnR5IG9mIE1FUkNIQU5UQUJJTElUWSBvcgorICAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxB
UiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IKKyAgKiBt
b3JlIGRldGFpbHMuCisgICoKKyAgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9m
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZyB3aXRoCisgICogdGhpcyBwcm9n
cmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4s
CisgICogNTEgRnJhbmtsaW4gU3QgLSBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAx
IFVTQS4KKyAgKi8KKworI2lmbmRlZiBNSURfSTJTX0VYVEVSTkFMX0hfCisjZGVmaW5lIE1JRF9J
MlNfRVhURVJOQUxfSF8KKworI2luY2x1ZGUgPGxpbnV4L3BjaS5oPgorI2luY2x1ZGUgPGxpbnV4
L2RtYS1tYXBwaW5nLmg+CisjaW5jbHVkZSA8bGludXgvaW50ZWxfbWlkX2RtYS5oPgorCisjaW5j
bHVkZSA8bGludXgvaW50ZXJydXB0Lmg+CisKKy8qCisgKglTdHJ1Y3R1cmVzIERlZmluaXRpb24K
KyAqLworCisKKy8qCisgKglTU0NSMCBzZXR0aW5ncworICovCitlbnVtIG1yc3Rfc3NwX21vZGUg
eworCVNTUF9JTl9OT1JNQUxfTU9ERSA9IDB4MCwKKwlTU1BfSU5fTkVUV09SS19NT0RFCit9Owor
CitlbnVtIG1yc3Rfc3NwX3J4X2ZpZm9fb3Zlcl9ydW5faW50X21hc2sgeworCVNTUF9SWF9GSUZP
X09WRVJfSU5UX0VOQUJMRSA9IDB4MCwKKwlTU1BfUlhfRklGT19PVkVSX0lOVF9ESVNBQkxFCit9
OworCitlbnVtIG1yc3Rfc3NwX3R4X2ZpZm9fdW5kZXJfcnVuX2ludF9tYXNrIHsKKwlTU1BfVFhf
RklGT19VTkRFUl9JTlRfRU5BQkxFID0gMHgwLAorCVNTUF9UWF9GSUZPX1VOREVSX0lOVF9ESVNB
QkxFCit9OworCitlbnVtIG1yc3Rfc3NwX2ZyYW1lX2Zvcm1hdCB7CisJTU9UT1JPTEFfU1BJX0ZP
Uk1BVCA9IDB4MCwKKwlUSV9TU1BfRk9STUFULAorCU1JQ1JPV0lSRV9GT1JNQVQsCisJUFNQX0ZP
Uk1BVAorCit9OworCitlbnVtIG1yc3Rfc3NwX21hc3Rlcl9tb2RlX2Nsb2NrX3NlbGVjdGlvbiB7
CisJU1NQX09OQ0hJUF9DTE9DSyA9IDB4MCwKKwlTU1BfTkVUV09SS19DTE9DSywKKwlTU1BfRVhU
RVJOQUxfQ0xPQ0ssCisJU1NQX09OQ0hJUF9BVURJT19DTE9DSywKKwlTU1BfTUFTVEVSX0NMT0NL
X1VOREVGSU5FRCA9IDB4RkYKK307CisKKy8qCisgKglTU0NSMSBzZXR0aW5ncworICovCitlbnVt
IG1yc3Rfc3NwX3R4ZF90cmlzdGF0ZV9sYXN0X3BoYXNlIHsKKwlUWERfVFJJU1RBVEVfTEFTVF9Q
SEFTRV9PRkYgPSAgMHgwLAorCVRYRF9UUklTVEFURV9MQVNUX1BIQVNFX09OCit9OworCitlbnVt
IG1yc3Rfc3NwX3R4ZF90cmlzdGF0ZV9lbmFibGUgeworCVRYRF9UUklTVEFURV9PRkYgPSAgMHgw
LAorCVRYRF9UUklTVEFURV9PTgorfTsKKworZW51bSBtcnN0X3NzcF9zbGF2ZV9zc3BjbGtfZnJl
ZV9ydW5uaW5nIHsKKwlTTEFWRV9TU1BDTEtfT05fQUxXQVlTID0gIDB4MCwKKwlTTEFWRV9TU1BD
TEtfT05fRFVSSU5HX1RSQU5TRkVSX09OTFkKK307CisKK2VudW0gbXJzdF9zc3Bfc3Nwc2Nsa19k
aXJlY3Rpb24geworCVNTUFNDTEtfTUFTVEVSX01PREUgPSAweDAsCisJU1NQU0NMS19TTEFWRV9N
T0RFCit9OworCitlbnVtIG1yc3Rfc3NwX3NzcHNmcm1fZGlyZWN0aW9uIHsKKwlTU1BTRlJNX01B
U1RFUl9NT0RFID0gMHgwLAorCVNTUFNGUk1fU0xBVkVfTU9ERQorfTsKKworZW51bSBtcnN0X3Nz
cF9yeF93aXRob3V0X3R4IHsKKwlSWF9BTkRfVFhfTU9ERSA9IDB4MCwKKwlSWF9XSVRIT1VUX1RY
X01PREUKK307CisKK2VudW0gbXJzdF90cmFpbGluZ19ieXRlX21vZGUgeworCVNTUF9UUkFJTElO
R19CWVRFX0hETF9CWV9JQSA9IDB4MCwKKwlTU1BfVFJBSUxJTkdfQllURV9IRExfQllfRE1BCit9
OworCitlbnVtIG1yc3Rfc3NwX3R4X2RtYV9zdGF0dXMgeworCVNTUF9UWF9ETUFfTUFTSyA9IDB4
MCwKKwlTU1BfVFhfRE1BX0VOQUJMRQorfTsKKworZW51bSBtcnN0X3NzcF9yeF9kbWFfc3RhdHVz
IHsKKwlTU1BfUlhfRE1BX01BU0sgPSAweDAsCisJU1NQX1JYX0RNQV9FTkFCTEUKK307CisKK2Vu
dW0gbXJzdF9zc3BfcnhfdGltZW91dF9pbnRfc3RhdHVzIHsKKwlTU1BfUlhfVElNRU9VVF9JTlRf
RElTQUJMRSA9IDB4MCwKKwlTU1BfUlhfVElNRU9VVF9JTlRfRU5BQkxFCit9OworCitlbnVtIG1y
c3Rfc3NwX3RyYWlsaW5nX2J5dGVfaW50X3N0YXR1cyB7CisJU1NQX1RSQUlMSU5HX0JZVEVfSU5U
X0RJU0FCTEUgPSAweDAsCisJU1NQX1RSQUlMSU5HX0JZVEVfSU5UX0VOQUJMRQorfTsKKworZW51
bSBtcnN0X3NzcF9sb29wYmFja19tb2RlX3N0YXR1cyB7CisJU1NQX0xPT1BCQUNLX09GRiA9IDB4
MCwKKwlTU1BfTE9PUEJBQ0tfT04KK307CisKKworLyoKKyAqCVNTUFNQIHNldHRpbmdzOiBmb3Ig
UFNQIEZvcm1hdCBPTkxZISEhISEhISEKKyAqLworCitlbnVtIG1yc3Rfc3NwX2ZyYW1lX3N5bmNf
cmVsYXRpdmVfdGltaW5nX2JpdCB7CisJTkVYVF9GUk1TX0FTU19BRlRFUl9FTkRfT0ZfVDQgPSAg
MHgwLAorCU5FWFRfRlJNU19BU1NfV0lUSF9MU0JfUFJFVklPVVNfRlJNCit9OworCitlbnVtIG1y
c3Rfc3NwX2ZyYW1lX3N5bmNfcG9sYXJpdHlfYml0IHsKKwlTU1BfRlJNU19BQ1RJVkVfTE9XID0g
IDB4MCwKKwlTU1BfRlJNU19BQ1RJVkVfSElHSAorfTsKKworZW51bSBtcnN0X3NzcF9lbmRfb2Zf
dHJhbnNmZXJfZGF0YV9zdGF0ZSB7CisJU1NQX0VORF9EQVRBX1RSQU5TRkVSX1NUQVRFX0xPVyA9
IDB4MCwKKwlTU1BfRU5EX0RBVEFfVFJBTlNGRVJfU1RBVEVfUEVWSU9VU19CSVQKK307CisKK2Vu
dW0gbXJzdF9zc3BfY2xrX21vZGUgeworCVNTUF9DTEtfTU9ERV8wID0gMHgwLAorCVNTUF9DTEtf
TU9ERV8xLAorCVNTUF9DTEtfTU9ERV8yLAorCVNTUF9DTEtfTU9ERV8zCit9OworCisKKy8qCisg
KglsaXN0IG9mIGRpZmZlcmVudHMgdHlwZXMgb2YgU1NQLCB2YWx1ZSBkZXBlbmRzIG9mIGFkaWQg
ZW50cnkgb2YKKyAqCWNhcGFiaWxpdHkgSUQgb2YgdGhlIFBDSQorICovCisKKy8qCisgKgorICog
VGhlIFBDSSBoZWFkZXIgYXNzb2NpYXRlZCB0byBTU1AgZGV2aWNlcyBub3cgaW5jbHVkZXMgYSBj
b25maWd1cmF0aW9uCisgKiByZWdpc3Rlci4gSXQgcHJvdmlkZXMgaW5mb3JtYXRpb24gdG8gYSBk
cml2ZXIgd2hpY2ggaXMgcHJvYmVkIGZvciB0aGUKKyAqIFNTUCwgc3BlY2lmeWluZyBpbiB3aGlj
aCB3YXkgdGhlIFNTUCBpcyBzdXBwb3NlZCB0byBiZSB1c2VkLiBIZXJlIGlzCisgKiB0aGUgZm9y
bWF0IG9mIHRoaXMgYnl0ZSByZWdpc3RlcjoKKyAqCisgKgliaXRzIDIuLjA6IE1vZGUKKyAqCQkw
MDA9MHgwIDogSW52YWxpZCwgdGhlIHJlZ2lzdGVyIHNob3VsZCBiZSBpZ25vcmVkCisgKgkJMDAx
PTB4MSA6IFNTUCB0byBiZSB1c2VkIGFzIFNQSSBjb250cm9sbGVyCisgKgkJMDEwPTB4MjogU1NQ
IHRvIGJlIHVzZWQgaW4gSTJTL0lTUyBtb2RlCisgKgkJb3RoZXI6IFJlc2VydmVkCisgKgorICoJ
Yml0cyA1Li4zOiBDb25maWd1cmF0aW9uCisgKglJbiBJMlMvSVNTIG1vZGU6CisgKgkJMDAwPTB4
MDogSW52YWxpZAorICoJCTAwMT0weDE6IEJsdWV0b290aAorICoJCTAxMD0weDI6IE1vZGVtCisg
KgkJb3RoZXI6IFJlc2VydmVkCisgKglJbiBTUEkgbW9kZToKKyAqCQlWYWx1ZSBpcyB0aGUgU1BJ
IGJ1cyBudW1iZXIgY29ubmVjdGVkIHRvIHRoZSBTU1AuCisgKgkJVG8gYmUgdXNlZCBmb3IgcmVn
aXN0cmF0aW9uIHRvIHRoZSBMaW51eCBTUEkKKyAqCQlmcmFtZXdvcmsuCisgKgliaXQgNjogU1BJ
IHNsYXZlCisgKglSZWxldmFudCBpbiBTUEkgbW9kZSBvbmx5LiBJZiBzZXQsIGluZGljYXRlcyB0
aGUgU1BJIGNsb2NrCisgKglpcyBub3QgcHJvdmlkZWQgYnkgdGhlIFNTUDogU1BJIHNsYXZlIG1v
ZGUuCisgKgorICoJYml0IDc6IFJlc2VydmVkICgwKQorICoKKyAqIFRoaXMgY29uZmlndXJhdGlv
biByZWdpc3RlciBpcyBpbXBsZW1lbnRlZCBpbiB0aGUgYWRpZCBmaWVsZCBvZiB0aGUKKyAqIFZl
bmRvciBTcGVjaWZpYyBQQ0kgY2FwYWJpbGl0eSBhc3NvY2lhdGVkIHRvIHRoZSBTU1AuCisgKgor
ICovCisKKyNkZWZpbmUgUENJX0FESURfU1NQX01PREVfU1BJICAoMSkKKyNkZWZpbmUgUENJX0FE
SURfU1NQX01PREVfSTJTICAoMikKKworI2RlZmluZSBQQ0lfQURJRF9TU1BfQ09ORl9CVF9GTSAg
KDE8PDMpCisjZGVmaW5lIFBDSV9BRElEX1NTUF9DT05GX01PREVNICAoMjw8MykKKworCisjZGVm
aW5lIFBDSV9DQVBfQURJRF9JMlNfQlRfRk0gICgoUENJX0FESURfU1NQX0NPTkZfQlRfRk0pIHwg
KFBDSV9BRElEX1NTUF9NT0RFX0kyUykpCisjZGVmaW5lIFBDSV9DQVBfQURJRF9JMlNfTU9ERU0g
ICgoUENJX0FESURfU1NQX0NPTkZfTU9ERU0pIHwgKFBDSV9BRElEX1NTUF9NT0RFX0kyUykpCisK
K2VudW0gaW50ZWxfbWlkX2kyc19zc3BfdXNhZ2UgeworCVNTUF9VU0FHRV9VTkFTU0lHTkVEID0g
MHgwMCwKKwlTU1BfVVNBR0VfQkxVRVRPT1RIX0ZNID0gMHgwMSwKKwlTU1BfVVNBR0VfTU9ERU0g
PSAweDAyCit9OworCisvKgorICoJU3RydWN0dXJlIHVzZWQgdG8gY29uZmlndXJlIHRoZSBTU1Ag
UG9ydAorICoJUGxlYXNlIG5vdGUgdGhhdCBvbmx5IHRoZSBQU1AgZm9ybWF0IGFuZCB0aGUgRE1B
IHRyYW5zZmVyIGFyZSBzdXBwb3J0ZWQKKyAqLworCitzdHJ1Y3QgaW50ZWxfbWlkX2kyc19zZXR0
aW5ncyB7CisJZW51bSBtcnN0X3NzcF9tb2RlICAgICAgICAgICAgICAgICAgICAgICAgIG1vZGU7
CisJZW51bSBtcnN0X3NzcF9yeF9maWZvX292ZXJfcnVuX2ludF9tYXNrICAgIHJ4X2ZpZm9faW50
ZXJydXB0OworCWVudW0gbXJzdF9zc3BfdHhfZmlmb191bmRlcl9ydW5faW50X21hc2sgICB0eF9m
aWZvX2ludGVycnVwdDsKKwllbnVtIG1yc3Rfc3NwX2ZyYW1lX2Zvcm1hdCAgICAgICAgICAgICAg
ICAgZnJhbWVfZm9ybWF0OworCWVudW0gbXJzdF9zc3BfbWFzdGVyX21vZGVfY2xvY2tfc2VsZWN0
aW9uICBtYXN0ZXJfbW9kZV9jbGtfc2VsZWN0aW9uOyAgICAgICAgICAgICAgLyogZm9yIE1hc3Rl
ciBNb2RlIE9ubHkgKi8KKwl1OCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZnJhbWVfcmF0ZV9kaXZpZGVyX2NvbnRyb2w7CisJdTE2ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIG1hc3Rlcl9tb2RlX3NlcmlhbF9jbG9ja19yYXRlOyAgICAgICAg
ICAvKiBmb3IgTWFzdGVyIE1vZGUgT25seSAqLworCXUxNiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBkYXRhX3NpemU7CisKKwllbnVtIG1yc3Rfc3NwX3R4ZF90cmlzdGF0
ZV9sYXN0X3BoYXNlICAgICAgdHhfdHJpc3RhdGVfcGhhc2U7CisJZW51bSBtcnN0X3NzcF90eGRf
dHJpc3RhdGVfZW5hYmxlICAgICAgICAgIHR4X3RyaXN0YXRlX2VuYWJsZTsKKwllbnVtIG1yc3Rf
c3NwX3NsYXZlX3NzcGNsa19mcmVlX3J1bm5pbmcgICAgc2xhdmVfY2xrX2ZyZWVfcnVubmluZ19z
dGF0dXM7CisJZW51bSBtcnN0X3NzcF9zc3BzY2xrX2RpcmVjdGlvbiAgICAgICAgICAgIHNzcHNs
Y2xrX2RpcmVjdGlvbjsKKwllbnVtIG1yc3Rfc3NwX3NzcHNmcm1fZGlyZWN0aW9uICAgICAgICAg
ICAgc3Nwc2ZybV9kaXJlY3Rpb247CisJZW51bSBtcnN0X3NzcF9yeF93aXRob3V0X3R4ICAgICAg
ICAgICAgICAgIHNzcF9kdXBsZXhfbW9kZTsKKwllbnVtIG1yc3RfdHJhaWxpbmdfYnl0ZV9tb2Rl
ICAgICAgICAgICAgICAgc3NwX3RyYWlsaW5nX2J5dGVfbW9kZTsKKwllbnVtIG1yc3Rfc3NwX3R4
X2RtYV9zdGF0dXMgICAgICAgICAgICAgICAgc3NwX3R4X2RtYTsKKwllbnVtIG1yc3Rfc3NwX3J4
X2RtYV9zdGF0dXMgICAgICAgICAgICAgICAgc3NwX3J4X2RtYTsKKwllbnVtIG1yc3Rfc3NwX3J4
X3RpbWVvdXRfaW50X3N0YXR1cyAgICAgICAgc3NwX3J4X3RpbWVvdXRfaW50ZXJydXB0X3N0YXR1
czsKKwllbnVtIG1yc3Rfc3NwX3RyYWlsaW5nX2J5dGVfaW50X3N0YXR1cyAgICAgc3NwX3RyYWls
aW5nX2J5dGVfaW50ZXJydXB0X3N0YXR1czsKKwllbnVtIG1yc3Rfc3NwX2xvb3BiYWNrX21vZGVf
c3RhdHVzICAgICAgICAgc3NwX2xvb3BiYWNrX21vZGVfc3RhdHVzOworCXU4ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzc3BfcnhfZmlmb190aHJlc2hvbGQ7CisJdTgg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNzcF90eF9maWZvX3RocmVz
aG9sZDsKKworCisJZW51bSBtcnN0X3NzcF9mcmFtZV9zeW5jX3JlbGF0aXZlX3RpbWluZ19iaXQg
IHNzcF9mcm1zeW5jX3RpbWluZ19iaXQ7CisJZW51bSBtcnN0X3NzcF9mcmFtZV9zeW5jX3BvbGFy
aXR5X2JpdCAgICAgIHNzcF9mcm1zeW5jX3BvbF9iaXQ7CisJZW51bSBtcnN0X3NzcF9lbmRfb2Zf
dHJhbnNmZXJfZGF0YV9zdGF0ZSAgIHNzcF9lbmRfdHJhbnNmZXJfc3RhdGU7CisJZW51bSBtcnN0
X3NzcF9jbGtfbW9kZSAgICAgICAgICAgICAgICAgICAgIHNzcF9zZXJpYWxfY2xrX21vZGU7CisJ
dTggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNzcF9wc3BfVDE7CisJ
dTggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNzcF9wc3BfVDI7CisJ
dTggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNzcF9wc3BfVDQ7ICAg
LyogRE1ZU1RPUCAqLworCXU4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBzc3BfcHNwX1Q1OyAgIC8qIFNGUk1ETFkgKi8KKwl1OCAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3NwX3BzcF9UNjsgICAvKiBTRlJNV0RUSCAqLworCisJdTggICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHNzcF9hY3RpdmVfdHhfc2xvdHNf
bWFwOworCXU4ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzc3BfYWN0
aXZlX3J4X3Nsb3RzX21hcDsKK307CisKKy8qCisgKglQcm92aWRlZCBJbnRlcmZhY2UKKyAqLwor
CisKK3N0cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqaW50ZWxfbWlkX2kyc19vcGVuKGVudW0gaW50
ZWxfbWlkX2kyc19zc3BfdXNhZ2UgdXNhZ2UsIGNvbnN0IHN0cnVjdCBpbnRlbF9taWRfaTJzX3Nl
dHRpbmdzICpwc19zZXR0aW5ncyk7Cit2b2lkICBpbnRlbF9taWRfaTJzX2Nsb3NlKHN0cnVjdCBp
bnRlbF9taWRfaTJzX2hkbCAqaGFuZGxlKTsKKworaW50IGludGVsX21pZF9pMnNfcmRfcmVxKHN0
cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqaGFuZGxlLCB1MzIgKmRzdCwgc2l6ZV90IGxlbiwgdm9p
ZCAqcGFyYW0pOworaW50IGludGVsX21pZF9pMnNfd3JfcmVxKHN0cnVjdCBpbnRlbF9taWRfaTJz
X2hkbCAqaGFuZGxlLCB1MzIgKnNyYywgc2l6ZV90IGxlbiwgdm9pZCAqcGFyYW0pOworaW50IGlu
dGVsX21pZF9pMnNfZW5hYmxlX3NzcChzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwgKmhhbmRsZSk7
CisKKworaW50IGludGVsX21pZF9pMnNfc2V0X3dyX2NiKHN0cnVjdCBpbnRlbF9taWRfaTJzX2hk
bCAqaGFuZGxlLCBpbnQgKCp3cml0ZV9jYWxsYmFjaykodm9pZCAqcGFyYW0pKTsKK2ludCBpbnRl
bF9taWRfaTJzX3NldF9yZF9jYihzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwgKmhhbmRsZSwgaW50
ICgqcmVhZF9jYWxsYmFjaykodm9pZCAqcGFyYW0pKTsKKworCitpbnQgaW50ZWxfbWlkX2kyc19n
ZXRfdHhfZmlmb19sZXZlbChzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwgKmhhbmRsZSk7CitpbnQg
aW50ZWxfbWlkX2kyc19nZXRfcnhfZmlmb19sZXZlbChzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwg
KmhhbmRsZSk7CitpbnQgaW50ZWxfbWlkX2kyc19mbHVzaChzdHJ1Y3QgaW50ZWxfbWlkX2kyc19o
ZGwgKmhhbmRsZSk7CisKKyNlbmRpZiAvKk1JRF9JMlNfRVhURVJOQUxfSF8qLwpkaWZmIC0tZ2l0
IGEvc291bmQvcGNpL0tjb25maWcgYi9zb3VuZC9wY2kvS2NvbmZpZwppbmRleCAxMmUzNDY1Li4w
YjBhNTI0IDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvS2NvbmZpZworKysgYi9zb3VuZC9wY2kvS2Nv
bmZpZwpAQCAtODUzLDQgKzg1MywyMiBAQCBjb25maWcgU05EX1lNRlBDSQogCSAgVG8gY29tcGls
ZSB0aGlzIGRyaXZlciBhcyBhIG1vZHVsZSwgY2hvb3NlIE0gaGVyZTogdGhlIG1vZHVsZQogCSAg
d2lsbCBiZSBjYWxsZWQgc25kLXltZnBjaS4KIAorY29uZmlnIFNORF9JTlRFTF9NSURfSTJTCisJ
dHJpc3RhdGUgIkludGVsIG1pZCBJMlMgaGFyZHdhcmUgZHJpdmVyIgorCWRlcGVuZHMgb24gRVhQ
RVJJTUVOVEFMICYmIFBDSSAmJiBJTlRFTF9NSURfRE1BQworCWRlZmF1bHQgbgorCWhlbHAKKwkg
IFNheSBZIGhlcmUgaWYgeW91IHdhbnQgdG8gYnVpbGQgbG93IGxldmVsIGRyaXZlciB0byBzdXBw
b3J0CisJICBzZW5kaW5nL3JlY2V2aW5nIEkyUyBhdWRpbyBzYW1wbGVzIG9uIEludGVsIE1JRCBT
U1AgZGV2aWNlLgorCSAgVGhpcyBpbnRlcmZhY2UgaXMgbW9zdGx5IHVzZWQgb24gSW50ZWwgTUlE
IHBsYXRmb3JtcyBhbmQgcHJvdmlkZQorCSAgdGhlIGxvdyBsZXZlbCBpbnRlcmZhY2UgZm9yIHNv
bWUgdXBwZXIgbGF5ZXIgZHJpdmVycyBzdWNoIGFzCisJICBBbHNhIFNvQywgY2hhciBkZXZpY2Ug
aW50ZXJmYWNlcy4uLiBkZXBlbmRpbmcgb2YgcGVyaXBoZXJhbCBjb25uZWN0ZWQuCisJICBQQ0kg
SGVhZGVyIHNob3VsZCBoYXZlIEFESUQgZmllbGQgc2V0IHRvIEkyUyBCVF9GTSBvciAKKwkgIEky
UyBNT0RFTSB0byBiZSB1c2VkIGJ5IHRoaXMgZHJpdmVyIChzbyBpdCBrbm93IGNvbm5lY3RlZCBw
ZXJpcGhlcmFsKS4KKwkgIE5vdGUgdGhpcyBpcyBhIHByb3RvdHlwZSBkcml2ZXIgYW5kIHN1cHBv
cnQgZm9yIGNvbnRpbnVvdXMKKwkgIGZsb3cgaXMgc3RpbGwgd29ya2luZy1pbi1wcm9ncmVzcy4K
KwkgIFRoaXMgZHJpdmVyIGNhbiBhbHNvIGJlIGJ1aWx0IGFzIGEgbW9kdWxlLiBJZiBzbywgdGhl
IG1vZHVsZQorCSAgd2lsbCBiZSBjYWxsZWQgaW50ZWxfbWlkX2kycy5rbworCSAgSWYgdW5zdXJl
LCBzYXkgTiBoZXJlLgorCiBlbmRpZgkjIFNORF9QQ0kKZGlmZiAtLWdpdCBhL3NvdW5kL3BjaS9N
YWtlZmlsZSBiL3NvdW5kL3BjaS9NYWtlZmlsZQppbmRleCA5Y2Y0MzQ4Li40NjYxM2EyIDEwMDY0
NAotLS0gYS9zb3VuZC9wY2kvTWFrZWZpbGUKKysrIGIvc291bmQvcGNpL01ha2VmaWxlCkBAIC03
OCw0ICs3OCw2IEBAIG9iai0kKENPTkZJR19TTkQpICs9IFwKIAlybWU5NjUyLyBcCiAJdHJpZGVu
dC8gXAogCXltZnBjaS8gXAotCXZ4MjIyLworCXZ4MjIyLyBcCisJaW50ZWxfbWlkX2kycy8KKwpk
aWZmIC0tZ2l0IGEvc291bmQvcGNpL2ludGVsX21pZF9pMnMvTWFrZWZpbGUgYi9zb3VuZC9wY2kv
aW50ZWxfbWlkX2kycy9NYWtlZmlsZQpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
Li5iZWJhYzFjCi0tLSAvZGV2L251bGwKKysrIGIvc291bmQvcGNpL2ludGVsX21pZF9pMnMvTWFr
ZWZpbGUKQEAgLTAsMCArMSwxOCBAQAorIyBTU1AgYXVkaW8gZHJpdmVyCisjIENvcHlyaWdodCAo
YykgMjAxMCwgSW50ZWwgQ29ycG9yYXRpb24uCisKKyMgVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29m
dHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkgaXQKKyMgdW5kZXIg
dGhlIHRlcm1zIGFuZCBjb25kaXRpb25zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5z
ZSwKKyMgdmVyc2lvbiAyLCBhcyBwdWJsaXNoZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRh
dGlvbi4KKworIyBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgaXQgd2ls
bCBiZSB1c2VmdWwsIGJ1dCBXSVRIT1VUCisjIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRo
ZSBpbXBsaWVkIHdhcnJhbnR5IG9mIE1FUkNIQU5UQUJJTElUWSBvcgorIyBGSVRORVNTIEZPUiBB
IFBBUlRJQ1VMQVIgUFVSUE9TRS4gIFNlZSB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2Ug
Zm9yCisjIG1vcmUgZGV0YWlscy4KKworIyBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZyB3aXRoCisjIHRoaXMgcHJv
Z3JhbTsgaWYgbm90LCB3cml0ZSB0byB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLCBJbmMu
LAorIyA1MSBGcmFua2xpbiBTdCAtIEZpZnRoIEZsb29yLCBCb3N0b24sIE1BIDAyMTEwLTEzMDEg
VVNBLgorCitvYmotJChDT05GSUdfU05EX0lOVEVMX01JRF9JMlMpICAgICs9ICBpbnRlbF9taWRf
aTJzLm8KKwpkaWZmIC0tZ2l0IGEvc291bmQvcGNpL2ludGVsX21pZF9pMnMvaW50ZWxfbWlkX2ky
cy5jIGIvc291bmQvcGNpL2ludGVsX21pZF9pMnMvaW50ZWxfbWlkX2kycy5jCm5ldyBmaWxlIG1v
ZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAuLjU3MmFiZGUKLS0tIC9kZXYvbnVsbAorKysgYi9zb3Vu
ZC9wY2kvaW50ZWxfbWlkX2kycy9pbnRlbF9taWRfaTJzLmMKQEAgLTAsMCArMSwxNDI4IEBACisv
KgorICAqIDxEcml2ZXIgZm9yIEkyUyBwcm90b2NvbCBvbiBTU1AgKE1vb3Jlc3Rvd24gYW5kIE1l
ZGZpZWxkIGhhcmR3YXJlKT4KKyAgKiBDb3B5cmlnaHQgKGMpIDIwMTAsIEludGVsIENvcnBvcmF0
aW9uLgorICAqIExvdWlzIExFIEdBTEwgPGxvdWlzLmxlLmdhbGwgaW50ZWwuY29tPgorICAqCisg
ICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0
IGFuZC9vciBtb2RpZnkgaXQKKyAgKiB1bmRlciB0aGUgdGVybXMgYW5kIGNvbmRpdGlvbnMgb2Yg
dGhlIEdOVSBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlLAorICAqIHZlcnNpb24gMiwgYXMgcHVibGlz
aGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCisgICoKKyAgKiBUaGlzIHByb2dy
YW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgaXQgd2lsbCBiZSB1c2VmdWwsIGJ1dCBXSVRI
T1VUCisgICogQU5ZIFdBUlJBTlRZOyB3aXRob3V0IGV2ZW5wIHRoZSBpbXBsaWVkIHdhcnJhbnR5
IG9mIE1FUkNIQU5UQUJJTElUWSBvcgorICAqIEZJVE5FU1MgRk9SIEEgUEFSVElDVUxBUiBQVVJQ
T1NFLiAgU2VlIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IKKyAgKiBtb3JlIGRl
dGFpbHMuCisgICoKKyAgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBH
TlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZyB3aXRoCisgICogdGhpcyBwcm9ncmFtOyBp
ZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIEluYy4sCisgICog
NTEgRnJhbmtsaW4gU3QgLSBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0xMzAxIFVTQS4K
KyAgKi8KKyNpbmNsdWRlIDxsaW51eC9wY2kuaD4KKyNpbmNsdWRlIDxsaW51eC9kbWEtbWFwcGlu
Zy5oPgorI2luY2x1ZGUgPGxpbnV4L2ludGVycnVwdC5oPgorI2luY2x1ZGUgPGxpbnV4L3BtX3J1
bnRpbWUuaD4KKyNpbmNsdWRlIDxsaW51eC9wY2lfcmVncy5oPgorI2luY2x1ZGUgPGxpbnV4L3dh
aXQuaD4KKyNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KKyNpbmNsdWRlIDxsaW51eC9zY2hl
ZC5oPgorCisjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+CisKKyNpbmNsdWRlIDxsaW51eC9pbnRl
bF9taWRfaTJzX2lmLmg+CisjaW5jbHVkZSAiaW50ZWxfbWlkX2kycy5oIgorCitNT0RVTEVfQVVU
SE9SKCJMb3VpcyBMRSBHQUxMIDxsb3Vpcy5sZS5nYWxsIGludGVsLmNvbT4iKTsKK01PRFVMRV9E
RVNDUklQVElPTigiSW50ZWwgTUlEIEkyUy9QQ00gU1NQIERyaXZlciIpOworTU9EVUxFX0xJQ0VO
U0UoIkdQTCIpOworTU9EVUxFX1ZFUlNJT04oIjEuMC4wIik7CisKKworLyoKKyAqIHN0cnVjdHVy
ZXMgZm9yIHBjaSBwcm9iaW5nCisgKi8KK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBp
bnRlbF9taWRfaTJzX3BtX29wcyA9IHsKKwkucnVudGltZV9zdXNwZW5kID0gaW50ZWxfbWlkX2ky
c19ydW50aW1lX3N1c3BlbmQsCisJLnJ1bnRpbWVfcmVzdW1lID0gaW50ZWxfbWlkX2kyc19ydW50
aW1lX3Jlc3VtZSwKK307CitzdGF0aWMgREVGSU5FX1BDSV9ERVZJQ0VfVEFCTEUocGNpX2lkcykg
PSB7CisJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIE1GTERfU1NQMV9ERVZJQ0Vf
SUQpIH0sCisJeyBQQ0lfREVWSUNFKFBDSV9WRU5ET1JfSURfSU5URUwsIE1GTERfU1NQMF9ERVZJ
Q0VfSUQpIH0sCisJeyAwLCB9LCAvKiB0ZXJtaW5hdGUgbGlzdCAqLworfTsKK3N0YXRpYyBzdHJ1
Y3QgcGNpX2RyaXZlciBpbnRlbF9taWRfaTJzX2RyaXZlciA9IHsKKwkuZHJpdmVyID0geworCQku
cG0gPSAmaW50ZWxfbWlkX2kyc19wbV9vcHMsCisJfSwKKwkubmFtZSA9IERSSVZFUl9OQU1FLAor
CS5pZF90YWJsZSA9IHBjaV9pZHMsCisJLnByb2JlID0gaW50ZWxfbWlkX2kyc19wcm9iZSwKKwku
cmVtb3ZlID0gX19kZXZleGl0X3AoaW50ZWxfbWlkX2kyc19yZW1vdmUpLAorI2lmZGVmIENPTkZJ
R19QTQorCS5zdXNwZW5kID0gaW50ZWxfbWlkX2kyc19kcml2ZXJfc3VzcGVuZCwKKwkucmVzdW1l
ID0gaW50ZWxfbWlkX2kyc19kcml2ZXJfcmVzdW1lLAorI2VuZGlmCit9OworCisKKy8qCisgKiBQ
T1dFUiBNQU5BR0VNRU5UIEZVTkNUSU9OUworICovCisKKyNpZmRlZiBDT05GSUdfUE0KKy8qKgor
ICogaW50ZWxfbWlkX2kyc19kcml2ZXJfc3VzcGVuZCAtIGRyaXZlciBwb3dlciBtYW5hZ2VtZW50
IHN1c3BlbmQgYWN0aXZpdHkKKyAqIEBkZXZpY2VfcHRyIDogcG9pbnRlciBvZiB0aGUgZGV2aWNl
IHRvIHJlc3VtZQorICoKKyAqIE91dHB1dCBwYXJhbWV0ZXJzCisgKiAgICAgIGVycm9yIDogMCBt
ZWFucyBubyBlcnJvcgorICovCitzdGF0aWMgaW50ICBpbnRlbF9taWRfaTJzX2RyaXZlcl9zdXNw
ZW5kKHN0cnVjdCBwY2lfZGV2ICpkZXYsIHBtX21lc3NhZ2VfdCBzdGF0ZSkKK3sKKwlzdHJ1Y3Qg
aW50ZWxfbWlkX2kyc19oZGwgKmRydl9kYXRhID0gcGNpX2dldF9kcnZkYXRhKGRldik7CisJV0FS
TighZHJ2X2RhdGEsICJEcml2ZXIgZGF0YT1OVUxMXG4iKTsKKwlpZiAoIWRydl9kYXRhKQorCQly
ZXR1cm4gMDsKKwlkZXZfZGJnKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAiU1VTUEVORCBTU1AgSUQg
JWRcbiIsIGRydl9kYXRhLT5wZGV2LT5kZXZpY2UpOworCXBjaV9zYXZlX3N0YXRlKGRldik7CisJ
cGNpX2Rpc2FibGVfZGV2aWNlKGRldik7CisJcGNpX3NldF9wb3dlcl9zdGF0ZShkZXYsIFBDSV9E
M2hvdCk7CisJcmV0dXJuIDA7Cit9CisKKy8qKgorICogaW50ZWxfbWlkX2kyc19kcml2ZXJfcmVz
dW1lIC0gZHJpdmVyIHBvd2VyIG1hbmFnZW1lbnQgc3VzcGVuZCBhY3Rpdml0eQorICogQGRldmlj
ZV9wdHIgOiBwb2ludGVyIG9mIHRoZSBkZXZpY2UgdG8gcmVzdW1lCisgKgorICogT3V0cHV0IHBh
cmFtZXRlcnMKKyAqICAgICAgZXJyb3IgOiAwIG1lYW5zIG5vIGVycm9yCisgKi8KK3N0YXRpYyBp
bnQgaW50ZWxfbWlkX2kyc19kcml2ZXJfcmVzdW1lKHN0cnVjdCBwY2lfZGV2ICpkZXYpCit7CisJ
aW50IGVycjsKKwlpbnQgcmV0ID0gMDsKKwlzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwgKmRydl9k
YXRhID0gcGNpX2dldF9kcnZkYXRhKGRldik7CisKKwlXQVJOKCFkcnZfZGF0YSwgIkRyaXZlciBk
YXRhPU5VTExcbiIpOworCWlmICghZHJ2X2RhdGEpCisJCXJldHVybiAtRUZBVUxUOworCWRldl9k
YmcoJmRydl9kYXRhLT5wZGV2LT5kZXYsICJSRVNVTUUgU1NQIElEICVkXG4iLCBkcnZfZGF0YS0+
cGRldi0+ZGV2aWNlKTsKKworCWVyciA9IHBjaV9lbmFibGVfZGV2aWNlKGRldik7CisJaWYgKGVy
cikKKwkJZGV2X2VycigmZHJ2X2RhdGEtPnBkZXYtPmRldiwgIlVuYWJsZSB0byByZS1lbmFibGUg
ZGV2aWNlLCB0cnlpbmcgdG8gY29udGludWUuXG4iKTsKKwlkZXZfZGJnKCZkcnZfZGF0YS0+cGRl
di0+ZGV2LCAicmVzdW1pbmdcbiIpOworCXBjaV9zZXRfcG93ZXJfc3RhdGUoZGV2LCBQQ0lfRDAp
OworCXBjaV9yZXN0b3JlX3N0YXRlKGRldik7CisJcmV0ID0gcGNpX2VuYWJsZV9kZXZpY2UoZGV2
KTsKKwlpZiAocmV0KQorCQlkZXZfZXJyKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAiSTJTOiBkZXZp
Y2UgY2FuJ3QgYmUgZW5hYmxlZCIpOworCWRldl9kYmcoJmRydl9kYXRhLT5wZGV2LT5kZXYsICJy
ZXN1bWVkIGluIEQzXG4iKTsKKwlyZXR1cm4gcmV0OworfQorCisvKioKKyAqIGludGVsX21pZF9p
MnNfcnVudGltZV9zdXNwZW5kIC0gcnVudGltZSBwb3dlciBtYW5hZ2VtZW50IHN1c3BlbmQgYWN0
aXZpdHkKKyAqIEBkZXZpY2VfcHRyIDogcG9pbnRlciBvZiB0aGUgZGV2aWNlIHRvIHJlc3VtZQor
ICoKKyAqIE91dHB1dCBwYXJhbWV0ZXJzCisgKiAgICAgIGVycm9yIDogMCBtZWFucyBubyBlcnJv
cgorICovCitzdGF0aWMgaW50IGludGVsX21pZF9pMnNfcnVudGltZV9zdXNwZW5kKHN0cnVjdCBk
ZXZpY2UgKmRldmljZV9wdHIpCit7CisJc3RydWN0IHBjaV9kZXYgKnBkZXY7CisJc3RydWN0IGlu
dGVsX21pZF9pMnNfaGRsICpkcnZfZGF0YTsKKwl2b2lkIF9faW9tZW0gKnJlZzsKKworCXBkZXYg
PSB0b19wY2lfZGV2KGRldmljZV9wdHIpOworCVdBUk4oIXBkZXYsICJQY2kgZGV2PU5VTExcbiIp
OworCWlmICghcGRldikKKwkJcmV0dXJuIC1FRkFVTFQ7CisJZHJ2X2RhdGEgPSAoc3RydWN0IGlu
dGVsX21pZF9pMnNfaGRsICopIHBjaV9nZXRfZHJ2ZGF0YShwZGV2KTsKKwlXQVJOKCFkcnZfZGF0
YSwgIkRyaXZlciBkYXRhPU5VTExcbiIpOworCWlmICghZHJ2X2RhdGEpCisJCXJldHVybiAtRUZB
VUxUOworCWlmICh0ZXN0X2JpdChJMlNfUE9SVF9PUEVORUQsICZkcnZfZGF0YS0+ZmxhZ3MpKSB7
CisJCWRldl9lcnIoZGV2aWNlX3B0ciwgIlRyeWluZyB0byBzdXNwZW5kIGEgZGV2aWNlIHRoYXQg
aXMgb3BlbmVkXG4iKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCXJlZyA9IGRydl9kYXRhLT5p
b2FkZHI7CisJZGV2X2RiZygmZHJ2X2RhdGEtPnBkZXYtPmRldiwgIlN1c3BlbmQgb2YgU1NQIHJl
cXVlc3RlZCAhIVxuIik7CisJcmV0dXJuIGludGVsX21pZF9pMnNfZHJpdmVyX3N1c3BlbmQodG9f
cGNpX2RldihkZXZpY2VfcHRyKSwgUE1TR19TVVNQRU5EKTsKK30KKyNlbmRpZgorCisvKioKKyAq
IGludGVsX21pZF9pMnNfcnVudGltZV9yZXN1bWUgLSBydW50aW1lIHBvd2VyIG1hbmFnZW1lbnQg
cmVzdW1lIGFjdGl2aXR5CisgKiBAZGV2aWNlX3B0ciA6IHBvaW50ZXIgb2YgdGhlIGRldmljZSB0
byByZXN1bWUKKyAqCisgKiBPdXRwdXQgcGFyYW1ldGVycworICogICAgICBlcnJvciA6IDAgbWVh
bnMgbm8gZXJyb3IKKyAqLworc3RhdGljIGludCBpbnRlbF9taWRfaTJzX3J1bnRpbWVfcmVzdW1l
KHN0cnVjdCBkZXZpY2UgKmRldmljZV9wdHIpCit7CisJc3RydWN0IHBjaV9kZXYgKnBkZXY7CisJ
c3RydWN0IGludGVsX21pZF9pMnNfaGRsICpkcnZfZGF0YTsKKwlwZGV2ID0gdG9fcGNpX2Rldihk
ZXZpY2VfcHRyKTsKKwlXQVJOKCFwZGV2LCAiUGNpIGRldj1OVUxMXG4iKTsKKwlpZiAoIXBkZXYp
CisJCXJldHVybiAtRUZBVUxUOworCWRydl9kYXRhID0gKHN0cnVjdCBpbnRlbF9taWRfaTJzX2hk
bCAqKSBwY2lfZ2V0X2RydmRhdGEocGRldik7CisJV0FSTighZHJ2X2RhdGEsICJEcml2ZXIgZGF0
YT1OVUxMXG4iKTsKKwlpZiAoIWRydl9kYXRhKQorCQlyZXR1cm4gLUVGQVVMVDsKKwlkZXZfZGJn
KCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAiUlQgUkVTVU1FIFNTUCBJRFxuIik7CisJcmV0dXJuIGlu
dGVsX21pZF9pMnNfZHJpdmVyX3Jlc3VtZSh0b19wY2lfZGV2KGRldmljZV9wdHIpKTsKK30KKwor
LyoKKyAqIElOVEVSRkFDRSBGVU5DVElPTlMKKyAqLworCisvKioKKyAqIGludGVsX21pZF9pMnNf
Zmx1c2ggLSBUaGlzIGlzIHRoZSBJMlMgZmx1c2ggcmVxdWVzdAorICogQGRydl9kYXRhIDogcG9p
bnRlciBvbiBwcml2YXRlIGkycyBkcml2ZXIgZGF0YSAoYnkgaTJzX29wZW4gZnVuY3Rpb24pCisg
KgorICogSXQgd2lsbCBmbHVzaCB0aGUgVFggRklGTworICogV0FSTklORzogdGhpcyBmdW5jdGlv
biBpcyB1c2VkIGluIGEgQnVyc3QgTW9kZSBjb250ZXh0IHdoZXJlIGl0IGlzIGNhbGxlZAorICog
YmV0d2VlbiBCdXJzdHMgaS5lLiB3aGVuIHRoZXJlIGlzIG5vIEZNU1lOQywgbm8gdHJhbnNmZXIg
b25nb2luZyBhdAorICogdGhhdCB0aW1lCisgKiBJZiB5b3UgbmVlZCBhIGZsdXNoIHdoaWxlIFNT
UCBjb25maWd1cmVkIGluIEkyUyBpcyBCVVNZIGFuZCBGTVNZTkMgYXJlCisgKiBnZW5lcmF0ZWQs
IHlvdSBoYXZlIHRvIHdyaXRlIGFub3RoZXIgZnVuY3Rpb24KKyAqIChsb29wIG9uIEJVU1kgYml0
IGFuZCBkbyBub3QgbGltaXQgdGhlIGZsdXNoIHRvIGF0IG1vc3QgMTYgc2FtcGxlcykKKyAqCisg
KiBPdXRwdXQgcGFyYW1ldGVycworICogICAgICBpbnQgOiBudW1iZXIgb2Ygc2FtcGxlcyBmbHVz
aGVkCisgKi8KK2ludCBpbnRlbF9taWRfaTJzX2ZsdXNoKHN0cnVjdCBpbnRlbF9taWRfaTJzX2hk
bCAqZHJ2X2RhdGEpCit7CisJdTMyIHNzc3IsIGRhdGE7CisJdTMyIG51bSA9IDA7CisJdm9pZCBf
X2lvbWVtICpyZWc7CisKKwlXQVJOKCFkcnZfZGF0YSwgIkRyaXZlciBkYXRhPU5VTExcbiIpOwor
CWlmICghZHJ2X2RhdGEpCisJCXJldHVybiAwOworCXJlZyA9IGRydl9kYXRhLT5pb2FkZHI7CisJ
c3NzciA9IHJlYWRfU1NTUihyZWcpOworCWRldl9kYmcoJmRydl9kYXRhLT5wZGV2LT5kZXYsICJp
biBmbHVzaCBzc3NyPTB4JTA4WFxuIiwgc3Nzcik7CisJLyoKKwkgKiBGbHVzaCAiYnkgaGFuZCIg
d2FzIGdlbmVyYXRpbmcgc3B1cmlvdXMgRE1BIFNFUlYgUkVRVUVTVAorCSAqIGZyb20gU1NQIHRv
IERNQSA9PiB0aGVuIGJ1Z2d5IHJldHJpZXZhbCBvZiBkYXRhIGZvciBuZXh0IGRtYV9yZXEKKwkg
KiBEaXNhYmxlOiBSWCBTZXJ2aWNlIFJlcXVlc3QgZnJvbSBSWCBmaWZvIHRvIERNQQorCSAqIGFz
IHdlIHdpbGwgZmx1c2ggYnkgaGFuZAorCSAqLworCWNsZWFyX1NTQ1IxX3JlZyhyZWcsIFJTUkUp
OworCS8qIGkyc19mbHVzaCBpcyBjYWxsZWQgaW4gYmV0d2VlbiAyIGJ1cnN0cworCSAqID0+IG5v
IEZNU1lOQyBhdCB0aGF0IHRpbWUgKGkuZS4gU1NQIG5vdCBidXN5KQorCSAqID0+IGF0IG1vc3Qg
MTYgc2FtcGxlcyBpbiB0aGUgRklGTyAqLworCXdoaWxlICgocmVhZF9TU1NSKHJlZykgJiAoU1NT
Ul9STkVfTUFTSzw8U1NTUl9STkVfU0hJRlQpKQorCQkJJiYgKG51bSA8IEZJRk9fU0laRSkpIHsK
KwkJZGF0YSA9IHJlYWRfU1NEUihyZWcpOworCQludW0rKzsKKwkJZGV2X3dhcm4oJmRydl9kYXRh
LT5wZGV2LT5kZXYsICJmbHVzaCgldSk9JXVcbiIsIG51bSwgZGF0YSk7CisJfQorCS8qIEVuYWJs
ZTogUlggU2VydmljZSBSZXF1ZXN0IGZyb20gUlggZmlmbyB0byBETUEKKwkgKiBhcyBmbHVzaCBi
eSBoYW5kIGlzIGRvbmUKKwkgKi8KKwlzZXRfU1NDUjFfcmVnKHJlZywgUlNSRSk7CisJc3NzciA9
IHJlYWRfU1NTUihyZWcpOworCWRldl9kYmcoJmRydl9kYXRhLT5wZGV2LT5kZXYsICJvdXQgZmx1
c2ggc3Nzcj0weCUwOFhcbiIsIHNzc3IpOworCXJldHVybiBudW07Cit9CitFWFBPUlRfU1lNQk9M
X0dQTChpbnRlbF9taWRfaTJzX2ZsdXNoKTsKKworLyoqCisgKiBpbnRlbF9taWRfaTJzX2dldF9y
eF9maWZvX2xldmVsIC0gcmV0dXJucyBJMlMgcnggZmlmbyBsZXZlbAorICogQGRydl9kYXRhIDog
cG9pbnRlciBvbiBwcml2YXRlIGkycyBkcml2ZXIgZGF0YSAoYnkgaTJzX29wZW4gZnVuY3Rpb24p
CisgKgorICogT3V0cHV0IHBhcmFtZXRlcnMKKyAqICAgICAgaW50IDogTnVtYmVyIG9mIHNhbXBs
ZXMgY3VycmVudGx5IGluIHRoZSBSWCBGSUZPIChuZWdhdGl2ZSA9IGVycm9yKQorICovCitpbnQg
aW50ZWxfbWlkX2kyc19nZXRfcnhfZmlmb19sZXZlbChzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwg
KmRydl9kYXRhKQoreworCXUzMiBzc3NyOworCXUzMiBybmUsIHJmbDsKKwl2b2lkIF9faW9tZW0g
KnJlZzsKKworCVdBUk4oIWRydl9kYXRhLCAiRHJpdmVyIGRhdGE9TlVMTFxuIik7CisJaWYgKCFk
cnZfZGF0YSkKKwkJcmV0dXJuIC1FRkFVTFQ7CisJcmVnID0gZHJ2X2RhdGEtPmlvYWRkcjsKKwlz
c3NyID0gcmVhZF9TU1NSKHJlZyk7CisJcmZsID0gR0VUX1NTU1JfdmFsKHNzc3IsIFJGTCk7CisJ
cm5lID0gR0VUX1NTU1JfdmFsKHNzc3IsIFJORSk7CisJaWYgKCFybmUpCisJCXJldHVybiAwOwor
CWVsc2UKKwkJcmV0dXJuIHJmbCsxOworfQorRVhQT1JUX1NZTUJPTF9HUEwoaW50ZWxfbWlkX2ky
c19nZXRfcnhfZmlmb19sZXZlbCk7CisKKy8qKgorICogaW50ZWxfbWlkX2kyc19nZXRfdHhfZmlm
b19sZXZlbCAtIHJldHVybnMgSTJTIHR4IGZpZm8gbGV2ZWwKKyAqIEBkcnZfZGF0YSA6IHBvaW50
ZXIgb24gcHJpdmF0ZSBpMnMgZHJpdmVyIGRhdGEgKGJ5IGkyc19vcGVuIGZ1bmN0aW9uKQorICoK
KyAqIE91dHB1dCBwYXJhbWV0ZXJzCisgKiAgICAgIGludCA6IG51bWJlciBvZiBzYW1wbGVzIGN1
cnJlbnRseSBpbiB0aGUgVFggRklGTyAobmVnYXRpdmUgPSBlcnJvcikKKyAqLworaW50IGludGVs
X21pZF9pMnNfZ2V0X3R4X2ZpZm9fbGV2ZWwoc3RydWN0IGludGVsX21pZF9pMnNfaGRsICpkcnZf
ZGF0YSkKK3sKKwl1MzIgc3NzcjsKKwl1MzIgdG5mLCB0Zmw7CisJdm9pZCBfX2lvbWVtICpyZWc7
CisJV0FSTighZHJ2X2RhdGEsICJEcml2ZXIgZGF0YT1OVUxMXG4iKTsKKwlpZiAoIWRydl9kYXRh
KQorCQlyZXR1cm4gLUVGQVVMVDsKKwlyZWcgPSBkcnZfZGF0YS0+aW9hZGRyOworCXNzc3IgPSBy
ZWFkX1NTU1IocmVnKTsKKwl0ZmwgPSBHRVRfU1NTUl92YWwoc3NzciwgVEZMKTsKKwl0bmYgPSBH
RVRfU1NTUl92YWwoc3NzciwgVEZOKTsKKwlpZiAoIXRuZikKKwkJcmV0dXJuIDE2OworCWVsc2UK
KwkJcmV0dXJuIHRmbDsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKGludGVsX21pZF9pMnNfZ2V0X3R4
X2ZpZm9fbGV2ZWwpOworCisvKioKKyAqIGludGVsX21pZF9pMnNfc2V0X3JkX2NiIC0gc2V0IHRo
ZSBjYWxsYmFjayBmdW5jdGlvbiBhZnRlciByZWFkIGlzIGRvbmUKKyAqIEBkcnZfZGF0YSA6IGhh
bmRsZSBvZiBjb3JyZXNwb25kaW5nIHNzcCBpMnMgKGdpdmVuIGJ5IGkyc19vcGVuIGZ1bmN0aW9u
KQorICogQHJlYWRfY2FsbGJhY2sgOiBwb2ludGVyIG9mIGNhbGxiYWNrIGZ1bmN0aW9uCisgKgor
ICogT3V0cHV0IHBhcmFtZXRlcnMKKyAqICAgICAgZXJyb3IgOiAwIG1lYW5zIG5vIGVycm9yCisg
Ki8KK2ludCBpbnRlbF9taWRfaTJzX3NldF9yZF9jYihzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwg
KmRydl9kYXRhLCBpbnQgKCpyZWFkX2NhbGxiYWNrKSh2b2lkICpwYXJhbSkpCit7CisJV0FSTigh
ZHJ2X2RhdGEsICJEcml2ZXIgZGF0YT1OVUxMXG4iKTsKKwlpZiAoIWRydl9kYXRhKQorCQlyZXR1
cm4gLUVGQVVMVDsKKwltdXRleF9sb2NrKCZkcnZfZGF0YS0+bXV0ZXgpOworCWlmICghdGVzdF9i
aXQoSTJTX1BPUlRfT1BFTkVELCAmZHJ2X2RhdGEtPmZsYWdzKSkgeworCQlkZXZfV0FSTigmZHJ2
X2RhdGEtPnBkZXYtPmRldiwgInNldCBXUiBDQiBJMlNfUE9SVCBOT1RfT1BFTkVEIik7CisJCW11
dGV4X3VubG9jaygmZHJ2X2RhdGEtPm11dGV4KTsKKwkJcmV0dXJuIC1FUEVSTTsKKwl9CisJLyog
RG8gbm90IGNoYW5nZSByZWFkIHBhcmFtZXRlcnMgaW4gdGhlIG1pZGRsZSBvZiBhIFJFQUQgcmVx
dWVzdCAqLworCWlmICh0ZXN0X2JpdChJMlNfUE9SVF9SRUFEX0JVU1ksICZkcnZfZGF0YS0+Zmxh
Z3MpKSB7CisJCWRldl9XQVJOKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAiQ0IgcmVqZWN0IEkyU19Q
T1JUX1JFQURfQlVTWSIpOworCQltdXRleF91bmxvY2soJmRydl9kYXRhLT5tdXRleCk7CisJCXJl
dHVybiAtRUJVU1k7CisJfQorCWRydl9kYXRhLT5yZWFkX2NhbGxiYWNrID0gcmVhZF9jYWxsYmFj
azsKKwlkcnZfZGF0YS0+cmVhZF9sZW4gPSAwOworCW11dGV4X3VubG9jaygmZHJ2X2RhdGEtPm11
dGV4KTsKKwlyZXR1cm4gMDsKKworfQorRVhQT1JUX1NZTUJPTF9HUEwoaW50ZWxfbWlkX2kyc19z
ZXRfcmRfY2IpOworCisvKioKKyAqIGludGVsX21pZF9pMnNfc2V0X3dyX2NiIC0gc2V0IHRoZSBj
YWxsYmFjayBmdW5jdGlvbiBhZnRlciB3cml0ZSBpcyBkb25lCisgKiBAZHJ2X2RhdGEgOiBoYW5k
bGUgb2YgY29ycmVzcG9uZGluZyBzc3AgaTJzIChnaXZlbiBieSBpMnNfb3BlbiAgZnVuY3Rpb24p
CisgKiBAd3JpdGVfY2FsbGJhY2sgOiBwb2ludGVyIG9mIGNhbGxiYWNrIGZ1bmN0aW9uCisgKgor
ICogT3V0cHV0IHBhcmFtZXRlcnMKKyAqICAgICAgZXJyb3IgOiAwIG1lYW5zIG5vIGVycm9yCisg
Ki8KK2ludCBpbnRlbF9taWRfaTJzX3NldF93cl9jYihzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwg
KmRydl9kYXRhLCBpbnQgKCp3cml0ZV9jYWxsYmFjaykodm9pZCAqcGFyYW0pKQoreworCVdBUk4o
IWRydl9kYXRhLCAiRHJpdmVyIGRhdGE9TlVMTFxuIik7CisJaWYgKCFkcnZfZGF0YSkKKwkJcmV0
dXJuIC1FRkFVTFQ7CisJbXV0ZXhfbG9jaygmZHJ2X2RhdGEtPm11dGV4KTsKKwlpZiAoIXRlc3Rf
Yml0KEkyU19QT1JUX09QRU5FRCwgJmRydl9kYXRhLT5mbGFncykpIHsKKwkJZGV2X3dhcm4oJmRy
dl9kYXRhLT5wZGV2LT5kZXYsICJzZXQgV1IgQ0IgSTJTX1BPUlQgTk9UX09QRU5FRCIpOworCQlt
dXRleF91bmxvY2soJmRydl9kYXRhLT5tdXRleCk7CisJCXJldHVybiAtRVBFUk07CisJfQorCS8q
IERvIG5vdCBjaGFuZ2Ugd3JpdGUgcGFyYW1ldGVycyBpbiB0aGUgbWlkZGxlIG9mIGEgV1JJVEUg
cmVxdWVzdCAqLworCWlmICh0ZXN0X2JpdChJMlNfUE9SVF9XUklURV9CVVNZLCAmZHJ2X2RhdGEt
PmZsYWdzKSkgeworCQlkZXZfd2FybigmZHJ2X2RhdGEtPnBkZXYtPmRldiwgIkNCIHJlamVjdCBJ
MlNfUE9SVF9XUklURV9CVVNZIik7CisJCW11dGV4X3VubG9jaygmZHJ2X2RhdGEtPm11dGV4KTsK
KwkJcmV0dXJuIC1FQlVTWTsKKwl9CisJZHJ2X2RhdGEtPndyaXRlX2NhbGxiYWNrID0gd3JpdGVf
Y2FsbGJhY2s7CisJZHJ2X2RhdGEtPndyaXRlX2xlbiA9IDA7CisJbXV0ZXhfdW5sb2NrKCZkcnZf
ZGF0YS0+bXV0ZXgpOworCXJldHVybiAwOworfQorRVhQT1JUX1NZTUJPTF9HUEwoaW50ZWxfbWlk
X2kyc19zZXRfd3JfY2IpOworCisvKioKKyAqIGludGVsX21pZF9pMnNfZW5hYmxlX3NzcCgpIDog
c3RhcnQgdGhlIHNzcCByaWdodCBhZnRlciB0aGUgcmVhZC93cml0ZSByZXEKKyAqIEBkcnZfZGF0
YSA6IGhhbmRsZSBvZiBjb3JyZXNwb25kaW5nIHNzcCBpMnMgKGdpdmVuIGJ5IGkyc19vcGVuIGZ1
bmN0aW9uKQorICoKKyAqIFRoaXMgZW5hYmxlIHRoZSByZWFkL3dyaXRlIHRvIGJlIHN0YXJ0ZWQg
c3luY2hyb25vdXNseQorICoKKyAqIE91dHB1dCBwYXJhbWV0ZXJzCisgKiAgICAgIGVycm9yIDog
MCBtZWFucyBubyBlcnJvcgorICovCitpbnQgaW50ZWxfbWlkX2kyc19lbmFibGVfc3NwKHN0cnVj
dCBpbnRlbF9taWRfaTJzX2hkbCAqZHJ2X2RhdGEpCit7CisJdm9pZCBfX2lvbWVtICpyZWcgPSBk
cnZfZGF0YS0+aW9hZGRyOworCXNldF9TU0NSMF9yZWcocmVnLCBTU0UpOworCXJldHVybiAwOwor
fQorRVhQT1JUX1NZTUJPTF9HUEwoaW50ZWxfbWlkX2kyc19lbmFibGVfc3NwKTsKKworLyoqCisg
KiBpbnRlbF9taWRfaTJzX3JkX3JlcSAtIHJlcXVlc3QgYSByZWFkIGZyb20gaTJzIHBlcmlwaGVy
YWwKKyAqIEBkcnZfZGF0YSA6IGhhbmRsZSBvZiBjb3JyZXNwb25kaW5nIHNzcCBpMnMgKGdpdmVu
IGJ5IGkyc19vcGVuIGZ1bmN0aW9uKQorICogQGRzdCA6IGRlc3RpbmF0aW9uIGJ1ZmZlciB3aGVy
ZSB0aGUgcmVhZCBzYW1wbGUgc2hvdWxkIGJlIHB1dAorICogQGxlbiA6IG51bWJlciBvZiBzYW1w
bGUgdG8gYmUgcmVhZCAoMTYwIHNhbXBsZXMgb25seSByaWdodCBub3cpCisgKiBAcGFyYW0gOiBw
cml2YXRlIGNvbnRleHQgcGFyYW1ldGVyIHRvIGdpdmUgYmFjayB0byByZWFkIGNhbGxiYWNrCisg
KgorICogT3V0cHV0IHBhcmFtZXRlcnMKKyAqICAgICAgZXJyb3IgOiAwIG1lYW5zIG5vIGVycm9y
CisgKi8KK2ludCBpbnRlbF9taWRfaTJzX3JkX3JlcShzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwg
KmRydl9kYXRhLCB1MzIgKmRlc3RpbmF0aW9uLCBzaXplX3QgbGVuLCB2b2lkICpwYXJhbSkKK3sK
KwlzdHJ1Y3QgZG1hX2FzeW5jX3R4X2Rlc2NyaXB0b3IgKnJ4ZGVzYyA9IE5VTEw7CisJc3RydWN0
IGRtYV9jaGFuICpyeGNoYW4gPSBkcnZfZGF0YS0+cnhjaGFuOworCWVudW0gZG1hX2N0cmxfZmxh
Z3MgZmxhZzsKKwlkbWFfYWRkcl90IHNzZHJfYWRkcjsKKwlkbWFfYWRkcl90IGRzdDsKKwlXQVJO
KCFkcnZfZGF0YSwgIkRyaXZlciBkYXRhPU5VTExcbiIpOworCWlmICghZHJ2X2RhdGEpCisJCXJl
dHVybiAtRUZBVUxUOworCW11dGV4X2xvY2soJmRydl9kYXRhLT5tdXRleCk7CisJaWYgKCFyeGNo
YW4pIHsKKwkJZGV2X1dBUk4oJihkcnZfZGF0YS0+cGRldi0+ZGV2KSwgInJkX3JlcSBGQUlMRUQg
bm8gcnhjaGFuXG4iKTsKKwkJbXV0ZXhfdW5sb2NrKCZkcnZfZGF0YS0+bXV0ZXgpOworCQlyZXR1
cm4gLUVJTlZBTDsKKwl9CisJaWYgKCFsZW4pIHsKKwkJZGV2X1dBUk4oJmRydl9kYXRhLT5wZGV2
LT5kZXYsICJyZCByZXEgaW52YWxpZCBsZW49MCIpOworCQltdXRleF91bmxvY2soJmRydl9kYXRh
LT5tdXRleCk7CisJCXJldHVybiAtRUlOVkFMOworCX0KKwlpZiAoIXRlc3RfYml0KEkyU19QT1JU
X09QRU5FRCwgJmRydl9kYXRhLT5mbGFncykpIHsKKwkJZGV2X1dBUk4oJmRydl9kYXRhLT5wZGV2
LT5kZXYsICJSRCByZWplY3QgSTJTX1BPUlQgTk9UX09QRU5FRCIpOworCQltdXRleF91bmxvY2so
JmRydl9kYXRhLT5tdXRleCk7CisJCXJldHVybiAtRVBFUk07CisJfQorCWlmICh0ZXN0X2JpdChJ
MlNfUE9SVF9DTE9TSU5HLCAmZHJ2X2RhdGEtPmZsYWdzKSkgeworCQlkZXZfV0FSTigmZHJ2X2Rh
dGEtPnBkZXYtPmRldiwgIlJEIHJlamVjdCBJMlNfUE9SVCBDTE9TSU5HIik7CisJCW11dGV4X3Vu
bG9jaygmZHJ2X2RhdGEtPm11dGV4KTsKKwkJcmV0dXJuIC1FUElQRTsKKwl9CisKKwlkZXZfZGJn
KCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAiSTJTX1JFQUQoKSBkc3Q9JXAsIGxlbj0lZCwgZHJ2X2Rh
dGE9JXAiLAlkZXN0aW5hdGlvbiwgbGVuLCBkcnZfZGF0YSk7CisJZHN0ID0gZG1hX21hcF9zaW5n
bGUoTlVMTCwgZGVzdGluYXRpb24sIGxlbiwgRE1BX0ZST01fREVWSUNFKTsKKwlpZiAoIWRzdCkg
eworCQlkZXZfV0FSTigmZHJ2X2RhdGEtPnBkZXYtPmRldiwgImNhbid0IG1hcCBETUEgYWRkcmVz
cyAlcCIsIGRlc3RpbmF0aW9uKTsKKwkJbXV0ZXhfdW5sb2NrKCZkcnZfZGF0YS0+bXV0ZXgpOwor
CQlyZXR1cm4gLUVOT01FTTsKKwl9CisKKwlkcnZfZGF0YS0+cmVhZF9kc3QgPSBkc3Q7CisJZHJ2
X2RhdGEtPnJlYWRfbGVuID0gbGVuOworCS8qIGdldCBEYXRhIFJlYWQvV3JpdGUgYWRkcmVzcyAq
LworCXNzZHJfYWRkciA9IChkcnZfZGF0YS0+cGFkZHIgKyBPRkZTRVRfU1NEUik7CisJc2V0X1NT
Q1IxX3JlZygoZHJ2X2RhdGEtPmlvYWRkciksIFJTUkUpOworCWNoYW5nZV9TU0NSMF9yZWcoKGRy
dl9kYXRhLT5pb2FkZHIpLCBSSU0sCisJCQkgKChkcnZfZGF0YS0+Y3VycmVudF9zZXR0aW5ncyku
cnhfZmlmb19pbnRlcnJ1cHQpKTsKKwlmbGFnID0gRE1BX1BSRVBfSU5URVJSVVBUIHwgRE1BX0NU
UkxfQUNLOworCS8qIFN0YXJ0IHRoZSBSWCBkbWEgdHJhbnNmZXIgKi8KKwlyeGRlc2MgPSByeGNo
YW4tPmRldmljZS0+ZGV2aWNlX3ByZXBfZG1hX21lbWNweSgKKwkJCXJ4Y2hhbiwJCS8qIERNQSBD
aGFubmVsICovCisJCQlkc3QsCQkvKiBEQVIgKi8KKwkJCXNzZHJfYWRkciwJLyogU0FSICovCisJ
CQlsZW4sCQkvKiBEYXRhIExlbmd0aCAqLworCQkJZmxhZyk7CQkvKiBGbGFnICovCisJaWYgKCFy
eGRlc2MpIHsKKwkJZGV2X1dBUk4oJmRydl9kYXRhLT5wZGV2LT5kZXYsICJjYW4gbm90IHByZXAg
ZG1hIG1lbWNweSIpOworCQltdXRleF91bmxvY2soJmRydl9kYXRhLT5tdXRleCk7CisJCXJldHVy
biAtRUZBVUxUOworCX0KKwkvKiBPbmx5IDEgUkVBRCBhdCBhIHRpbWUgYWxsb3dlZC4gZG8gaXQg
YXQgZW5kIHRvIGF2b2lkIGNsZWFyJndha2V1cCovCisJaWYgKHRlc3RfYW5kX3NldF9iaXQoSTJT
X1BPUlRfUkVBRF9CVVNZLCAmZHJ2X2RhdGEtPmZsYWdzKSkgeworCQlkbWFfdW5tYXBfc2luZ2xl
KE5VTEwsIGRzdCwgbGVuLCBETUFfRlJPTV9ERVZJQ0UpOworCQlkZXZfV0FSTigmZHJ2X2RhdGEt
PnBkZXYtPmRldiwgIlJEIHJlamVjdCBJMlNfUE9SVCBSRUFEX0JVU1kiKTsKKwkJbXV0ZXhfdW5s
b2NrKCZkcnZfZGF0YS0+bXV0ZXgpOworCQlyZXR1cm4gLUVCVVNZOworCX0KKwlkZXZfZGJnKCYo
ZHJ2X2RhdGEtPnBkZXYtPmRldiksICJSRCBkbWEgdHggc3VibWl0XG4iKTsKKwlyeGRlc2MtPmNh
bGxiYWNrID0gaTJzX3JlYWRfZG9uZTsKKwlkcnZfZGF0YS0+cmVhZF9wYXJhbSA9IHBhcmFtOwor
CXJ4ZGVzYy0+Y2FsbGJhY2tfcGFyYW0gPSBkcnZfZGF0YTsKKwlyeGRlc2MtPnR4X3N1Ym1pdChy
eGRlc2MpOworCW11dGV4X3VubG9jaygmZHJ2X2RhdGEtPm11dGV4KTsKKwlyZXR1cm4gMDsKK30K
K0VYUE9SVF9TWU1CT0xfR1BMKGludGVsX21pZF9pMnNfcmRfcmVxKTsKKworLyoqCisgKiBpbnRl
bF9taWRfaTJzX3dyX3JlcSAtIHJlcXVlc3QgYSB3cml0ZSB0byBpMnMgcGVyaXBoZXJhbAorICog
QGRydl9kYXRhIDogaGFuZGxlIG9mIGNvcnJlc3BvbmRpbmcgc3NwIGkycyAoZ2l2ZW4gYnkgaTJz
X29wZW4gZnVuY3Rpb24pCisgKiBAc3JjIDogc291cmNlIGJ1ZmZlciB3aGVyZSB0aGUgc2FtcGxl
cyB0byB3cm90ZSBzaG91bGQgYmUgZ2V0CisgKiBAbGVuIDogbnVtYmVyIG9mIHNhbXBsZSB0byBi
ZSByZWFkICgxNjAgc2FtcGxlcyBvbmx5IHJpZ2h0IG5vdykKKyAqIEBwYXJhbSA6IHByaXZhdGUg
Y29udGV4dCBwYXJhbWV0ZXIgdG8gZ2l2ZSBiYWNrIHRvIHdyaXRlIGNhbGxiYWNrCisgKgorICog
T3V0cHV0IHBhcmFtZXRlcnMKKyAqICAgICAgZXJyb3IgOiAwIG1lYW5zIG5vIGVycm9yCisgKi8K
K2ludCBpbnRlbF9taWRfaTJzX3dyX3JlcShzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwgKmRydl9k
YXRhLCB1MzIgKnNvdXJjZSwgc2l6ZV90IGxlbiwgdm9pZCAqcGFyYW0pCit7CisJZG1hX2FkZHJf
dCBzc2RyX2FkZHI7CisJc3RydWN0IGRtYV9hc3luY190eF9kZXNjcmlwdG9yICp0eGRlc2MgPSBO
VUxMOworCXN0cnVjdCBkbWFfY2hhbiAqdHhjaGFuID0gZHJ2X2RhdGEtPnR4Y2hhbjsKKwllbnVt
IGRtYV9jdHJsX2ZsYWdzIGZsYWc7CisJZG1hX2FkZHJfdCBzcmM7CisJV0FSTighZHJ2X2RhdGEs
ICJEcml2ZXIgZGF0YT1OVUxMXG4iKTsKKwlpZiAoIWRydl9kYXRhKQorCQlyZXR1cm4gLUVGQVVM
VDsKKwltdXRleF9sb2NrKCZkcnZfZGF0YS0+bXV0ZXgpOworCWlmICghdHhjaGFuKSB7CisJCWRl
dl9XQVJOKCYoZHJ2X2RhdGEtPnBkZXYtPmRldiksICJ3cl9yZXEgYnV0IG5vIHR4Y2hhblxuIik7
CisJCW11dGV4X3VubG9jaygmZHJ2X2RhdGEtPm11dGV4KTsKKwkJcmV0dXJuIC1FSU5WQUw7CisJ
fQorCWlmICghbGVuKSB7CisJCWRldl9XQVJOKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAiaW52YWxp
ZCBsZW4gMCIpOworCQltdXRleF91bmxvY2soJmRydl9kYXRhLT5tdXRleCk7CisJCXJldHVybiAt
RUlOVkFMOworCX0KKwlpZiAoIXRlc3RfYml0KEkyU19QT1JUX09QRU5FRCwgJmRydl9kYXRhLT5m
bGFncykpIHsKKwkJZGV2X1dBUk4oJmRydl9kYXRhLT5wZGV2LT5kZXYsICJXUiByZWplY3QgSTJT
X1BPUlQgTk9UX09QRU5FRCIpOworCQltdXRleF91bmxvY2soJmRydl9kYXRhLT5tdXRleCk7CisJ
CXJldHVybiAtRVBFUk07CisJfQorCWlmICh0ZXN0X2JpdChJMlNfUE9SVF9DTE9TSU5HLCAmZHJ2
X2RhdGEtPmZsYWdzKSkgeworCQlkZXZfV0FSTigmZHJ2X2RhdGEtPnBkZXYtPmRldiwgIldSIHJl
amVjdCBJMlNfUE9SVCBDTE9TSU5HIik7CisJCW11dGV4X3VubG9jaygmZHJ2X2RhdGEtPm11dGV4
KTsKKwkJcmV0dXJuIC1FUElQRTsKKwl9CisKKwlkZXZfZGJnKCZkcnZfZGF0YS0+cGRldi0+ZGV2
LCAiSTJTX1dSSVRFKCkgc3JjPSVwLCBsZW49JWQsIGRydl9kYXRhPSVwIiwgc291cmNlLCBsZW4s
IGRydl9kYXRhKTsKKworCXNyYyA9IGRtYV9tYXBfc2luZ2xlKE5VTEwsIHNvdXJjZSwgbGVuLCBE
TUFfVE9fREVWSUNFKTsKKwlpZiAoIXNyYykgeworCQlkZXZfV0FSTigmZHJ2X2RhdGEtPnBkZXYt
PmRldiwgImNhbid0IG1hcCBETUEgYWRkcmVzcyAlcCIsIHNvdXJjZSk7CisJCW11dGV4X3VubG9j
aygmZHJ2X2RhdGEtPm11dGV4KTsKKwkJcmV0dXJuIC1FRkFVTFQ7CisJfQorCWRydl9kYXRhLT53
cml0ZV9zcmMgPSBzcmM7CisJZHJ2X2RhdGEtPndyaXRlX2xlbiA9IGxlbjsKKwkvKiBnZXQgRGF0
YSBSZWFkL1dyaXRlIGFkZHJlc3MgKi8KKwlzc2RyX2FkZHIgPSAoZG1hX2FkZHJfdCkodTMyKShk
cnZfZGF0YS0+cGFkZHIgKyBPRkZTRVRfU1NEUik7CisJc2V0X1NTQ1IxX3JlZygoZHJ2X2RhdGEt
PmlvYWRkciksIFRTUkUpOworCWNoYW5nZV9TU0NSMF9yZWcoKGRydl9kYXRhLT5pb2FkZHIpLCBU
SU0sCisJCQkgKChkcnZfZGF0YS0+Y3VycmVudF9zZXR0aW5ncykudHhfZmlmb19pbnRlcnJ1cHQp
KTsKKwlmbGFnID0gRE1BX1BSRVBfSU5URVJSVVBUIHwgRE1BX0NUUkxfQUNLOworCXR4ZGVzYyA9
IHR4Y2hhbi0+ZGV2aWNlLT5kZXZpY2VfcHJlcF9kbWFfbWVtY3B5KAorCQkJdHhjaGFuLAkJLyog
RE1BIENoYW5uZWwgKi8KKwkJCXNzZHJfYWRkciwJLyogREFSICovCisJCQlzcmMsCQkvKiBTQVIg
Ki8KKwkJCWxlbiwJCS8qIERhdGEgTGVuZ3RoICovCisJCQlmbGFnKTsJCS8qIEZsYWcgKi8KKwlp
ZiAoIXR4ZGVzYykgeworCQlkZXZfV0FSTigmKGRydl9kYXRhLT5wZGV2LT5kZXYpLAorCQkJIndy
X3JlcSBkbWEgbWVtY3B5IEZBSUxFRChzcmM9JTA4eCxsZW49JWQsdHhjaGFuPSVwKVxuIiwKKwkJ
CXNyYywgbGVuLCB0eGNoYW4pOworCQltdXRleF91bmxvY2soJmRydl9kYXRhLT5tdXRleCk7CisJ
CXJldHVybiAtMTsKKwl9CisJZGV2X2RiZygmKGRydl9kYXRhLT5wZGV2LT5kZXYpLCAiV1IgZG1h
IHR4IHN1bW1pdFxuIik7CisJLyogT25seSAxIFdSSVRFIGF0IGEgdGltZSBhbGxvd2VkICovCisJ
aWYgKHRlc3RfYW5kX3NldF9iaXQoSTJTX1BPUlRfV1JJVEVfQlVTWSwgJmRydl9kYXRhLT5mbGFn
cykpIHsKKwkJZG1hX3VubWFwX3NpbmdsZShOVUxMLCBzcmMsIGxlbiwgRE1BX1RPX0RFVklDRSk7
CisJCWRldl9XQVJOKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAiV1IgcmVqZWN0IEkyU19QT1JUIFdS
SVRFX0JVU1kiKTsKKwkJbXV0ZXhfdW5sb2NrKCZkcnZfZGF0YS0+bXV0ZXgpOworCQlyZXR1cm4g
LUVCVVNZOworCX0KKwl0eGRlc2MtPmNhbGxiYWNrID0gaTJzX3dyaXRlX2RvbmU7CisJZHJ2X2Rh
dGEtPndyaXRlX3BhcmFtID0gcGFyYW07CisJdHhkZXNjLT5jYWxsYmFja19wYXJhbSA9IGRydl9k
YXRhOworCXR4ZGVzYy0+dHhfc3VibWl0KHR4ZGVzYyk7CisJZGV2X2RiZygmKGRydl9kYXRhLT5w
ZGV2LT5kZXYpLCAid3IgZG1hIHJlcSBwcm9ncmFtbWVkXG4iKTsKKwltdXRleF91bmxvY2soJmRy
dl9kYXRhLT5tdXRleCk7CisJcmV0dXJuIDA7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChpbnRlbF9t
aWRfaTJzX3dyX3JlcSk7CisKKy8qKgorICogaW50ZWxfbWlkX2kyc19vcGVuIC0gcmVzZXJ2ZSBh
bmQgc3RhcnQgYSBTU1AgZGVwZW5kaW5nIG9mIGl0J3MgdXNhZ2UKKyAqIEB1c2FnZSA6IHNlbGVj
dCB3aGljaCBzc3AgaTJzIHlvdSBuZWVkIGJ5IGdpdmluZyB1c2FnZSAoQlQsTU9ERU0uLi4pCisg
KiBAcHNfc2V0dGluZ3MgOiBoYXJkd2FyZSBzZXR0aW5ncyB0byBjb25maWd1cmUgdGhlIFNTUCBt
b2R1bGUKKyAqCisgKiBNYXkgc2xlZXAgKGRyaXZlcl9maW5kX2RldmljZSkgOiBubyBsb2NrIHBl
cm1pdHRlZCB3aGVuIGNhbGxlZC4KKyAqCisgKiBPdXRwdXQgcGFyYW1ldGVycworICogICAgICBo
YW5kbGUgOiBoYW5kbGUgb2YgdGhlIHNlbGVjdGVkIFNTUCwgb3IgTlVMTCBpZiBub3QgZm91bmQK
KyAqLworc3RydWN0IGludGVsX21pZF9pMnNfaGRsICppbnRlbF9taWRfaTJzX29wZW4oZW51bSBp
bnRlbF9taWRfaTJzX3NzcF91c2FnZSB1c2FnZSwKKwkJCSBjb25zdCBzdHJ1Y3QgaW50ZWxfbWlk
X2kyc19zZXR0aW5ncyAqcHNfc2V0dGluZ3MpCit7CisJc3RydWN0IHBjaV9kZXYgKnBkZXY7CisJ
c3RydWN0IGludGVsX21pZF9pMnNfaGRsICpkcnZfZGF0YSA9IE5VTEw7CisJc3RydWN0IGRldmlj
ZSAqZm91bmRfZGV2aWNlID0gTlVMTDsKKwlwcl9kZWJ1ZygiJXMgOiBvcGVuIGNhbGxlZCxzZWFy
Y2hpbmcgZm9yIGRldmljZSB3aXRoIHVzYWdlPSV4ICFcbiIsIERSSVZFUl9OQU1FLCB1c2FnZSk7
CisJZm91bmRfZGV2aWNlID0gZHJpdmVyX2ZpbmRfZGV2aWNlKCYoaW50ZWxfbWlkX2kyc19kcml2
ZXIuZHJpdmVyKSwgTlVMTCwgJnVzYWdlLCBjaGVja19kZXZpY2UpOworCWlmICghZm91bmRfZGV2
aWNlKSB7CisJCXByX2RlYnVnKCIlcyA6IG9wZW4gY2FuIG5vdCBmb3VuZCB3aXRoIHVzYWdlPTB4
JTAyWFxuIiwgRFJJVkVSX05BTUUsIChpbnQpdXNhZ2UpOworCQlyZXR1cm4gTlVMTDsKKwl9CisJ
cGRldiA9IHRvX3BjaV9kZXYoZm91bmRfZGV2aWNlKTsKKwlkcnZfZGF0YSA9IHBjaV9nZXRfZHJ2
ZGF0YShwZGV2KTsKKworCWlmICghZHJ2X2RhdGEpIHsKKwkJZGV2X2Vycihmb3VuZF9kZXZpY2Us
ICJubyBkcnZfZGF0YSBpbiBvcGVuIHBkZXY9JXBcbiIsIHBkZXYpOworCQlwdXRfZGV2aWNlKGZv
dW5kX2RldmljZSk7CisJCXJldHVybiBOVUxMOworCX0KKwltdXRleF9sb2NrKCZkcnZfZGF0YS0+
bXV0ZXgpOworCWRldl9kYmcoZm91bmRfZGV2aWNlLCAiT3BlbiBmb3VuZCBwZGV2aWNlPTB4JXBc
biIsIHBkZXYpOworCS8qIHBtX3J1bnRpbWUgKi8KKwlwbV9ydW50aW1lX2dldF9zeW5jKCZkcnZf
ZGF0YS0+cGRldi0+ZGV2KTsKKwkvKiBkbWFjMSBpcyBhbHJlYWR5IHNldCBkdXJpbmcgcHJvYmUg
Ki8KKwlpZiAoaTJzX2RtYV9zdGFydChkcnZfZGF0YSkgIT0gMCkgeworCQlkZXZfZXJyKGZvdW5k
X2RldmljZSwgIkNhbiBub3Qgc3RhcnQgRE1BXG4iKTsKKwkJZ290byBvcGVuX2Vycm9yOworCX0K
KwkvKiBpZiB3ZSByZXN0YXJ0IGFmdGVyIHN0b3Agd2l0aG91dCBzdXNwZW5kLCB3ZSBzdGFydCBz
c3AgZmFzdGVyICovCisJZHJ2X2RhdGEtPmN1cnJlbnRfc2V0dGluZ3MgPSAqcHNfc2V0dGluZ3M7
CisJc2V0X3NzcF9pMnNfaHcoZHJ2X2RhdGEsIHBzX3NldHRpbmdzKTsKKworCWRydl9kYXRhLT5t
YXNrX3NyID0gKChTU1NSX0JDRV9NQVNLIDw8IFNTU1JfQkNFX1NISUZUKSB8CisJCQkoU1NTUl9F
T0NfTUFTSyA8PCBTU1NSX0VPQ19TSElGVCkgfAorCQkJKFNTU1JfUk9SX01BU0sgPDwgU1NTUl9S
T1JfU0hJRlQpIHwKKwkJCShTU1NSX1RVUl9NQVNLIDw8IFNTU1JfVFVSX1NISUZUKSB8CisJCQko
U1NTUl9USU5UX01BU0sgPDwgU1NTUl9USU5UX1NISUZUKSB8CisJCQkoU1NTUl9QSU5UX01BU0sg
PDwgU1NTUl9QSU5UX1NISUZUKSk7CisJaWYgKHRlc3RfYml0KEkyU19QT1JUX0NMT1NJTkcsICZk
cnZfZGF0YS0+ZmxhZ3MpKSB7CisJCWRldl9lcnIoJmRydl9kYXRhLT5wZGV2LT5kZXYsICJPcGVu
aW5nIGEgY2xvc2luZyBJMlMhIik7CisJCWdvdG8gb3Blbl9lcnJvcjsKKwl9CisJLyogdGhlcmUg
aXMgbm8gbmVlZCB0byAid2FrZSB1cCIgYXMgd2UgY2FuIG5vdCBjbG9zZSBhbiBvcGVuaW5nIGky
cyAqLworCWNsZWFyX2JpdChJMlNfUE9SVF9XUklURV9CVVNZLCAmZHJ2X2RhdGEtPmZsYWdzKTsK
KwljbGVhcl9iaXQoSTJTX1BPUlRfUkVBRF9CVVNZLCAmZHJ2X2RhdGEtPmZsYWdzKTsKKwltdXRl
eF91bmxvY2soJmRydl9kYXRhLT5tdXRleCk7CisJcmV0dXJuIGRydl9kYXRhOworCitvcGVuX2Vy
cm9yOgorCXB1dF9kZXZpY2UoZm91bmRfZGV2aWNlKTsKKwltdXRleF91bmxvY2soJmRydl9kYXRh
LT5tdXRleCk7CisJcmV0dXJuIE5VTEw7Cit9CitFWFBPUlRfU1lNQk9MX0dQTChpbnRlbF9taWRf
aTJzX29wZW4pOworCisvKioKKyAqIGludGVsX21pZF9pMnNfY2xvc2UgLSByZWxlYXNlIGFuZCBz
dG9wIHRoZSBTU1AKKyAqIEBkcnZfZGF0YSA6IGhhbmRsZSBvZiBjb3JyZXNwb25kaW5nIHNzcCBp
MnMgKGdpdmVuIGJ5IGkyc19vcGVuIGZ1bmN0aW9uKQorICoKKyAqIFdBUk5JTkc6IFRoaXMgaXMg
bm90IC15ZXQtIGFsbG93ZWQgdG8gY2FsbCBjbG9zZSBmcm9tIGEgcmVhZC93cml0ZSBjYWxsYmFj
ayAhCisgKgorICogT3V0cHV0IHBhcmFtZXRlcnMKKyAqICAgICAgbm9uZQorICovCit2b2lkIGlu
dGVsX21pZF9pMnNfY2xvc2Uoc3RydWN0IGludGVsX21pZF9pMnNfaGRsICpkcnZfZGF0YSkKK3sK
Kwl2b2lkIF9faW9tZW0gKnJlZzsKKwlXQVJOKCFkcnZfZGF0YSwgIkRyaXZlciBkYXRhPU5VTExc
biIpOworCWlmICghZHJ2X2RhdGEpCisJCXJldHVybjsKKwltdXRleF9sb2NrKCZkcnZfZGF0YS0+
bXV0ZXgpOworCWlmICghdGVzdF9iaXQoSTJTX1BPUlRfT1BFTkVELCAmZHJ2X2RhdGEtPmZsYWdz
KSkgeworCQlkZXZfZXJyKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAibm90IG9wZW5lZCBidXQgY2xv
c2luZz8iKTsKKwkJbXV0ZXhfdW5sb2NrKCZkcnZfZGF0YS0+bXV0ZXgpOworCQlyZXR1cm47CisJ
fQorCS8qIHRvIGJlIG1vZGlmaWVkIHRvIHdhaXRfZXZlbnRfaW50ZXJydXB0aWJsZV90aW1lb3V0
ICovCisJc2V0X2JpdChJMlNfUE9SVF9DTE9TSU5HLCAmZHJ2X2RhdGEtPmZsYWdzKTsKKwlkZXZf
ZGJnKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAiU3RhdHVzIGJpdCBwZW5kaW5nIHdyaXRlPSVkIHJl
YWQ9JWRcbiIsCisJCQl0ZXN0X2JpdChJMlNfUE9SVF9XUklURV9CVVNZLCAmZHJ2X2RhdGEtPmZs
YWdzKSwKKwkJCXRlc3RfYml0KEkyU19QT1JUX1JFQURfQlVTWSwgJmRydl9kYXRhLT5mbGFncykp
OworCWlmICh0ZXN0X2JpdChJMlNfUE9SVF9XUklURV9CVVNZLCAmZHJ2X2RhdGEtPmZsYWdzKSB8
fAorCSAgICAgdGVzdF9iaXQoSTJTX1BPUlRfUkVBRF9CVVNZLCAmZHJ2X2RhdGEtPmZsYWdzKSkg
eworCQlkZXZfZGJnKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAiUGVuZGluZyBjYWxsYmFjayBpbiBj
bG9zZS4uLlxuIik7CisJfQorCisJLyogd2FpdGluZyBiZWxvdy4gVG8gYmUgcmVwbGFjZWQgd2hl
biAiRE1BX1RFUk1JTkFURV9BTEwiIGZpeCBhdmFpbGFibGUgKi8KKwl3YWl0X2V2ZW50KGRydl9k
YXRhLT53cV9jaGFuX2Nsb3NpbmcsCisJCSgoIXRlc3RfYml0KEkyU19QT1JUX1dSSVRFX0JVU1ks
ICZkcnZfZGF0YS0+ZmxhZ3MpKSAmJgorCQkgKCF0ZXN0X2JpdChJMlNfUE9SVF9SRUFEX0JVU1ks
ICAmZHJ2X2RhdGEtPmZsYWdzKSkpKTsKKwkvKiByZWxlYXNlIERNQSBDaGFubmVsLi4gKi8KKwlp
MnNfZG1hX3N0b3AoZHJ2X2RhdGEpOworCXJlZyA9IGRydl9kYXRhLT5pb2FkZHI7CisJZGV2X2Ri
ZygmZHJ2X2RhdGEtPnBkZXYtPmRldiwgIlN0b3BwaW5nIHRoZSBTU1BcbiIpOworCWkyc19zc3Bf
c3RvcChkcnZfZGF0YSk7CisJcHV0X2RldmljZSgmZHJ2X2RhdGEtPnBkZXYtPmRldik7CisJd3Jp
dGVfU1NDUjAoMCwgcmVnKTsKKwkvKiBwbSBydW50aW1lICovCisJcG1fcnVudGltZV9wdXQoJmRy
dl9kYXRhLT5wZGV2LT5kZXYpOworCWRldl9kYmcoJihkcnZfZGF0YS0+cGRldi0+ZGV2KSwgIlNT
UCBTdG9wcGVkLlxuIik7CisJY2xlYXJfYml0KEkyU19QT1JUX0NMT1NJTkcsICZkcnZfZGF0YS0+
ZmxhZ3MpOworCWNsZWFyX2JpdChJMlNfUE9SVF9PUEVORUQsICZkcnZfZGF0YS0+ZmxhZ3MpOwor
CW11dGV4X3VubG9jaygmZHJ2X2RhdGEtPm11dGV4KTsKK30KK0VYUE9SVF9TWU1CT0xfR1BMKGlu
dGVsX21pZF9pMnNfY2xvc2UpOworLyoKKyAqIElOVEVSTkFMIEZVTkNUSU9OUworICovCisKKy8q
KgorICogY2hlY2tfZGV2aWNlIC0gIHJldHVybiBpZiB0aGUgZGV2aWNlIGlzIHRoZSB1c2FnZSB3
ZSB3YW50ICh1c2FnZSA9KmRhdGEpCisgKiBAZGV2aWNlX3B0ciA6IHBvaW50ZXIgb24gZGV2aWNl
IHN0cnVjdAorICogQGRhdGEgOiBwb2ludGVyIHBvaW50ZXIgb24gdXNhZ2Ugd2UgYXJlIGxvb2tp
bmcgZm9yCisgKgorICogdGhpcyBpcyBjYWxsZWQgZm9yIGVhY2ggZGV2aWNlIGJ5IGZpbmRfZGV2
aWNlKCkgZnJvbSBpbnRlbF9taWRfaTJzX29wZW4oKQorICogSW5mbyA6IHdoZW4gZm91bmQsIHRo
ZSBmbGFnIG9mIGRyaXZlciBpcyBzZXQgdG8gSTJTX1BPUlRfT1BFTkVECisgKgorICogT3V0cHV0
IHBhcmFtZXRlcnMKKyAqICAgICAgaW50ZWdlciA6IHJldHVybiAwIG1lYW5zIG5vdCB0aGUgZGV2
aWNlIG9yIGFscmVhZHkgc3RhcnRlZC4gZ28gbmV4dAorICoJCSAgcmV0dXJuICE9IDAgbWVhbnMg
c3RvcCB0aGUgc2VhcmNoIGFuZCByZXR1cm4gdGhpcyBkZXZpY2UKKyAqLworc3RhdGljIGludAor
Y2hlY2tfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldmljZV9wdHIsIHZvaWQgKmRhdGEpCit7CisJ
c3RydWN0IHBjaV9kZXYgKnBkZXY7CisJc3RydWN0IGludGVsX21pZF9pMnNfaGRsICpkcnZfZGF0
YTsKKwllbnVtIGludGVsX21pZF9pMnNfc3NwX3VzYWdlIHVzYWdlOworCWVudW0gaW50ZWxfbWlk
X2kyc19zc3BfdXNhZ2UgdXNhZ2VfdG9fZmluZDsKKworCXBkZXYgPSB0b19wY2lfZGV2KGRldmlj
ZV9wdHIpOworCVdBUk4oIXBkZXYsICJQY2kgZGV2aWNlPU5VTExcbiIpOworCWlmICghcGRldikK
KwkJcmV0dXJuIDA7CisJZHJ2X2RhdGEgPSAoc3RydWN0IGludGVsX21pZF9pMnNfaGRsICopIHBj
aV9nZXRfZHJ2ZGF0YShwZGV2KTsKKwlXQVJOKCFkcnZfZGF0YSwgIkRyaXZlciBkYXRhPU5VTExc
biIpOworCWlmICghZHJ2X2RhdGEpCisJCXJldHVybiAwOworCWRldl9kYmcoJihwZGV2LT5kZXYp
LCAiQ2hlY2sgZGV2aWNlIHBjaV9kZXYgcHRyID0gMFglcFxuIiwgcGRldik7CisJdXNhZ2VfdG9f
ZmluZCA9ICooKGVudW0gaW50ZWxfbWlkX2kyc19zc3BfdXNhZ2UgKikgZGF0YSk7CisJdXNhZ2Ug
PSBkcnZfZGF0YS0+dXNhZ2U7CisKKwkvKiBDYW4gYmUgZG9uZSBpbiBvbmUgImlmIiBidXQgc2Vw
YXJhdGVkIGluIHB1cnBvc2UgOiB0YWtlIGNhcmUgb2YKKwkgKiB0ZXN0X2FuZF9zZXRfYml0IHRo
YXQgbmVlZCB0byBiZSBkb25lIEFGVEVSIHRoZSBjaGVjayBvbiB1c2FnZS4KKwkgKi8KKwlpZiAo
dXNhZ2UgPT0gdXNhZ2VfdG9fZmluZCkgeworCQlpZiAoIXRlc3RfYW5kX3NldF9iaXQoSTJTX1BP
UlRfT1BFTkVELCAmZHJ2X2RhdGEtPmZsYWdzKSkKKwkJCXJldHVybiAxOyAgLyogQWxyZWFkeSBv
cGVuZWQsIGRvIG5vdCB1c2UgdGhpcyByZXN1bHQgKi8KKwl9OworCXJldHVybiAwOyAvKiBub3Qg
dXNhZ2Ugd2UgbG9vayBmb3IsIG9yIGFscmVhZHkgb3BlbmVkICovCit9CisKKy8qKgorICogaTJz
X3JlYWRfZG9uZSAtIGNhbGxiYWNrIGZyb20gdGhlIF9kbWEgdGFza2xldF8gYWZ0ZXIgcmVhZAor
ICogQGFyZyA6IHZvaWQgcG9pbnRlciB0byB0aGF0IHNob3VsZCBiZSBkcml2ZXIgZGF0YSAoY29u
dGV4dCkKKyAqCisgKiBPdXRwdXQgcGFyYW1ldGVycworICogICAgICBub25lCisgKi8KK3N0YXRp
YyB2b2lkIGkyc19yZWFkX2RvbmUodm9pZCAqYXJnKQoreworCWludCBzdGF0dXMgPSAwOworCisJ
c3RydWN0IGludGVsX21pZF9pMnNfaGRsICpkcnZfZGF0YSA9IGFyZzsKKwl2b2lkICpwYXJhbV9j
b21wbGV0ZTsKKwl2b2lkIF9faW9tZW0gKnJlZyA7CisKKwlXQVJOKCFkcnZfZGF0YSwgIkRyaXZl
ciBkYXRhPU5VTExcbiIpOworCWlmICghZHJ2X2RhdGEpCisJCXJldHVybjsKKwltdXRleF9sb2Nr
KCZkcnZfZGF0YS0+bXV0ZXgpOworCWlmICghdGVzdF9iaXQoSTJTX1BPUlRfUkVBRF9CVVNZLCAm
ZHJ2X2RhdGEtPmZsYWdzKSkKKwkJZGV2X1dBUk4oJmRydl9kYXRhLT5wZGV2LT5kZXYsICJzcHVy
aW91cyByZWFkIGRtYSBjb21wbGV0ZSIpOworCisJZG1hX3VubWFwX3NpbmdsZShOVUxMLCBkcnZf
ZGF0YS0+cmVhZF9kc3QsCisJCQkgZHJ2X2RhdGEtPnJlYWRfbGVuLCBETUFfRlJPTV9ERVZJQ0Up
OworCWRydl9kYXRhLT5yZWFkX2xlbiA9IDA7CisJcmVnID0gZHJ2X2RhdGEtPmlvYWRkcjsKKwkv
KiBSeCBmaWZvIG92ZXJydW4gSW50ZXJydXB0ICovCisJY2hhbmdlX1NTQ1IwX3JlZyhyZWcsIFJJ
TSwgU1NQX1JYX0ZJRk9fT1ZFUl9JTlRfRElTQUJMRSk7CisJcGFyYW1fY29tcGxldGUgPSBkcnZf
ZGF0YS0+cmVhZF9wYXJhbTsKKwkvKiBEbyBub3QgY2hhbmdlIG9yZGVyIHNlcXVlbmNlOgorCSAq
IFJFQURfQlVTWSBjbGVhciwgdGhlbiB0ZXN0IFBPUlRfQ0xPU0lORworCSAqIHdha2V1cCBmb3Ig
Y2xvc2UoKSBmdW5jdGlvbgorCSAqLworCWNsZWFyX2JpdChJMlNfUE9SVF9SRUFEX0JVU1ksICZk
cnZfZGF0YS0+ZmxhZ3MpOworCXdha2VfdXAoJmRydl9kYXRhLT53cV9jaGFuX2Nsb3NpbmcpOwor
CWlmICh0ZXN0X2JpdChJMlNfUE9SVF9DTE9TSU5HLCAmZHJ2X2RhdGEtPmZsYWdzKSkgeworCQlk
ZXZfZGJnKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAicmVhZCBkb25lIHdha2luZyB1cCBjbG9zZSIp
OworCQltdXRleF91bmxvY2soJmRydl9kYXRhLT5tdXRleCk7CisJCXJldHVybjsKKwl9CisJbXV0
ZXhfdW5sb2NrKCZkcnZfZGF0YS0+bXV0ZXgpOworCWlmIChkcnZfZGF0YS0+cmVhZF9jYWxsYmFj
ayAhPSBOVUxMKQorCQlzdGF0dXMgPSBkcnZfZGF0YS0+cmVhZF9jYWxsYmFjayhwYXJhbV9jb21w
bGV0ZSk7CisJZWxzZQorCQlkZXZfd2FybigmZHJ2X2RhdGEtPnBkZXYtPmRldiwgIlJEIGRvbmUg
YnV0IG5vdCBjYWxsYmFjayBzZXQiKTsKKworfQorCisvKioKKyAqIGkyc193cml0ZV9kb25lKCkg
OiBjYWxsYmFjayBmcm9tIHRoZSBfZG1hIHRhc2tsZXRfIGFmdGVyIHdyaXRlCisgKiBAYXJnIDog
dm9pZCBwb2ludGVyIHRvIHRoYXQgc2hvdWxkIGJlIGRyaXZlciBkYXRhIChjb250ZXh0KQorICoK
KyAqIE91dHB1dCBwYXJhbWV0ZXJzCisgKiAgICAgIG5vbmUKKyAqLworc3RhdGljIHZvaWQgaTJz
X3dyaXRlX2RvbmUodm9pZCAqYXJnKQoreworCWludCBzdGF0dXMgPSAwOworCXZvaWQgKnBhcmFt
X2NvbXBsZXRlOworCXN0cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqZHJ2X2RhdGEgPSBhcmc7CisJ
dm9pZCBfX2lvbWVtICpyZWcgOworCisJV0FSTighZHJ2X2RhdGEsICJEcml2ZXIgZGF0YT1OVUxM
XG4iKTsKKwlpZiAoIWRydl9kYXRhKQorCQlyZXR1cm47CisJbXV0ZXhfbG9jaygmZHJ2X2RhdGEt
Pm11dGV4KTsKKwlpZiAoIXRlc3RfYml0KEkyU19QT1JUX1dSSVRFX0JVU1ksICZkcnZfZGF0YS0+
ZmxhZ3MpKQorCQlkZXZfd2FybigmZHJ2X2RhdGEtPnBkZXYtPmRldiwgInNwdXJpb3VzIHdyaXRl
IGRtYSBjb21wbGV0ZSIpOworCWRtYV91bm1hcF9zaW5nbGUoTlVMTCwgZHJ2X2RhdGEtPnJlYWRf
ZHN0LAorCQkJIGRydl9kYXRhLT5yZWFkX2xlbiwgRE1BX1RPX0RFVklDRSk7CisJZHJ2X2RhdGEt
PnJlYWRfbGVuID0gMDsKKwlyZWcgPSBkcnZfZGF0YS0+aW9hZGRyOworCWNoYW5nZV9TU0NSMF9y
ZWcocmVnLCBUSU0sIFNTUF9UWF9GSUZPX1VOREVSX0lOVF9ESVNBQkxFKTsKKwlkZXZfZGJnKCYo
ZHJ2X2RhdGEtPnBkZXYtPmRldiksICJETUEgY2hhbm5lbCBkaXNhYmxlLi5cbiIpOworCXBhcmFt
X2NvbXBsZXRlID0gZHJ2X2RhdGEtPndyaXRlX3BhcmFtOworCS8qIERvIG5vdCBjaGFuZ2Ugb3Jk
ZXIgc2VxdWVuY2U6CisJICogV1JJVEVfQlVTWSBjbGVhciwgdGhlbiB0ZXN0IFBPUlRfQ0xPU0lO
RworCSAqIHdha2V1cCBmb3IgY2xvc2UoKSBmdW5jdGlvbgorCSAqLworCWNsZWFyX2JpdChJMlNf
UE9SVF9XUklURV9CVVNZLCAmZHJ2X2RhdGEtPmZsYWdzKTsKKwl3YWtlX3VwKCZkcnZfZGF0YS0+
d3FfY2hhbl9jbG9zaW5nKTsKKwlpZiAodGVzdF9iaXQoSTJTX1BPUlRfQ0xPU0lORywgJmRydl9k
YXRhLT5mbGFncykpIHsKKwkJbXV0ZXhfdW5sb2NrKCZkcnZfZGF0YS0+bXV0ZXgpOworCQlkZXZf
ZGJnKCZkcnZfZGF0YS0+cGRldi0+ZGV2LCAid3JpdGUgZG9uZSB3YWtpbmcgdXAgY2xvc2UiKTsK
KwkJcmV0dXJuOworCX0KKwltdXRleF91bmxvY2soJmRydl9kYXRhLT5tdXRleCk7CisJaWYgKGRy
dl9kYXRhLT53cml0ZV9jYWxsYmFjayAhPSBOVUxMKQorCQlzdGF0dXMgPSBkcnZfZGF0YS0+d3Jp
dGVfY2FsbGJhY2socGFyYW1fY29tcGxldGUpOworCWVsc2UKKwkJZGV2X3dhcm4oJmRydl9kYXRh
LT5wZGV2LT5kZXYsICJXUiBkb25lIGJ1dCBubyBjYWxsYmFjayBzZXQiKTsKK30KKworc3RhdGlj
IGJvb2wgY2hhbl9maWx0ZXIoc3RydWN0IGRtYV9jaGFuICpjaGFuLCB2b2lkICpwYXJhbSkKK3sK
KwlzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwgKmRydl9kYXRhID0gKHN0cnVjdCBpbnRlbF9taWRf
aTJzX2hkbCAqKXBhcmFtOworCWJvb2wgcmV0ID0gZmFsc2U7CisKKwlpZiAoIWRydl9kYXRhLT5k
bWFjMSkKKwkJZ290byBvdXQ7CisJaWYgKGNoYW4tPmRldmljZS0+ZGV2ID09ICZkcnZfZGF0YS0+
ZG1hYzEtPmRldikKKwkJcmV0ID0gdHJ1ZTsKK291dDoKKwlyZXR1cm4gcmV0OworfQorCisvKioK
KyAqIGkyc19kbWFfc3RhcnQgLSBwcmVwYXJlIGFuZCByZXNlcnZlIGRtYSBjaGFubmVscworICog
QGFyZyA6IGludGVsX21pZF9pMnNfaGRsIHBvaW50ZXIgdG8gdGhhdCBzaG91bGQgYmUgZHJpdmVy
IGRhdGEgKGNvbnRleHQpCisgKgorICogInNzcCBvcGVuIiBjb250ZXh0IGFuZCBkbWFjMSBzaG91
bGQgYWxyZWFkeSBiZSBmaWxsZWQgaW4gZHJ2X2RhdGEKKyAqCisgKiBPdXRwdXQgcGFyYW1ldGVy
cworICogICAgICBpbnQgOiBzaG91bGQgYmUgemVybywgZWxzZSBpdCBtZWFucyBlcnJvciBjb2Rl
CisgKi8KK3N0YXRpYyBpbnQgaTJzX2RtYV9zdGFydChzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwg
KmRydl9kYXRhKQoreworCXN0cnVjdCBpbnRlbF9taWRfZG1hX3NsYXZlICpyeHMsICp0eHM7CisJ
ZG1hX2NhcF9tYXNrX3QgbWFzazsKKwlpbnQgcmV0dmFsID0gMDsKKwlzdHJ1Y3QgcGNpX2RldiAq
bF9wZGV2OworCisJZGV2X2RiZygmZHJ2X2RhdGEtPnBkZXYtPmRldiwgIkRNQUMxIHN0YXJ0XG4i
KTsKKwlkcnZfZGF0YS0+dHhjaGFuID0gTlVMTDsKKwlkcnZfZGF0YS0+cnhjaGFuID0gTlVMTDsK
KwlsX3BkZXYgPSBkcnZfZGF0YS0+cGRldjsKKwkvKiAxLiBpbml0IHJ4IGNoYW5uZWwgKi8KKwly
eHMgPSAmZHJ2X2RhdGEtPmRtYXNfcng7CisJcnhzLT5kaXJuID0gRE1BX0ZST01fREVWSUNFOwor
CXJ4cy0+aHNfbW9kZSA9IExOV19ETUFfSFdfSFM7CisJcnhzLT5jZmdfbW9kZSA9IExOV19ETUFf
UEVSX1RPX01FTTsKKwlyeHMtPnNyY193aWR0aCA9IExOV19ETUFfV0lEVEhfMTZCSVQ7CisJcnhz
LT5kc3Rfd2lkdGggPSBMTldfRE1BX1dJRFRIXzMyQklUOworCXJ4cy0+c3JjX21zaXplID0gTE5X
X0RNQV9NU0laRV84OworCXJ4cy0+ZHN0X21zaXplID0gTE5XX0RNQV9NU0laRV84OworCXJ4cy0+
ZGV2aWNlX2luc3RhbmNlID0gZHJ2X2RhdGEtPmRldmljZV9pbnN0YW5jZTsKKwlkbWFfY2FwX3pl
cm8obWFzayk7CisJZG1hX2NhcF9zZXQoRE1BX01FTUNQWSwgbWFzayk7CisJZG1hX2NhcF9zZXQo
RE1BX1NMQVZFLCBtYXNrKTsKKwlkcnZfZGF0YS0+cnhjaGFuID0gZG1hX3JlcXVlc3RfY2hhbm5l
bChtYXNrLCBjaGFuX2ZpbHRlciwgZHJ2X2RhdGEpOworCWlmICghZHJ2X2RhdGEtPnJ4Y2hhbikg
eworCQlkZXZfZXJyKCYoZHJ2X2RhdGEtPnBkZXYtPmRldiksCisJCQkiQ291bGQgbm90IGdldCBS
eCBjaGFubmVsXG4iKTsKKwkJcmV0dmFsID0gLTI7CisJCWdvdG8gZXJyX2V4aXQ7CisJfQorCWRy
dl9kYXRhLT5yeGNoYW4tPnByaXZhdGUgPSByeHM7CisJLyogMi4gaW5pdCB0eCBjaGFubmVsICov
CisJdHhzID0gJmRydl9kYXRhLT5kbWFzX3R4OworCXR4cy0+ZGlybiA9IERNQV9UT19ERVZJQ0U7
CisJdHhzLT5oc19tb2RlID0gTE5XX0RNQV9IV19IUzsKKwl0eHMtPmNmZ19tb2RlID0gTE5XX0RN
QV9NRU1fVE9fUEVSOworCXR4cy0+c3JjX3dpZHRoID0gTE5XX0RNQV9XSURUSF8zMkJJVDsKKwl0
eHMtPmRzdF93aWR0aCA9IExOV19ETUFfV0lEVEhfMTZCSVQ7CisJdHhzLT5zcmNfbXNpemUgPSBM
TldfRE1BX01TSVpFXzg7CisJdHhzLT5kc3RfbXNpemUgPSBMTldfRE1BX01TSVpFXzg7CisJdHhz
LT5kZXZpY2VfaW5zdGFuY2UgPSBkcnZfZGF0YS0+ZGV2aWNlX2luc3RhbmNlOworCWRtYV9jYXBf
c2V0KERNQV9TTEFWRSwgbWFzayk7CisJZG1hX2NhcF9zZXQoRE1BX01FTUNQWSwgbWFzayk7CisJ
ZHJ2X2RhdGEtPnR4Y2hhbiA9IGRtYV9yZXF1ZXN0X2NoYW5uZWwobWFzaywgY2hhbl9maWx0ZXIs
IGRydl9kYXRhKTsKKwlpZiAoIWRydl9kYXRhLT50eGNoYW4pIHsKKwkJZGV2X2VycigmKGRydl9k
YXRhLT5wZGV2LT5kZXYpLAorCQkJIkNvdWxkIG5vdCBnZXQgVHggY2hhbm5lbFxuIik7CisJCXJl
dHZhbCA9IC0zOworCQlnb3RvIGZyZWVfcnhjaGFuOworCX0KKwlkcnZfZGF0YS0+dHhjaGFuLT5w
cml2YXRlID0gdHhzOworCXJldHVybiByZXR2YWw7CitmcmVlX3J4Y2hhbjoKKwlkbWFfcmVsZWFz
ZV9jaGFubmVsKGRydl9kYXRhLT5yeGNoYW4pOworZXJyX2V4aXQ6CisJcmV0dXJuIHJldHZhbDsK
K30KKworLyoqCisgKiBpMnNfZG1hX3N0b3AgLSByZWxlYXNlIGRtYSBjaGFubmVscworICogQGFy
ZyA6IHN0cnVjdCBpbnRlbF9taWRfaTJzX2hkbCBwb2ludGVyIHRvIHRoYXQgc2hvdWxkIGJlIGRy
aXZlciBkYXRhIChjb250ZXh0KQorICoKKyAqIGNhbGxlZCBieSBpbnRlbF9taWRfaTJzX2Nsb3Nl
KCkgY29udGV4dAorICoKKyAqIE91dHB1dCBwYXJhbWV0ZXJzCisgKiAgICAgIG5vbmUKKyAqLwor
c3RhdGljIHZvaWQgaTJzX2RtYV9zdG9wKHN0cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqZHJ2X2Rh
dGEpCit7CisJZGV2X2RiZygmZHJ2X2RhdGEtPnBkZXYtPmRldiwgIkRNQUMxIHN0b3BcbiIpOwor
CWRtYV9yZWxlYXNlX2NoYW5uZWwoZHJ2X2RhdGEtPnR4Y2hhbik7CisJZG1hX3JlbGVhc2VfY2hh
bm5lbChkcnZfZGF0YS0+cnhjaGFuKTsKK30KKworc3RhdGljIHZvaWQgaTJzX3NzcF9zdG9wKHN0
cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqZHJ2X2RhdGEpCit7CisJdm9pZCBfX2lvbWVtICpyZWcg
PSBkcnZfZGF0YS0+aW9hZGRyOworCWRldl9kYmcoJmRydl9kYXRhLT5wZGV2LT5kZXYsICJTdG9w
IFNTUFxuIik7CisJY2xlYXJfU1NDUjBfcmVnKHJlZywgU1NFKTsKK30KKworc3RhdGljIHZvaWQg
c3NwMV9kdW1wX3JlZ2lzdGVycyhzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwgKmRydl9kYXRhKQor
eworCXUzMiBpcnFfc3RhdHVzOworCXZvaWQgX19pb21lbSAqcmVnID0gZHJ2X2RhdGEtPmlvYWRk
cjsKKwlzdHJ1Y3QgZGV2aWNlICpkZGJnID0gJihkcnZfZGF0YS0+cGRldi0+ZGV2KTsKKwl1MzIg
c3RhdHVzOworCWlycV9zdGF0dXMgPSByZWFkX1NTU1IocmVnKTsKKwlkZXZfZGJnKGRkYmcsICJk
dW1wIFNTU1I9MHglMDhYXG4iLCBpcnFfc3RhdHVzKTsKKwlzdGF0dXMgPSByZWFkX1NTQ1IwKHJl
Zyk7CisJZGV2X2RiZyhkZGJnLCAiZHVtcCBTU0NSMD0weCUwOFhcbiIsIHN0YXR1cyk7CisJc3Rh
dHVzID0gcmVhZF9TU0NSMShyZWcpOworCWRldl9kYmcoZGRiZywgImR1bXAgU1NDUjE9MHglMDhY
XG4iLCBzdGF0dXMpOworCXN0YXR1cyA9IHJlYWRfU1NQU1AocmVnKTsKKwlkZXZfZGJnKGRkYmcs
ICJkdW1wIFNTUFNQPTB4JTA4WFxuIiwgc3RhdHVzKTsKKwlzdGF0dXMgPSByZWFkX1NTVFNBKHJl
Zyk7CisJZGV2X2RiZyhkZGJnLCAiZHVtcCBTU1RTQT0weCUwOFhcbiIsIHN0YXR1cyk7CisJc3Rh
dHVzID0gcmVhZF9TU1JTQShyZWcpOworCWRldl9kYmcoZGRiZywgImR1bXAgU1NSU0E9MHglMDhY
XG4iLCBzdGF0dXMpOworCXN0YXR1cyA9IHJlYWRfU1NUTyhyZWcpOworCWRldl9kYmcoZGRiZywg
ImR1bXAgU1NUTz0weCUwOFhcbiIsIHN0YXR1cyk7CisJc3RhdHVzID0gcmVhZF9TU0lUUihyZWcp
OworCWRldl9kYmcoZGRiZywgImR1bXAgU1NJVFI9MHglMDhYXG4iLCBzdGF0dXMpOworCXN0YXR1
cyA9IHJlYWRfU1NUU1MocmVnKTsKKwlkZXZfZGJnKGRkYmcsICJkdW1wIFNTVFNTPTB4JTA4WFxu
Iiwgc3RhdHVzKTsKKwlzdGF0dXMgPSByZWFkX1NTQUNEKHJlZyk7CisJZGV2X2RiZyhkZGJnLCAi
ZHVtcCBTU0FDRD0weCUwOFhcbiIsIHN0YXR1cyk7Cit9CisKKy8qKgorICogaTJzX2ludCgpOiBm
dW5jdGlvbiB0aGF0IGhhbmRsZXMgdGhlIFNTUCBJbnRlcnJ1cHRzIChlcnJvcnMpCisgKiBAaXJx
IDogSVJRIE51bWJlcgorICogQGRldl9pZCA6IHN0cnVjdHVyZSB0aGF0IGNvbnRhaW5zIGRyaXZl
ciBpbmZvcm1hdGlvbgorICoKKyAqIFRoaXMgaW50ZXJydXB0cyBkbyBub3RoaW5nIGJ1dCB3YXJu
aW5ncyBpbiBjYXNlIHRoZXJlIGlzIHNvbWUgcHJvYmxlbXMKKyAqIGluIEkyUyBjb25uZWN0aW9u
ICh1bmRlcnJ1bnMsIG92ZXJydW5zLi4uKS4gVGhpcyBtYXkgYmUgcmVwb3J0ZWQgYnkgYWRkaW5n
IGEKKyAqIG5ldyBpbnRlcmZhY2UgdG8gdGhlIGRyaXZlciwgYnV0IG5vdCB5ZXQgcmVxdWVzdGVk
IGJ5ICJ1c2VycyIgb2YgdGhpcyBkcml2ZXIKKyAqCisgKiBPdXRwdXQgcGFyYW1ldGVycworICog
ICAgICBOQQorICovCitzdGF0aWMgaXJxcmV0dXJuX3QgaTJzX2ludChpbnQgaXJxLCB2b2lkICpk
ZXZfaWQpCit7CisJc3RydWN0IGludGVsX21pZF9pMnNfaGRsICpkcnZfZGF0YSA9IGRldl9pZDsK
Kwl2b2lkIF9faW9tZW0gKnJlZzsKKwl1MzIgaXJxX3N0YXR1cyA9IDA7CisJdTMyIG1hc2tfc3Rh
dHVzID0gMDsKKwlzdHJ1Y3QgZGV2aWNlICpkZGJnID0gJihkcnZfZGF0YS0+cGRldi0+ZGV2KTsK
KwlyZWcgPSBkcnZfZGF0YS0+aW9hZGRyOworCWlycV9zdGF0dXMgPSByZWFkX1NTU1IocmVnKTsK
KworCWlmICghKGlycV9zdGF0dXMgJiAoZHJ2X2RhdGEtPm1hc2tfc3IpKSkgeworCQlyZXR1cm4g
SVJRX05PTkU7CisJfSBlbHNlIHsKKwkJLyogbWF5IGJlIGltcHJvdmVkIGJ5IHVzaW5nIGEgdGFz
a2xldCB0byBzZW5kIHRoZSBlcnJvcgorCQkgKiAodW5kZXJydW4sLi4uKSB0byBjbGllbnQgYnkg
dXNpbmcgY2FsbGJhY2sKKwkJICovCisJCWlmIChpcnFfc3RhdHVzICYgKFNTU1JfUk9SX01BU0sg
PDwgU1NTUl9ST1JfU0hJRlQpKSB7CisJCQlkZXZfd2FybihkZGJnLAorCQkJCSJzc3BfaW50IFJY
IEZJRk8gT1ZFUiBSVU4gU1NTUj0weCUwOFhcbiIsCisJCQkJaXJxX3N0YXR1cyk7CisJCQltYXNr
X3N0YXR1cyB8PSAoU1NTUl9ST1JfTUFTSyA8PCBTU1NSX1JPUl9TSElGVCk7CisKKwkJfQorCQlp
ZiAoaXJxX3N0YXR1cyAmIChTU1NSX1RVUl9NQVNLIDw8IFNTU1JfVFVSX1NISUZUKSkgeworCQkJ
ZGV2X3dhcm4oZGRiZywKKwkJCQkic3NwX2ludCBUWCBGSUZPIFVOREVSIFJVTiBTU1NSPTB4JTA4
WFxuIiwKKwkJCQlpcnFfc3RhdHVzKTsKKwkJCW1hc2tfc3RhdHVzIHw9IChTU1NSX1RVUl9NQVNL
IDw8IFNTU1JfVFVSX1NISUZUKTsKKworCQl9CisJCWlmIChpcnFfc3RhdHVzICYgKFNTU1JfVElO
VF9NQVNLIDw8IFNTU1JfVElOVF9TSElGVCkpIHsKKwkJCWRldl93YXJuKGRkYmcsCisJCQkJInNz
cF9pbnQgUlggVElNRSBPVVQgU1NTUj0weCUwOFhcbiIsCisJCQkJaXJxX3N0YXR1cyk7CisJCQlt
YXNrX3N0YXR1cyB8PSAoU1NTUl9USU5UX01BU0sgPDwgU1NTUl9USU5UX1NISUZUKTsKKworCQl9
CisJCWlmIChpcnFfc3RhdHVzICYgKFNTU1JfUElOVF9NQVNLIDw8IFNTU1JfUElOVF9TSElGVCkp
IHsKKwkJCWRldl93YXJuKGRkYmcsCisJCQkJInNzcF9pbnQgVFJBSUxJTkcgQllURSBTU1NSPTB4
JTA4WFxuIiwKKwkJCQlpcnFfc3RhdHVzKTsKKwkJCW1hc2tfc3RhdHVzIHw9IChTU1NSX1BJTlRf
TUFTSyA8PCBTU1NSX1BJTlRfU0hJRlQpOworCQl9CisJCWlmIChpcnFfc3RhdHVzICYgKFNTU1Jf
RU9DX01BU0sgPDwgU1NTUl9FT0NfU0hJRlQpKSB7CisJCQlkZXZfd2FybihkZGJnLAorCQkJCSJz
c3BfaW50IEVORCBPRiBDSEFJTiBTU1NSPTB4JTA4WFxuIiwKKwkJCQlpcnFfc3RhdHVzKTsKKwkJ
CW1hc2tfc3RhdHVzIHw9IChTU1NSX0VPQ19NQVNLIDw8IFNTU1JfRU9DX1NISUZUKTsKKwkJfQor
CQkvKiBjbGVhciBzdGlja3kgYml0cyAqLworCQl3cml0ZV9TU1NSKChpcnFfc3RhdHVzICYgbWFz
a19zdGF0dXMpLCByZWcpOworCX0KKwlyZXR1cm4gSVJRX0hBTkRMRUQ7Cit9CisKKy8qKgorICog
Y2FsY3VsYXRlX3NzcHNwX3BzcCAtIHNlcGFyYXRlIGZ1bmN0aW9uIHRoYXQgY2FsY3VsYXRlIHNz
cHNwIHJlZ2lzdGVyCisgKiBAcHNfc2V0dGluZ3MgOiBwb2ludGVyIG9mIHRoZSBzZXR0aW5ncyBz
dHJ1Y3QKKyAqCisgKiB0aGlzIGZ1bmN0aW9uIGlzIHRvIHNpbXBsaWZ5L2NsYXJpZnkgc2V0X3Nz
cF9pMnNfaHcgZnVuY3Rpb24KKyAqCisgKgorICogT3V0cHV0IHBhcmFtZXRlcnMKKyAqICAgICAg
dTMyIDogY2FsY3VsYXRlZCBTU1BTUCByZWdpc3RlcgorICovCit1MzIgY2FsY3VsYXRlX3NzcHNw
X3BzcChjb25zdCBzdHJ1Y3QgaW50ZWxfbWlkX2kyc19zZXR0aW5ncyAqcHNfc2V0dGluZ3MpCit7
CisJdTMyIHNzcHNwOworCXNzcHNwID0gU1NQU1BfcmVnKEZTUlQsCXBzX3NldHRpbmdzLT5zc3Bf
ZnJtc3luY190aW1pbmdfYml0KQorCQl8U1NQU1BfcmVnKEVURFMsCXBzX3NldHRpbmdzLT5zc3Bf
ZW5kX3RyYW5zZmVyX3N0YXRlKQorCQl8U1NQU1BfcmVnKFNDTU9ERSwJcHNfc2V0dGluZ3MtPnNz
cF9zZXJpYWxfY2xrX21vZGUpCisJCXxTU1BTUF9yZWcoRE1ZU1RPUCwJcHNfc2V0dGluZ3MtPnNz
cF9wc3BfVDQpCisJCXxTU1BTUF9yZWcoU0ZSTURMWSwJcHNfc2V0dGluZ3MtPnNzcF9wc3BfVDUp
CisJCXxTU1BTUF9yZWcoU0ZSTVdEVEgsCXBzX3NldHRpbmdzLT5zc3BfcHNwX1Q2KQorCQl8U1NQ
U1BfcmVnKFNGUk1QLAlwc19zZXR0aW5ncy0+c3NwX2ZybXN5bmNfcG9sX2JpdCk7CisJcmV0dXJu
IHNzcHNwOworfQorCisvKgorICogY2FsY3VsYXRlX3NzY3IwX3BzcDogc2VwYXJhdGUgZnVuY3Rp
b24gdGhhdCBjYWxjdWxhdGUgc3NjcjAgcmVnaXN0ZXIKKyAqIEBwc19zZXR0aW5ncyA6IHBvaW50
ZXIgb2YgdGhlIHNldHRpbmdzIHN0cnVjdAorICoKKyAqIHRoaXMgZnVuY3Rpb24gaXMgdG8gc2lt
cGxpZnkvY2xhcmlmeSBzZXRfc3NwX2kyc19odyBmdW5jdGlvbgorICoKKyAqIE91dHB1dCBwYXJh
bWV0ZXJzCisgKiAgICAgIHUzMiA6IGNhbGN1bGF0ZWQgU1NDUjAgcmVnaXN0ZXIKKyAqLwordTMy
IGNhbGN1bGF0ZV9zc2NyMF9wc3AoY29uc3Qgc3RydWN0IGludGVsX21pZF9pMnNfc2V0dGluZ3Mg
KnBzX3NldHRpbmdzKQoreworCXUxNiBsX3NzcF9kYXRhX3NpemUgPSBwc19zZXR0aW5ncy0+ZGF0
YV9zaXplOworCXUzMiBzc2NyMDsKKwlpZiAobF9zc3BfZGF0YV9zaXplID4gMTYpIHsKKwkJc3Nj
cjAgPSAgIFNTQ1IwX3JlZyhEU1MsIFNTQ1IwX0RhdGFTaXplKGxfc3NwX2RhdGFfc2l6ZSAtIDE2
KSkKKwkJCXwgU1NDUjBfcmVnKEVEU1MsIDEpOworCX0gZWxzZSB7CisJCXNzY3IwID0gICBTU0NS
MF9yZWcoRFNTLCBTU0NSMF9EYXRhU2l6ZShsX3NzcF9kYXRhX3NpemUpKQorCQkJfCBTU0NSMF9y
ZWcoRURTUywgMCk7CisJfQorLyoKK0NhbiBiZSByZXBsYWNlZCBieSBjb2RlIGJlbG93IDoKK3Nz
Y3IwID0gU1NDUjBfcmVnKERTUywgKGxfc3NwX2RhdGFfc2l6ZSAtIDEpICYgMHgwRikKK3wgU1ND
UjBfcmVnKEVEU1MsICgobF9zc3BfZGF0YV9zaXplIC0gMSkgJiAweDEwKSA+PiA4KTsKKyovCisJ
c3NjcjAgfD0gU1NDUjBfcmVnKE1PRCwJcHNfc2V0dGluZ3MtPm1vZGUpCisJCXxTU0NSMF9yZWco
RlJGLAlwc19zZXR0aW5ncy0+ZnJhbWVfZm9ybWF0KQorCQl8U1NDUjBfcmVnKFJJTSwJU1NQX1JY
X0ZJRk9fT1ZFUl9JTlRfRElTQUJMRSkKKwkJfFNTQ1IwX3JlZyhUSU0sCVNTUF9UWF9GSUZPX1VO
REVSX0lOVF9ESVNBQkxFKTsKKwlyZXR1cm4gc3NjcjA7Cit9CisKKy8qKgorICogY2FsY3VsYXRl
X3NzY3IxX3BzcCAtIHNlcGFyYXRlIGZ1bmN0aW9uIHRoYXQgY2FsY3VsYXRlIHNzY3IxIHJlZ2lz
dGVyCisgKiBAcHNfc2V0dGluZ3MgOiBwb2ludGVyIG9mIHRoZSBzZXR0aW5ncyBzdHJ1Y3QKKyAq
CisgKiB0aGlzIGZ1bmN0aW9uIGlzIHRvIHNpbXBsaWZ5L2NsYXJpZnkgc2V0X3NzcF9pMnNfaHcg
ZnVuY3Rpb24KKyAqCisgKiBPdXRwdXQgcGFyYW1ldGVycworICogICAgICB1MzIgOiBjYWxjdWxh
dGVkIFNTQ1IxIHJlZ2lzdGVyCisgKi8KK3UzMiBjYWxjdWxhdGVfc3NjcjFfcHNwKGNvbnN0IHN0
cnVjdCBpbnRlbF9taWRfaTJzX3NldHRpbmdzICpwc19zZXR0aW5ncykKK3sKKwl1MzIgc3NjcjE7
CisJc3NjcjEgPSBTU0NSMV9yZWcoU0ZSTURJUiwJcHNfc2V0dGluZ3MtPnNzcHNmcm1fZGlyZWN0
aW9uKQorCQl8U1NDUjFfcmVnKFNDTEtESVIsCXBzX3NldHRpbmdzLT5zc3BzbGNsa19kaXJlY3Rp
b24pCisJCXxTU0NSMV9yZWcoVFRFTFAsCXBzX3NldHRpbmdzLT50eF90cmlzdGF0ZV9waGFzZSkK
KwkJfFNTQ1IxX3JlZyhUVEUsCXBzX3NldHRpbmdzLT50eF90cmlzdGF0ZV9lbmFibGUpCisJCXxT
U0NSMV9yZWcoVFJBSUwsCXBzX3NldHRpbmdzLT5zc3BfdHJhaWxpbmdfYnl0ZV9tb2RlKQorCQl8
U1NDUjFfcmVnKFRJTlRFLAlwc19zZXR0aW5ncy0+c3NwX3J4X3RpbWVvdXRfaW50ZXJydXB0X3N0
YXR1cykKKwkJfFNTQ1IxX3JlZyhQSU5URSwJcHNfc2V0dGluZ3MtPnNzcF90cmFpbGluZ19ieXRl
X2ludGVycnVwdF9zdGF0dXMpCisJCXxTU0NSMV9yZWcoTEJNLAlwc19zZXR0aW5ncy0+c3NwX2xv
b3BiYWNrX21vZGVfc3RhdHVzKQorCQl8U1NDUjFfcmVnKFJXT1QsCXBzX3NldHRpbmdzLT5zc3Bf
ZHVwbGV4X21vZGUpCisJCXxTU0NSMV9yZWcoUkZULAlTU0NSMV9SeFRyZXNoKHBzX3NldHRpbmdz
LT5zc3BfcnhfZmlmb190aHJlc2hvbGQpKQorCQl8U1NDUjFfcmVnKFRGVCwJU1NDUjFfVHhUcmVz
aChwc19zZXR0aW5ncy0+c3NwX3R4X2ZpZm9fdGhyZXNob2xkKSk7CisJcmV0dXJuIHNzY3IxOwor
fQorCisvKioKKyAqIHNldF9zc3BfaTJzX2h3IC0gY29uZmlndXJlIHRoZSBTU1AgZHJpdmVyIGFj
Y29yZGluZyB0byB0aGUgcHNfc2V0dGluZ3MKKyAqIEBkcnZfZGF0YSA6IHN0cnVjdHVyZSB0aGF0
IGNvbnRhaW5zIGFsbCBkZXRhaWxzIGFib3V0IHRoZSBTU1AgRHJpdmVyCisgKiBAcHNfc2V0dGlu
Z3MgOiBzdHJ1Y3R1cmUgdGhhdCBjb250YWlucyBTU1AgSGFyZHdhcmUgc2V0dGluZ3MKKyAqCisg
KiBpdCBhbHNvIHN0b3JlIHBzX3NldHRpbmdzIHRoZSBkcnZfZGF0YQorICoKKyAqIE91dHB1dCBw
YXJhbWV0ZXJzCisgKiAgICAgIE5BCisgKi8KK3N0YXRpYyB2b2lkIHNldF9zc3BfaTJzX2h3KHN0
cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqZHJ2X2RhdGEsCisJCQljb25zdCBzdHJ1Y3QgaW50ZWxf
bWlkX2kyc19zZXR0aW5ncyAqcHNfc2V0dGluZ3MpCit7CisJdTMyIHNzY3IwID0gMDsKKwl1MzIg
c3NjcjEgPSAwOworCXUzMiBzc3RzYSA9IDA7CisJdTMyIHNzcnNhID0gMDsKKwl1MzIgc3Nwc3Ag
PSAwOworCXUzMiBzc3NyID0gMDsKKwkvKiBHZXQgdGhlIFNTUCBTZXR0aW5ncyAqLworCXUxNiBs
X3NzcF9jbGtfZnJtX21vZGUgPSAweEZGOworCXZvaWQgX19pb21lbSAqcmVnID0gZHJ2X2RhdGEt
PmlvYWRkcjsKKwlzdHJ1Y3QgZGV2aWNlICpkZGJnID0gJihkcnZfZGF0YS0+cGRldi0+ZGV2KTsK
KwlkZXZfZGJnKGRkYmcsCisJCSJzZXR1cCBTU1AgSTJTIFBDTTEgY29uZmlndXJhdGlvblxuIik7
CisJaWYgKChwc19zZXR0aW5ncy0+c3Nwc2ZybV9kaXJlY3Rpb24gPT0gU1NQU0ZSTV9NQVNURVJf
TU9ERSkKKwkgICAmJiAocHNfc2V0dGluZ3MtPnNzcHNsY2xrX2RpcmVjdGlvbiA9PSBTU1BTQ0xL
X01BU1RFUl9NT0RFKSkgeworCQlsX3NzcF9jbGtfZnJtX21vZGUgPSBTU1BfSU5fTUFTVEVSX01P
REU7CisJfSBlbHNlIGlmICgocHNfc2V0dGluZ3MtPnNzcHNmcm1fZGlyZWN0aW9uID09IFNTUFNG
Uk1fU0xBVkVfTU9ERSkKKwkgICAmJiAocHNfc2V0dGluZ3MtPnNzcHNsY2xrX2RpcmVjdGlvbiA9
PSBTU1BTQ0xLX1NMQVZFX01PREUpKSB7CisJCWxfc3NwX2Nsa19mcm1fbW9kZSA9IFNTUF9JTl9T
TEFWRV9NT0RFOworCX0gZWxzZSB7CisJCWRldl9lcnIoZGRiZywgIlVuc3VwcG9ydGVkIEkyUyBQ
Q00xIGNvbmZpZ3VyYXRpb25cbiIpOworCQlnb3RvIGxlYXZlOworCX0KKwlkZXZfZGJnKGRkYmcs
ICJTU1BTRlJNX0RJUkVDVElPTjolZDpcbiIsCisJCXBzX3NldHRpbmdzLT5zc3BzZnJtX2RpcmVj
dGlvbik7CisJZGV2X2RiZyhkZGJnLCAiU1NQU0NMS19ESVJFQ1RJT046JWQ6XG4iLAorCQlwc19z
ZXR0aW5ncy0+c3Nwc2xjbGtfZGlyZWN0aW9uKTsKKwlpZiAocHNfc2V0dGluZ3MtPmZyYW1lX2Zv
cm1hdCAhPSBQU1BfRk9STUFUKSB7CisJCWRldl9lcnIoZGRiZywgIlVOU1VQUE9SVEVEIEZSQU1F
IEZPUk1BVDolZDpcbiIsIHBzX3NldHRpbmdzLT5mcmFtZV9mb3JtYXQpOworCQlnb3RvIGxlYXZl
OworCX0KKwlpZiAoKHBzX3NldHRpbmdzLT5zc3BfdHhfZG1hICE9IFNTUF9UWF9ETUFfRU5BQkxF
KQorCXx8IChwc19zZXR0aW5ncy0+c3NwX3J4X2RtYSAhPSBTU1BfUlhfRE1BX0VOQUJMRSkpIHsK
KwkJZGV2X2VycihkZGJnLCAiT05MWSBETUEgTU9ERSBJUyBTVVBQT1JURUQiKTsKKwkJZ290byBs
ZWF2ZTsKKwl9CisJLyoqKioqKioqKioqIERNQSBUcmFuc2ZlciBNb2RlICoqKioqKioqKioqLwor
CWRldl9kYmcoZGRiZywgIkZPUk1BVCA6JWQ6XG4iLCBwc19zZXR0aW5ncy0+ZnJhbWVfZm9ybWF0
KTsKKwlzc2NyMCA9IGNhbGN1bGF0ZV9zc2NyMF9wc3AocHNfc2V0dGluZ3MpOworCWRldl9kYmco
ZGRiZywgIiBzc2NyMCA6MHglMDhYXG4iLCBzc2NyMCk7CisJc3NjcjEgPSBjYWxjdWxhdGVfc3Nj
cjFfcHNwKHBzX3NldHRpbmdzKTsKKwlkZXZfZGJnKGRkYmcsICIgc3NjcjEgOjB4JTA4WFxuIiwg
c3NjcjEpOworCWlmIChwc19zZXR0aW5ncy0+bW9kZSA9PSBTU1BfSU5fTkVUV09SS19NT0RFKSB7
CisJCWRldl9kYmcoZGRiZywgIk1PREUgOiVkOlxuIiwgcHNfc2V0dGluZ3MtPm1vZGUpOworCQlz
c2NyMCB8PSBTU0NSMF9yZWcoRlJEQywgU1NDUjBfU2xvdHNQZXJGcm0ocHNfc2V0dGluZ3MtPmZy
YW1lX3JhdGVfZGl2aWRlcl9jb250cm9sKSk7CisJCWRldl9kYmcoZGRiZywgInNzY3IwIDoweCUw
OFhcbiIsIHNzY3IwKTsKKwkJc3Nwc3AgPSBjYWxjdWxhdGVfc3Nwc3BfcHNwKHBzX3NldHRpbmdz
KTsKKwkJZGV2X2RiZyhkZGJnLCAic3Nwc3AgOjB4JTA4WFxuIiwgc3Nwc3ApOworCQkvKiBzZXQg
dGhlIGFjdGl2ZSBUWCB0aW1lIHNsb3QgKGJpdG1hcCkgKi8KKwkJc3N0c2EgPSBTU1RTQV9yZWco
VFRTQSwgcHNfc2V0dGluZ3MtPnNzcF9hY3RpdmVfdHhfc2xvdHNfbWFwKTsKKwkJLyogc2V0IHRo
ZSBhY3RpdmUgUlggdGltZSBzbG90IChiaXRtYXApICovCisJCXNzcnNhID0gU1NSU0FfcmVnKFJU
U0EsIHBzX3NldHRpbmdzLT5zc3BfYWN0aXZlX3J4X3Nsb3RzX21hcCk7CisJCWlmIChsX3NzcF9j
bGtfZnJtX21vZGUgPT0gU1NQX0lOX01BU1RFUl9NT0RFKSB7CisJCQlzd2l0Y2ggKHBzX3NldHRp
bmdzLT5tYXN0ZXJfbW9kZV9jbGtfc2VsZWN0aW9uKSB7CisJCQljYXNlIFNTUF9PTkNISVBfQ0xP
Q0s6CisJCQkJYnJlYWs7CisJCQljYXNlIFNTUF9ORVRXT1JLX0NMT0NLOgorCQkJCXNzY3IwIHw9
IFNTQ1IwX3JlZyhOQ1MsIDEpOworCQkJCWJyZWFrOworCQkJY2FzZSBTU1BfRVhURVJOQUxfQ0xP
Q0s6CisJCQkJc3NjcjAgfD0gU1NDUjBfcmVnKEVDUywgMSk7CisJCQkJYnJlYWs7CisJCQljYXNl
IFNTUF9PTkNISVBfQVVESU9fQ0xPQ0s6CisJCQkJc3NjcjAgfD0gU1NDUjBfcmVnKEFDUywgMSk7
CisJCQkJYnJlYWs7CisJCQlkZWZhdWx0OgorCQkJCWRldl9lcnIoZGRiZywgIk1hc3RlciBNb2Rl
IGNsayBzZWxlY3Rpb24gVU5LTk9XTiIpOworCQkJCWJyZWFrOworCQkJfQorCQkJc3Nwc3AgfD0g
U1NQU1BfcmVnKFNUUlRETFksIHBzX3NldHRpbmdzLT5zc3BfcHNwX1QxKQorCQkJCXxTU1BTUF9y
ZWcoRE1ZU1RSVCwgcHNfc2V0dGluZ3MtPnNzcF9wc3BfVDIpOworCQl9IGVsc2UgewkvKiBTZXQg
dGhlIFNsYXZlIENsb2NrIEZyZWUgUnVubmluZyBTdGF0dXMgKi8KKwkJCXNzY3IxIHw9IFNTQ1Ix
X3JlZyhTQ0ZSLCBwc19zZXR0aW5ncy0+c2xhdmVfY2xrX2ZyZWVfcnVubmluZ19zdGF0dXMpOwor
CQl9CisJfSBlbHNlIHsgIC8qIFNTUF9JTl9OT1JNQUxfTU9ERSAqLworCQlkZXZfZXJyKGRkYmcs
ICJVTlNVUFBPUlRFRCBNT0RFIik7CisJCWdvdG8gbGVhdmU7CisJfQorCisJLyogQ2xlYXIgc3Rh
dHVzICovCisJc3NzciA9IChTU1NSX0JDRV9NQVNLIDw8IFNTU1JfQkNFX1NISUZUKQorCSAgICAg
fCAoU1NTUl9UVVJfTUFTSyA8PCBTU1NSX1RVUl9TSElGVCkKKwkgICAgIHwgKFNTU1JfVElOVF9N
QVNLIDw8IFNTU1JfVElOVF9TSElGVCkKKwkgICAgIHwgKFNTU1JfUElOVF9NQVNLIDw8IFNTU1Jf
UElOVF9TSElGVCkKKwkgICAgIHwgKFNTU1JfUk9SX01BU0sgPDwgU1NTUl9ST1JfU0hJRlQpOwor
CS8qIGRpc2FibGUgU1NQICovCisJY2xlYXJfU1NDUjBfcmVnKHJlZywgU1NFKTsKKwlkZXZfZGJn
KGRkYmcsICJXUklURSBTU0NSMCBESVNBQkxFXG4iKTsKKwkvKiBDbGVhciBzdGF0dXMgKi8KKwl3
cml0ZV9TU1NSKHNzc3IsIHJlZyk7CisJZGV2X2RiZyhkZGJnLCAiV1JJVEUgU1NTUjogMHglMDhY
XG4iLCBzc3NyKTsKKwl3cml0ZV9TU0NSMChzc2NyMCwgcmVnKTsKKwlkZXZfZGJnKGRkYmcsICJX
UklURSBTU0NSMFxuIik7CisJLyogZmlyc3Qgc2V0IENSMSB3aXRob3V0IGludGVycnVwdCBhbmQg
c2VydmljZSBlbmFibGVzICovCisJd3JpdGVfU1NDUjEoc3NjcjEsIHJlZyk7CisJd3JpdGVfU1NQ
U1Aoc3Nwc3AsIHJlZyk7CisJd3JpdGVfU1NUU0Eoc3N0c2EsIHJlZyk7CisJd3JpdGVfU1NSU0Eo
c3Nyc2EsIHJlZyk7CisJLyogc2V0IHRoZSB0aW1lIG91dCBmb3IgdGhlIHJlY2VwdGlvbiAqLwor
CXdyaXRlX1NTVE8oMCwgcmVnKTsKKwlzc3AxX2R1bXBfcmVnaXN0ZXJzKGRydl9kYXRhKTsKK2xl
YXZlOgorCXJldHVybjsKK30KKworc3RhdGljIGludAoraW50ZWxfbWlkX2kyc19maW5kX3VzYWdl
KHN0cnVjdCBwY2lfZGV2ICpwZGV2LAorCQkJIHN0cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqZHJ2
X2RhdGEsCisJCQkgZW51bSBpbnRlbF9taWRfaTJzX3NzcF91c2FnZSAqdXNhZ2UpCit7CisJaW50
IHBvczsKKwl1OCAgYWRpZDsKKwlpbnQgc3RhdHVzID0gMDsKKworCSp1c2FnZSA9IFNTUF9VU0FH
RV9VTkFTU0lHTkVEOworCXBvcyA9IHBjaV9maW5kX2NhcGFiaWxpdHkocGRldiwgUENJX0NBUF9J
RF9WTkRSKTsKKwlkZXZfaW5mbygoJnBkZXYtPmRldiksCisJCSJQcm9iZS9maW5kIGNhcGFiaWxp
dHkgKFZORFIgJWQgcG9zPTB4JXgpXG4iLAorCQlQQ0lfQ0FQX0lEX1ZORFIsIHBvcyk7CisJaWYg
KHBvcyA+IDApIHsKKwkJcG9zICs9IFBDSV9DQVBfT0ZGU0VUX0FESUQ7CisJCXBjaV9yZWFkX2Nv
bmZpZ19ieXRlKHBkZXYsIHBvcywgJmFkaWQpOworCQlkZXZfaW5mbygmKHBkZXYtPmRldiksICJW
ZW5kb3IgY2FwYWJpbGl0eSBhZGlkID0gMHgleFxuIiwgYWRpZCk7CisJCWlmIChhZGlkID09IFBD
SV9DQVBfQURJRF9JMlNfQlRfRk0pCisJCQkqdXNhZ2UJPSBTU1BfVVNBR0VfQkxVRVRPT1RIX0ZN
OworCQllbHNlIGlmIChhZGlkID09IFBDSV9DQVBfQURJRF9JMlNfTU9ERU0pCisJCQkqdXNhZ2UJ
PSBTU1BfVVNBR0VfTU9ERU07CisJCWVsc2UKKwkJCSp1c2FnZQk9IFNTUF9VU0FHRV9VTkFTU0lH
TkVEOworCX0KKwkvKiBJZiB0aGVyZSBpcyBubyBjYXBhYmlsaXR5LCBjaGVjayB3aXRoIG9sZCBQ
Q0lfSUQgKi8KKyNpZmRlZiBCWVBBU1NfQURJRAorCWlmICgqdXNhZ2UgPT0gU1NQX1VTQUdFX1VO
QVNTSUdORUQpIHsKKwkJZGV2X3dhcm4oJihwZGV2LT5kZXYpLCAiVmVuZG9yIGNhcGFiaWxpdHkg
bm90IHByZXNlbnQvaW52YWxpZFxuIik7CisJCXN3aXRjaCAocGRldi0+ZGV2aWNlKSB7CisJCWNh
c2UgTUZMRF9TU1AxX0RFVklDRV9JRDoKKwkJCSp1c2FnZQk9IFNTUF9VU0FHRV9CTFVFVE9PVEhf
Rk07CisJCQlicmVhazsKKwkJY2FzZSBNRkxEX1NTUDBfREVWSUNFX0lEOgorCQkJKnVzYWdlCT0g
U1NQX1VTQUdFX01PREVNOworCQkJYnJlYWs7CisJCX0KKwl9CisjZW5kaWYKKwlpZiAoKnVzYWdl
ID09IFNTUF9VU0FHRV9VTkFTU0lHTkVEKSB7CisJCWRldl9pbmZvKCgmcGRldi0+ZGV2KSwKKwkJ
CSJObyBwcm9iZSBmb3IgSTJTIFBDSS1JRDogJTA0eDolMDR4LCBBRElEKDB4JXgpPTB4JXhcbiIs
CisJCQlwZGV2LT52ZW5kb3IsIHBkZXYtPmRldmljZSwgcG9zLCBhZGlkKTsKKwkJc3RhdHVzID0g
LUVOT0RFVjsKKwkJZ290byBlcnJfZmluZF91c2FnZTsKKwl9CisJZGV2X2RiZygmKHBkZXYtPmRl
diksCisJCSJEZXRlY3RlZCBQQ0kgU1NQIChJRDogJTA0eDolMDR4KSB1c2FnZSA9JXhcbiIsCisJ
CXBkZXYtPnZlbmRvciwgcGRldi0+ZGV2aWNlLCAqdXNhZ2UpOworCWRldl9kYmcoJihwZGV2LT5k
ZXYpLAorCQkiIGZvdW5kIFBDSSBTU1AgY29udHJvbGxlcihJRDogJTA0eDolMDR4KVxuIiwKKwkJ
cGRldi0+dmVuZG9yLCBwZGV2LT5kZXZpY2UpOworCS8qIEluaXQgdGhlIGRyaXZlciBkYXRhIHN0
cnVjdHVyZSBmaWVsZHMqLworCXN3aXRjaCAocGRldi0+ZGV2aWNlKSB7CisJY2FzZSBNRkxEX1NT
UDFfREVWSUNFX0lEOgorCQlkcnZfZGF0YS0+ZGV2aWNlX2luc3RhbmNlID0gRE1BMUNfREVWSUNF
X0lOU1RBTkNFX1NTUDE7CisJCWJyZWFrOworCWNhc2UgTUZMRF9TU1AwX0RFVklDRV9JRDoKKwkJ
ZHJ2X2RhdGEtPmRldmljZV9pbnN0YW5jZSA9IERNQTFDX0RFVklDRV9JTlNUQU5DRV9TU1AwOwor
CQlicmVhazsKKwlkZWZhdWx0OgorCQlkZXZfZXJyKCYocGRldi0+ZGV2KSwKKwkJCSJDYW4gbm90
IGRldGVybWluZSBkbWEgZGV2aWNlIGluc3RhbmNlIChQQ0kgSUQ6JTA0eClcbiIsCisJCQlwZGV2
LT5kZXZpY2UpOworCQlzdGF0dXMgPSAtRU5PREVWOworCQlnb3RvIGVycl9maW5kX3VzYWdlOwor
CX0KKwlzdGF0dXMgPSBwY2lfZW5hYmxlX2RldmljZShwZGV2KTsKKwlpZiAoc3RhdHVzKQorCQlk
ZXZfZXJyKCgmcGRldi0+ZGV2KSwgIkNhbiBub3QgZW5hYmxlIGRldmljZS5FcnI9JWRcbiIsIHN0
YXR1cyk7CitlcnJfZmluZF91c2FnZToKKwlyZXR1cm4gc3RhdHVzOworfQorCisvKioKKyAqIGlu
dGVsX21pZF9pMnNfcHJvYmUgLSBwcm9iaW5nIGZ1bmN0aW9uIGZvciB0aGUgcGNpIHNlbGVjdGVk
CisgKiBAcGRldiA6IHBjaV9kZXYgcG9pbnRlciB0aGF0IGlzIHByb2JlZAorICogQGVudCA6IHBj
aV9kZXZpY2VfaWQKKyAqCisgKiBPdXRwdXQgcGFyYW1ldGVycworICogICAgICBOQQorICovCitz
dGF0aWMgaW50IGludGVsX21pZF9pMnNfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBkZXYsCisJCQkJ
Y29uc3Qgc3RydWN0IHBjaV9kZXZpY2VfaWQgKmVudCkKK3sKKwlzdHJ1Y3QgaW50ZWxfbWlkX2ky
c19oZGwgKmRydl9kYXRhOworCWludCBzdGF0dXMgPSAwOworCWVudW0gaW50ZWxfbWlkX2kyc19z
c3BfdXNhZ2UgdXNhZ2U7CisKKwlkcnZfZGF0YSA9IGt6YWxsb2Moc2l6ZW9mKHN0cnVjdCBpbnRl
bF9taWRfaTJzX2hkbCksIEdGUF9LRVJORUwpOworCWRldl9kYmcoJihwZGV2LT5kZXYpLCAiJXMg
UHJvYmUsIGRydl9kYXRhID0lcFxuIiwgRFJJVkVSX05BTUUsIGRydl9kYXRhKTsKKwlpZiAoIWRy
dl9kYXRhKSB7CisJCWRldl9lcnIoKCZwZGV2LT5kZXYpLCAiQ2FuJ3QgYWxsb2MgZHJpdmVyIGRh
dGEgaW4gcHJvYmVcbiIpOworCQlzdGF0dXMgPSAtRU5PTUVNOworCQlnb3RvIGxlYXZlOworCX0K
KwlkZXZfaW5mbygoJnBkZXYtPmRldiksICJEZXRlY3RlZCBQQ0kgU1NQIChJRDogJTA0eDolMDR4
KVxuIiwgcGRldi0+dmVuZG9yLCBwZGV2LT5kZXZpY2UpOworCXN0YXR1cyA9IGludGVsX21pZF9p
MnNfZmluZF91c2FnZShwZGV2LCBkcnZfZGF0YSwgJnVzYWdlKTsKKwlpZiAoc3RhdHVzKQorCQln
b3RvIGVycl9pMnNfcHJvYmUwOworCW11dGV4X2luaXQoJmRydl9kYXRhLT5tdXRleCk7CisJZHJ2
X2RhdGEtPnBkZXYgPSBwZGV2OworCWRydl9kYXRhLT51c2FnZSA9IHVzYWdlOworCS8qCisJICog
R2V0IGJhc2ljIGlvIHJlc291cmNlIGFuZCBtYXAgaXQgZm9yIFNTUDEgW0JBUj0wXQorCSAqLwor
CWlmICgocGRldi0+ZGV2aWNlID09IE1GTERfU1NQMV9ERVZJQ0VfSUQpIHx8CisJICAgIChwZGV2
LT5kZXZpY2UgPT0gTUZMRF9TU1AwX0RFVklDRV9JRCkpIHsKKwkJZHJ2X2RhdGEtPnBhZGRyID0g
cGNpX3Jlc291cmNlX3N0YXJ0KHBkZXYsIE1SU1RfU1NQX0JBUik7CisJCWRydl9kYXRhLT5pb2xl
biA9IHBjaV9yZXNvdXJjZV9sZW4ocGRldiwgTVJTVF9TU1BfQkFSKTsKKwkJc3RhdHVzID0gcGNp
X3JlcXVlc3RfcmVnaW9uKHBkZXYsIE1SU1RfU1NQX0JBUiwgZGV2X25hbWUoJnBkZXYtPmRldikp
OworCQkvKiBtYXAgYnVzIG1lbW9yeSBpbnRvIENQVSBzcGFjZSAqLworCQlkcnZfZGF0YS0+aW9h
ZGRyID0gcGNpX2lvcmVtYXBfYmFyKHBkZXYsIE1SU1RfU1NQX0JBUik7CisJfSBlbHNlIHsKKwkJ
ZGV2X2VycigmcGRldi0+ZGV2LAorCQkJIkRvbid0IGtub3cgd2hpY2ggQkFSIHRvIHVzZWZvciB0
aGlzIFNTUCBQQ0RJRD0leFxuIiwKKwkJCXBkZXYtPmRldmljZSk7CisJCXN0YXR1cyA9IC1FTk9E
RVY7CisJCWdvdG8gZXJyX2kyc19wcm9iZTE7CisJfQorCWRldl9kYmcoJihwZGV2LT5kZXYpLCAi
cGFkZHIgPSA6ICV4XG4iLCBkcnZfZGF0YS0+cGFkZHIpOworCWRldl9kYmcoJihwZGV2LT5kZXYp
LCAiaW9sZW4gPSA6ICVkXG4iLCBkcnZfZGF0YS0+aW9sZW4pOworCWlmIChzdGF0dXMpIHsKKwkJ
ZGV2X2VycigoJnBkZXYtPmRldiksICJDYW4ndCByZXF1ZXN0IHJlZ2lvbi4gZXJyPSVkXG4iLCBz
dGF0dXMpOworCQlnb3RvIGVycl9pMnNfcHJvYmUxOworCX0KKwlpZiAoIWRydl9kYXRhLT5pb2Fk
ZHIpIHsKKwkJZGV2X2VycigoJnBkZXYtPmRldiksICJpb3JlbWFwX25vY2FjaGUgZXJyb3JcbiIp
OworCQlzdGF0dXMgPSAtRU5PTUVNOworCQlnb3RvIGVycl9pMnNfcHJvYmUyOworCX0KKwlkZXZf
ZGJnKCYocGRldi0+ZGV2KSwgImlvYWRkciA9IDogJXBcbiIsIGRydl9kYXRhLT5pb2FkZHIpOwor
CS8qIHByZXBhcmUgZm9yIERNQSBjaGFubmVsIGFsbG9jYXRpb24gKi8KKwkvKiBnZXQgdGhlIHBj
aV9kZXYgc3RydWN0dXJlIHBvaW50ZXIgKi8KKwkvKiBDaGVjayB0aGUgU1NQLCBpZiBTU1AzLCB0
aGVuIGFub3RoZXIgRE1BIGlzIHVzZWQgKEdQRE1BLi4pICovCisJaWYgKChwZGV2LT5kZXZpY2Ug
PT0gTUZMRF9TU1AxX0RFVklDRV9JRCkgfHwKKwkgICAgKHBkZXYtPmRldmljZSA9PSBNRkxEX1NT
UDBfREVWSUNFX0lEKSkgeworCQlkcnZfZGF0YS0+ZG1hYzEgPSBwY2lfZ2V0X2RldmljZShQQ0lf
VkVORE9SX0lEX0lOVEVMLAorCQkJCQkJIE1GTERfTFBFX0RNQV9ERVZJQ0VfSUQsCisJCQkJCQkg
TlVMTCk7CisJfSBlbHNlIHsKKwkJZGV2X2VycigmcGRldi0+ZGV2LAorCQkJIkRvbid0IGtub3cg
ZG1hIGRldmljZSBJRCBmb3IgdGhpcyBTU1AgUENESUQ9JXhcbiIsCisJCQlwZGV2LT5kZXZpY2Up
OworCQlnb3RvIGVycl9pMnNfcHJvYmUzOworCX0KKwkvKiBpbiBjYXNlIHRoZSBzdG9wIGRtYSBo
YXZlIHRvIHdhaXQgZm9yIGVuZCBvZiBjYWxsYmFja3MgICAqLworCS8qIFRoaXMgd2lsbCBiZSBy
ZW1vdmVkIHdoZW4gVEVSTUlOQVRFX0FMTCBhdmFpbGFibGUgaW4gRE1BICovCisJaW5pdF93YWl0
cXVldWVfaGVhZCgmZHJ2X2RhdGEtPndxX2NoYW5fY2xvc2luZyk7CisJaWYgKCFkcnZfZGF0YS0+
ZG1hYzEpIHsKKwkJZGV2X2VycigmKGRydl9kYXRhLT5wZGV2LT5kZXYpLCAiQ2FuJ3QgZmluZCBE
TUFDMSwgZG1hIGluaXQgZmFpbGVkXG4iKTsKKwkJc3RhdHVzID0gLUVOT0RFVjsKKwkJZ290byBl
cnJfaTJzX3Byb2JlMzsKKwl9CisJLyogaW5jcmVtZW50IHJlZiBjb3VudCBvZiBwY2kgZGV2aWNl
IHN0cnVjdHVyZSBhbHJlYWR5IGRvbmUgYnkgKi8KKwkvKiBwY2lfZ2V0X2RldmljZS4gd2lsbCBk
byBhIHBjaV9kZXZfcHV0IHdoZW4gZXhpdGluZyB0aGUgbW9kdWxlICovCisJcGNpX3NldF9kcnZk
YXRhKHBkZXYsIGRydl9kYXRhKTsKKwkvKiBzZXQgU1NQIEZyYW1lU3luYyBhbmQgQ0xLIGRpcmVj
dGlvbiBpbiBJTlBVVCBtb2RlIGluIG9yZGVyCisJICogdG8gYXZvaWQgZGlzdHVyYmluZyBwZXJp
cGhlcmFscworCSAqLworCXdyaXRlX1NTQ1IxKChTU0NSMV9TRlJNRElSX01BU0s8PFNTQ1IxX1NG
Uk1ESVJfU0hJRlQpCisJCSAgfCAoU1NDUjFfU0NMS0RJUl9NQVNLPDxTU0NSMV9TQ0xLRElSX1NI
SUZUKSwKKwlkcnZfZGF0YS0+aW9hZGRyKTsKKwkvKiBBdHRhY2ggdG8gSVJRICovCisJZHJ2X2Rh
dGEtPmlycSA9IHBkZXYtPmlycTsKKwlkZXZfZGJnKCYocGRldi0+ZGV2KSwgImF0dGFjaGluZyB0
byBJUlE6ICUwNHhcbiIsIHBkZXYtPmlycSk7CisJc3RhdHVzID0gcmVxdWVzdF9pcnEoZHJ2X2Rh
dGEtPmlycSwgaTJzX2ludCwgSVJRRl9TSEFSRUQsICJpMnMgc3NwIiwgZHJ2X2RhdGEpOworCWlm
IChzdGF0dXMgPCAwKQl7CisJCWRldl9lcnIoJnBkZXYtPmRldiwgImNhbiBub3QgZ2V0IElSUS4g
c3RhdHVzIGVycj0lZFxuIiwgc3RhdHVzKTsKKwkJZ290byBlcnJfaTJzX3Byb2JlMzsKKwl9CisJ
cG1fcnVudGltZV9lbmFibGUoJihkcnZfZGF0YS0+cGRldi0+ZGV2KSk7CisJZ290byBsZWF2ZTsK
K2Vycl9pMnNfcHJvYmUzOgorCWlvdW5tYXAoZHJ2X2RhdGEtPmlvYWRkcik7CitlcnJfaTJzX3By
b2JlMjoKKwlwY2lfcmVsZWFzZV9yZWdpb24ocGRldiwgTVJTVF9TU1BfQkFSKTsKK2Vycl9pMnNf
cHJvYmUxOgorCXBjaV9kaXNhYmxlX2RldmljZShwZGV2KTsKK2Vycl9pMnNfcHJvYmUwOgorCWtm
cmVlKGRydl9kYXRhKTsKK2xlYXZlOgorCXJldHVybiBzdGF0dXM7Cit9CisKK3N0YXRpYyB2b2lk
IF9fZGV2ZXhpdCBpbnRlbF9taWRfaTJzX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqcGRldikKK3sK
KwlzdHJ1Y3QgaW50ZWxfbWlkX2kyc19oZGwgKmRydl9kYXRhOworCisJZHJ2X2RhdGEgPSBwY2lf
Z2V0X2RydmRhdGEocGRldik7CisJaWYgKCFkcnZfZGF0YSkgeworCQlkZXZfZXJyKCZwZGV2LT5k
ZXYsICJubyBkcnZfZGF0YSBpbiBwY2kgZGV2aWNlIHRvIHJlbW92ZSFcbiIpOworCQlnb3RvIGxl
YXZlOworCX0KKwlpZiAodGVzdF9iaXQoSTJTX1BPUlRfT1BFTkVELCAmZHJ2X2RhdGEtPmZsYWdz
KSkgeworCQlkZXZfd2FybigmcGRldi0+ZGV2LCAiTm90IGNsb3NlZCBiZWZvcmUgcmVtb3Zpbmcg
cGNpX2RldiFcbiIpOworCQlpbnRlbF9taWRfaTJzX2Nsb3NlKGRydl9kYXRhKTsKKwl9CisJcGNp
X3NldF9kcnZkYXRhKHBkZXYsIE5VTEwpOworCS8qIFN0b3AgRE1BIGlzIGFscmVhZHkgZG9uZSBk
dXJpbmcgY2xvc2UoKSAgKi8KKwlwY2lfZGV2X3B1dChkcnZfZGF0YS0+ZG1hYzEpOworCS8qIERp
c2FibGUgdGhlIFNTUCBhdCB0aGUgcGVyaXBoZXJhbCBhbmQgU09DIGxldmVsICovCisJd3JpdGVf
U1NDUjAoMCwgZHJ2X2RhdGEtPmlvYWRkcik7CisJZnJlZV9pcnEoZHJ2X2RhdGEtPmlycSwgZHJ2
X2RhdGEpOworCWlvdW5tYXAoZHJ2X2RhdGEtPmlvYWRkcik7CisJcGNpX3JlbGVhc2VfcmVnaW9u
KHBkZXYsIE1SU1RfU1NQX0JBUik7CisJcGNpX3JlbGVhc2VfcmVnaW9uKHBkZXYsIE1SU1RfTFBF
X0JBUik7CisJcGNpX2Rpc2FibGVfZGV2aWNlKHBkZXYpOworCWtmcmVlKGRydl9kYXRhKTsKK2xl
YXZlOgorCXJldHVybjsKK30KKworLyoqCisgKiBpbnRlbF9taWRfaTJzX2luaXQgLSByZWdpc3Rl
ciBwY2kgZHJpdmVyCisgKgorICovCitzdGF0aWMgaW50IF9faW5pdCBpbnRlbF9taWRfaTJzX2lu
aXQodm9pZCkKK3sKKwlyZXR1cm4gcGNpX3JlZ2lzdGVyX2RyaXZlcigmaW50ZWxfbWlkX2kyc19k
cml2ZXIpOworfQorCitzdGF0aWMgdm9pZCBfX2V4aXQgaW50ZWxfbWlkX2kyc19leGl0KHZvaWQp
Cit7CisJcGNpX3VucmVnaXN0ZXJfZHJpdmVyKCZpbnRlbF9taWRfaTJzX2RyaXZlcik7Cit9CisK
KworbW9kdWxlX2luaXQoaW50ZWxfbWlkX2kyc19pbml0KTsKK21vZHVsZV9leGl0KGludGVsX21p
ZF9pMnNfZXhpdCk7CisKKworCmRpZmYgLS1naXQgYS9zb3VuZC9wY2kvaW50ZWxfbWlkX2kycy9p
bnRlbF9taWRfaTJzLmggYi9zb3VuZC9wY2kvaW50ZWxfbWlkX2kycy9pbnRlbF9taWRfaTJzLmgK
bmV3IGZpbGUgbW9kZSAxMDA2NDQKaW5kZXggMDAwMDAwMC4uZWYyOWNlNwotLS0gL2Rldi9udWxs
CisrKyBiL3NvdW5kL3BjaS9pbnRlbF9taWRfaTJzL2ludGVsX21pZF9pMnMuaApAQCAtMCwwICsx
LDUwMCBAQAorLyoKKyAgKiA8RHJpdmVyIGZvciBJMlMgcHJvdG9jb2wgb24gU1NQIChNb29yZXN0
b3duIGFuZCBNZWRmaWVsZCBoYXJkd2FyZSk+CisgICogQ29weXJpZ2h0IChjKSAyMDEwLCBJbnRl
bCBDb3Jwb3JhdGlvbi4KKyAgKiBMb3VpcyBMRSBHQUxMIDxsb3Vpcy5sZS5nYWxsIGludGVsLmNv
bT4KKyAgKgorICAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlz
dHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5IGl0CisgICogdW5kZXIgdGhlIHRlcm1zIGFuZCBjb25k
aXRpb25zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSwKKyAgKiB2ZXJzaW9uIDIs
IGFzIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBGb3VuZGF0aW9uLgorICAqCisgICog
VGhpcyBwcm9ncmFtIGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIGl0IHdpbGwgYmUgdXNlZnVs
LCBidXQgV0lUSE9VVAorICAqIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVk
IHdhcnJhbnR5IG9mIE1FUkNIQU5UQUJJTElUWSBvcgorICAqIEZJVE5FU1MgRk9SIEEgUEFSVElD
VUxBUiBQVVJQT1NFLiAgU2VlIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBmb3IKKyAg
KiBtb3JlIGRldGFpbHMuCisgICoKKyAgKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBjb3B5
IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBhbG9uZyB3aXRoCisgICogdGhpcyBw
cm9ncmFtOyBpZiBub3QsIHdyaXRlIHRvIHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24sIElu
Yy4sCisgICogNTEgRnJhbmtsaW4gU3QgLSBGaWZ0aCBGbG9vciwgQm9zdG9uLCBNQSAwMjExMC0x
MzAxIFVTQS4KKyAgKi8KKyNkZWZpbmUgRFJJVkVSX05BTUUgIkkyUyBTU1AgRHJpdmVyIgorLyoK
KyAqIERlZmluZXMKKyAqLworI2RlZmluZSBNRkxEX1NTUDFfREVWSUNFX0lEIDB4MDgyNQkvKiBG
T1IgTUZMRCAqLworI2RlZmluZSBNUlNUX1NTUDBfREVWSUNFX0lEIDB4MDgxNQkvKiBGT1IgTVJT
VCAqLworI2RlZmluZSBNRkxEX1NTUDBfREVWSUNFX0lEIDB4MDgzMgkvKiBGT1IgTUZMRCAqLwor
CisjZGVmaW5lIE1SU1RfTFBFX0RNQV9ERVZJQ0VfSUQgMHgwODE0CisjZGVmaW5lIE1GTERfTFBF
X0RNQV9ERVZJQ0VfSUQgMHgwODMwCisKKy8qIFNTUDEgUENJIGRldmljZSBCYXNlIEFkZHJlc3Mg
UmVnaXN0ZXIgKi8KKyNkZWZpbmUgTVJTVF9TU1BfQkFSCTAKKyNkZWZpbmUgTVJTVF9MUEVfQkFS
CTEKKyNkZWZpbmUgRE1BMUNfREVWSUNFX0lOU1RBTkNFX1NTUDAgMAorI2RlZmluZSBETUExQ19E
RVZJQ0VfSU5TVEFOQ0VfU1NQMSAxCisjZGVmaW5lIE9GRlNFVF9TU0NSMAkweDAwCisjZGVmaW5l
IE9GRlNFVF9TU0NSMQkweDA0CisjZGVmaW5lIE9GRlNFVF9TU1NSCQkweDA4CisjZGVmaW5lIE9G
RlNFVF9TU0lUUgkweDBjCisjZGVmaW5lIE9GRlNFVF9TU0RSCQkweDEwCisjZGVmaW5lIE9GRlNF
VF9TU1RPCQkweDI4CisjZGVmaW5lIE9GRlNFVF9TU1BTUAkweDJjCisjZGVmaW5lIE9GRlNFVF9T
U1RTQQkweDMwCS8qIFNTUCBUeCBUaW1lc2xvdCBBY3RpdmUgKi8KKyNkZWZpbmUgT0ZGU0VUX1NT
UlNBCTB4MzQJLyogU1NQIFJ4IFRpbWVzbG90IEFjdGl2ZSAqLworLyogU1NUIHJlZ2lzdGVyIG1h
cCAqLworI2RlZmluZSBPRkZTRVRfTFBFX0NTUgkJCTB4MDAKKyNkZWZpbmUgT0ZGU0VUX0xQRV9Q
SVNSCQkJMHgwOAorI2RlZmluZSBPRkZTRVRfTFBFX1BJTVIJCQkweDEwCisjZGVmaW5lIE9GRlNF
VF9MUEVfSVNSWAkJCTB4MTgKKyNkZWZpbmUgT0ZGU0VUX0xQRV9JTVJYCQkJMHgyOAorI2RlZmlu
ZSBPRkZTRVRfTFBFX0lQQ1gJCQkweDM4CS8qIElQQyBJQS1TU1QgKi8KKyNkZWZpbmUgT0ZGU0VU
X0xQRV9JUENECQkJMHg0MAkvKiBJUEMgU1NULUlBICovCisjZGVmaW5lIE9GRlNFVF9MUEVfSVNS
RAkJCTB4MjAJLyogZHVtbXkgcmVnaXN0ZXIgZm9yKi8KKwkJCQkJCS8qIHNoaW0gd29ya2Fyb3Vu
ZCAgICovCisjZGVmaW5lIE9GRlNFVF9MUEVfU0hJTV9TSVpFCTBYNDQKKworI2RlZmluZSBTU1Bf
SU5fTUFTVEVSX01PREUJCTB4MAorI2RlZmluZSBTU1BfSU5fU0xBVkVfTU9ERQkJMHgxCisKKy8q
CisgKglNYWNyb3MKKyAqLworI2RlZmluZSBERUZJTkVfU1NQX1JFRyhyZWcsIG9mZikgXAorc3Rh
dGljIGlubGluZSB1MzIgcmVhZF8jI3JlZyh2b2lkICpwKSB7IHJldHVybiBfX3Jhd19yZWFkbChw
ICsgKG9mZikpOyB9IFwKK3N0YXRpYyBpbmxpbmUgdm9pZCB3cml0ZV8jI3JlZyh1MzIgdiwgdm9p
ZCAqcCkgeyBfX3Jhd193cml0ZWwodiwgcCArIChvZmYpKTsgfQorREVGSU5FX1NTUF9SRUcoU1ND
UjAsIDB4MDApCitERUZJTkVfU1NQX1JFRyhTU0NSMSwgMHgwNCkKK0RFRklORV9TU1BfUkVHKFNT
U1IsIDB4MDgpCitERUZJTkVfU1NQX1JFRyhTU0lUUiwgMHgwYykKK0RFRklORV9TU1BfUkVHKFNT
RFIsIDB4MTApCitERUZJTkVfU1NQX1JFRyhTU1RPLCAweDI4KQorREVGSU5FX1NTUF9SRUcoU1NQ
U1AsIDB4MmMpCitERUZJTkVfU1NQX1JFRyhTU1RTQSwgMHgzMCkKK0RFRklORV9TU1BfUkVHKFNT
UlNBLCAweDM0KQorREVGSU5FX1NTUF9SRUcoU1NUU1MsIDB4MzgpCitERUZJTkVfU1NQX1JFRyhT
U0FDRCwgMHgzQykKK0RFRklORV9TU1BfUkVHKEkyQ0NUUkwsIDB4MDApOworREVGSU5FX1NTUF9S
RUcoSTJDREFUQSwgMHgwNCk7CisvKgorICogTGFuZ3dlbGwgU1NQIHNlcmlhbCBwb3J0IHJlZ2lz
dGVyIGRlZmluaXRpb25zCisgKi8KKyNkZWZpbmUgU1NDUjBfRFNTX01BU0sgICAweDBGCS8qIERh
dGEgU2l6ZSBTZWxlY3QgWzQuLjE2XSAqLworI2RlZmluZSBTU0NSMF9EU1NfU0hJRlQgIDAKKyNk
ZWZpbmUgU1NDUjBfRlJGX01BU0sgICAweDAzCS8qIEZSYW1lIEZvcm1hdCAqLworI2RlZmluZSBT
U0NSMF9GUkZfU0hJRlQgIDQKKyNkZWZpbmUgU1NDUjBfRUNTX01BU0sgICAweDAxCS8qIEV4dGVy
bmFsIGNsb2NrIHNlbGVjdCAqLworI2RlZmluZSBTU0NSMF9FQ1NfU0hJRlQgIDYKKyNkZWZpbmUg
U1NDUjBfU1NFX01BU0sgICAweDAxCS8qIFN5bmNocm9ub3VzIFNlcmlhbCBQb3J0IEVuYWJsZSAq
LworI2RlZmluZSBTU0NSMF9TU0VfU0hJRlQgIDcKKyNkZWZpbmUgU1NDUjBfU0NSX01BU0sgICAw
eEZGRgkvKiBOb3QgaW1wbGVtZW50ZWQgKi8KKyNkZWZpbmUgU1NDUjBfU0NSX1NISUZUICA4Cisj
ZGVmaW5lIFNTQ1IwX0VEU1NfTUFTSyAgMHgxCS8qIEV4dGVuZGVkIGRhdGEgc2l6ZSBzZWxlY3Qg
Ki8KKyNkZWZpbmUgU1NDUjBfRURTU19TSElGVCAyMAorI2RlZmluZSBTU0NSMF9OQ1NfTUFTSyAg
IDB4MQkvKiBOZXR3b3JrIGNsb2NrIHNlbGVjdCAqLworI2RlZmluZSBTU0NSMF9OQ1NfU0hJRlQg
IDIxCisjZGVmaW5lIFNTQ1IwX1JJTV9NQVNLICAgMHgxCS8qIFJlY2VpdmUgRklGTyBvdmVycnJ1
biBpbnQgbWFzayAqLworI2RlZmluZSBTU0NSMF9SSU1fU0hJRlQgIDIyCisjZGVmaW5lIFNTQ1Iw
X1RJTV9NQVNLICAgMHgxCS8qIFRyYW5zbWl0IEZJRk8gdW5kZXJydW4gaW50IG1hc2sgKi8KKyNk
ZWZpbmUgU1NDUjBfVElNX1NISUZUICAyMworI2RlZmluZSBTU0NSMF9GUkRDX01BU0sgIDB4Nwkv
KiBGcmFtZSBSYXRlIERpdmlkZXIgQ29udHJvbCAqLworI2RlZmluZSBTU0NSMF9GUkRDX1NISUZU
IDI0CisjZGVmaW5lIFNTQ1IwX0FDU19NQVNLICAgMHgxCS8qIEF1ZGlvIGNsb2NrIHNlbGVjdCAq
LworI2RlZmluZSBTU0NSMF9BQ1NfU0hJRlQgIDMwCisjZGVmaW5lIFNTQ1IwX01PRF9NQVNLICAg
MHgxCS8qIE1vZGUgKG5vcm1hbCBvciBuZXR3b3JrKSAqLworI2RlZmluZSBTU0NSMF9NT0RfU0hJ
RlQgIDMxCisKKyNkZWZpbmUgU1NDUjBfRGF0YVNpemUoeCkgICAgICgoeCkgLSAxKQkvKiBEYXRh
IFNpemUgU2VsZWN0IFs0Li4xNl0gKi8KKyNkZWZpbmUgU1NDUjBfU2xvdHNQZXJGcm0oeCkgICgo
eCkgLSAxKQkvKiBUaW1lIHNsb3RzIHBlciBmcmFtZSAqLworI2RlZmluZSBTU0NSMF9TZXJDbGtE
aXYoeCkgICAgKCh4KSAtIDEpCS8qIERpdmlzb3IgWzEuLjQwOTZdLC4uLiAqLworCQkJCQkgLyou
Li5ub3QgaW1wbGVtZW50ZWQgb24gTGFuZ3dlbGwgKi8KKyNkZWZpbmUgU1NDUjFfVFRFTFBfTUFT
SyAgICAgMHgxCS8qIFRYRCBUcmlzdGF0ZSBFbmFibGUgb24gTGFzdCBQaGFzZSAqLworI2RlZmlu
ZSBTU0NSMV9UVEVMUF9TSElGVCAgICAzMQorI2RlZmluZSBTU0NSMV9UVEVfTUFTSwkgICAgIDB4
MQkvKiBUWEQgVHJpc3RhdGUgRW5hYmxlICovCisjZGVmaW5lIFNTQ1IxX1RURV9TSElGVCAgICAg
IDMwCisjZGVmaW5lIFNTQ1IxX0VCQ0VJX01BU0sgICAgIDB4MQkvKiBFbmFibGUgQml0IENvdW50
IEVycm9yIEludGVycnVwdCAqLworI2RlZmluZSBTU0NSMV9FQkNFSV9TSElGVCAgICAyOQorI2Rl
ZmluZSBTU0NSMV9TQ0ZSX01BU0sgICAgICAweDEJLyogU2xhdmUgQ2xvY2sgUnVubmluZyAqLwor
I2RlZmluZSBTU0NSMV9TQ0ZSX1NISUZUICAgICAyOAorI2RlZmluZSBTU0NSMV9FQ1JBX01BU0sg
ICAgICAweDEJLyogRW5hYmxlIENsb2NrIFJlcXVlc3QgQSAqLworI2RlZmluZSBTU0NSMV9FQ1JB
X1NISUZUICAgICAyNworI2RlZmluZSBTU0NSMV9FQ1JCX01BU0sgICAgICAweDEJLyogRW5hYmxl
IENsb2NrIFJlcXVlc3QgQiAqLworI2RlZmluZSBTU0NSMV9FQ1JCX1NISUZUICAgICAyNgorI2Rl
ZmluZSBTU0NSMV9TQ0xLRElSX01BU0sgICAweDEJLyogU1NQQ0xLIERpcmVjdGlvbiAqLworI2Rl
ZmluZSBTU0NSMV9TQ0xLRElSX1NISUZUICAyNQorI2RlZmluZSBTU0NSMV9TRlJNRElSX01BU0sg
ICAweDEJLyogU1NQRlJNIERpcmVjdGlvbiAqLworI2RlZmluZSBTU0NSMV9TRlJNRElSX1NISUZU
ICAyNAorI2RlZmluZSBTU0NSMV9SV09UX01BU0sgICAgICAweDEJLyogUmVjZWl2ZSB3aXRob3V0
IFRyYW5zbWl0ICovCisjZGVmaW5lIFNTQ1IxX1JXT1RfU0hJRlQgICAgIDIzCisjZGVmaW5lIFNT
Q1IxX1RSQUlMX01BU0sgICAgIDB4MQkvKiBUcmFpbGluZyBCeXRlICovCisjZGVmaW5lIFNTQ1Ix
X1RSQUlMX1NISUZUICAgIDIyCisjZGVmaW5lIFNTQ1IxX1RTUkVfTUFTSyAgICAgIDB4MQkvKiBE
TUEgVHJhbnNtaXQgU2VydmljZSBSZXF1ZXN0IEVuYWJsZSovCisjZGVmaW5lIFNTQ1IxX1RTUkVf
U0hJRlQgICAgIDIxCisjZGVmaW5lIFNTQ1IxX1JTUkVfTUFTSyAgICAgIDB4MQkvKiBETUEgUmVj
ZWl2ZSBTZXJ2aWNlIFJlcXVlc3QgRW5hYmxlICovCisjZGVmaW5lIFNTQ1IxX1JTUkVfU0hJRlQg
ICAgIDIwCisjZGVmaW5lIFNTQ1IxX1RJTlRFX01BU0sgICAgIDB4MQkvKiBSZWNlaXZlciBUaW1l
LW91dCBJbnRlcnJ1cHQgRW5hYmxlICovCisjZGVmaW5lIFNTQ1IxX1RJTlRFX1NISUZUICAgIDE5
CisjZGVmaW5lIFNTQ1IxX1BJTlRFX01BU0sgICAgIDB4MQkvKiBQZXJpcGguIFRyYWlsaW5nIEJ5
dGUgSW50LiBFbmFibGUgKi8KKyNkZWZpbmUgU1NDUjFfUElOVEVfU0hJRlQgICAgMTgKKyNkZWZp
bmUgU1NDUjFfSUZTX01BU0sgICAgICAgMHgxCS8qIEludmVydCBGcmFtZSBTaWduYWwgKi8KKyNk
ZWZpbmUgU1NDUjFfSUZTX1NISUZUICAgICAgMTYKKyNkZWZpbmUgU1NDUjFfU1RGUl9NQVNLICAg
ICAgMHgxCS8qIFNlbGVjdCBGSUZPIGZvciBFRldSOiB0ZXN0IG1vZGUgKi8KKyNkZWZpbmUgU1ND
UjFfU1RGUl9TSElGVCAgICAgMTUKKyNkZWZpbmUgU1NDUjFfRUZXUl9NQVNLICAgICAgMHgxCS8q
IEVuYWJsZSBGSUZPIFdyaXRlL1JlYWQ6IHRlc3QgbW9kZSAqLworI2RlZmluZSBTU0NSMV9FRldS
X1NISUZUICAgICAxNAorI2RlZmluZSBTU0NSMV9SRlRfTUFTSyAgICAgICAweEYJLyogUmVjZWl2
ZSBGSUZPIFRyaWdnZXIgVGhyZXNob2xkICovCisjZGVmaW5lIFNTQ1IxX1JGVF9TSElGVCAgICAg
IDEwCisjZGVmaW5lIFNTQ1IxX1RGVF9NQVNLICAgICAgIDB4RgkvKiBUcmFuc21pdCBGSUZPIFRy
aWdnZXIgVGhyZXNob2xkICovCisjZGVmaW5lIFNTQ1IxX1RGVF9TSElGVCAgICAgIDYKKyNkZWZp
bmUgU1NDUjFfTVdEU19NQVNLICAgICAgMHgxCS8qIE1pY3Jvd2lyZSBUcmFuc21pdCBEYXRhIFNp
emUgKi8KKyNkZWZpbmUgU1NDUjFfTVdEU19TSElGVCAgICAgNQorI2RlZmluZSBTU0NSMV9TUEhf
TUFTSyAgICAgICAweDEJLyogTW90b3JvbGEgU1BJIFNTUFNDTEsgcGhhc2Ugc2V0dGluZyAqLwor
I2RlZmluZSBTU0NSMV9TUEhfU0hJRlQgICAgICA0CisjZGVmaW5lIFNTQ1IxX1NQT19NQVNLICAg
ICAgIDB4MQkvKiBNb3Rvcm9sYSBTUEkgU1NQU0NMSyBwb2xhcml0eSAqLworI2RlZmluZSBTU0NS
MV9TUE9fU0hJRlQgICAgICAzCisjZGVmaW5lIFNTQ1IxX0xCTV9NQVNLICAgICAgIDB4MQkvKiBM
b29wYmFjayBtb2RlOiB0ZXN0IG1vZGUgKi8KKyNkZWZpbmUgU1NDUjFfTEJNX1NISUZUICAgICAg
MgorI2RlZmluZSBTU0NSMV9USUVfTUFTSyAgICAgICAweDEJLyogVHJhbnNtaXQgRklGTyBJbnRl
cnJ1cHQgRW5hYmxlICovCisjZGVmaW5lIFNTQ1IxX1RJRV9TSElGVCAgICAgIDEKKyNkZWZpbmUg
U1NDUjFfUklFX01BU0sgICAgICAgMHgxCS8qIFJlY2VpdmUgRklGTyBJbnRlcnJ1cHQgRW5hYmxl
ICovCisjZGVmaW5lIFNTQ1IxX1JJRV9TSElGVCAgICAgIDAKKworI2RlZmluZSBTU0NSMV9SeFRy
ZXNoKHgpICgoeCkgLSAxKQkvKiBsZXZlbCBbMS4uMTZdICovCisjZGVmaW5lIFNTQ1IxX1R4VHJl
c2goeCkgKCh4KSAtIDEpCS8qIGxldmVsIFsxLi4xNl0gKi8KKworI2RlZmluZSBTU1BTUF9GU1JU
X01BU0sgICAgICAweDEJLyogRnJhbWUgU3luYyBSZWxhdGl2ZSBUaW1pbmcgQml0ICovCisjZGVm
aW5lIFNTUFNQX0ZTUlRfU0hJRlQgICAgIDI1CisjZGVmaW5lIFNTUFNQX0RNWVNUT1BfTUFTSyAg
IDB4MwkvKiBEdW1teSBTdG9wIGluIE51bWJlciBvZiBTU1BTQ0xLczpUNCovCisjZGVmaW5lIFNT
UFNQX0RNWVNUT1BfU0hJRlQgIDIzCisjZGVmaW5lIFNTUFNQX1NGUk1XRFRIX01BU0sgIDB4M0YJ
LyogU2VyaWFsIEZyYW1lIHdpZHRoIDogVDYgKi8KKyNkZWZpbmUgU1NQU1BfU0ZSTVdEVEhfU0hJ
RlQgMTYKKyNkZWZpbmUgU1NQU1BfU0ZSTURMWV9NQVNLICAgMHg3RgkvKiBTZXJpYWwgRnIuIERl
bGF5IGluIDEvMlNTUFNDTEtzOlQ1ICovCisjZGVmaW5lIFNTUFNQX1NGUk1ETFlfU0hJRlQgIDkK
KyNkZWZpbmUgU1NQU1BfRE1ZU1RSVF9NQVNLICAgMHgzCS8qIER1bW15IFN0YXJ0IGluIE51bWJl
ciBvZiBTU1BTQ0xLcy4uKi8KKyNkZWZpbmUgU1NQU1BfRE1ZU1RSVF9TSElGVCAgNwkgICAgLyou
Li5hZnRlciBTVFJURExZLCBUMiAobWFzdGVyIG1vZGUgb25seSkgKi8KKyNkZWZpbmUgU1NQU1Bf
U1RSVERMWV9NQVNLICAgMHg3CS8qIFN0YXJ0IERlbGF5LCBUMSAobWFzdGVyIG1vZGUgb25seSkg
Ki8KKyNkZWZpbmUgU1NQU1BfU1RSVERMWV9TSElGVCAgNAorI2RlZmluZSBTU1BTUF9FVERTX01B
U0sgICAgICAweDEJLyogRW5kIG9mIFRyYW5zZmVyIERhdGEgU3RhdGUgKi8KKyNkZWZpbmUgU1NQ
U1BfRVREU19TSElGVCAgICAgMworI2RlZmluZSBTU1BTUF9TRlJNUF9NQVNLICAgICAweDEJLyog
U2VyaWFsIEZyYW1lIFBvbGFyaXR5ICovCisjZGVmaW5lIFNTUFNQX1NGUk1QX1NISUZUICAgIDIK
KyNkZWZpbmUgU1NQU1BfU0NNT0RFX01BU0sgICAgMHgzCS8qIFNlcmlhbCBiaXQtcmF0ZSBDbG9j
ayBNb2RlICovCisjZGVmaW5lIFNTUFNQX1NDTU9ERV9TSElGVCAgIDAKKworI2RlZmluZSBTU1RT
QV9UVFNBX01BU0sgICAgICAweEZGCisjZGVmaW5lIFNTVFNBX1RUU0FfU0hJRlQgICAgIDAKKwor
I2RlZmluZSBTU1JTQV9SVFNBX01BU0sgICAgICAweEZGCisjZGVmaW5lIFNTUlNBX1JUU0FfU0hJ
RlQgICAgIDAKKworI2RlZmluZSBTU1NSX0JDRV9NQVNLICAgMHgxCS8qIEJpdCBDb3VudCBFcnJv
cjogUmVhZC9Xcml0ZSAxIHRvIENsZWFyICovCisjZGVmaW5lIFNTU1JfQkNFX1NISUZUICAyMwor
I2RlZmluZSBTU1NSX0NTU19NQVNLICAgMHgxCS8qIENsb2NrIFN5bmNocm9uaXphdGlvbiBTdGF0
dXMgKi8KKyNkZWZpbmUgU1NTUl9DU1NfU0hJRlQgIDIyCisjZGVmaW5lIFNTU1JfVFVSX01BU0sg
ICAweDEJLyogVHJhbnNtaXQgRklGTyBVbmRlclJ1bjogUmQvV3IgMSB0byBDbGVhciAqLworI2Rl
ZmluZSBTU1NSX1RVUl9TSElGVCAgMjEKKyNkZWZpbmUgU1NTUl9FT0NfTUFTSyAgIDB4MQkvKiBF
bmQgT2YgQ2hhaW46IFJlYWQvV3JpdGUgMSB0byBDbGVhciAqLworI2RlZmluZSBTU1NSX0VPQ19T
SElGVCAgMjAKKyNkZWZpbmUgU1NTUl9USU5UX01BU0sgIDB4MQkvKiBSZWNlaXZlciBUaW1lLW91
dCBJbnRlcnJ1cHQ6Li4uICovCisjZGVmaW5lIFNTU1JfVElOVF9TSElGVCAxOQkvKiAuLi5SZWFk
L1dyaXRlIDEgdG8gQ2xlYXIgKi8KKyNkZWZpbmUgU1NTUl9QSU5UX01BU0sgIDB4MQkvKiBQZXJp
cGhlcmFsIFRyYWlsaW5nIEJ5dGUgSW50ZXJydXB0Oi4uLiAqLworI2RlZmluZSBTU1NSX1BJTlRf
U0hJRlQgMTgJLyogLi4uUmVhZC9Xcml0ZSAxIHRvIENsZWFyICovCisjZGVmaW5lIFNTU1JfUkZM
X01BU0sgICAweEYJLyogUmVjZWl2ZSBGSUZPIExldmVsICovCisjZGVmaW5lIFNTU1JfUkZMX1NI
SUZUICAxMgorI2RlZmluZSBTU1NSX1RGTF9NQVNLICAgMHhGCS8qIFRyYW5zbWl0IEZJRk8gTGV2
ZWwgKi8KKyNkZWZpbmUgU1NTUl9URkxfU0hJRlQgIDgKKyNkZWZpbmUgU1NTUl9ST1JfTUFTSyAg
IDB4MQkvKiBSZWNlaXZlIEZJRk8gT3ZlcnJ1bjogUmVhZC9Xcml0ZSAxIHRvIENsZWFyKi8KKyNk
ZWZpbmUgU1NTUl9ST1JfU0hJRlQgIDcKKyNkZWZpbmUgU1NTUl9SRlNfTUFTSyAgIDB4MQkvKiBS
ZWNlaXZlIEZJRk8gU2VydmljZSBSZXF1ZXN0ICovCisjZGVmaW5lIFNTU1JfUkZTX1NISUZUICA2
CisjZGVmaW5lIFNTU1JfVEZTX01BU0sgICAweDEJLyogVHJhbnNtaXQgRklGTyBTZXJ2aWNlIFJl
cXVlc3QgKi8KKyNkZWZpbmUgU1NTUl9URlNfU0hJRlQgIDUKKyNkZWZpbmUgU1NTUl9CU1lfTUFT
SyAgIDB4MQkvKiBTU1AgQnVzeSAqLworI2RlZmluZSBTU1NSX0JTWV9TSElGVCAgNAorI2RlZmlu
ZSBTU1NSX1JORV9NQVNLICAgMHgxCS8qIFJlY2VpdmUgRklGTyBub3QgZW1wdHkgKi8KKyNkZWZp
bmUgU1NTUl9STkVfU0hJRlQgIDMKKyNkZWZpbmUgU1NTUl9URk5fTUFTSyAgIDB4MQkvKiBUcmFu
c21pdCBGSUZPIG5vdCBGdWxsICovCisjZGVmaW5lIFNTU1JfVEZOX1NISUZUICAyCisKKworI2Rl
ZmluZSBTU1BfT0ZGIDAKKyNkZWZpbmUgU1NQX09OICAxCisKKy8qIGJpdCBJMlNfUE9SVF9PUEVO
RUQgbG9jayBmb3Igb3Blbi9jbG9zZQorICogYml0IEkyU19QT1JUX1JFQURfQlVTWSBsb2NrIGZv
ciByZWFkIHJlcXVlc3RzIChzZXJpYWxpemVkKQorICogYml0IEkyU19QT1JUX1dSSVRFX0JVU1kg
bG9jayBmb3Igd3JpdGUgcmVxdWVzdHMgKHNlcmlhbGl6ZWQpCisgKiBiaXQgSTJTX1BPUlRfQ0xP
U0lORyBtZWFucyBjbG9zZSBvbiBnb2luZywgd2FpdGluZyBmb3IgcGVuZGluZyBjYWxsYmFja3Mu
CisgKi8KKworZW51bSBpMnNfZmxhZ3MgeworCUkyU19QT1JUX09QRU5FRCwKKwlJMlNfUE9SVF9X
UklURV9CVVNZLAorCUkyU19QT1JUX1JFQURfQlVTWSwKKwlJMlNfUE9SVF9DTE9TSU5HCit9Owor
CisjZGVmaW5lIEZJRk9fU0laRSAxNgorLyoKKyAqCVN0cnVjdHVyZXMgRGVmaW5pdGlvbgorICov
CisKKy8qKgorICogc3RydWN0IGludGVsX21pZF9pMnNfZGF0YSAtIGNvbnRleHQgc3RydWN0IHRv
IGtlZXAgU1NQIEkyUyBkYXRhCisgKiBAcGRldjogcGNpIGRldiBwb2ludGVyIGNvcnJlc3BvbmRp
bmcgdG8gY29udGV4dAorICogQHBhZGRyOgorICogQGlvYWRkcjoKKyAqIEBpb2xlbjoKKyAqIEBp
cnE6CisgKiBAY2xlYXJfc3I6CisgKiBAbWFza19zcjoKKyAqIEBkbWFjMToKKyAqIEBkbWFzX3R4
OiBkbWEgc2xhdmUgc3RydWN0dXJlIGZvciB0cmFuc21pdAorICogQGRtYXNfcng6IGRtYSBzbGF2
ZSBzdHJ1Y3R1cmUgZm9yIHJlY2VpdmUKKyAqIEB0eGNoYW46IERtYSBjaGFubmVsIGZvciB0cmFu
c21pdAorICogQHJ4Y2hhbjogRG1hIGNoYW5uZWwgZm9yIHJlY2VpdmUKKyAqCisgKiBAcmVhZF9k
b25lOgorICogQHJlYWRfZHN0OgorICogQHJlYWRfbGVuOgorICoKKyAqIEB3cml0ZV9kb25lOgor
ICogQHdyaXRlX3NyYzoKKyAqIEB3cml0ZV9sZW46CisgKgorICogQG11dGV4OiAgYSBtdXRleCB0
byBtYWtlIHN1cmUgd2UgaGF2ZSBvbmNlLWF0LXRpbWUgY3JpdGljYWwgZnVuY3Rpb25zLgorICoK
KyAqIExvbmdlciBkZXNjcmlwdGlvbgorICovCisKKy8qIExvY2tpbmcgcnVsZXM6CisgKgorICog
QWxsIHRoZSBmaWVsZHMsIG5vdCBsaXN0ZWQgYmVsb3csIGFyZSBzZXQgZHVyaW5nIHByb2JlLCBh
bmQgdGhlbiByZWFkIG9ubHkKKyAqIFNvIHRoZXkgZG8gbm90IHJlcXVpcmUgbG9ja2luZworICoK
KyAqIFRoZSBmaWVsZHMgdGhhdCByZXF1aXJlIGxvY2tpbmcgYXJlIHJlbGF0ZWQgdG8gdGhlIEky
UyByZWFkIGFuZCB3cml0ZQorICogcmVxdWVzdHMuCisgKgorICogV2UgYWxsb3cgb25seSAxIHJl
YWQgYXQgYSB0aW1lLCBhbmQgMSB3cml0ZSBhdCBhIHRpbWUuCisgKiBXZSBhbGxvdyByZWFkIGlu
IHBhcmFsbGVsIG9mIHdyaXRlIGJ1dCB1c2Ugc2VwYXJhdGUgdmFyaWFibGVzLgorICogV2UgYWxs
b3cgb25seSAxIHVzZXIgcGVyIFNTUC9JMlMgcG9ydC4KKyAqIFR5cGljYWxseSB0aGlzIHVzZXIg
d2lsbCBiZSBhIGRlZGljYXRlZCBQdWxzZUF1ZGlvIFJUIHRocmVhZCBjb21tdW5pY2F0aW5nCisg
KiB3aXRoIGNtdC1zcGVlY2ggZHJpdmVyIHdoaWNoIGluIHR1cm5zIGNvbW11bmljYXRlcyB3aXRo
IGludGVsX21pZF9zc3AKKyAqIGRyaXZlci4KKyAqIFBDTSBtaXhpbmcgaXMgZG9uZSBiZWZvcmUg
YWNjZXNzIHRvIGtlcm5lbCBkcml2ZXJzO3R5cGljYWxseSB3aXRoaW4KKyAqIFB1bHNlQXVkaW8g
b3IgYWZ0ZXI7IHR5cGljYWxseSB3aXRoaW4gdGhlIG1vZGVtLgorICogU28gbm8gY29uY3VycmVu
dCB1c2VycywgcGVyIEkyUyBjaGFubmVsLCB0byB0aGlzIGRyaXZlciBhcmUgYWxsb3dlZAorICog
VGhlIHJlYWQgJiB3cml0ZSBhcmUgdHJpZ2dlcmVkIGZyb20gYSBVU0VSIGNvbnRleHQKKyAqIFRo
ZSByZWFkICYgd3JpdGUgY2FsbGJhY2tzIGFyZSBjYWxsZWQgZnJvbSBhIEJIIGNvbnRleHQKKyAq
IFlvdSBzaG91bGQgaGF2ZSBub3QgY2FsbGJhY2sgcGVuZGluZyBiZWZvcmUgY2FsbGluZyBjbG9z
ZSwgY2xvc2Ugd2lsbCB3YWl0CisgKiBmb3IgcmVtYWluaW5nIGNhbGxiYWNrIGNhbGxzLgorICog
SXQgaXMgbm90IGFsbG93ZWQgdG8gY2FsbCBjbG9zZSBmdW5jdGlvbiBmcm9tIHJlYWQvd3JpdGUg
Y2FsbGJhY2sgdGhyZWFkcy4KKyAqCisgKiBMb2NraW5nIGlzIGhhbmRsZWQgdmlhIGRydl9kYXRh
LT5mbGFncyAmIGF0b21pYyBiaXR3aXNlIG9wZXJhdGlvbnMKKyAqCisgKiBJMlMwIGlzIGRlZGlj
YXRlZCBmb3IgUENNIHRyYW5zZmVyIHRvL2Zyb20gdGhlIG1vZGVtIG1vZHVsZQorICogSTJTMSBp
cyBkZWRpY2F0ZWQgZm9yIFBDTSB0cmFuc2ZlciB0by9mcm9tIHRoZSBCbHVldG9vdGggb3IgRk0g
bW9kdWxlCisgKgorICogcmVhZF9kb25lOgorICogcmVhZF9sZW46CisgKiByZWFkX2RzdDoKKyAq
CisgKiB3cml0ZV9kb25lOgorICogd3JpdGVfc3JjOgorICogd3JpdGVfbGVuOgorICoKKyAqIG11
dGV4OiAgYSBtdXRleCB0byBtYWtlIHN1cmUgd2UgaGF2ZSBvbmNlLWF0LXRpbWUgY3JpdGljYWwg
ZnVuY3Rpb25zLgorICoJCW9uY2UtYXQtYS10aW1lIGFjdGlvbnMgZnVuY3Rpb25zIGFyZToKKyAq
CQkJLWludGVsX21pZF9pMnNfb3BlbgorICoJCQktaW50ZWxfbWlkX2kyc19jbG9zZQorICoJCQkt
aW50ZWxfbWlkX2kyc19yZF9yZXEKKyAqCQkJLWludGVsX21pZF9pMnNfd3JfcmVxCisgKgkJCS1p
bnRlbF9taWRfaTJzX3NldF9yZF9jYgorICoJCQktaW50ZWxfbWlkX2kyc19zZXRfd3JfY2IKKyAq
IFRoZXNlIGZ1bmN0aW9ucyBzaG91bGQgbm90IGJlIGNhbGxlZCBkdXJpbmcgYSBsb2NrKCkgbmVp
dGhlciBpbiBpbnRlcnJ1cHQuCisgKi8KKworc3RydWN0IGludGVsX21pZF9pMnNfaGRsIHsKKwkv
KiBEcml2ZXIgbW9kZWwgaG9va3VwICovCisJc3RydWN0IHBjaV9kZXYgKnBkZXY7CisJLyogcmVn
aXN0ZXIgYWRkcmVzc2VzICovCisJZG1hX2FkZHJfdCBwYWRkcjsKKwl2b2lkIF9faW9tZW0gKmlv
YWRkcjsKKwl1MzIgaW9sZW47CisJaW50IGlycTsKKworCS8qIFNTUCBtYXNrcyAqLworCXUzMiBj
bGVhcl9zcjsKKwl1MzIgbWFza19zcjsKKworCS8qIFNTUCBDb25maWd1cmF0aW9uICovCisJLyog
RE1BIGluZm8gKi8KKwlzdHJ1Y3QgcGNpX2RldiAqZG1hYzE7CisJd2FpdF9xdWV1ZV9oZWFkX3Qg
d3FfY2hhbl9jbG9zaW5nOworCisJc3RydWN0IGludGVsX21pZF9kbWFfc2xhdmUgZG1hc190eDsK
KwlzdHJ1Y3QgaW50ZWxfbWlkX2RtYV9zbGF2ZSBkbWFzX3J4OworCXN0cnVjdCBkbWFfY2hhbiAq
dHhjaGFuOworCXN0cnVjdCBkbWFfY2hhbiAqcnhjaGFuOworCisJdW5zaWduZWQgaW50IGRldmlj
ZV9pbnN0YW5jZTsKKwkvKiBDYWxsIGJhY2sgZnVuY3Rpb25zICovCisJaW50ICgqcmVhZF9jYWxs
YmFjaykodm9pZCAqcGFyYW0pOworCWRtYV9hZGRyX3QgcmVhZF9kc3Q7CisJc2l6ZV90IHJlYWRf
bGVuOyAgICAgLyogcmVhZF9sZW4gPiAwIDw9PiByZWFkX2RtYV9ydW5uaW5nICovCisJdm9pZCAq
cmVhZF9wYXJhbTsJIC8qIGNvbnRleHQgcGFyYW0gZm9yIGNhbGxiYWNrICovCisJaW50ICgqd3Jp
dGVfY2FsbGJhY2spKHZvaWQgKnBhcmFtKTsKKwlkbWFfYWRkcl90IHdyaXRlX3NyYzsKKwlzaXpl
X3Qgd3JpdGVfbGVuOwkvKiB3cml0ZV9sZW4gPiAwIDw9PiByZWFkX2RtYV9ydW5uaW5nICovCisJ
dm9pZCAqd3JpdGVfcGFyYW07CS8qIGNvbnRleHQgcGFyYW0gZm9yIGNhbGxiYWNrICovCisKKwl1
bnNpZ25lZCBsb25nIGZsYWdzOworCXN0cnVjdCBtdXRleCBtdXRleDsKKwllbnVtIGludGVsX21p
ZF9pMnNfc3NwX3VzYWdlIHVzYWdlOworCisJc3RydWN0IGludGVsX21pZF9pMnNfc2V0dGluZ3Mg
Y3VycmVudF9zZXR0aW5nczsKKworfTsKKworc3RhdGljIHZvaWQgaTJzX3JlYWRfZG9uZSh2b2lk
ICphcmcpOworc3RhdGljIHZvaWQgaTJzX3dyaXRlX2RvbmUodm9pZCAqYXJnKTsKK3N0YXRpYyBi
b29sIGNoYW5fZmlsdGVyKHN0cnVjdCBkbWFfY2hhbiAqY2hhbiwgdm9pZCAqcGFyYW0pOworc3Rh
dGljIHZvaWQgaTJzX2RtYV9zdG9wKHN0cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqZHJ2X2RhdGEp
Oworc3RhdGljIGludCBpMnNfZG1hX3N0YXJ0KHN0cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqZHJ2
X2RhdGEpOworc3RhdGljIHZvaWQgc3NwMV9kdW1wX3JlZ2lzdGVycyhzdHJ1Y3QgaW50ZWxfbWlk
X2kyc19oZGwgKik7CitzdGF0aWMgaXJxcmV0dXJuX3QgaTJzX2ludChpbnQgaXJxLCB2b2lkICpk
ZXZfaWQpOworc3RhdGljIHZvaWQgc2V0X3NzcF9pMnNfaHcoc3RydWN0IGludGVsX21pZF9pMnNf
aGRsICpkcnZfZGF0YSwKKwkJY29uc3Qgc3RydWN0IGludGVsX21pZF9pMnNfc2V0dGluZ3MgKnBz
X3NldHRpbmdzKTsKK3N0YXRpYyBpbnQgY2hlY2tfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldmlj
ZV9wdHIsIHZvaWQgKmRhdGEpOworc3RhdGljIGludCBpbnRlbF9taWRfaTJzX3J1bnRpbWVfcmVz
dW1lKHN0cnVjdCBkZXZpY2UgKmRldmljZV9wdHIpOworc3RhdGljIGludCBpbnRlbF9taWRfaTJz
X3J1bnRpbWVfc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXZpY2VfcHRyKTsKK3N0YXRpYyBpbnQg
aW50ZWxfbWlkX2kyc19wcm9iZShzdHJ1Y3QgcGNpX2RldiAqcGRldiwKKwkJY29uc3Qgc3RydWN0
IHBjaV9kZXZpY2VfaWQgKmVudCk7CitzdGF0aWMgdm9pZCBpbnRlbF9taWRfaTJzX3JlbW92ZShz
dHJ1Y3QgcGNpX2RldiAqcGRldik7CitzdGF0aWMgdm9pZCBpMnNfc3NwX3N0b3Aoc3RydWN0IGlu
dGVsX21pZF9pMnNfaGRsICpkcnZfZGF0YSk7CisvKnN0YXRpYyBpbnQgYnRfcGNtX2RtYV9pbml0
KHN0cnVjdCBpbnRlbF9taWRfaTJzX2hkbCAqZHJ2X2RhdGEpOyovCisKKworI2lmZGVmIENPTkZJ
R19QTQorc3RhdGljIGludCAgaW50ZWxfbWlkX2kyc19kcml2ZXJfc3VzcGVuZChzdHJ1Y3QgcGNp
X2RldiAqZGV2LAorCQkJCQkgIHBtX21lc3NhZ2VfdCBzdGF0ZSk7CitzdGF0aWMgaW50IGludGVs
X21pZF9pMnNfZHJpdmVyX3Jlc3VtZShzdHJ1Y3QgcGNpX2RldiAqZGV2KTsKKyNlbmRpZgorCisv
KgorICogVGhlc2UgZGVmaW5lIHdpbGwgY2xhcmlmeSBzb3VyY2UgY29kZSB3aGVuIGFjY2Vzc2lu
ZyBTU0NSeCByZWdpc3RlcnMKKyAqLworCisjZGVmaW5lIFNTQ1IwX3JlZyhyZWdiaXQsIHZhbHVl
KQkJCQkJXAorCSgoKHZhbHVlKSAmIFNTQ1IwXyMjcmVnYml0IyNfTUFTSykgPDwgU1NDUjBfIyNy
ZWdiaXQjI19TSElGVCkKKworI2RlZmluZSBTU0NSMV9yZWcocmVnYml0LCB2YWx1ZSkJCQkJCVwK
KwkoKCh2YWx1ZSkgJiBTU0NSMV8jI3JlZ2JpdCMjX01BU0spIDw8IFNTQ1IxXyMjcmVnYml0IyNf
U0hJRlQpCisKKyNkZWZpbmUgU1NQU1BfcmVnKHJlZ2JpdCwgdmFsdWUpCQkJCQlcCisJKCgodmFs
dWUpICYgU1NQU1BfIyNyZWdiaXQjI19NQVNLKSA8PCBTU1BTUF8jI3JlZ2JpdCMjX1NISUZUKQor
CisjZGVmaW5lIFNTUlNBX3JlZyhyZWdiaXQsIHZhbHVlKQkJCQkJXAorCSgoKHZhbHVlKSAmIFNT
UlNBXyMjcmVnYml0IyNfTUFTSykgPDwgU1NSU0FfIyNyZWdiaXQjI19TSElGVCkKKyNkZWZpbmUg
U1NUU0FfcmVnKHJlZ2JpdCwgdmFsdWUpCQkJCQlcCisJKCgodmFsdWUpICYgU1NUU0FfIyNyZWdi
aXQjI19NQVNLKSA8PCBTU1RTQV8jI3JlZ2JpdCMjX1NISUZUKQorCisKKyNkZWZpbmUgY2hhbmdl
X1NTQ1IwX3JlZyhyZWdfcG9pbnRlciwgcmVnYml0LCB2YWx1ZSkJCQkgIFwKKwl3cml0ZV9TU0NS
MCgocmVhZF9TU0NSMChyZWdfcG9pbnRlcikJCQkJICBcCisJJiAofigoU1NDUjBfIyNyZWdiaXQj
I19NQVNLIDw8IFNTQ1IwXyMjcmVnYml0IyNfU0hJRlQpKSkpCSAgXAorCXwgKCgodmFsdWUpICYg
U1NDUjBfIyNyZWdiaXQjI19NQVNLKSA8PCBTU0NSMF8jI3JlZ2JpdCMjX1NISUZUKSwgIFwKKwly
ZWdfcG9pbnRlcik7CisKKyNkZWZpbmUgc2V0X1NTQ1IwX3JlZyhyZWdfcG9pbnRlciwgcmVnYml0
KQkJCQkgIFwKKwl3cml0ZV9TU0NSMChyZWFkX1NTQ1IwKHJlZ19wb2ludGVyKQkJCQkgIFwKKwl8
IChTU0NSMF8jI3JlZ2JpdCMjX01BU0sgPDwgU1NDUjBfIyNyZWdiaXQjI19TSElGVCksCQlcCisJ
cmVnX3BvaW50ZXIpOworCisjZGVmaW5lIGNsZWFyX1NTQ1IwX3JlZyhyZWdfcG9pbnRlciwgcmVn
Yml0KQkJCQkgIFwKKwl3cml0ZV9TU0NSMCgocmVhZF9TU0NSMChyZWdfcG9pbnRlcikJCQkJICBc
CisJJiAofigoU1NDUjBfIyNyZWdiaXQjI19NQVNLIDw8IFNTQ1IwXyMjcmVnYml0IyNfU0hJRlQp
KSkpLAkgIFwKKwlyZWdfcG9pbnRlcik7CisKKyNkZWZpbmUgY2hhbmdlX1NTQ1IxX3JlZyhyZWdf
cG9pbnRlciwgcmVnYml0LCB2YWx1ZSkJCQkgIFwKKwl3cml0ZV9TU0NSMSgocmVhZF9TU0NSMShy
ZWdfcG9pbnRlcikJCQkJICBcCisJJiAofigoU1NDUjFfIyNyZWdiaXQjI19NQVNLIDw8IFNTQ1Ix
XyMjcmVnYml0IyNfU0hJRlQpKSkpCSAgXAorCXwgKCgodmFsdWUpICYgU1NDUjFfIyNyZWdiaXQj
I19NQVNLKSA8PCBTU0NSMV8jI3JlZ2JpdCMjX1NISUZUKSwgIFwKKwlyZWdfcG9pbnRlcik7CisK
KyNkZWZpbmUgc2V0X1NTQ1IxX3JlZyhyZWdfcG9pbnRlciwgcmVnYml0KQkJCQkgIFwKKwl3cml0
ZV9TU0NSMShyZWFkX1NTQ1IxKHJlZ19wb2ludGVyKQkJCQkgIFwKKwl8IChTU0NSMV8jI3JlZ2Jp
dCMjX01BU0sgPDwgU1NDUjFfIyNyZWdiaXQjI19TSElGVCksCQkgIFwKKwlyZWdfcG9pbnRlcik7
CisKKyNkZWZpbmUgY2xlYXJfU1NDUjFfcmVnKHJlZ19wb2ludGVyLCByZWdiaXQpCQkJCSAgXAor
CXdyaXRlX1NTQ1IxKChyZWFkX1NTQ1IxKHJlZ19wb2ludGVyKQkJCQkgIFwKKwkmICh+KChTU0NS
MV8jI3JlZ2JpdCMjX01BU0sgPDwgU1NDUjFfIyNyZWdiaXQjI19TSElGVCkpKSksCSAgXAorCXJl
Z19wb2ludGVyKTsKKworLyogUlggRklGTyBsZXZlbCAqLworI2RlZmluZSBHRVRfU1NTUl92YWwo
eCwgcmVnYikJCQkJCQkgIFwKKwkoKHggJiAoU1NTUl8jI3JlZ2IjI19NQVNLPDxTU1NSXyMjcmVn
YiMjX1NISUZUKSk+PlNTU1JfIyNyZWdiIyNfU0hJRlQpCisKKworLyoKKyAqIFNTUCBoYXJkd2Fy
ZSBjYW4gYmUgY29uZmlndXJlZCBhcyBJMlMsIFBDTSwgU1BJLi4uCisgKiBJbiBvcmRlciB0byBh
bGxvdyBmbGV4aWJpbGl0eSB3aXRob3V0IG1vZGlmeWluZyB0aGUgc29mdHdhcmUgZHJpdmVyLCB0
aGUKKyAqIFBDSSBoZWFkZXIgdXNlcyB0aGUgY29uZmlndXJhdGlvbiByZWdpc3RlciAnYWRpZCc6
CisgKgorICogVGhlIFBDSSBoZWFkZXIgYXNzb2NpYXRlZCB0byBTU1AgZGV2aWNlcyBpbmNsdWRl
cyBhIGNvbmZpZ3VyYXRpb24gcmVnaXN0ZXIuCisgKiBJdCBwcm92aWRlcyBpbmZvcm1hdGlvbiB0
byBhIGRyaXZlciB3aGljaCBpcyBwcm9iZWQgZm9yIHRoZSBTU1AsIHNwZWNpZnlpbmcKKyAqIGlu
IHdoaWNoIHdheSB0aGUgU1NQIGlzIHN1cHBvc2VkIHRvIGJlIHVzZWQuCisgKiBIZXJlIGlzIHRo
ZSBmb3JtYXQgb2YgdGhpcyBjb25maWd1cmF0aW9uIHJlZ2lzdGVyICg4IGJpdHMpOgorICoKKyAq
ICAgYml0cyAyLi4wOiBNb2RlCisgKiAgICAgICAwMDA6IEludmFsaWQsIHRoZSByZWdpc3RlciBz
aG91bGQgYmUgaWdub3JlZAorICogICAgICAgMDAxOiBTU1AgdG8gYmUgdXNlZCBhcyBTUEkgY29u
dHJvbGxlcgorICogICAgICAgMDEwOiBTU1AgdG8gYmUgdXNlZCBpbiBJMlMvSVNTIG1vZGUKKyAq
ICAgICAgIG90aGVyOiBSZXNlcnZlZAorICoKKyAqICAgYml0cyA1Li4zOiBDb25maWd1cmF0aW9u
CisgKiAgICAgICBJbiBJMlMvSVNTIG1vZGU6CisgKiAgICAgICAgICAgICAgIDAwMDogSW52YWxp
ZAorICogICAgICAgICAgICAgICAwMDE6IEJsdWV0b290aAorICogICAgICAgICAgICAgICAwMTA6
IE1vZGVtCisgKiAgICAgICAgICAgICAgIG90aGVyOiBSZXNlcnZlZAorICogICAgICAgSW4gU1BJ
IG1vZGU6CisgKiAgICAgICAgICAgICAgIFZhbHVlIGlzIHRoZSBTUEkgYnVzIG51bWJlciBjb25u
ZWN0ZWQgdG8gdGhlIFNTUC4KKyAqICAgICAgICAgICAgICAgVG8gYmUgdXNlZCBmb3IgcmVnaXN0
cmF0aW9uIHRvIHRoZSBMaW51eCBTUEkKKyAqICAgICAgICAgICAgICAgZnJhbWV3b3JrLgorICoK
KyAqICAgYml0IDY6IFNQSSBzbGF2ZQorICogICAgICAgUmVsZXZhbnQgaW4gU1BJIG1vZGUgb25s
eS4gSWYgc2V0LCBpbmRpY2F0ZXMgdGhlIFNQSSBjbG9jaworICogICAgICAgaXMgbm90IHByb3Zp
ZGVkIGJ5IHRoZSBTU1A6IFNQSSBzbGF2ZSBtb2RlLgorICoKKyAqICAgYml0IDc6IFJlc2VydmVk
ICgwKQorICoKKyAqICAgVGhpcyBjb25maWd1cmF0aW9uIHJlZ2lzdGVyIGlzIGltcGxlbWVudGVk
IGluIHRoZSBhZGlkIGZpZWxkIG9mIHRoZQorICogICBWZW5kb3IgU3BlY2lmaWMgUENJIGNhcGFi
aWxpdHkgYXNzb2NpYXRlZCB0byB0aGUgU1NQLiBUaGUgZm9ybWF0IG9mCisgKiAgIHRoaXMgY2Fw
YWJpbGl0eSBpczoKKyAqCisgKiAgIHVpbnQ4X3QgICAgIGNhcElkOyAgICAgICAgICAgICAgPCBD
YXBhYmlsaXR5IElEICh2ZW5kb3Itc3BlY2lmaWMpCisgKiAgIHVpbnQ4X3QgICAgIG5leHRDYXA7
ICAgICAgICAgICAgPCBOZXh0IEl0ZW0gUHRyCisgKiAgIHVpbnQ4X3QgICAgIGxlbmd0aDsgICAg
ICAgICAgICAgPCBTaXplIG9mIHRoaXMgY2FwYWJpbGl0eSAoNykKKyAqICAgdWludDhfdCAgICAg
dmVyc2lvbjsgICAgICAgICAgICA8IFZlcnNpb24gb2YgdGhpcyBjYXBhYmlsaXR5ICgxKQorICog
ICB1aW50OF90ICAgICBsc3M7ICAgICAgICAgICAgICAgIDwgTG9naWNhbCBzdWJzeXN0ZW0gaW5m
bworICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJpdCA3ID0gUE1V
ICgwID0gTkMsIDEgPSBTQykKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCaXRzIDY6MCA9IExTUyBJRAorICogICB1aW50OF90ICAgICBhcG1jOyAgICAgICAgICAg
ICAgIDwgQWRkaXRpb25hbCBQTSBjYXBhYmlsaXRpZXMKKyAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBCaXQgNyA9IFJzdmQKKyAqICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBCaXQgNiA9IFdha2UgY2FwYWJsZQorICogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJpdCA1ID0gRDMgc3VwcG9ydAorICogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJpdCA0ID0gRDIgc3VwcG9ydAorICog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJpdCAzID0gRDEgc3VwcG9y
dAorICogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJpdCAyID0gRDBp
MyBzdXBwb3J0CisgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQml0
IDEgPSBEMGkyIHN1cHBvcnQKKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBCaXQgMCA9IEQwaTEgc3VwcG9ydAorICogICB1aW50OF90ICAgICBhZGlkOyAgICAgICAg
ICAgICAgIDwgQWRkaXRpb25hbCBkZXZpY2UgSUQgKGRldi1zcGVjaWZpYykKKyAqICAgdWludDhf
dCAgICAgcnN2ZDsgICAgICAgICAgICAgICA8IFJlc2VydmVkIGZvciBmdXR1cmUgdXNlCisgKgor
ICogICBUaGUgY2FwYWJpbGl0eSBkYXRhIGFyZSBpbiB0aGUgUENJIGNvbmZpZ3VyYXRpb24gc3Bh
Y2UgYW5kIHRoZQorICogICBhZGlkIGZpZWxkIGNhbiBiZSBtb2RpZmllZCB1c2luZyBCTVAgdG9v
bC4KKyAqLworLyogQURESUQgPSBBZGRpdGlvbmFsIERldmljZSBJRCAqLworI2RlZmluZSBQQ0lf
Q0FQX09GRlNFVF9BRElEIDYKKworCi0tIAoxLjYuNi4xCgo=

--_002_2A84145621092446B6659B8A0F28E26F46FE77084Airsmsx501gerc_
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--_002_2A84145621092446B6659B8A0F28E26F46FE77084Airsmsx501gerc_--
