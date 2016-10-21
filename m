From: Hardik Shah <hardik.t.shah@intel.com>
Subject: [RFC 05/14] SoundWire: Add SoundWire bus driver interfaces
Date: Fri, 21 Oct 2016 18:11:03 +0530
Message-ID: <1477053673-16021-6-git-send-email-hardik.t.shah@intel.com>
References: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1477053673-16021-1-git-send-email-hardik.t.shah@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: tiwai@suse.de, pierre-louis.bossart@linux.intel.com, broonie@kernel.org, lgirdwood@gmail.com, plai@codeaurora.org, patches.audio@intel.com, Hardik Shah <hardik.t.shah@intel.com>, Sanyog Kale <sanyog.r.kale@intel.com>
List-Id: alsa-devel@alsa-project.org

This patch adds the SoundWire bus driver interfaces for following.

1. APIs to register/unregister SoundWire Master device and driver.
2. APIs to register/unregister SoundWire Slave driver.
3. API to Read/Write Slave registers.
4. API for Master driver to update Slave status to bus driver.
5. APIs for Master driver to prepare and initiate clock stop.
6. APIs for SoundWire stream configuration.
7. APIs to prepare, enable, deprepare and disable SoundWire stream.

Signed-off-by: Hardik Shah <hardik.t.shah@intel.com>
Signed-off-by: Sanyog Kale <sanyog.r.kale@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 MAINTAINERS                |   12 +
 include/sound/sdw_bus.h    |  898 ++++++++++++++++++++++++++++++++++++++++++++
 include/sound/sdw_master.h |  627 +++++++++++++++++++++++++++++++
 include/sound/sdw_slave.h  |  563 +++++++++++++++++++++++++++
 4 files changed, 2100 insertions(+)
 create mode 100644 include/sound/sdw_bus.h
 create mode 100644 include/sound/sdw_master.h
 create mode 100644 include/sound/sdw_slave.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1cd38a7..73e85a8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11334,6 +11334,18 @@ F:	include/sound/dmaengine_pcm.h
 F:	sound/core/pcm_dmaengine.c
 F:	sound/soc/soc-generic-dmaengine-pcm.c
 
+SOUND - SOUNDWIRE
+M:	Hardik Shah <hardik.t.shah@intel.com>
+M:	Sanyog Kale <sanyog.r.kale@intel.com>
+R:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Supported
+F:	Documentation/sound/sdw/
+F:	include/sound/sdw_*
+F:	include/sound/sdw/
+F:	sound/sdw/
+F:	drivers/base/regmap-sdw.c
+
 SP2 MEDIA DRIVER
 M:	Olli Salonen <olli.salonen@iki.fi>
 L:	linux-media@vger.kernel.org
