From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] slimbus: minor fixes.
Date: Mon, 14 Jan 2019 13:44:45 +0000
Message-ID: <20190114134449.15367-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org, linux-arm-msm@vger.kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

Here are some minor fixes to slimbus core for issues found while testing wcd9335.
First one is make the slimbus core match full device id,
second one is to avoid using big lock in status callback function,
third one is to use status function rather than directly invoking the status ops.
finally last one is to fix missing spinlock init.

Thanks,
srini


Srinivas Kandagatla (4):
  slimbus: core: match full device id
  slimbus: core: do not call device_status under a lock
  slimbus: core: use slim_device_update_status() to update status
  slimbus: core: add missing spin_lock_init on txn_lock

 drivers/slimbus/core.c | 45 +++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

-- 
2.20.1
