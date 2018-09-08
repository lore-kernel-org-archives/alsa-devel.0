From: zhong jiang <zhongjiang@huawei.com>
Subject: [PATCH 0/2] sound: Use kmemdup to replace kzalloc + memcpy
Date: Sat, 8 Sep 2018 16:36:18 +0800
Message-ID: <1536395780-18725-1-git-send-email-zhongjiang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.com, perex@perex.cz, broonie@kernel.org
Cc: lgirdwood@gmail.com, bgoswami@codeaurora.org, plai@codeaurora.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

I find the issue with the help of Coccinelle.

zhong jiang (2):
  sound: q6core: Use kmemdup to replace kzalloc + memcpy
  sound: skl-topology: Use kmemdup to replace kzalloc + memcpy

 sound/soc/intel/skylake/skl-topology.c | 3 +--
 sound/soc/qcom/qdsp6/q6core.c          | 8 ++------
 2 files changed, 3 insertions(+), 8 deletions(-)

-- 
1.7.12.4
