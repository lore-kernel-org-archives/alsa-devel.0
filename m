From: srinivas.kandagatla@linaro.org
Subject: [Patch v6 0/7] Introduce framework for SLIMbus device drivers
Date: Fri,  6 Oct 2017 17:51:29 +0200
Message-ID: <20171006155136.4682-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, bp@suse.de, poeschel@lemonage.de, treding@nvidia.com, gong.chen@linux.intel.com, andreas.noever@gmail.com, alan@linux.intel.com, mathieu.poirier@linaro.org, daniel@ffwll.ch, jkosina@suse.cz, sharon.dvir1@mail.huji.ac.il, joe@perches.com, davem@davemloft.net, james.hogan@imgtec.com, michael.opdenacker@free-electrons.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kheitke@audience.com, linux-arm-msm@vger.kernel.org, arnd@arndb.de, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

It's been very long time since there was any activity on the slimbus patches,
Am currently working on getting Qualcomm DSP based audio working on top
of mainline. Slimbus is one of the major component for getting any analog
audio on QCOM SoC's. So am taking intiative to address the review
comments on the older patchset and send it.
I have tested this patch on IFC6410 board with wcd9310 codec.


SLIMbus (Serial Low Power Interchip Media Bus) is a specification
developed by MIPI (Mobile Industry Processor Interface) alliance.
SLIMbus is a 2-wire implementation, which is used to communicate with
peripheral components like audio-codec.
SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
channels, and control channel. Control channel has messages to do
device-enumeration, messages to send/receive control-data to/from
slimbus devices, messages for port/channel management, and messages to
do bandwidth allocation.
Framework is introduced to support  multiple instances of the bus
(1 controller per bus), and multiple slave devices per controller.
SPI and I2C frameworks, and comments from last time when I submitted
the patches were referred-to while working on this framework.

These patchsets introduce device-management, OF helpers, and messaging
APIs, controller driver for Qualcomm's slimbus controller, and
clock-pause feature for entering/exiting low-power mode for SLIMbus.
Framework patches to do channel, port and bandwidth
management are work-in-progress and will be sent out once these
initial patches are accepted.

These patchsets were tested on Qualcomm Snapdragon processor board
using the controller driver, and a test slave device.

Changes from V5 to V6:
* aligned slim_driver_register more like other buses, suggested by Arnd.
* removed boardinfo and add_device apis for now, suggested by Arnd
* Few namespace cleanups suggested by Masami
* merged of apis in to first patch as suggested by Arnd.
* slimbus clients "compatible" name space made much inline with USB
  and PCIE, suggested by Rob and Arnd.
* Removed memory allocations to controller drivers, as suggested by Arnd.
* Various bindings comments addressed as suggested by Mark and others.
* Added regmap interface so that codecs can write more generic code.
* Added MAINTAINER file.

Sagar Dharia (5):
  slimbus: Device management on SLIMbus
  slimbus: Add messaging APIs to slimbus framework
  slimbus: qcom: Add Qualcomm Slimbus controller driver
  slimbus: Add support for 'clock-pause' feature
  slimbus: qcom: Add runtime-pm support using clock-pause feature

Srinivas Kandagatla (2):
  regmap: add SLIMBUS support
  MAINTAINERS: Add SLIMbus maintainer

 Documentation/devicetree/bindings/slimbus/bus.txt  |  57 ++
 .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt |  43 ++
 Documentation/slimbus/summary                      | 109 ++++
 MAINTAINERS                                        |   8 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/base/regmap/Kconfig                        |   4 +
 drivers/base/regmap/Makefile                       |   1 +
 drivers/base/regmap/regmap-slimbus.c               |  89 +++
 drivers/slimbus/Kconfig                            |  20 +
 drivers/slimbus/Makefile                           |   8 +
 drivers/slimbus/slim-core.c                        | 725 +++++++++++++++++++++
 drivers/slimbus/slim-messaging.c                   | 509 +++++++++++++++
 drivers/slimbus/slim-qcom-ctrl.c                   | 714 ++++++++++++++++++++
 drivers/slimbus/slim-qcom.h                        |  64 ++
 drivers/slimbus/slim-sched.c                       | 126 ++++
 include/linux/mod_devicetable.h                    |  13 +
 include/linux/regmap.h                             |  18 +
 include/linux/slimbus.h                            | 512 +++++++++++++++
 19 files changed, 3023 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
 create mode 100644 Documentation/slimbus/summary
 create mode 100644 drivers/base/regmap/regmap-slimbus.c
 create mode 100644 drivers/slimbus/Kconfig
 create mode 100644 drivers/slimbus/Makefile
 create mode 100644 drivers/slimbus/slim-core.c
 create mode 100644 drivers/slimbus/slim-messaging.c
 create mode 100644 drivers/slimbus/slim-qcom-ctrl.c
 create mode 100644 drivers/slimbus/slim-qcom.h
 create mode 100644 drivers/slimbus/slim-sched.c
 create mode 100644 include/linux/slimbus.h

-- 
2.9.3