diff --git a/include/sound/sdw_bus.h b/include/sound/sdw_bus.h
new file mode 100644
index 0000000..3ea0c71
--- /dev/null
+++ b/include/sound/sdw_bus.h
@@ -0,0 +1,898 @@
+/*
+ * sdw_bus.h - Definition for SoundWire bus interface. This file has all
+ *	the SoundWire bus interfaces common to both Master and Slave
+ *	interfaces.
+ *
+ * Author: Hardik Shah <hardik.t.shah@intel.com>
+ *
+ *
+ * This header file refers to the MIPI SoundWire 1.1 Spec.
+ * [1.1] https://members.mipi.org/wg/All-Members/document (accessible to
+ * MIPI members).
+ *
+ * The comments in the file try to follow the same conventions with a
+ * capital letter for all standard definitions such as Master, Slave,
+ * Data Port, etc. When possible, the constant numeric values are kept
+ * the same as in the MIPI specifications. All of the constants reflect
+ * the MIPI SoundWire definitions and are not vendor specific. Some of
+ * the constants are for bus driver usage and not MIPI defined. These
+ * are specified at appropriate place in this file.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright(c) 2016 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ *
+ * BSD LICENSE
+ *
+ * Copyright(c) 2016 Intel Corporation.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#ifndef _LINUX_SDW_BUS_H
+#define _LINUX_SDW_BUS_H
+
+#include <linux/device.h>
+#include <linux/mod_devicetable.h>
+
+
+/* Broadcast address for Slaves. */
+#define SDW_SLAVE_BDCAST_ADDR		15 /* As per MIPI 1.1 Spec */
+
+/* Total number of valid rows possible for SoundWire frame. */
+#define MAX_NUM_ROWS			23 /* As per MIPI 1.1 Spec */
+
+/* Total number of valid columns possible for SoundWire frame. */
+#define MAX_NUM_COLS			8 /* As per MIPI 1.1 Spec */
+
+/* Number of control bits in SoundWire frame. */
+#define SDW_BUS_CONTROL_BITS		48 /* As per MIPI 1.1 Spec */
+
+/**
+ * Number of dev_id registers. This represents the device ID of slaves
+ *	which includes manufacturer ID, part ID and unique device ID.
+ */
+#define SDW_NUM_DEV_ID_REGISTERS		6 /* As per MIPI 1.1 Spec */
+
+#define SDW_MAX_DEVICES				11 /* Max. Slave devices on bus */
+
+#define SDW_SLAVE_ENUM_ADDR			0 /* Enumeration addr. for Slaves */
+
+#define SDW_PORT_SINK				0x0 /* Sink Port */
+
+#define SDW_PORT_SOURCE				0x1 /* Source Port */
+
+#define SDW_MAX_PORT_DIRECTIONS			0x2 /* Source or Sink */
+
+#define SDW_MSG_FLAG_READ			0x0 /* Read Flag for MSG and BRA transfer  */
+
+#define SDW_MSG_FLAG_WRITE			0x1 /* Write Flag MSG and BRA transfer */
+
+/* Total number of Row and Column combination possible for SoundWire frame. */
+#define MAX_NUM_ROW_COLS		(MAX_NUM_ROWS * MAX_NUM_COLS)
+
+/**
+ * The following set of constants for flow control, Port type and transport
+ * packing are bit masks since devices can expose combinations of
+ * capabilities.
+ */
+
+/* Port flow mask for ISOCHRONOUS mode. */
+#define SDW_PORT_FLOW_MODE_ISOCH		0x1
+
+
+/* Port flow mask for TX_CONTROLLED mode. */
+#define SDW_PORT_FLOW_MODE_TX_CNTRL		0x2
+
+/* Port flow mask for RX_CONTROLLED mode. */
+#define SDW_PORT_FLOW_MODE_RX_CNTRL		0x4
+
+/* Port flow mask for ASYNCHRONOUS mode. */
+#define SDW_PORT_FLOW_MODE_ASYNC		0x8
+
+/* Sample packaging mask for Block per Port mode. */
+#define SDW_PORT_BLK_PER_PORT			0x1
+
+/* Sample packaging mask for Block per Channel mode. */
+#define SDW_PORT_BLK_PER_CH			0x2
+
+
+/* Port encoding mask definitions are part of SoundWire DisCo Spec */
+
+/* Mask to specify data encoding supported by Port, type 2's complement. */
+#define SDW_PORT_ENC_TWOS_CMPLMNT	0x1
+
+/* Mask to specify data encoding supported by Port, type sign magnitude. */
+#define SDW_PORT_ENC_SIGN_MAGNITUDE	0x2
+
+/* Mask to specify data encoding supported by Port, type IEEE 32 float. */
+#define SDW_PORT_ENC_IEEE_32_FLOAT	0x4
+
+/* sdw_driver_type: Driver type on SoundWire bus. */
+enum sdw_driver_type {
+	SDW_DRIVER_TYPE_MASTER = 0,
+	SDW_DRIVER_TYPE_SLAVE = 1,
+};
+
+/**
+ * sdw_command_response: Response to the command. Command responses are
+ *	part of SoundWire Spec. The values in the enum is different than
+ *	actual Spec, since the response in the Spec is defined based on
+ *	the combination of ACK/NAK bits.
+ */
+enum sdw_command_response {
+	SDW_CMD_OK = 0,
+	SDW_CMD_IGNORED = 1,
+	SDW_CMD_FAILED = 2,
+};
+
+/**
+ * sdw_dpn_type: Data Port type
+ *
+ * @SDW_DP_TYPE_FULL: Full Data Port supported.
+ * @SDW_DP_TYPE_SIMPLE: Simplified Data Port defined in SoundWire 1.1
+ *	Spec. DPN_SampleCtrl2, DPN_OffsetCtrl2, DPN_HCtrl and
+ *	DPN_BlockCtrl3 are not implemented for Simplified Data Port.
+ * @SDW_DP_TYPE_REDUCED: Reduced SoundWire Data Port, defined in SoundWire
+ *	1.1 Spec. DPN_SampleCtrl2, DPN_HCtrl are not implemented for
+ *	Reduced Data Port.
+ */
+enum sdw_dpn_type {
+	SDW_DP_TYPE_FULL = 0,
+	SDW_DP_TYPE_SIMPLE = 1,
+	SDW_DP_TYPE_REDUCED = 2,
+};
+
+/* sdw_dpn_grouping: Maximum block group count supported. */
+enum sdw_dpn_grouping {
+	SDW_BLK_GRP_CNT_1 = 0,
+	SDW_BLK_GRP_CNT_2 = 1,
+	SDW_BLK_GRP_CNT_3 = 2,
+	SDW_BLK_GRP_CNT_4 = 3,
+};
+
+/**
+ * sdw_prep_ch_behavior: Specifies the dependencies between channel prepare
+ *	sequence and bus clock configuration. This property is not required
+ *	for ports implementing a simplified ChannelPrepare State Machine
+ *	(SCPSM) This is not part of SoundWire Spec, but defined in SoundWire
+ *	DisCo properties.
+ *
+ * @SDW_CHAN_PREP_RATE_ANY: Channel prepare can happen at any bus clock
+ *	rate.
+ * @SDW_CHAN_PREP_RATE_COMPAT: Channel prepare sequence needs to happen
+ *	after bus clock is changed to a frequency supported by this mode.
+ *
+ *	TODO: This flag is not used, prepare is done after bus clock is
+ *	changed. Bus driver will be extended later to use this.
+ */
+enum sdw_prep_ch_behavior {
+	SDW_CHAN_PREP_RATE_ANY = 0,
+	SDW_CHAN_PREP_RATE_COMPAT = 1,
+};
+
+/**
+ * sdw_slave_status: Slave status reported by PING commands.
+ *
+ * @SDW_SLAVE_STAT_NOT_PRESENT: Slave is not present.
+ * @SDW_SLAVE_STAT_ATTACHED_OK: Slave is attached to the bus.
+ * @SDW_SLAVE_STAT_ALERT: Some alert condition on the Slave. An alert status
+ *	will be reported by Slave, if the relevant Slave interrupt mask
+ *	register is programmed. By default, on reset interrupt masks are not
+ *	enabled.
+ * @SDW_SLAVE_STAT_RESERVED: Reserved.
+ */
+enum sdw_slave_status {
+	SDW_SLAVE_STAT_NOT_PRESENT = 0,
+	SDW_SLAVE_STAT_ATTACHED_OK = 1,
+	SDW_SLAVE_STAT_ALERT = 2,
+	SDW_SLAVE_STAT_RESERVED = 3,
+};
+
+/**
+ * sdw_stream_type: Stream type used by bus driver for the bandwidth
+ *	allocation. This is not SoundWire Spec definition but required by
+ *	implementations that need to route PDM data through decimator
+ *	hardware.
+ */
+enum sdw_stream_type {
+	SDW_STREAM_PCM = 0,
+	SDW_STREAM_PDM = 1,
+};
+
+/**
+ * sdw_ch_prepare_mode: Channel prepare state machine.
+ *
+ * @SDW_CP_MODE_SIMPLE: Simplified channel prepare state machine
+ * @SDW_CP_MODE_NORMAL: Normal channel prepare state machine.
+ */
+enum sdw_ch_prepare_mode {
+	SDW_CP_MODE_SIMPLE = 0,
+	SDW_CP_MODE_NORMAL = 1,
+};
+
+/**
+ * sdw_clk_stop_mode: Clock Stop mode.
+ *
+ * @SDW_CLOCK_STOP_MODE_0: Clock Stop mode 0. ClockStopMode0 is used when
+ *	the Slave is capable of continuing operation seamlessly when the
+ *	Clock is restarted, as though time had stood still while the Clock
+ *	was stopped.
+ *
+ * @SDW_CLOCK_STOP_MODE_1: Clock Stop mode 1. ClockStopMode1 is used when
+ *	the Slave might have entered a deeper power-saving mode that does
+ *	not retain state while the Clock is stopped, so is not capable of
+ *	continuing operation seamlessly when the Clock restarts.
+ */
+enum sdw_clk_stop_mode {
+	SDW_CLOCK_STOP_MODE_0 = 0,
+	SDW_CLOCK_STOP_MODE_1 = 1,
+};
+
+/**
+ * sdw_data_direction: Data direction w.r.t Port. e.g for playback between
+ *	the Master and Slave, where Slave is codec, data direction for the
+ *	Master Port will be OUT, since its transmitting the data, while for
+ *	the Slave (codec) it will be IN, since its receiving the data. This
+ *	is not SoundWire Spec definition, it is used by bus driver for
+ *	stream configuration. For all the sink Ports data direction is
+ *	always IN, while for all the source Ports data direction is always
+ *	OUT.
+ *
+ * @SDW_DATA_DIR_IN: Data is input to Port.
+ * @SDW_DATA_DIR_OUT: Data is output from Port.
+ */
+enum sdw_data_direction {
+	SDW_DATA_DIR_IN = 0,
+	SDW_DATA_DIR_OUT = 1,
+};
+
+/**
+ * sdw_port_data_mode: Data Port mode. It can be normal mode where audio
+ *	data is received and transmitted, or any of the 3 different test
+ *	modes defined by the SoundWire Spec 1.1. Test modes are normally
+ *	used for testing at component and system level.
+ *
+ * @SDW_PORT_DATA_MODE_NORMAL: Normal data mode where audio data is received
+ *	and transmitted.
+ *
+ * @SDW_PORT_DATA_MODE_STATIC_1: This simple test mode uses static value of
+ *	logic 1. The encoding will result in signal transitions at every
+ *	bitslot owned by this Port.
+ *
+ * @SDW_PORT_DATA_MODE_STATIC_0: This simple test mode uses static value of
+ *	logic 0. The encoding will result in no signal transitions (the
+ *	voltage level prior to the bitSlots owned by the Port will be
+ *	maintained by the bus holder). Here enum says as _0 but enum value
+ *	is 2. This is confusing while debugging, but kept to match the Spec
+ *	values.
+ *
+ * @SDW_PORT_DATA_MODE_PRBS: This test mode uses a PRBS generator to produce
+ *	a pseudo random data pattern that is transported from source Data
+ *	Port to sink Data Port where similar pattern generators check the
+ *	received pattern.
+ */
+enum sdw_port_data_mode {
+	SDW_PORT_DATA_MODE_NORMAL = 0,
+	SDW_PORT_DATA_MODE_STATIC_1 = 1,
+	SDW_PORT_DATA_MODE_STATIC_0 = 2,
+	SDW_PORT_DATA_MODE_PRBS = 3,
+};
+
+/**
+ * sdw_port_prep_ops: Prepare operations for Master Data Ports
+ *
+ * @SDW_OPS_PORT_PRE_PREP: Pre prepare operation for the Ports.
+ * @SDW_OPS_PORT_PREP: Prepare operation for the Ports.
+ * @SDW_OPS_PORT_POST_PREP: Post prepare operation for the Ports.
+ */
+enum sdw_port_prep_ops {
+	SDW_OPS_PORT_PRE_PREP = 0,
+	SDW_OPS_PORT_PREP = 1,
+	SDW_OPS_PORT_POST_PREP = 2,
+};
+
+struct sdw_master;
+struct sdw_slave;
+
+/**
+ * sdw_port_aud_mode_prop: Audio properties for the Port mode. The
+ *	SoundWire specification only requires command and control to be
+ *	supported for all bus frequencies. Audio transport may be restricted
+ *	to specific modes (bus frequencies, sample rate, etc). The following
+ *	capabilities are defined in the SoundWire DisCo Spec and provide
+ *	additional information needed to configure the bus. All frequencies
+ *	and sampling rates are in Hz.
+ *
+ * @max_bus_freq: Maximum frequency Port can support for the clock. The use
+ *	of max_ and min_ frequency requires num_bus_freq_cfgs to
+ *	be zero
+ *
+ * @min_bus_freq: Minimum frequency Port can support for the clock.
+ * @num_bus_freq_cfgs: Array size for the frequencies supported by Port.
+ * @clk_freq_buf: Buffer of frequencies supported by the Port.
+ * @max_sample_rate: Maximum sampling rate supported by this Port. Use of
+ *	max_ and min_ requires num_sample_rate_cfgs to be zero.
+ *
+ * @min_sample_rate: Minimum sampling rate supported by Port.
+ * @num_sample_rate_cfgs: Array size for the number of sampling freq.
+ *	supported by Port.
+ *
+ * @sample_rate_buf: Array for the sampling freq configs supported.
+ * @ch_prepare_behavior: Specifies the dependencies between Channel Prepare
+ *	Prepare sequence and Bus clock configuration.
+ *	0: Channel prepare can happen at any bus clock rate
+ *	1: Channel prepare sequence shall happen only after Bus clock is
+ *	changed to a frequency supported by this mode or compatible modes
+ *	described by the next field. This may be required, e.g. when the
+ *	Slave internal audio clocks are derived from the bus clock. This
+ *	property applies to all channels within this port. This property may
+ *	be omitted for ports implementing a Simplified ChannelPrepare State
+ *	Machine (SCPSM). Currently bus driver ignores this fields and always
+ *	prepares the port after Bus clock is changed. This will be enhanced
+ *	in future to optimize the prepare time.
+ *
+ * @glitchless_transitions_mask: Glitchless transition mask from one mode to
+ *	other mode. Each bit refers to a mode number that can be reached
+ *	from current mode without audible issues.
+ */
+struct sdw_port_aud_mode_prop {
+	unsigned int max_bus_freq;
+	unsigned int min_bus_freq;
+	unsigned int num_bus_freq_cfgs;
+	unsigned int *clk_freq_buf;
+	unsigned int max_sample_rate;
+	unsigned int min_sample_rate;
+	unsigned int num_sample_rate_cfgs;
+	unsigned int *sample_rate_buf;
+	enum sdw_prep_ch_behavior ch_prepare_behavior;
+	unsigned int glitchless_transitions_mask;
+
+};
+
+/**
+ * sdw_slave_addr: Structure representing the read-only unique device ID
+ *	and the SoundWire logical device number (assigned by bus driver).
+ *
+ * @slave: Slave device reference for easy access, to which this address is
+ *	assigned.
+ *
+ * @dev_id: 6-byte device ID of the Slave
+ * @dev_num: Slave address, "Device Number" field of the SCP_DevNumber
+ *	registers. This gets programmed into the register. Currently
+ *	Group_Id field is not used.
+ *
+ * @assigned: Flag if the logical address(aka Slave device number) is
+ *	assigned to some Slave or is free.
+ *
+ * @status: mirrors Slave status reported by PING commands.
+ */
+struct sdw_slave_addr {
+	struct sdw_slave *slave;
+	unsigned int dev_id[SDW_NUM_DEV_ID_REGISTERS];
+	unsigned int dev_num;
+	bool assigned;
+	enum sdw_slave_status status;
+};
+
+/**
+ * sdw_dpn_caps: Capabilities of the Data Port, other than Data Port 0 for
+ *	SoundWire Master and Slave. This follows the definitions in the
+ *	SoundWire DisCo Spec. All fields are listed in order of the
+ *	SoundWire DisCo Spec. Name of the fields are altered to follow Linux
+ *	convention. All the fields which are required by bus driver but not
+ *	present in DisCo Spec are listed at the end of the structure. There
+ *	is a common dpn capability structure for Master and Slave ports.
+ *	Some of the fields doesn't make sense for Master which are called
+ *	out explicitly in fields description. Port properties can be
+ *	different for same Port, based on Port is configured as source or
+ *	sink Port.
+ *
+ * @max_bps: Maximum bits per sample supported by Port. This is same as word
+ *	length in SoundWire Spec.
+ *
+ * @min_bps: Minimum bits per sample supported by Port. This is same as word
+ *	length in SoundWire Spec.
+ *
+ * @num_bps: Length of supported bits per sample buffer. The use of max_ and
+ *	min_ bps requires num_bps to be zero
+ *
+ * @bps_buf: Array of the bits per sample buffer.
+ * @type: Type of Data Port. Simplified or Normal Data Port.
+ * @grouping: Max Block group count supported for this Port.
+ * @prepare_ch: Channel prepare scheme. Simplified channel prepare or normal
+ *	channel prepare. All Channels in the Port are assumed to share the
+ *	same scheme. For Masters this should be always simplified channel
+ *	prepare.
+ *
+ * @ch_prep_timeout: A port-specific timeout value in milliseconds. This
+ *	value indicates the worst-case latency of the channel prepare state
+ *	machine transitions. After receiving a successful channel
+ *	prepare/de-prepare command, the slave should complete the operation
+ *	before the expiration of the timeout. Software stack may poll for
+ *	completion periodically or wait for this timeout value. If the
+ *	requested action has not completed at the end of this timeout,
+ *	software shall interpret this as an error condition. This is don't
+ *	care for Master.
+ *
+ * @imp_def_intr_mask: Implementation defined interrupt mask. Master should
+ *	always set this to 0. Bus driver doesn't use this for Master.
+ *
+ * @min_ch_cnt: Minimum number of channels supported.
+ * @max_ch_cnt: Maximum number of channels supported.
+ * @num_ch_cnt: Buffer length for the channels supported. The use of max_ and
+ *	min_ ch_num requires num_ch_cnt to be zero.
+ *
+ * @ch_cnt_buf: Array of the channel count.
+ * @port_flow_mode_mask: Transport flow modes supported by Port.
+ * @max_async_buffer: Number of samples this port can buffer in asynchronous
+ *	modes. The SoundWire specification only requires minimal buffering,
+ *	this property is only required if the Slave implements a buffer that
+ *	exceeds the SoundWire requirements. Bus driver currently doesn't
+ *	support this.
+ *
+ * @blk_pack_mode: Block packing mode mask.
+ * @port_encoding: Port Data encoding type mask.
+ * @num_audio_modes: Number of audio modes supported by Port. This should be
+ *	0 for Master. Bus driver doesn't use this for Master.
+ *
+ * @mode_properties: Port audio mode properties buffer of size
+ *	num_audio_modes. This is not used for Master. This needs to be
+ *	populated only for Slave.
+ *
+ * @port_number: Port number.
+ */
+struct sdw_dpn_caps {
+	unsigned int max_bps;
+	unsigned int min_bps;
+	unsigned int num_bps;
+	unsigned int *bps_buf;
+	enum sdw_dpn_type type;
+	enum sdw_dpn_grouping grouping;
+	enum sdw_ch_prepare_mode prepare_ch;
+	unsigned int ch_prep_timeout;
+	u8 imp_def_intr_mask;
+	unsigned int min_ch_cnt;
+	unsigned int max_ch_cnt;
+	unsigned int num_ch_cnt;
+	unsigned int *ch_cnt_buf;
+	unsigned int port_flow_mode_mask;
+	unsigned int blk_pack_mode;
+	unsigned int port_encoding;
+	unsigned int num_audio_modes;
+	struct sdw_port_aud_mode_prop *mode_properties;
+	unsigned int port_number;
+};
+
+/**
+ * sdw_prepare_ch: Prepare/De-prepare the Data Port channel. This is similar
+ *	to the prepare API of Alsa, where most of the hardware interfaces
+ *	are prepared for the playback/capture to start. All the parameters
+ *	are known to the hardware at this point for starting
+ *	playback/capture next.
+ *
+ * @num: Port number.
+ * @ch_mask: Channels to be prepared/deprepared specified by ch_mask.
+ * @prepare: Prepare/de-prepare channel, true (prepare) or false
+ *	(de-prepare).
+ *
+ * @bank: Register bank, which bank Slave/Master driver should program for
+ *	implementation defined registers. This is the inverted value of the
+ *	current bank.
+ */
+struct sdw_prepare_ch {
+	unsigned int num;
+	unsigned int ch_mask;
+	bool prepare;
+	unsigned int bank;
+};
+
+/**
+ * sdw_bus_params: Bus params for the Slave/Master to be ready for next
+ *	bus changes.
+ *
+ * @clk_freq: Clock frequency for the bus in Hz.
+ * @num_rows: Number of rows in new frame to be enabled
+ * @num_cols: Number of columns in new frame to be enabled. The MIPI
+ *	specification lists restrictions on values for rows and cols that
+ *	will be enforced by the bus driver.
+ *
+ * @bank: Register bank, which bank Slave/Master driver should program for
+ *	implementation defined registers. This is the inverted value of the
+ *	current bank. The implementation of this bus driver follows the
+ *	recommendations of the MIPI specification and will never modify
+ *	registers in the current bank to avoid audible issues and bus
+ *	conflicts. Bus reconfigurations are always handled through a
+ *	synchronized bank switch mechanism. The use of Port-specific banks
+ *	is not supported for now.
+ */
+struct sdw_bus_params {
+	unsigned int clk_freq;
+	u16 num_rows;
+	unsigned int num_cols;
+	unsigned int bank;
+};
+
+/**
+ * sdw_bra_block: Data block to be sent/received using SoundWire Bulk
+ *	Register Access Protocol (BRA).
+ *
+ * @dev_num: Slave address, "Device Number" field of the SCP_DevNumber
+ *	registers. This gets programmed into the register. Currently
+ *	Group_Id field is not used.
+ *
+ * @r_w_flag: Read/Write operation. Read(0) or Write(1) based on above #def
+ * @num_bytes: Number of Data bytes to be transferred.
+ * @reg_offset: Register offset for the first byte of the read/write
+ *	transaction.
+ *
+ * @values: Array containing value for write operation and to be filled for
+ *	read operation.
+ */
+struct sdw_bra_block {
+	unsigned int dev_num;
+	u8 r_w_flag;
+	unsigned int num_bytes;
+	unsigned int reg_offset;
+	u8 *values;
+};
+
+/**
+ * sdw_msg: Message to be sent on bus. This is similar to i2c_msg on I2C
+ *	bus. Message is sent from the bus driver to the Slave device. Slave
+ *	driver can also initiate transfer of the message to program
+ *	implementation defined registers. Message is formatted and
+ *	transmitted on to the bus by Master interface in hardware-specific
+ *	way. Bus driver initiates the Master interface callback to transmit
+ *	the message on bus.
+ *
+ * @addr: Address of the register to be read.
+ * @len: Length of the message to be transferred. Successive increment in
+ *	the register address for every message. Bus driver sets this field
+ *	to 0, if transfer fails. E.g. If calling function sets len = 2 for
+ *	two byte transfer, and if transfer fails for 2nd byte, "len" field
+ *	is set to 0 by bus driver.
+ *
+ * @dev_num: Slave address, "Device Number" field of the SCP_DevNumber
+ *	registers. Currently Group_Id field is not used.
+ *
+ * @addr_page1: SCP address page 1 Slave register. 32-bit address of the
+ *	SoundWire Slave register is constructed using 16-bit lower bit
+ *	address as part of command, 8-bit as part of this register and MSB
+ *	8-bits as a part of addr_page2 register. This registers needs to be
+ *	programmed first for any transfer with register address greater than
+ *	0xFFFF.
+ *
+ * @addr_page2: SCP address page 2
+ * @r_w_flag: Message operation to be read or write.
+ * @buf: Buf to be written or read from the register.
+ * @xmit_on_ssp: Send message at SSP (Stream Synchronization Point). It
+ *	should be used when a command needs to be issued during the next
+ *	SSP. For all normal reads/writes this should be zero. This will be
+ *	used for broadcast write to SCP_FrameCtrl register by bus driver
+ *	only. Slave driver should always set xmit_on_ssp to 0. This flag
+ *	applies only if len = 1 in message. Multiple length messages cannot
+ *	be transmitted on SSP, for this caller needs to create multiple
+ *	messages.
+ *
+ */
+struct sdw_msg {
+	u16 addr;
+	u16 len;
+	u8 dev_num;
+	u8 addr_page1;
+	u8 addr_page2;
+	u8 r_w_flag;
+	u8 *buf;
+	bool xmit_on_ssp;
+};
+
+/**
+ * sdw_stream_config: Stream configuration set by the Master(s) and Slave(s)
+ *	via sdw_config_stream API. Both Master(s) and Slave(s) needs to
+ *	provide stream configuration because stream configuration for
+ *	Master(s) and Slave(s) could be different for a given stream. E.g.
+ *	in case of Stream associated with Single Master and a Slave, both
+ *	Master and Slave shall have same "sdw_stream_config" except the
+ *	"direction" (assuming Master and Slave supports stereo channels per
+ *	port). In case of stereo stream attached to single Master and two
+ *	Slaves, "channel_count" for each Slave shall be 1 and for the Master
+ *	it shall be 2, (assuming Master supports stereo channels per port
+ *	and Slave supports mono channel per port).
+ *
+ * @frame_rate: Audio frame rate of the stream (not the bus frame rate
+ *	defining command bandwidth).
+ *
+ * @channel_count: Channel count of the stream.
+ * @bps: Number of bits per audio sample.
+ * @direction: Data direction w.r.t Port. This is used by bus driver to
+ *	identify source and sink of the stream.
+ *
+ * @type: Stream type PCM or PDM. This is internally used by bus driver for
+ *	bandwidth allocation.
+ */
+struct sdw_stream_config {
+	unsigned int frame_rate;
+	unsigned int channel_count;
+	unsigned int bps;
+	enum sdw_data_direction direction;
+	enum sdw_stream_type type;
+};
+
+/**
+ * sdw_port_config: SoundWire Port configuration for a given port (Master
+ *	and Slave) associated with the stream.
+ *
+ * @num: Port number to be configured
+ * @ch_mask: Which channels needs to be enabled for this Port.
+ */
+struct sdw_port_config {
+	unsigned int num;
+	unsigned int ch_mask;
+};
+
+/**
+ * sdw_ports_config: Ports configuration set by the Master(s) and
+ *	Slave(s) via "sdw_config_ports" API. Both Master(s) and Slave(s)
+ *	needs to provide port configuration because port configuration for
+ *	Master(s) and Slave(s) could be different for a given stream. E.g.
+ *	in case of Stream associated with Single Master and a Slave, both
+ *	Master and Slave shall have same "sdw_ports_config" except the
+ *	"num" inside "sdw_port_config"(assuming Master and Slave
+ *	supports stereo channels per port). In case of stereo stream
+ *	attached to single Master and two Slaves, "num_ports" for each Slave
+ *	shall be 1 and for the Master it shall be 2 for "sdw_ports_config",
+ *	"ch_mask" for Slave which handles left channel shall be 0x1, and for
+ *	Slave which handles right channel shall be 0x2. "num" should
+ *	be based on port allocated by Master and Slaves(assuming Master
+ *	supports stereo channels per port and Slave supports mono channel
+ *	per port).
+ *
+ * @num_ports: Number of ports to be configured.
+ * @port_cfg: Port configuration for each Port.
+ */
+struct sdw_ports_config {
+	unsigned int num_ports;
+	struct sdw_port_config *port_config;
+};
+
+/**
+ * sdw_slave_status: Status of all the SoundWire Slave devices.
+ *
+ * @status: Array of status of SoundWire Slave devices. There can be 11
+ *	Slaves with non-zero device number, before enumeration all Slaves
+ *	reports as device0.
+ */
+struct sdw_status {
+	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
+};
+
+/**
+ * snd_sdw_alloc_stream_tag: Allocates unique stream_tag. Stream tag is
+ *	a unique identifier for each SoundWire stream across all SoundWire
+ *	bus instances. Stream tag is a software concept defined by bus
+ *	driver for stream management and not by MIPI SoundWire Spec. Each
+ *	SoundWire Stream is individually configured and controlled using the
+ *	stream tag. Multiple Master(s) and Slave(s) associated with the
+ *	stream, uses stream tag as an identifier. All the operations on the
+ *	stream e.g. stream configuration, port configuration, prepare and
+ *	enable of the ports are done based on stream tag. This API shall be
+ *	called once per SoundWire stream either by the Master or Slave
+ *	associated with the stream.
+ *
+ * @stream_tag: Stream tag returned by bus driver.
+ */
+int snd_sdw_alloc_stream_tag(unsigned int *stream_tag);
+
+/**
+ * snd_sdw_release_stream_tag: Free the already assigned stream tag.
+ *	Reverses effect of "sdw_alloc_stream_tag"
+ *
+ * @stream_tag: Stream tag to be freed.
+ */
+void snd_sdw_release_stream_tag(unsigned int stream_tag);
+
+/**
+ * snd_sdw_config_stream: Configures the SoundWire stream. All the Master(s)
+ *	and Slave(s) associated with the stream calls this API with
+ *	"sdw_stream_config". This API configures SoundWire stream based on
+ *	"sdw_stream_config" provided by each Master(s) and Slave(s)
+ *	associated with the stream. Master calls this function with Slave
+ *	handle as NULL, Slave calls this with Master handle as NULL.
+ *
+ * @mstr: Master handle.
+ * @slave: SoundWire Slave handle, Null if stream configuration is called by
+ *	Master driver.
+ *
+ * @stream_config: Stream configuration for the SoundWire audio stream.
+ * @stream_tag: Stream_tag representing the audio stream. All Masters and
+ *	Slaves part of the same stream has same stream tag. So Bus driver
+ *	holds information of all Masters and Slaves associated with stream
+ *	tag.
+ */
+int snd_sdw_config_stream(struct sdw_master *mstr, struct sdw_slave *slave,
+			struct sdw_stream_config *stream_config,
+			unsigned int stream_tag);
+
+/**
+ * snd_sdw_release_stream: De-associates Master(s) and Slave(s) from stream.
+ *	Reverse effect of the sdw_config_stream. Master calls this with
+ *	Slave handle as NULL, Slave calls this with Master handle as NULL.
+ *
+ * @mstr: Master handle,
+ * @slave: SoundWire Slave handle, Null if stream configuration is called by
+ *	Master driver.
+ *
+ * @stream_tag: Stream_tag representing the audio stream. All Masters and
+ *	Slaves part of the same stream has same stream tag. So Bus driver
+ *	holds information of all Masters and Slaves associated with stream
+ *	tag.
+ */
+int snd_sdw_release_stream(struct sdw_master *mstr, struct sdw_slave *slave,
+						unsigned int stream_tag);
+
+/**
+ * snd_sdw_config_ports: Configures Master or Slave Port(s) associated with
+ *	the stream. All the Master(s) and Slave(s) associated with the
+ *	stream calls this API with "sdw_ports_config". Master calls this
+ *	function with Slave handle as NULL, Slave calls this with Master
+ *	handle as NULL.
+ *
+ * @mstr: Master handle where the Slave is connected.
+ * @slave: Slave handle.
+ * @ports_config: Port configuration for each Port of SoundWire Slave.
+ * @stream_tag: Stream tag, where this Port is connected.
+ */
+int snd_sdw_config_ports(struct sdw_master *mstr, struct sdw_slave *slave,
+				struct sdw_ports_config *ports_config,
+				unsigned int stream_tag);
+
+/**
+ * snd_sdw_prepare_and_enable: Prepare and enable all the ports of all the
+ *	Master(s) and Slave(s) associated with this stream tag. Following
+ *	will be done as part of prepare operation.
+ *	1. Bus parameters such as bandwidth, frame shape, clock frequency,
+ *	SSP interval are computed based on current stream as well as already
+ *	active streams on bus. Re-computation is required to accommodate
+ *	current stream on the bus.
+ *	2. Transport parameters of all Master and Slave ports are computed
+ *	for the current as well as already active stream based on above
+ *	calculated frame shape and clock frequency.
+ *	3. Computed bus and transport parameters are programmed in Master
+ *	and Slave registers. The banked registers programming is done on the
+ *	alternate bank (bank currently unused). Port channels are enabled
+ *	for the already active streams on the alternate bank (bank currently
+ *	unused). This is done in order to not to disrupt already active
+ *	stream.
+ *	4. Once all the new values are programmed, switch is made to
+ *	alternate bank. Once switch is successful, the port channels enabled
+ *	on previous bank for already active streams are disabled.
+ *	5. Ports of Master and Slave for new stream are prepared.
+ *
+ *	Following will be done as part of enable operation.
+ *	1. All the values computed in SDW_STATE_STRM_PREPARE state are
+ *	programmed in alternate bank (bank currently unused). It includes
+ *	programming of already active streams as well.
+ *	2. All the Master and Slave port channels for the new stream are
+ *	enabled on alternate bank (bank currently unused).
+ *	3. Once all the new values are programmed, switch is made on the
+ *	alternate bank. Once the switch is successful, the port channels
+ *	enabled on previous bank for already active streams are disabled.
+ *
+ *	This shall be called either by Master or Slave, which is responsible
+ *	for doing data transfer between SoundWire link and the system
+ *	memory.
+ *
+ * @stream_tag: Audio stream to be enabled. Each stream has unique
+ *	stream_tag. All the channels of all the ports of Slave(s) and
+ *	Master(s) attached to this stream will be prepared and enabled
+ *	simultaneously with bank switch.
+ */
+int snd_sdw_prepare_and_enable(unsigned int stream_tag);
+
+/**
+ * snd_sdw_disable_and_deprepare: Disable and de-prepare all the ports of
+ *	all the Master(s) and Slave(s) associated with stream tag. Following
+ *	will be done as part of disable operation.
+ *	1. Disable for Master and Slave ports channels is performed on
+ *	alternate bank (bank currently unused) registers for current stream.
+ *	2. All the current configuration of bus and Master and Slave ports
+ *	are programmed into alternate bank (bank currently unused). It
+ *	includes programming of already active streams port channels on
+ *	alternate bank (bank currently unused).
+ *	3. Switch is made on new bank. Once the switch is successful, the
+ *	port channels of current stream are disabled. All the port channels
+ *	enabled on previous bank for active stream are disabled.
+ *
+ *	Following will be done as part of de-prepare operation.
+ *	1. Check the bandwidth required per Master. If its zero, de-prepare
+ *	current stream and move stream state SDW_STATE_STRM_UNPREPARE, rest
+ *	of the steps are not required. If bandwidth required per Master is
+ *	non zero that means some more streams are running on Master and
+ *	continue with next step.
+ *	2. Bus parameters and transport parameters are computed for the
+ *	streams active on the given Master.
+ *	3. All the computed values for active stream are programmed into
+ *	alternate bank (bank currently unused) in Master and Slave registers
+ *	including already active streams port channels on alternate bank
+ *	(bank currently unused).
+ *	4. Switch is made to alternate bank where all the values for active
+ *	stream were programmed. On successful switch of bank, all the port
+ *	channels enabled on previous bank for active stream are disabled.
+ *	5. De-prepare ports of the Master and Slave associated with current
+ *	stream.
+ *
+ *	This shall be called either by Master or Slave, which is
+ *	responsible for doing data transfer between SoundWire link and the
+ *	system memory.
+ *	Note: Both disable and de-prepare operations are performed in single
+ *	call. De-prepare operation can be deferred for some specific timeout
+ *	value after disable operation, to avoid bus re-configurations
+ *	between short play and pause periods.
+ *
+ * @stream_tag: Audio stream to be disabled. Each stream has unique
+ *	stream_tag. All the channels of all the ports of Slave(s) and
+ *	Master(s) attached to this stream will be disabled and de-prepared
+ *	simultaneously with bank switch.
+ */
+int snd_sdw_disable_and_deprepare(unsigned int stream_tag);
+
+/**
+ * snd_sdw_slave_transfer: Transfer message on bus.
+ *
+ * @master: Master which will transfer the message.
+ * @msg: Array of messages to be transferred.
+ * @num: Number of messages to be transferred, messages include read and
+ *	write messages, but not the ping commands. The read and write
+ *	messages are transmitted as a part of read and write SoundWire
+ *	commands with a parameter containing the payload.
+ *
+ * Returns the number of messages successfully transferred else appropriate
+ * error code.
+ */
+int snd_sdw_slave_transfer(struct sdw_master *master, struct sdw_msg *msg,
+						unsigned int num);
+#endif /*  _LINUX_SDW_BUS_H */
+
diff --git a/include/sound/sdw_master.h b/include/sound/sdw_master.h
new file mode 100644
index 0000000..e709c51
--- /dev/null
+++ b/include/sound/sdw_master.h
@@ -0,0 +1,627 @@
+/*
+ * sdw_master.h - Definition for SoundWire Master interface. This file
+ *	has all the definitions which are required for only Soundwire
+ *	Master driver. Some interfaces are common for both Slave and
+ *	Master driver. Please refer to sdw_bus.h for common interfaces.
+ *
+ * Author: Hardik Shah <hardik.t.shah@intel.com>
+ *
+ *
+ * This header file refers to the MIPI SoundWire 1.1 Spec.
+ * [1.1] https://members.mipi.org/wg/All-Members/document (accessible to
+ * MIPI members).
+ *
+ * The comments in the file try to follow the same conventions with a
+ * capital letter for all standard definitions such as Master, Slave,
+ * Data Port, etc. When possible, the constant numeric values are kept
+ * the same as in the MIPI specifications. All of the constants reflect
+ * the MIPI SoundWire definitions and are not vendor specific. Some of
+ * the constants are for bus driver usage and not MIPI defined. These
+ * are specified at appropriate place in this file.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright(c) 2016 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ *
+ * BSD LICENSE
+ *
+ * Copyright(c) 2016 Intel Corporation.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#ifndef _LINUX_SDW_MASTER_H
+#define _LINUX_SDW_MASTER_H
+
+#include <sound/sdw_bus.h>
+
+/**
+ * sdw_deferred_xfer_data: Data to be provided by bus driver for calling
+ *	xfer_msg_deferred callback of Master driver.
+ *
+ * @result: Result of the asynchronous transfer.
+ * @xfer_complete: Bus driver will wait on this. Master needs to ack on this
+ *	for transfer complete.
+ *
+ * @msg: Message to be transferred.
+ */
+struct sdw_deferred_xfer_data {
+	int result;
+	struct completion xfer_complete;
+	struct sdw_msg *msg;
+};
+
+/**
+ * sdw_master_dp0_caps: Master Data Port 0 capabilities.
+ *
+ * @max_bps: Maximum bits per sample supported by Port. This is same as word
+ *	length in SoundWire Spec.
+ *
+ * @min_bps: Minimum bits per sample supported by Port. This is same as word
+ *	length in SoundWire Spec.
+ *
+ * @num_bps: Array size of the buffer containing the supported bps use of
+ *	max and min bps requires num_bps to be 0
+ *
+ * @bps_buf: Array containing supported sample sizes.
+ * @bra_max_data_per_frame: Maximum Data size per BRA(Bulk Access Register)
+ *	packet.
+ */
+struct sdw_master_dp0_caps {
+	unsigned int max_bps;
+	unsigned int min_bps;
+	unsigned int num_bps;
+	unsigned int *bps_buf;
+	unsigned int bra_max_data_per_frame;
+};
+
+/**
+ * sdw_master_caps: Capabilities of the Master. This is filled by the
+ *	software registering Master device like board or device entry table.
+ *	All fields are listed in order of the SoundWire DisCo Spec. Name of
+ *	the fields are altered to follow Linux convention. All the fields
+ *	which are required by bus driver but not present in DisCo Spec are
+ *	listed at the end of the structure.
+ *
+ * @clk_stp_mode0: True if Master interface supports ClockStop Mode0
+ * @clk_stp_mode1: True if Master interface supports ClockStop Mode1. Both
+ *	of these fields are not used by bus driver as of now. This will be
+ *	implemented in later version of the bus driver.
+ *
+ * @max_clk_freq: Max soundwire clock frequency at SDW clock line. This is
+ *	in Hz.
+ *
+ * @num_clk_gears: Number of clock gears supported by Master.
+ * @clk_gears: A array containing clock gears integer supported by Master.
+ * @num_clk_freq: Number of clock frequencies supported by Master. This is
+ *	alternate way of representing the clock gear. To use this
+ *	num_clock_gears must be 0.
+ *
+ * @clk_freq_buf: Array representing the clock frequencies supported by the
+ *	Master.
+ *
+ * @def_frame_rate: Master default frame rate in Hz. The frame rate defines
+ *	the control bandwidth on a SoundWire bus.
+ *
+ * @def_frame_row_size: Number of rows 47<n<257. Not all values are valid as
+ *	per Table 19 of the SoundWire MIPI specification Version 1.1.
+ *
+ * @def_frame_col_size: Number of rows 1<n<17. Only even numbers are
+ *	valid.
+ *
+ * @dynamic_frame_shape: If false, bus driver may not change the frame shape
+ *	dynamically and must only use the default/initial settings.
+ *
+ * @command_error_threshold: Number of times software may retry sending a
+ *	single command. Once the threshold has been reached, an error
+ *	condition exists and the command should not be retried.
+ *
+ * @bank_switch_timeout: Bus driver to wait for the specific timeout for
+ *	bank switch to complete, after initiating the the bank switch
+ *	operation. This is in milli-seconds.
+ *
+ * @monitor_handover_supported: Does Master support monitor handover.
+ * @highphy_capable: Is Master High-PHY capable? Basic-PHY and High-PHY are
+ *	two modes a device can run. Bus driver doesn't support High-PHY mode
+ *	as of now.
+ *
+ * @sdw_dp0_present: Data port0 present?
+ * @sdw_dp0_caps: Capabilities of the Data Port 0 of the Master.
+ * @num_data_ports: Array size for the number of Data Ports present in
+ *	Master.
+ *
+ * @sdw_dpn_caps: Array containing information about SoundWire Master Data
+ *	Port Capabilities.
+ */
+struct sdw_master_caps {
+	bool clk_stp_mode0;
+	bool clk_stp_mode1;
+	unsigned int max_clk_freq;
+	unsigned int num_clk_gears;
+	unsigned int *clk_gears;
+	unsigned int num_clk_freq;
+	unsigned int *clk_freq_buf;
+	unsigned int def_frame_rate;
+	unsigned int def_frame_row_size;
+	unsigned int def_frame_col_size;
+	bool dynamic_frame_shape;
+	unsigned int command_error_threshold;
+	unsigned int bank_switch_timeout;
+	bool monitor_handover_supported;
+	bool highphy_capable;
+	bool sdw_dp0_present;
+	struct sdw_master_dp0_caps sdw_dp0_caps;
+	unsigned int num_data_ports;
+	struct sdw_dpn_caps *sdw_dpn_caps;
+};
+
+/**
+ * sdw_master: Structure representing the Master interface of the SoundWire.
+ *
+ * @dev: Master interface for this driver.
+ * @bus: Bus handle for easy access of bus from Master.
+ * @name: Name of the Master driver.
+ * @nr: Master instance number. This represents SoundWire bus. This is
+ *	logical number incremented per every Master getting registered.
+ *
+ * @timeout: Timeout before getting message response, in ms.
+ * @retries: How many times to retry before giving up on Slave response.
+ * @link_sync_mask: Bit mask representing all the other Master links with
+ *	which this link is synchronized.
+ *
+ * @slv_list: List of SoundWire Slaves registered to the bus.
+ * @sdw_addr: Array containing Slave SoundWire bus Slave address
+ *	information. Its a part of Slave list as well, but for easier access
+ *	its part of array to find the Slave reference by directly indexing
+ *	the Slave number into the array.
+ *
+ * @lock: Global lock for bus functions. This lock is used for
+ *	following
+ *	1. Enumerating the Slaves and adding it to the Master list.
+ *	2. Bus reconfiguration operations.
+ *
+ * @msg_lock: Used to serialize the messages on the bus.
+ * @caps: Capabilities of the SoundWire Master interface.
+ * @driver: Driver handling the Master.
+ * @slv_released_complete: Flag to indicate Slave release completion.
+ *	Internally used by bus driver. This is to make sure that Master is
+ *	freed only after all Slaves devices are freed.
+ *
+ * @link_id: This is the link_id of the Master. This has direct relationship
+ *	with the Slaves address. This is provided by the software
+ *	registering the Master. This is read either from ACPI or from board
+ *	data.
+ *
+ * @num_slv: Number of SoundWire Slaves assigned DeviceNumber after
+ *	enumeration. The SoundWire specification does not place a
+ *	restriction on how many Slaves are physically connected, as long as
+ *	only 11 are active concurrently. This bus driver adds a pragmatic
+ *	restriction to 11 Slaves, the current implementation assigns a
+ *	DeviceNumber once and will never use the same DeviceNumber for
+ *	different devices.
+ */
+struct sdw_master {
+	struct device dev;
+	struct sdw_bus *bus;
+	char name[SOUNDWIRE_NAME_SIZE];
+	unsigned int nr;
+	unsigned int timeout;
+	unsigned int retries;
+	unsigned int link_sync_mask;
+	struct list_head slv_list;
+	struct sdw_slave_addr sdw_addr[SDW_MAX_DEVICES];
+	struct mutex lock;
+	struct mutex msg_lock;
+	struct sdw_master_caps caps;
+	struct sdw_master_driver *driver;
+	struct completion slv_released_complete;
+	struct list_head mstr_rt_list;
+	unsigned int link_id;
+	unsigned int num_slv;
+};
+#define to_sdw_master(d) container_of(d, struct sdw_master, dev)
+
+/**
+ * sdw_port_params: This is used to program the Data Port based on Data Port
+ *	stream params. These parameters are not banked and not expected to
+ *	change dynamically to avoid audio artifacts.
+ *
+ * @num: Port number.
+ * @bps: Word length of the Port
+ * @flow_mode: Port Data flow mode.
+ * @data_mode: Test modes or normal mode.
+ */
+struct sdw_port_params {
+	unsigned int num;
+	unsigned int bps;
+	unsigned int flow_mode;
+	unsigned int data_mode;
+};
+
+/**
+ * sdw_transport_params: This is used to program the Data Port based on Data
+ *	Port transport params. All these parameters are banked and can be
+ *	modified during a bank switch without any artefact's in audio
+ *	stream. Bus driver modifies these parameters as part new stream
+ *	getting enabled/disabled on the bus. Registers are explained next to
+ *	each field where values will be filled. Those are MIPI defined
+ *	registers for Slave devices.
+ *
+ * @blk_grp_ctrl_valid: Does Port implement block group control?
+ * @port_num: Port number for which params are to be programmed.
+ * @blk_grp_ctrl: Block group control value.
+ * @sample_interval: Sample interval.
+ * @offset1: Blockoffset of the payload Data.
+ * @offset2: Blockoffset of the payload Data.
+ * @hstart: Horizontal start of the payload Data.
+ * @hstop: Horizontal stop of the payload Data.
+ * @blk_pkg_mode: Block per channel or block per Port.
+ * @lane_ctrl: Data lane Port uses for Data transfer. Currently only single
+ *	data lane is supported in bus driver.
+ */
+struct sdw_transport_params {
+	bool blk_grp_ctrl_valid;
+	unsigned int port_num;
+	unsigned int blk_grp_ctrl;	/* DPN_BlockCtrl2 */
+	unsigned int sample_interval;	/* DPN_SampleCtrl1 & DPN_SampleCtrl2 */
+	unsigned int offset1;		/* DPN_OffsetCtrl1 */
+	unsigned int offset2;		/* DPN_OffsetCtrl2 */
+	unsigned int hstart;		/* DPN_HCtrl */
+	unsigned int hstop;		/* DPN_HCtrl */
+	unsigned int blk_pkg_mode;	/* DPN_BlockCtrl3 */
+	unsigned int lane_ctrl;		/* DPN_LaneCtrl */
+};
+
+/**
+ * sdw_enable_ch: Enable/disable Data Port channel. This is for triggering
+ *	On/Off the Port. This readily translates to the trigger functions of
+ *	ALSA. Actual trigger/enabling of the channels of the Port is done
+ *	through with a bank switch since transport parameters may need to
+ *	change due to a clock or frame shape change.
+ *
+ * @num: Port number for which params are to be programmed.
+ * @ch_mask: Active channel mask for this Port.
+ * @enable: Enable/disable channel, true (enable) or false
+ *	(disable).
+ */
+struct sdw_enable_ch {
+	unsigned int num;
+	unsigned int ch_mask;
+	bool enable;
+};
+
+/**
+ * sdw_master_port_ops: Callback functions from bus driver to Master driver
+ *	to set Master Data ports. Since Master registers are not standard,
+ *	commands are passed to Master from bus and Master converts commands
+ *	to register settings based on Master register map.
+ *
+ * @dpn_set_port_params: Set the Port parameters for the Master Port. This
+ *	is mandatory callback to be provided by Master, if it support data
+ *	ports.
+ *
+ * @dpn_set_port_transport_params: Set transport parameters for the Master
+ *	Port. This is mandatory callback to be provided by Master if it
+ *	supports data ports.
+ *
+ * @dpn_port_prep: Port prepare operations for the Master Data Port. Called
+ *	before and after Port prepare as well as for Master Data Port
+ *	prepare.
+ *
+ * @dpn_port_enable_ch: Enable the channels of particular Master Port.
+ *	Actual enabling of the port is done as a part of bank switch This
+ *	call is to enable the channels in alternate bank. This is mandatory
+ *	if Master supports data ports.
+ */
+struct sdw_master_port_ops {
+	int (*dpn_set_port_params)(struct sdw_master *master,
+			struct sdw_port_params *port_params, unsigned int bank);
+	int (*dpn_set_port_transport_params)(struct sdw_master *master,
+			struct sdw_transport_params *transport_params,
+			unsigned int bank);
+	int (*dpn_port_prep)(struct sdw_master *master,
+				struct sdw_prepare_ch *prepare_ch,
+				enum sdw_port_prep_ops prep_ops);
+	int (*dpn_port_enable_ch)(struct sdw_master *master,
+			struct sdw_enable_ch *enable_ch, unsigned int bank);
+};
+
+/**
+ * sdw_master_ops: Callback operations from bus driver to Master driver.
+ *	Bus driver calls these functions to control the bus parameters in
+ *	Master hardware specific way. Its like i2c_algorithm to access the
+ *	bus in Master specific way.
+ *
+ * @xfer_msg: Callback function to Master driver to read/write Slave
+ *	registers. This is mandatory callback to be provided by Master
+ *	driver to do Slave register read/writes.
+ *
+ * @reset_page_addr: Callback function to Master driver to reset the SCP
+ *	page address registers of Slave. This is called by bus driver after
+ *	message transfer, to reset the page address registers to 0. This is
+ *	to make sure MIPI defined Slave registers are accessed in fast
+ *	manner as all the MIPI defined Slave registers are till 0xFFFF,
+ *	where SCP page address is always 0. xfer_msg callback can also be
+ *	used to reset page address with dummy message. But this callback is
+ *	more explicit where master driver is informed to reset the page
+ *	address registers of the Slave. This is mandatory callback to be
+ *	provided by Master driver.
+ *
+ * @xfer_bra: Callback function to Master driver for BRA transfer. This is
+ *	required if BRA is supported on DP0.
+ *
+ * @monitor_handover: Allow monitor to be owner of command, if requested.
+ *	This is optional based on Master support for handovers.
+ *
+ * @set_ssp_interval: Set SSP interval. This is mandatory callback to be
+ *	provided by Master driver.
+ *
+ * @set_bus_params: Set the clock frequency and frame shape based on
+ *	bandwidth requirement. Master driver sets the frequency and frame
+ *	shape in hardware specific way. This is mandatory if Master supports
+ *	dynamic frame shape and clock scaling.
+ *
+ * @pre_bank_switch: This is required to be implemented by Master driver if
+ *	stream is handled by more than one Master. This is called by the the
+ *	bus driver before bank switch operation is initiated. If there are
+ *	two masters handling the stream, for both masters this will be
+ *	called before scheduling bank switch operation. Normally master
+ *	prepares itself in this call for synchronous bank switch.
+ *
+ * @xfer_msg_deferred: This is required to be implemented by Master driver
+ *	if stream is handled by more than one Master interface. Bus driver
+ *	initiates bank switch and wait for the bank switch to be completed.
+ *	For streams handled by multiple Masters, bus driver initiates bank
+ *	switch using this API for all Masters of the associated with the
+ *	stream and waits for bank switch to be completed on all Masters. Its
+ *	up to master implementation on how to synchronize bank switches on
+ *	Multiple masters.
+ *
+ * @post_bank_switch: This is required to be implemented by Master driver if
+ *	stream is handled by more than one Master. This is called by the bus
+ *	driver after bank switch operation is initiated. If there are two
+ *	masters handling the stream, for both masters this will be called
+ *	after initiating bank switch operation. Normally master completes
+ *	the bank switch operation on all the Masters associated with this
+ *	stream in this call.
+ */
+struct sdw_master_ops {
+	enum sdw_command_response (*xfer_msg)(struct sdw_master *master,
+		struct sdw_msg *msg, bool program_scp_addr_page);
+	enum sdw_command_response (*reset_page_addr)(struct sdw_master *master,
+			unsigned int dev_num);
+	int (*xfer_bra)(struct sdw_master *master,
+		struct sdw_bra_block *block);
+	int (*monitor_handover)(struct sdw_master *master,
+		bool handover);
+	int (*set_ssp_interval)(struct sdw_master *master,
+			unsigned int ssp_interval, unsigned int bank);
+	int (*set_bus_params)(struct sdw_master *master,
+			struct sdw_bus_params *params);
+	int (*pre_bank_switch)(struct sdw_master *master);
+	void (*xfer_msg_deferred)(struct sdw_master *master,
+		struct sdw_msg *msg, bool program_scp_addr_page,
+		struct sdw_deferred_xfer_data *data);
+	int (*post_bank_switch)(struct sdw_master *master);
+};
+
+/**
+ * sdw_master_driver: Manage SoundWire Master device driver.
+ *
+ * @driver_type: To distinguish between Master and Slave driver. This should
+ *	be set by driver based on its handling Slave or Master SoundWire
+ *	interface.
+ *
+ * @probe: Binds this driver to a SoundWire Master.
+ * @remove: Unbinds this driver from the SoundWire Master.
+ * @shutdown: Standard shutdown callback used during power down/halt.
+ * @suspend: Standard suspend callback used during system suspend
+ * @resume: Standard resume callback used during system resume
+ * @driver: SoundWire device drivers should initialize name and owner field
+ *	of this structure.
+ *
+ * @ops: Callback operations from bus driver to Master driver for
+ *	programming and controlling bus parameters and to program Slave
+ *	registers.
+ *
+ * @port_ops: Commands to setup the Master ports. Master register map is
+ *	not defined by standard. So these ops represents the commands to
+ *	setup Master ports.
+ *
+ * @id_table: List of SoundWire devices supported by this driver. This list
+ *	should be NULL terminated.
+ */
+struct sdw_master_driver {
+	enum sdw_driver_type driver_type;
+	struct device_driver driver;
+	int (*probe)(struct sdw_master *master, const struct sdw_master_id *);
+	int (*remove)(struct sdw_master *master);
+	void (*shutdown)(struct sdw_master *master);
+	int (*suspend)(struct sdw_master *master);
+	int (*resume)(struct sdw_master *master);
+	struct sdw_master_ops *ops;
+	struct sdw_master_port_ops *port_ops;
+	const struct sdw_master_id *id_table;
+};
+#define to_sdw_master_driver(d)			\
+		container_of(d, struct sdw_master_driver, driver)
+
+/**
+ * snd_sdw_master_add: Registers the SoundWire Master interface. This needs
+ *	to be called for each Master interface supported by SoC. This
+ *	represents One clock and data line (Optionally multiple data lanes)
+ *	of Master interface.
+ *
+ * @master: the Master to be added.
+ */
+int snd_sdw_master_add(struct sdw_master *master);
+
+/**
+ * snd_sdw_master_del - unregister SDW Master
+ *
+ * @master: the Master being unregistered
+ */
+void snd_sdw_master_del(struct sdw_master *master);
+
+/**
+ * snd_sdw_master_register_driver: SoundWire Master driver registration with
+ *	bus. This API will register the Master driver with the SoundWire
+ *	bus. It is typically called from the driver's module-init function.
+ *
+ * @driver: Master Driver to be associated with Master interface.
+ * @owner: Module owner, generally THIS module.
+ */
+int snd_sdw_master_register_driver(struct sdw_master_driver *driver,
+					struct module *owner);
+
+/**
+ * sdw_unregister_master_driver: Undo effects of
+ *	snd_sdw_master_driver_register
+ *
+ * @drv: SoundWire Master driver to be unregistered
+ */
+static inline void sdw_master_unregister_driver(struct sdw_master_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+
+/**
+ * snd_sdw_master_update_slave_status: Update the status of the Slave to the
+ *	bus driver. Master calls this function based on the interrupt it
+ *	gets once the Slave changes its state or from interrupts for the
+ *	Master hardware that caches status information reported in PING
+ *	commands.
+ *
+ * @master: Master handle for which status is reported.
+ * @status: Array of status of each Slave.
+ *
+ * This function can be called from interrupt context by Master driver to
+ *	report Slave status without delay.
+ */
+int snd_sdw_master_update_slave_status(struct sdw_master *master,
+				struct sdw_status *status);
+
+/**
+ * snd_sdw_master_get: Return the Master handle from Master number.
+ *	Increments the reference count of the module. Similar to
+ *	i2c_get_adapter.
+ *
+ * @nr: Master number.
+ *
+ * Returns Master handle on success, else NULL
+ */
+struct sdw_master *snd_sdw_master_get(int nr);
+
+/**
+ * snd_sdw_master_put: Reverses the effect of sdw_master_get
+ *
+ * @master: Master handle.
+ */
+void snd_sdw_master_put(struct sdw_master *master);
+
+/**
+ * snd_sdw_master_prepare_for_clk_stop: Prepare all the Slaves for clock
+ *	stop. Iterate through each of the enumerated Slaves. Prepare each
+ *	Slave according to the clock stop mode supported by Slave. Use
+ *	dynamic value from Slave callback if registered, else use static
+ *	values from Slave capabilities registered.
+ *	1. Get clock stop mode for each Slave.
+ *	2. Call pre_prepare callback of each Slave if registered.
+ *	3. Write ClockStopPrepare bit in SCP_SystemCtrl register for each of
+ *	the enumerated Slaves.
+ *	4. Broadcast the read message to read the SCP_Stat register to make
+ *	sure ClockStop Prepare is finished for all Slaves.
+ *	5. Call post_prepare callback of each Slave if registered after
+ *	Slaves are in ClockStopPrepare state.
+ *
+ * @master: Master handle for which clock state has to be changed.
+ */
+int snd_sdw_master_prepare_for_clk_stop(struct sdw_master *master);
+
+/**
+ * snd_sdw_master_deprepare_after_clk_start: De-prepare all the Slaves
+ *	exiting clock stop mode 0 after clock resumes. Clock is already
+ *	resumed before this. De-prepare for the Slaves which were there in
+ *	clock stop mode 1 is done after they enumerated back. This is because
+ *	Slave specific callbacks needs to be invoked as part of de-prepare,
+ *	which can be invoked only after Slave enumerates.
+ *	1. Get clock stop mode for each Slave.
+ *	2. Call pre_prepare callback of each Slave exiting from clock stop
+ *	mode 0.
+ *	3. De-Prepare each Slave exiting from clock stop mode 0
+ *	4. Broadcast the Read message to make sure all Slaves are
+ *	de-prepared for clock stop.
+ *	5. Call post_prepare callback of each Slave exiting from clock stop
+ *	mode0
+ *
+ * @master: Master handle
+ */
+int snd_sdw_master_deprepare_after_clk_start(struct sdw_master *master);
+
+/**
+ * snd_sdw_master_stop_clock: Stop the clock. This function broadcasts the
+ *	SCP_CTRL register with clock_stop_now bit set.
+ *
+ * @master: Master handle for which clock has to be stopped.
+ */
+int snd_sdw_master_stop_clock(struct sdw_master *master);
+
+/* Return the adapter number for a specific adapter */
+static inline int sdw_master_get_id(struct sdw_master *master)
+{
+	return master->nr;
+}
+
+static inline void *sdw_master_get_drvdata(const struct sdw_master *master)
+{
+	return dev_get_drvdata(&master->dev);
+}
+
+static inline void sdw_master_set_drvdata(struct sdw_master *master,
+							void *data)
+{
+	dev_set_drvdata(&master->dev, data);
+}
+#endif /*  _LINUX_SDW_MASTER_H */
diff --git a/include/sound/sdw_slave.h b/include/sound/sdw_slave.h
new file mode 100644
index 0000000..6577933
--- /dev/null
+++ b/include/sound/sdw_slave.h
@@ -0,0 +1,563 @@
+/*
+ * sdw_slave.h - Definition for SoundWire Slave interface. This file has
+ *	all the definitions which are required for only SoundWire Slave
+ *	driver. Some interfaces are common for both Slave and Master
+ *	driver. Please refer to sdw_bus.h for common interfaces.
+ *
+ * Author: Hardik Shah <hardik.t.shah@intel.com>
+ *
+ *
+ * This header file refers to the MIPI SoundWire 1.1 Spec.
+ * [1.1] https://members.mipi.org/wg/All-Members/document (accessible to
+ * MIPI members).
+ *
+ * The comments in the file try to follow the same conventions with a
+ * capital letter for all standard definitions such as Master, Slave,
+ * Data Port, etc. When possible, the constant numeric values are kept
+ * the same as in the MIPI specifications. All of the constants reflect
+ * the MIPI SoundWire definitions and are not vendor specific. Some of
+ * the constants are for bus driver usage and not MIPI defined. These
+ * are specified at appropriate place in this file.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This file is provided under a dual BSD/GPLv2 license.  When using or
+ * redistributing this file, you may do so under either license.
+ *
+ * GPL LICENSE SUMMARY
+ *
+ * Copyright(c) 2016 Intel Corporation.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of version 2 of the GNU General Public License as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ *
+ * BSD LICENSE
+ *
+ * Copyright(c) 2016 Intel Corporation.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ *
+ *   * Redistributions of source code must retain the above copyright
+ *     notice, this list of conditions and the following disclaimer.
+ *   * Redistributions in binary form must reproduce the above copyright
+ *     notice, this list of conditions and the following disclaimer in
+ *     the documentation and/or other materials provided with the
+ *     distribution.
+ *   * Neither the name of Intel Corporation nor the names of its
+ *     contributors may be used to endorse or promote products derived
+ *     from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
+ * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
+ * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
+ * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
+ * OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
+ * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
+ * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
+ * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ */
+
+#ifndef _LINUX_SDW_SLAVE_H
+#define _LINUX_SDW_SLAVE_H
+
+#include <sound/sdw_bus.h>
+
+/**
+ * sdw_portn_intr_mask: Implementation defined interrupt mask for Slave
+ *	Ports other than Data Port 0.
+ *
+ * @mask: Mask for the implementation defined interrupt.
+ */
+struct sdw_portn_intr_mask {
+	u8 mask;
+};
+
+/**
+ * sdw_impl_def_intr_mask: Implementation defined interrupt mask for Slave.
+ *	Slave Ports can be sink or source or bidirectional. If Slave has
+ *	bidirectional Ports, implementation defined interrupt mask should be
+ *	provided for both directions. Bus driver programs the mask in the
+ *	register before Port prepare based on Port configured as a sink or
+ *	source.
+ *
+ * @portn_mask: Implementation defined mask for Slave Ports other than port0.
+ *	Mask bits are exactly same as defined in MIPI Spec 1.1. Array size
+ *	shall be same as number of Ports in Slave. For bidirectional ports,
+ *	masks can be different for Source and Sink ports.
+ *
+ * @control_port_mask: Implementation defined interrupt mask for control
+ *	Port. Mask Bits are exactly same as defined in MIPI Spec 1.1.
+ *
+ * @port0_mask: Implementation defined interrupt mask for Data Port 0.
+ *	Mask bits are exactly same as defined in MIPI Spec 1.1.
+ */
+struct sdw_impl_def_intr_mask {
+	struct sdw_portn_intr_mask *portn_mask[SDW_MAX_PORT_DIRECTIONS];
+	u8 control_port_mask;
+	u8 port0_mask;
+};
+
+/**
+ * sdw_slave_bra_caps: Bulk Register Access (BRA) Capabilities of the Slave.
+ *	This list all the fields listed in MIPI DisCo Spec.
+ *
+ * @max_bus_freq: Maximum bus frequency of this mode, in Hz
+ * @min_bus_freq: Minimum bus frequency of this mode, in Hz when using
+ *	min-max properties, all values in the defined range are allowed. Use
+ *	the config list in the next field if only discrete values are
+ *	supported.
+ *
+ * @num_bus_freq: Number of discrete bus frequency configurations. Use of
+ *	max_ and min_ bus frequencies requires num_bus_freq to be zero.
+ *
+ * @bus_freq_buf: Array of bus frequency configs.
+ * @max_data_per_frame: Maximum Data payload, in bytes per frame. Excludes
+ *	header, CRC, footer. Maximum value defined by SoundWire protocol is
+ *	470 bytes.
+ *
+ * @min_us_between_transactions: Amount of delay, in microseconds,
+ *	required to be inserted between BRA transactions. Use if Slave needs
+ *	idle time between BRA transactions.
+ *
+ * @max_bandwidth: Maximum bandwidth (in bytes/s) that can be written/read
+ *	(header, CRCs, footer excluded).
+ *
+ * @mode_block_alignment: Size of basic block in bytes. The Data payload
+ *	size shall be an integer multiple of this basic block size.
+ *	padding/repeating of the same value is required for transactions
+ *	smaller than this basic block size.
+ */
+struct sdw_slave_bra_caps {
+	unsigned int max_bus_freq;
+	unsigned int min_bus_freq;
+	unsigned int num_bus_freq;
+	unsigned int *bus_freq_buf;
+	unsigned int max_data_per_frame;
+	unsigned int min_us_between_transactions;
+	unsigned int max_bandwidth;
+	unsigned int mode_block_alignment;
+};
+
+/**
+ * sdw_slave_dp0_caps: Capabilities of the Data Port 0 of Slave. All fields
+ *	are listed in order of the SoundWire DisCo Spec. Name of the fields
+ *	are altered to follow Linux convention. All the fields which are
+ *	required by bus driver but not present in DisCo Spec are listed at
+ *	the end of the structure.
+ *
+ * @max_bps: Maximum bits per sample supported by Port. This is same as word
+ *	length in SoundWire Spec.
+ *
+ * @min_bps: Minimum bits per sample supported by Port. This is same as word
+ *	length in SoundWire Spec.
+ *
+ * @num_bps: Array size of the buffer containing the supported bits per sample
+ *	configuration. The use of max_ and min_ bps requires num_bps to be
+ *	zero
+ *
+ * @bps_buf: Array containing supported sample sizes.
+ * @bra_use_flow_control: Flow control is required or not for bra block
+ *	transfer.
+ *
+ * @impl_def_response: If True (nonzero), implementation-defined response is
+ *	supported. This information may be used by a device driver to
+ *	request that a generic bus driver forwards the response to the
+ *	client device driver.
+ *
+ * @bra_initiator: Slave BRA initiator role supported
+ * @prepare_ch: Type of channel prepare scheme. Simplified or Normal channel
+ *	prepare.
+ *
+ * @imp_def_intr_mask: Implementation defined interrupt mask for DP0 Port.
+ *	These interrupts will be enabled by bus driver.
+ *
+ * @impl_def_bpt: If True (nonzero), implementation-defined. Payload Type is
+ *	supported. This information is used to bypass the BRA protocol and
+ *	may only be of interest when a device driver is aware of the
+ *	Capabilities of the Master and Slave devices devices. This is not
+ *	supported as of now.
+ *
+ * @bra_cap: BRA capabilities of the Slave. Currently only one mode is
+ *	supported.
+ */
+struct sdw_slave_dp0_caps {
+	unsigned int max_bps;
+	unsigned int min_bps;
+	unsigned int num_bps;
+	unsigned int *bps_buf;
+	bool bra_use_flow_control;
+	bool impl_def_response;
+	bool bra_initiator;
+	enum sdw_ch_prepare_mode prepare_ch;
+	unsigned int imp_def_intr_mask;
+	bool impl_def_bpt;
+	struct sdw_slave_bra_caps bra_cap;
+};
+
+/**
+ * sdw_slave_caps: Capabilities of the SoundWire Slave. This is the
+ *	structure for Slave driver to register its capabilities to bus
+ *	driver. This structure is based on the MIPI DisCo Spec for
+ *	registering Slave capabilities. It lists all the capabilities
+ *	required by bus driver from DisCo Spec. It omits few of the
+ *	capabilities from DisCo Spec, which bus driver doesn't require.
+ *	Some of the DisCo Slave properties also provides information about
+ *	Slave containing SoundWire controller and number of Master
+ *	interfaces. This is not required by bus driver as Slave properties.
+ *
+ * @wake_up_unavailable: Slave is not capable of waking up the Master by
+ *	driving the data line to High.
+ *
+ * @test_mode: Slave supports test modes.
+ * @clk_stp1_mode: Clock stop 1 mode supported by this Slave. SoundWire
+ *	specification requires all compliant Slaves to support Clock Stop
+ *	mode 0.
+ *
+ * @simple_clk_stp_prep: Simplified clock stop prepare supported.
+ * @clk_stp_prep_timeout: A slave-specific timeout in milliseconds. This
+ *	value indicates the worst-case latency of the Clock Stop Prepare
+ *	state machine transitions. After receiving a successful clock stop
+ *	prepare/de-prepare command, the Slave should complete the operation
+ *	before the expiration of the timeout. Software may poll for
+ *	completion periodically or wait for this timeout value. If the
+ *	requested action has not completed at the end of this timeout,
+ *	software shall interpret this as an error condition.
+ *
+ * @clk_stp_prep_hard_reset_behavior: When set, the Slave keeps its prepare
+ *	status after exit from clock stop mode1 and needs to be de-prepared
+ *	by software. Otherwise, the slave does not need a de-prepare command
+ *	upon resuming from clock stop mode1.
+ *
+ * @highphy_capable: Slave is highphy_capable or not? Currently highphy is
+ *	not supported in bus driver.
+ *
+ * @paging: Paging registers supported for Slave?
+ * @bank_delay_support: Bank switching delay for Slave
+ * @port_15_read_behavior: Slave behavior when the Master attempts a Read to
+ *	the Port15 alias
+ *	0: Command_Ignored
+ *	1: Command_OK, Data is OR of all registers
+ *
+ * @scp_impl_def_intr_mask: Implementation defined interrupt mask for Slave
+ *	control port
+ *
+ * @lane_control_support: Lane control support for Slave
+ * @dp0_present: DP0 is supported by Slave.
+ * @dp0_caps: Data Port 0 Capabilities of the Slave.
+ * @num_ports: Number of SoundWire Data ports present. The representation
+ *	assumes contiguous Port numbers starting at 1.
+ *
+ * @dpn_caps: Capabilities of the SoundWire Slave ports. This includes
+ *	both Source and Sink Ports.
+ *
+ * @num_src_ports: Number of Source ports present on Slave. If Slave has
+ *	bidirectional ports, it is counted as both Source and Sink ports.
+ *	E.g. if Slave has two bidirectional ports, num_src_ports in
+ *	capabilities shall be 2. This is used by bus driver to get the port
+ *	capabilities based on port configured as Source or Sink for the
+ *	particular stream.
+ *
+ * @num_sink_ports: Number of Sink ports present on Slave. If Slave has
+ *	bidirectional ports, it is counted as both Source and Sink ports.
+ *	E.g. if Slave has two bidirectional ports, num_sink_ports in
+ *	capabilities shall be 2. This is used by bus driver to get the port
+ *	capabilities based on port configured as Source or Sink for the
+ *	particular stream.
+ *
+ * @num_ports: Total number of ports on the Slave. E.g. If Slave has 2
+ *	bidirectional ports and 2 source ports and 2 sink ports, total
+ *	number of ports reported to bus driver shall be 6.
+ */
+struct sdw_slave_caps {
+	bool wake_up_unavailable;
+	bool test_mode;
+	bool clk_stp1_mode;
+	bool simple_clk_stp_prep;
+	unsigned int clk_stp_prep_timeout;
+	bool clk_stp_prep_hard_reset_behavior;
+	bool highphy_capable;
+	bool paging;
+	bool bank_delay_support;
+	unsigned int port_15_read_behavior;
+	u8 scp_impl_def_intr_mask;
+	bool lane_control_support;
+	bool dp0_present;
+	struct sdw_slave_dp0_caps *dp0_caps;
+	unsigned int num_src_ports;
+	unsigned int num_sink_ports;
+	struct sdw_dpn_caps *dpn_caps[SDW_MAX_PORT_DIRECTIONS];
+	unsigned int num_ports;
+};
+
+/**
+ * sdw_portn_intr_stat: Implementation defined interrupt status for Slave
+ *	Ports other than Data Port 0
+ *
+ * @num: Port number for which status is reported.
+ * @status: status of the implementation defined interrupts.
+ */
+struct sdw_portn_intr_stat {
+	unsigned int num;
+	u8 status;
+};
+
+/**
+ * sdw_impl_def_intr_stat: Implementation defined interrupt status for
+ *	Slave.
+ *
+ * @num_ports: Number of ports in Slave other than Data Port 0.
+ * @portn_stat: Implementation defined status for Slave ports other than
+ *	port0. Mask bits are exactly same as defined in MIPI Spec 1.1. Array
+ *	size is same as number of ports in Slave.
+ *
+ * @control_port_stat: Implementation defined interrupt status mask for
+ *	control port. Mask Bits are exactly same as defined in MIPI Spec
+ *	1.1.
+ *
+ * @port0_stat: Implementation defined interrupt status mask for Data
+ *	Port 0. Mask bits are exactly same as defined in MIPI Spec 1.1.
+ */
+struct sdw_impl_def_intr_stat {
+	unsigned int num_ports;
+	struct sdw_portn_intr_stat *portn_stat;
+	u8 control_port_stat;
+	u8 port0_stat;
+};
+
+/**
+ * sdw_slave_priv: Slave device private structure. This is used by bus
+ *	driver and need not to be used by Slave driver.
+ *
+ * @name: Name of the driver to use with the device.
+ * @addr: Slave logical and dev_id address structures. This is non-null
+ *	for all the Slave which are enumerated.
+ *
+ * @driver: Slave's driver, pointer to access routine.
+ * @node: Node to add the Slave to the list of Slave devices physically
+ *	connected to and managed by same Master.
+ *
+ * @port_ready: Port ready completion flag for each Port of the Slave. This
+ *	field is not used for simplified channel prepare.
+ *
+ * @caps: Slave capabilities.
+ * @slave_cap_updated: Did Slave device driver updated Slave capabilities to
+ *	bus. This is used by bus driver for Slave configurations like
+ *	ClockStopMode etc.
+ *
+ * @dev_id: 6-byte unique device identification.
+ */
+struct sdw_slave_priv {
+	char name[SOUNDWIRE_NAME_SIZE];
+	struct sdw_slave_addr *addr;
+	struct sdw_slave_driver *driver;
+	struct list_head node;
+	struct completion *port_ready;
+	struct sdw_slave_caps caps;
+	bool slave_cap_updated;
+	unsigned int dev_id[SDW_NUM_DEV_ID_REGISTERS];
+};
+
+/**
+ * sdw_slave: Represents SoundWire Slave device (similar to 'i2c_client' on
+ *	I2C).
+ *
+ * @dev: Driver model representation of the device.
+ * @mstr: SoundWire Master, instance physically connected to Slave.
+ * @link_id: SoundWire Master link_id to which this Slave is connected. This
+ *	is required by Slave driver to get the ACPI or any platform specific
+ *	configuration based on dev_id and link_id to which Slave is
+ *	connected.
+ *
+ * @dev_num: DeviceNumber of the Slave, assigned by bus driver.
+ * @priv: Bus driver private data structure, Slave device driver should not
+ *	use it.
+ */
+struct sdw_slave {
+	struct device dev;
+	struct sdw_master *mstr;
+	unsigned int link_id;
+	unsigned int dev_num;
+	struct sdw_slave_priv priv;
+};
+#define to_sdw_slave(d) container_of(d, struct sdw_slave, dev)
+
+/**
+ * sdw_slave_driver: Manage SoundWire Slave device driver.
+ *
+ * @driver_type: To distinguish between Master and Slave driver. Driver
+ *	should set this based on its controlling Master or Slave device.
+ *
+ * @probe: Binds this driver to a SoundWire Slave device (in Linux Device
+ *	model sense).
+ *
+ * @remove: Unbinds this driver from the SoundWire Slave.
+ * @shutdown: Standard shutdown callback used during power down/halt.
+ * @suspend: Standard suspend callback used during system suspend.
+ * @resume: Standard resume callback used during system resume.
+ * @driver: Generic driver structure, according to driver model.
+ * @slave_irq: When interrupts are enabled, the Master driver is notified of
+ *	alert conditions through the PREQ mechanism and fetches the Slave
+ *	status. Bus driver handles all interrupts specified in the
+ *	SoundWire specification, such as bus clash, parity or Port test
+ *	fail. Slave driver handles all implementation-defined interrupts,
+ *	such as jack detect and pll-locked. If the slave_irq callback is
+ *	defined, the bus driver invokes it and lets the Slave driver handle
+ *	the status. Bus driver ACKs all interrupts including implementation
+ *	defined interrupts once Slave handles it. This is mandatory if Slave
+ *	is supporting implementation defined interrupts.
+ *
+ * @pre_bus_config: Slave callback function to let Slave configure
+ *	implementation defined registers prior to any bus configuration
+ *	changes. Bus configuration changes will be signaled by a bank switch
+ *	initiated by the bus driver once all Slaves drivers have performed
+ *	their imp-def configuration sequence (if any). If this callback is
+ *	not implemented the bus driver will assume the Slave can tolerate
+ *	bus configurations changes at any time. This is optional based on
+ *	Slave implementation.
+ *
+ * @port_prep: Slave driver callback to allow Slave Port to be
+ *	prepared/de-prepared by configuring impl defined register as part of
+ *	Port prepare state machine. This fn is called before and after
+ *	DPn_Prepare ctrl is written based on "sdw_port_prep_ops" ops. Post
+ *	prepare is called after Port is prepared/de-prepared.
+ *
+ * @status_change_event: Slave device status change event to Slave driver.
+ *	Bus driver calls this callback to Slave driver every time there is
+ *	status change of the Slave. Slave device use this to make sure that
+ *	its in attached state after resuming, before doing any register
+ *	access. This is mandatory callback to be provided by Slave to update
+ *	the status change events.
+ *
+ * @pre_clk_stop_prep: Common Slave driver callback to prepare for clock
+ *	stop and deprepare after clock is resumed - depending upon flag
+ *	value.  This is called before prepare bit is set for clock stop,
+ *	while in resume case its called before prepare bit is reset. This is
+ *	optional based on Slave implementation.
+ *
+ * @post_clk_stop_prep: Common Slave driver call back for Slave operations
+ *	to be done after clock stop prepare is done for clock stop and after
+ *	clock stop de-prepare is done after clock resume. This is called
+ *	after prepare is done for clock stop and deprepare is done for clock
+ *	resume. This is optional based on Slave implementation.
+ *
+ * @get_dyn_clk_stp_mod: Get the clock stop mode from Slave dynamically
+ *	before preparing Slave for prepare. Slave registers the ClockStop
+ *	capability as part of registering Slave capability. This API
+ *	provides Slave with dynamically updating the ClockStop mode based on
+ *	use case. If this is not defined by Slave, bus driver will use
+ *	static capability for ClockStop Mode registered to bus driver as
+ *	part of Slave capabilities. This is optional based on Slave
+ *	implementation.
+ *
+ * @id_table: List of SoundWire Slaves supported by this driver. Multiple
+ *	Slaves from the same vendor may be handled by the same Slave driver
+ *	as long as hardware differences are handled within this Slave driver
+ *	(same as for I2S codecs).
+ */
+struct sdw_slave_driver {
+	enum sdw_driver_type driver_type;
+	struct device_driver driver;
+	int (*probe)(struct sdw_slave *slave, const struct sdw_slave_id *);
+	int (*remove)(struct sdw_slave *slave);
+	void (*shutdown)(struct sdw_slave *slave);
+	int (*suspend)(struct sdw_slave *slave);
+	int (*resume)(struct sdw_slave *slave);
+	int (*slave_irq)(struct sdw_slave *slave,
+		struct sdw_impl_def_intr_stat *intr_stat);
+	int (*pre_bus_config)(struct sdw_slave *slave,
+			struct sdw_bus_params *params);
+	int (*port_prep)(struct sdw_slave *slave,
+			struct sdw_prepare_ch *prepare_ch,
+			enum sdw_port_prep_ops pre_ops);
+	int (*status_change_event)(struct sdw_slave *slave,
+			enum sdw_slave_status status);
+	int (*pre_clk_stop_prep)(struct sdw_slave *slave,
+			enum sdw_clk_stop_mode mode, bool prep);
+	int (*post_clk_stop_prep)(struct sdw_slave *slave,
+			enum sdw_clk_stop_mode mode, bool prep);
+	enum sdw_clk_stop_mode (*get_dyn_clk_stp_mod)(struct sdw_slave *slave);
+	const struct sdw_slave_id *id_table;
+};
+#define to_sdw_slave_driver(d) container_of(d, struct sdw_slave_driver, driver)
+
+/**
+ * snd_sdw_slave_driver_register: SoundWire Slave driver registration with
+ *	bus. This API will register the Slave driver with the SoundWire bus.
+ *	It is typically called from the driver's module-init function.
+ *
+ * @driver: Driver to be associated with Slave.
+ * @owner: Module owner, generally THIS module.
+ */
+int snd_sdw_slave_driver_register(struct sdw_slave_driver *driver,
+					struct module *owner);
+
+/**
+ * snd_sdw_slave_register_caps: Register Slave device capabilities to the
+ *	bus driver. Since bus driver handles bunch of Slave register
+ *	programming it should be aware of Slave device capabilities. Slave
+ *	device is attached to bus based on enumeration. Once Slave driver is
+ *	attached to device and probe of Slave driver is called on device and
+ *	driver binding, Slave driver should call this function to register
+ *	its capabilities to bus. This should be the very first function to
+ *	bus driver from Slave driver once Slave driver is registered and
+ *	probed.
+ *
+ * @slave: SoundWire Slave handle.
+ * @cap: Slave caps to be registered to bus driver.
+ */
+int snd_sdw_slave_register_caps(struct sdw_slave *slave,
+			struct sdw_slave_caps *cap);
+
+/**
+ * snd_sdw_slave_set_intr_mask: Set the implementation defined interrupt
+ *	mask. Slave sets the implementation defined interrupt mask as part
+ *	of registering Slave capabilities. Slave driver can also modify
+ *	implementation defined interrupt dynamically using below function.
+ *
+ * @slave: SoundWire Slave handle for which interrupt needs to be enabled.
+ * @intr_mask: Implementation defined interrupt mask.
+ */
+int snd_sdw_slave_set_intr_mask(struct sdw_slave *slave,
+		struct sdw_impl_def_intr_mask *intr_mask);
+
+/**
+ * sdw_slave_unregister_driver: Undo effects of sdw_slave_driver_register.
+ *
+ * @drv: SoundWire Slave driver to be unregistered.
+ */
+static inline void sdw_slave_unregister_driver(struct sdw_slave_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+
+static inline struct sdw_master *sdw_slave_to_master(struct sdw_slave *slv)
+{
+	return slv->mstr;
+}
+
+static inline void *sdw_slave_get_drvdata(const struct sdw_slave *slv)
+{
+	return dev_get_drvdata(&slv->dev);
+}
+
+static inline void sdw_slave_set_drvdata(struct sdw_slave *slv, void *data)
+{
+	dev_set_drvdata(&slv->dev, data);
+}
+
+#endif /*  _LINUX_SDW_SLAVE_H */
-- 
1.7.9.5
