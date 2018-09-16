From: srinivas.kandagatla@linaro.org
Subject: [PATCH 0/7] slimbus: fix module loading
Date: Sun, 16 Sep 2018 16:45:39 -0700
Message-ID: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org, vkoul@kernel.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Hi Greg,

Here are some of the fixes for issues found while testing module loading
on DB820c debian setup.

First 3 core fixes are to do with generating uevents, calling status callback in
probe sequence if the device is up and one fix is able to match device id from
device tree compatible strings.
Second 4 ngd patches fixes few issues firstly with registration, secondly checking
the validity of logical address assigned by remote. Lastly there are few typo fixes.


Thanks,
Srini


Srinivas Kandagatla (7):
  slimbus: core: add support to uevent
  slimbus: core: update device status in probe
  slimbus: core: match device tree based devices correctly
  slimbus: ngd: validate logical address assigned by remote
  silmbus: ngd: register controller after power up.
  slimbus: ngd: return proper error code instead of zero
  slimbus: ngd: register ngd driver only once.

 drivers/slimbus/core.c          | 37 +++++++++++++++++++++++++++++++++++--
 drivers/slimbus/qcom-ngd-ctrl.c | 28 +++++++++++++++++-----------
 2 files changed, 52 insertions(+), 13 deletions(-)

-- 
2.9.3
