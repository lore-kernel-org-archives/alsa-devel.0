From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/7] slimbus: fixes and some helpers
Date: Wed, 16 May 2018 12:36:35 +0100
Message-ID: <20180516113642.28136-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Hi Greg,

Here is set of patches for slimbus, there are 5 fixes and
two helper functions.
Most of these issues were found while testing QCOM NGD SLIMBus
controller with WCD9335 codec.

thanks,
Srini

Srinivas Kandagatla (7):
  slimbus: core: add of_slim_device_get() helper
  slimbus: core: rearrange slim_eaddr structure
  slimbus: core: add need_tid flag to slim_msg_txn
  slimbus: messaging: pass correct wbuf
  slimbus: messaging: remove multiple calls to pm_runtime_mark_last_busy
  slimbus: messaging: add slim_prepare_txn() helper function
  slimbus: messaging: initialize completion correctly

 drivers/slimbus/core.c      | 39 +++++++++++++++++++
 drivers/slimbus/messaging.c | 92 ++++++++++++++++++++++++++++++---------------
 drivers/slimbus/qcom-ctrl.c |  7 +++-
 drivers/slimbus/slimbus.h   |  3 ++
 include/linux/slimbus.h     | 14 ++++---
 5 files changed, 118 insertions(+), 37 deletions(-)

-- 
2.16.2
