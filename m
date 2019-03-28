From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] soundwire: few trival fixes and cleanups.
Date: Thu, 28 Mar 2019 13:41:30 +0000
Message-ID: <20190328134134.22479-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD089F80769
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 14:42:00 +0100 (CET)
Received: by mail-wm1-x342.google.com with SMTP id h18so4091728wml.1
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2019 06:42:00 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: vkoul@kernel.org
Cc: sanyog.r.kale@intel.com, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, pierre-louis.bossart@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Vinod,
Here are few trivial updates to soundwire which I found while
trying out Qualcomm WCD934x codecs.

Thanks,

Srinivas Kandagatla (4):
  soundwire: add module_sdw_driver helper macro
  soundwire: cdns: fix check for number of messages
  soundwire: bus: check if pm runtime is enabled before calling
  soundwire: remove unused struct sdw_bus_conf definition

 drivers/soundwire/bus.c            | 16 ++++++++++------
 drivers/soundwire/cadence_master.c |  2 +-
 include/linux/soundwire/sdw.h      | 15 ---------------
 include/linux/soundwire/sdw_type.h | 11 +++++++++++
 4 files changed, 22 insertions(+), 22 deletions(-)

-- 
2.21.0
