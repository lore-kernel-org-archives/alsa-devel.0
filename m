From: srinivas.kandagatla@linaro.org
Subject: [PATCH v8 00/13] Introduce framework for SLIMbus
	device driver
Date: Thu, 30 Nov 2017 17:41:47 +0000
Message-ID: <20171130174200.6684-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f45.google.com (mail-wm0-f45.google.com [74.125.82.45])
 by alsa0.perex.cz (Postfix) with ESMTP id ECD3226698E
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 18:45:47 +0100 (CET)
Received: by mail-wm0-f45.google.com with SMTP id 9so14554847wme.4
 for <alsa-devel@alsa-project.org>; Thu, 30 Nov 2017 09:45:47 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: gregkh@linuxfoundation.org, broonie@kernel.org, alsa-devel@alsa-project.org
Cc: mark.rutland@arm.com, michael.opdenacker@free-electrons.com, poeschel@lemonage.de, srinivas.kandagatla@linaro.org, andreas.noever@gmail.com, arnd@arndb.de, vinod.koul@intel.com, bp@suse.de, devicetree@vger.kernel.org, james.hogan@imgtec.com, pawel.moll@arm.com, linux-arm-msm@vger.kernel.org, sharon.dvir1@mail.huji.ac.il, robh+dt@kernel.org, sdharia@codeaurora.org, alan@linux.intel.com, treding@nvidia.com, mathieu.poirier@linaro.org, jkosina@suse.cz, linux-kernel@vger.kernel.org, daniel@ffwll.ch, joe@perches.com, davem@davemloft.net
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks for everyone who reviewed v7 patchset, here is v8 with
review comments addressed.

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

These patchsets were tested on Qualcomm Snapdragon processor board
using the controller driver, and a test slave device.

v7: https://lwn.net/Articles/739150/

Changes from v7 to v8:
* Fixed few warnings from kerneldoc
* Few cosmetic fixes suggested by Vinod
* made SLIMbus string usage more consistent with spec
* made probe mandatory for slim device
* replaced explicit info and value element apis with
  more generic api
* made driver_data aligned 
* cleaned up qcom controller driver as suggested by
  Charles and Jonathan

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
 Documentation/driver-api/slimbus/index.rst         |  15 +
 Documentation/driver-api/slimbus/summary.rst       | 108 +++
 MAINTAINERS                                        |   8 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/base/regmap/Kconfig                        |   4 +
 drivers/base/regmap/Makefile                       |   1 +
 drivers/base/regmap/regmap-slimbus.c               |  89 +++
 drivers/slimbus/Kconfig                            |  22 +
 drivers/slimbus/Makefile                           |   9 +
 drivers/slimbus/core.c                             | 487 +++++++++++++
 drivers/slimbus/messaging.c                        | 336 +++++++++
 drivers/slimbus/qcom-ctrl.c                        | 756 +++++++++++++++++++++
 drivers/slimbus/sched.c                            | 128 ++++
 drivers/slimbus/slimbus.h                          | 268 ++++++++
 include/linux/mod_devicetable.h                    |  13 +
 include/linux/regmap.h                             |  18 +
 include/linux/slimbus.h                            | 171 +++++
 20 files changed, 2525 insertions(+)
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
