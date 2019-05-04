From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [RFC PATCH 0/7] soundwire: add sysfs and debugfs support
Date: Fri,  3 May 2019 20:00:23 -0500
Message-ID: <20190504010030.29233-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

This patchset is not fully-tested and is not a candidate for any
merge. Since I am not very comfortable with sysfs and debugfs support,
and I am not the initial author for this code, I could use feedback
from smarter people than me. 

This series is intented to be applied on top of the 'soundwire:
corrections to ACPI and DisCo properties' series

Parts of this code was initially written by my Intel colleagues Vinod
Koul, Sanyog Kale, Shreyas Nc and Hardik Shah, who are either no
longer with Intel or no longer involved in SoundWire development. When
relevant, I explictly added a note in commit messages to give them
credit for their hard work, but I removed their signed-off-by tags to
avoid email bounces and avoid spamming them forever with SoundWire
patches.

The sysfs parts essentially expose the values of MIPI DisCo
properties. My contribution here was mainly to align with the
specification, a number of properties from the Intel internal code
were missing. I also split the code to make sure the same attribute
names can be used at different levels, as described in the spec.

One of the main questions I have is whether there is really a need to
add new devices, or if the attributes can be added to the *existing*
ones. For example, the sysfs hierarchy for the SoundWire 0 master
shows as:

/sys/bus/acpi/devices/PRP00001:00/int-sdw.0# ls sdw*
'sdw:0:25d:700:0:0':
bank_delay_support  hda_reg           paging_support           source_ports
ch_prep_timeout     high_PHY_capable  power                    src-dp2
clk_stop_mode1      index_reg         reset_behave             src-dp4
clk_stop_timeout    master_count      simple_clk_stop_capable  subsystem
dp0                 mipi_revision     sink-dp1                 test_mode_capable
driver              modalias          sink-dp3                 uevent
firmware_node       p15_behave        sink_ports               wake_capable

'sdw:0:25d:701:0:0':
bank_delay_support  high_PHY_capable  paging_support           source_ports
ch_prep_timeout     master_count      power                    subsystem
clk_stop_mode1      mipi_revision     reset_behave             test_mode_capable
clk_stop_timeout    modalias          simple_clk_stop_capable  uevent
firmware_node       p15_behave        sink_ports               wake_capable

'sdw-master:0':
clk_stop_modes     default_col         dynamic_frame  power      uevent
clock_frequencies  default_frame_rate  err_threshold  revision
clock_gears        default_row         max_clk_freq   subsystem

For the first two Slaves, this results in pretend-devices being added
below each master, the actual Slave devices are children of the
PRP00001 devices, so here we add a bit of complexity. Likewise, the
'sdw-master:0' is a pretend-device whose purpose is only to expose
property values. Is this the recommended direction? Or should all the
sysfs properties be added to the devices exposed by ACPI?

The debugfs part is mainly to dump the Master and Slave registers, as
well as the Intel-specific parts. One of the main changes from the
previous code was to harden the code with scnprintf

Feedback welcome.
~Pierre

Pierre-Louis Bossart (7):
  soundwire: Add sysfs support for master(s)
  soundwire: add Slave sysfs support
  ABI: testing: Add description of soundwire master sysfs files
  ABI: testing: Add description of soundwire slave sysfs files
  soundwire: add debugfs support
  soundwire: cadence_master: add debugfs register dump
  soundwire: intel: add debugfs register dump

 .../ABI/testing/sysfs-bus-soundwire-master    |  21 +
 .../ABI/testing/sysfs-bus-soundwire-slave     |  85 ++++
 drivers/soundwire/Makefile                    |   4 +-
 drivers/soundwire/bus.c                       |  13 +
 drivers/soundwire/bus.h                       |  30 ++
 drivers/soundwire/bus_type.c                  |   8 +
 drivers/soundwire/cadence_master.c            |  98 +++++
 drivers/soundwire/cadence_master.h            |   5 +
 drivers/soundwire/debugfs.c                   | 214 ++++++++++
 drivers/soundwire/intel.c                     | 115 ++++++
 drivers/soundwire/slave.c                     |   2 +
 drivers/soundwire/sysfs.c                     | 376 ++++++++++++++++++
 drivers/soundwire/sysfs_local.h               |  42 ++
 drivers/soundwire/sysfs_slave_dp0.c           | 112 ++++++
 drivers/soundwire/sysfs_slave_dpn.c           | 168 ++++++++
 include/linux/soundwire/sdw.h                 |  24 ++
 16 files changed, 1316 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-master
 create mode 100644 Documentation/ABI/testing/sysfs-bus-soundwire-slave
 create mode 100644 drivers/soundwire/debugfs.c
 create mode 100644 drivers/soundwire/sysfs.c
 create mode 100644 drivers/soundwire/sysfs_local.h
 create mode 100644 drivers/soundwire/sysfs_slave_dp0.c
 create mode 100644 drivers/soundwire/sysfs_slave_dpn.c

-- 
2.17.1
