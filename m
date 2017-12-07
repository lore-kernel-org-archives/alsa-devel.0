From: srinivas.kandagatla@linaro.org
Subject: [PATCH v9 00/13] Introduce framework for SLIMbus
	device driver
Date: Thu,  7 Dec 2017 10:27:07 +0000
Message-ID: <20171207102720.21071-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f43.google.com (mail-wm0-f43.google.com [74.125.82.43])
 by alsa0.perex.cz (Postfix) with ESMTP id F32FE266E6C
 for <alsa-devel@alsa-project.org>; Thu,  7 Dec 2017 11:30:35 +0100 (CET)
Received: by mail-wm0-f43.google.com with SMTP id f206so11897098wmf.5
 for <alsa-devel@alsa-project.org>; Thu, 07 Dec 2017 02:30:35 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, alsa-devel@alsa-project.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, pombredanne@nexb.com, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Thanks for everyone who reviewed v8 patchset, here is v9 with
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

These patchsets were tested on IFC6410 board with Qualcomm APQ8064
processor using the controller driver, and a WCD9310 codec.

v8: https://lkml.org/lkml/2017/11/30/713

Changes from v8 to v9:
* Fixed Licence tags as suggested by Philippe Ombredanne and Greg KH
* Fixed typos spotted by Jonathan Neuschafer in documentation
* Added missing addtion in index.rst file spotted by Jonathan Neuschafer

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
 Documentation/driver-api/slimbus/index.rst         |  15 +
 Documentation/driver-api/slimbus/summary.rst       | 106 +++
 MAINTAINERS                                        |   8 +
 drivers/Kconfig                                    |   2 +
 drivers/Makefile                                   |   1 +
 drivers/base/regmap/Kconfig                        |   4 +
 drivers/base/regmap/Makefile                       |   1 +
 drivers/base/regmap/regmap-slimbus.c               |  80 +++
 drivers/slimbus/Kconfig                            |  23 +
 drivers/slimbus/Makefile                           |  10 +
 drivers/slimbus/core.c                             | 478 +++++++++++++
 drivers/slimbus/messaging.c                        | 328 +++++++++
 drivers/slimbus/qcom-ctrl.c                        | 748 +++++++++++++++++++++
 drivers/slimbus/sched.c                            | 119 ++++
 drivers/slimbus/slimbus.h                          | 259 +++++++
 include/linux/mod_devicetable.h                    |  13 +
 include/linux/regmap.h                             |  18 +
 include/linux/slimbus.h                            | 162 +++++
 21 files changed, 2465 insertions(+)
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
