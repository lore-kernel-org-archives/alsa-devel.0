From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v4 0/5] slimbus: Add QCOM SLIMBus NGD driver
Date: Tue, 19 Jun 2018 17:12:56 +0100
Message-ID: <20180619161301.4556-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: robh+dt@kernel.org, kramasub@codeaurora.org, sdharia@quicinc.com, linux-kernel@vger.kernel.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

This patchset adds support to basic version of Qualcomm NGD SLIMBus
controller driver found SoCs from B family.

This controller is light-weight SLIMBus controller driver responsible for
communicating with slave HW directly over the bus using messaging
interface, and communicating with master component residing on ADSP
for bandwidth and data-channel management.

Some parts fot the work is derived from Qualcomm downstream kernels
and intial work from
Karthikeyan Ramasubramanian <kramasub@codeaurora.org> and
Sagar Dharia <sdharia@codeaurora.org>

Tested this patchset with v4.18-rc1 on DB820c with WCD9335 codec for playback
and Craig tested on msm8974 with wcd9320 codec for register read/writes.

I have pushed my working branch to [1] incase someone want to try.

[1]:https://git.linaro.org/people/srinivas.kandagatla/linux.git/log/?h=slimbus-ngd

Changes since v4:
- Moved all dependency patches to this patchset.
- replaced slim_prepare_txn with slim_alloc/free_txn_tid()
- fixed runtime pm issue for ngd device.

Srinivas Kandagatla (5):
  slimbus: core: add of_slim_device_get() helper
  slimbus: core: rearrange slim_eaddr structure
  slimbus: messaging: add slim_alloc/free_txn_tid()
  slimbus: ngd: dt-bindings: Add slim ngd dt bindings
  slimbus: ngd: Add qcom SLIMBus NGD driver

 .../bindings/slimbus/slim-ngd-qcom-ctrl.txt        |   84 ++
 drivers/slimbus/Kconfig                            |   11 +
 drivers/slimbus/Makefile                           |    3 +
 drivers/slimbus/core.c                             |   39 +
 drivers/slimbus/messaging.c                        |   74 +-
 drivers/slimbus/qcom-ngd-ctrl.c                    | 1381 ++++++++++++++++++++
 drivers/slimbus/slimbus.h                          |   10 +
 include/linux/slimbus.h                            |   14 +-
 8 files changed, 1588 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/slimbus/slim-ngd-qcom-ctrl.txt
 create mode 100644 drivers/slimbus/qcom-ngd-ctrl.c

-- 
2.16.2
