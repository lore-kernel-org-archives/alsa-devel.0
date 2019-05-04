From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 4/7] ABI: testing: Add description of soundwire slave sysfs files
Date: Fri,  3 May 2019 20:00:27 -0500
Message-ID: <20190504010030.29233-5-pierre-louis.bossart@linux.intel.com>
References: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The description is directly derived from the MIPI DisCo specification.

Credits: this patch is based on an earlier internal contribution by
Vinod Koul, Sanyog Kale, Shreyas Nc and Hardik Shah

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../ABI/testing/sysfs-bus-soundwire-slave     | 85 +++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-slave

diff --git a/Documentation/ABI/testing/sysfs-bus-soundwire-slave b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
new file mode 100644
index 000000000000..db2a0177f68f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-soundwire-slave
@@ -0,0 +1,85 @@
+What:		/sys/bus/soundwire/devices/sdw:.../bank_delay_support
+		/sys/bus/soundwire/devices/sdw:.../ch_prep_timeout
+		/sys/bus/soundwire/devices/sdw:.../clk_stop_mode1
+		/sys/bus/soundwire/devices/sdw:.../clk_stop_timeout
+		/sys/bus/soundwire/devices/sdw:.../high_PHY_capable
+		/sys/bus/soundwire/devices/sdw:.../master_count
+		/sys/bus/soundwire/devices/sdw:.../mipi_revision
+		/sys/bus/soundwire/devices/sdw:.../p15_behave
+		/sys/bus/soundwire/devices/sdw:.../paging_support
+		/sys/bus/soundwire/devices/sdw:.../reset_behave
+		/sys/bus/soundwire/devices/sdw:.../simple_clk_stop_capable
+		/sys/bus/soundwire/devices/sdw:.../sink_ports
+		/sys/bus/soundwire/devices/sdw:.../source_ports
+		/sys/bus/soundwire/devices/sdw:.../test_mode_capable
+		/sys/bus/soundwire/devices/sdw:.../wake_capable
+
+Date:		May 2019
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+
+Description:	SoundWire Slave DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for SoundWire. They define various properties of the
+		SoundWire Slave and are used by the bus to configure
+		the Slave
+
+
+What:		/sys/bus/soundwire/devices/sdw:.../dp0/BRA_flow_controlled
+		/sys/bus/soundwire/devices/sdw:.../dp0/imp_def_interrupts
+		/sys/bus/soundwire/devices/sdw:.../dp0/max_word
+		/sys/bus/soundwire/devices/sdw:.../dp0/min_word
+		/sys/bus/soundwire/devices/sdw:.../dp0/simple_ch_prep_sm
+		/sys/bus/soundwire/devices/sdw:.../dp0/word_bits
+
+Date:		May 2019
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+
+Description:	SoundWire Slave Data Port-0 DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for the SoundWire. They define various properties of the
+		Data port 0 are used by the bus to configure the Data Port 0.
+
+
+What:		/sys/bus/soundwire/devices/sdw:.../src-dpN/block_pack_mode
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/channels
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/ch_combinations
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/ch_prep_timeout
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/imp_def_interrupts
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/max_async_buffer
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/max_ch
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/max_grouping
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/max_word
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/min_ch
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/min_word
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/modes
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/port_encoding
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/simple_ch_prep_sm
+		/sys/bus/soundwire/devices/sdw:.../src-dpN/words
+
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/block_pack_mode
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/channels
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/ch_combinations
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/ch_prep_timeout
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/imp_def_interrupts
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/max_async_buffer
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/max_ch
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/max_grouping
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/max_word
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/min_ch
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/min_word
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/modes
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/port_encoding
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/simple_ch_prep_sm
+		/sys/bus/soundwire/devices/sdw:.../sink-dpN/words
+
+Date:		May 2019
+
+Contact:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+
+Description:	SoundWire Slave Data Source/Sink Port-N DisCo properties.
+		These properties are defined by MIPI DisCo Specification
+		for SoundWire. They define various properties of the
+		Source/Sink Data port N and are used by the bus to configure
+		the Data Port N.
-- 
2.17.1
