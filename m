From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v3 0/8] slimbus: fixes and some helpers
Date: Fri, 25 May 2018 15:36:10 +0100
Message-ID: <20180525143618.820-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Greg,

Here is set of patches for slimbus, there are 6 fixes and
two helper functions.
Most of these issues were found while testing QCOM NGD SLIMBus
controller with WCD9335 codec.

Changes since v2 (https://lkml.org/lkml/2018/5/17/251)
- removed unnecessary changes in slim_prepare_txn patch

thanks,
Srini

Srinivas Kandagatla (8):
  slimbus: core: rearrange slim_eaddr structure
  slimbus: core: add need_tid flag to slim_msg_txn
  slimbus: messaging: pass correct wbuf
  slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
  slimbus: messaging: initialize completion correctly
  slimbus: qcom: remove redundant depends in Kconfig
  slimbus: messaging: add slim_prepare_txn() helper function
  slimbus: core: add of_slim_device_get() helper

 drivers/slimbus/Kconfig     |  1 -
 drivers/slimbus/core.c      | 39 ++++++++++++++++++++
 drivers/slimbus/messaging.c | 89 ++++++++++++++++++++++++++++++---------------
 drivers/slimbus/slimbus.h   |  4 ++
 include/linux/slimbus.h     | 14 ++++---
 5 files changed, 110 insertions(+), 37 deletions(-)

-- 
2.16.2
