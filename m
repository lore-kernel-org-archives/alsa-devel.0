From: srinivas.kandagatla@linaro.org
Subject: [PATCH v10 00/13] Introduce framework for SLIMbus device driver
Date: Mon, 11 Dec 2017 23:42:54 +0000
Message-ID: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
Cc: sdharia@codeaurora.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jonathan Corbet <corbet@lwn.net>, pombredanne@nexb.com, j.neuschaefer@gmx.net, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

SLIMbus (Serial Low Power Interchip Media Bus) is a specification
developed by MIPI (Mobile Industry Processor Interface) alliance.
SLIMbus is a 2-wire implementation, which is used to communicate with
peripheral components like audio-codec.
SLIMbus uses Time-Division-Multiplexing to accommodate multiple data
channels, and control channel. Control channel has messages to do
device-enumeration, messages to send/receive control-data to/from
SLIMbus devices, messages for port/channel management, and messages to
do bandwidth allocation.
Framework is introduced to support  multiple instances of the bus
(1 controller per bus), and multiple slave devices per controller.
SPI and I2C frameworks, and comments from last time when I submitted
the patches were referred-to while working on this framework.

These patchsets introduce device-management, OF helpers, and messaging
APIs, controller driver for Qualcomm's SLIMbus controller, and
clock-pause feature for entering/exiting low-power mode for SLIMbus.
Framework patches to do channel, port and bandwidth
management are work-in-progress and will be sent out once these
initial patches are accepted.

These patchsets were tested on IFC6410 board with Qualcomm APQ8064
processor using the controller driver, and a WCD9310 codec.

v9: https://lkml.org/lkml/2017/12/7/289

Changes from v9 to v10:
* Added kernel-doc reference into slimbus driver api doc suggested by
 Jonathan Corbet

Sagar Dharia (9):
  Documentation: Add SLIMbus summary
  dt-bindings: Add SLIMbus bindings
  slimbus: Add SLIMbus bus type
  slimbus: core: Add slim controllers support
  slimbus: Add messaging APIs to slimbus framework
  slimbus: Add support for 'clock-pause' feature
  dt-bindings: Add qcom slimbus controller bindings
  slimbus: qcom: Add Qualcomm Slimbus controller driver
  slimbus: qcom: Add runtime-pm support using clock-pause

Srinivas Kandagatla (4):
  slimbus: core: add support to device tree helper
  regmap: add SLIMbus support
  slimbus: core: add common defines required for controllers
  MAINTAINERS: Add SLIMbus maintainer

 Documentation/devicetree/bindings/slimbus/bus.txt  |  50 ++
 .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt |  39 ++
 Documentation/driver-api/index.rst                 |   1 +
 Documentation/driver-api/slimbus.rst               | 127 ++++
 MAINTAINERS                                        |   8 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/base/regmap/Kconfig                        |   4 +
 drivers/base/regmap/Makefile                       |   1 +
 drivers/base/regmap/regmap-slimbus.c               |  80 +++
 drivers/slimbus/Kconfig                            |  23 +
 drivers/slimbus/Makefile                           |  10 +
 drivers/slimbus/core.c                             | 480 +++++++++++++
 drivers/slimbus/messaging.c                        | 330 +++++++++
 drivers/slimbus/qcom-ctrl.c                        | 750 +++++++++++++++++++++
 drivers/slimbus/sched.c                            | 121 ++++
 drivers/slimbus/slimbus.h                          | 261 +++++++
 include/linux/mod_devicetable.h                    |  13 +
 include/linux/regmap.h                             |  18 +
 include/linux/slimbus.h                            | 164 +++++
 20 files changed, 2483 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
 create mode 100644 Documentation/driver-api/slimbus.rst
 create mode 100644 drivers/base/regmap/regmap-slimbus.c
 create mode 100644 drivers/slimbus/Kconfig
 create mode 100644 drivers/slimbus/Makefile
 create mode 100644 drivers/slimbus/core.c
 create mode 100644 drivers/slimbus/messaging.c
 create mode 100644 drivers/slimbus/qcom-ctrl.c
 create mode 100644 drivers/slimbus/sched.c
 create mode 100644 drivers/slimbus/slimbus.h
 create mode 100644 include/linux/slimbus.h

-- 
2.15.0
