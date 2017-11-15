From: srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Subject: [PATCH v7 00/13] Introduce framework for SLIMbus device driver
Date: Wed, 15 Nov 2017 14:10:30 +0000
Message-ID: <20171115141043.29202-1-srinivas.kandagatla@linaro.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
Cc: sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, bp-l3A5Bk7waGM@public.gmane.org, poeschel-Xtl8qvBWbHwb1SvskN2V4Q@public.gmane.org, treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, andreas.noever-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mathieu.poirier-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, daniel-/w4YWyX8dFk@public.gmane.org, jkosina-AlSwsSmVLrQ@public.gmane.org, sharon.dvir1-MQgwKvJRKlGYZoqfULhbRA@public.gmane.org, joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org, davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, james.hogan-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, michael.opdenacker-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>

Thanks for everyone who reviewed v6 patchset, here is v7 with
review comments addressed.

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

v6: https://lwn.net/Articles/735693/

Changes from v6 to v7:
* Various improvements in commenting style and kerneldoc
 suggested by various reviewers.
* Removed usage of semaphores.
* Split patches into more reviewable sizes.
* Move buffer management into the controller driver.
* use IDR for TID transactions.
* use IDA for controller ids.
* Remove lot of redundant code.
* remove framer booted call for now, which can be added in future.
* Added slim_readb/writeb and slim_read/write apis for 
simplified value element interface. Inspired by Soundwire patches.
* Added slim device state so the the drivers which are 
probed after the device is announced, can get device state.
* Lots of code cleanup.
* move summary to .rst format.
* move from callbacks to completions for async reads.
* split slimbus.h into device and controller specific parts.

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
 .../devicetree/bindings/slimbus/slim-qcom-ctrl.txt |  43 ++
 Documentation/driver-api/slimbus/index.rst         |  15 +
 Documentation/driver-api/slimbus/summary.rst       | 108 +++
 MAINTAINERS                                        |   8 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/base/regmap/Kconfig                        |   4 +
 drivers/base/regmap/Makefile                       |   1 +
 drivers/base/regmap/regmap-slimbus.c               |  95 +++
 drivers/slimbus/Kconfig                            |  22 +
 drivers/slimbus/Makefile                           |   9 +
 drivers/slimbus/core.c                             | 500 +++++++++++++
 drivers/slimbus/messaging.c                        | 448 ++++++++++++
 drivers/slimbus/qcom-ctrl.c                        | 791 +++++++++++++++++++++
 drivers/slimbus/sched.c                            | 128 ++++
 drivers/slimbus/slimbus.h                          | 276 +++++++
 include/linux/mod_devicetable.h                    |  13 +
 include/linux/regmap.h                             |  18 +
 include/linux/slimbus.h                            | 167 +++++
 20 files changed, 2699 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/slimbus/bus.txt
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-qcom-ctrl.txt
 create mode 100644 Documentation/driver-api/slimbus/index.rst
 create mode 100644 Documentation/driver-api/slimbus/summary.rst
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
