From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 0/8] slimbus: fixes and some helpers
Date: Thu, 17 May 2018 09:58:42 +0100
Message-ID: <20180517085850.14276-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
List-Id: alsa-devel@alsa-project.org

Hi Greg,

Here is set of patches for slimbus, there are 6 fixes and
two helper functions.
Most of these issues were found while testing QCOM NGD SLIMBus
controller with WCD9335 codec.


Changes since v1 (https://lkml.org/lkml/2018/5/16/436):
- add need_tid to documentation reported by 0 day test.
- remove redundant kconfig for qcom slim controller.

thanks,
Srini

Srinivas Kandagatla (8):
  slimbus: core: add of_slim_device_get() helper
  slimbus: core: rearrange slim_eaddr structure
  slimbus: core: add need_tid flag to slim_msg_txn
  slimbus: messaging: pass correct wbuf
  slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
  slimbus: messaging: add slim_prepare_txn() helper function
  slimbus: messaging: initialize completion correctly
  slimbus: qcom: remove redundant depends in Kconfig

 drivers/slimbus/Kconfig     |  1 -
 drivers/slimbus/core.c      | 39 +++++++++++++++++++
 drivers/slimbus/messaging.c | 92 ++++++++++++++++++++++++++++++---------------
 drivers/slimbus/qcom-ctrl.c |  7 +++-
 drivers/slimbus/slimbus.h   |  4 ++
 include/linux/slimbus.h     | 14 ++++---
 6 files changed, 119 insertions(+), 38 deletions(-)

-- 
2.16.2
