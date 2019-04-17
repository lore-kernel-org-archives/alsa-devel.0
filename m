From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: Intel: Haswell: Remove set but not used variable 'stage_type'
Date: Wed, 17 Apr 2019 23:11:40 +0800
Message-ID: <20190417151140.20320-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com, yang.jie@linux.intel.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>
List-Id: alsa-devel@alsa-project.org

From: YueHaibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/intel/haswell/sst-haswell-ipc.c: In function 'hsw_stream_message':
sound/soc/intel/haswell/sst-haswell-ipc.c:669:29: warning: variable 'stage_type' set but not used [-Wunused-but-set-variable]

It is never used since introduction in
commit ba57f68235cf ("ASoC: Intel: create haswell folder and move haswell platform files in")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 31fcdf12..4d3de99 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -672,7 +672,6 @@ static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
 
 	stream_msg = msg_get_stream_type(header);
 	stream_id = msg_get_stream_id(header);
-	stage_type = msg_get_stage_type(header);
 
 	stream = get_stream_by_id(hsw, stream_id);
 	if (stream == NULL)
-- 
2.7.4
