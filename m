From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] ASoC: Intel: Haswell: Remove set but not used variable 'stage_type'
Date: Thu, 18 Apr 2019 10:48:48 +0800
Message-ID: <20190418024848.39112-1-yuehaibing@huawei.com>
References: <20190417151140.20320-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190417151140.20320-1-yuehaibing@huawei.com>
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
v2: also remove the variable declaration and the static inline mst_get_stage_type
---
 sound/soc/intel/haswell/sst-haswell-ipc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/sound/soc/intel/haswell/sst-haswell-ipc.c b/sound/soc/intel/haswell/sst-haswell-ipc.c
index 31fcdf12..74acf9c 100644
--- a/sound/soc/intel/haswell/sst-haswell-ipc.c
+++ b/sound/soc/intel/haswell/sst-haswell-ipc.c
@@ -345,11 +345,6 @@ static inline u32 msg_get_stream_type(u32 msg)
 	return (msg & IPC_STR_TYPE_MASK) >>  IPC_STR_TYPE_SHIFT;
 }
 
-static inline u32 msg_get_stage_type(u32 msg)
-{
-	return (msg & IPC_STG_TYPE_MASK) >>  IPC_STG_TYPE_SHIFT;
-}
-
 static inline u32 msg_get_stream_id(u32 msg)
 {
 	return (msg & IPC_STR_ID_MASK) >>  IPC_STR_ID_SHIFT;
@@ -666,13 +661,12 @@ static int hsw_module_message(struct sst_hsw *hsw, u32 header)
 
 static int hsw_stream_message(struct sst_hsw *hsw, u32 header)
 {
-	u32 stream_msg, stream_id, stage_type;
+	u32 stream_msg, stream_id;
 	struct sst_hsw_stream *stream;
 	int handled = 0;
 
 	stream_msg = msg_get_stream_type(header);
 	stream_id = msg_get_stream_id(header);
-	stage_type = msg_get_stage_type(header);
 
 	stream = get_stream_by_id(hsw, stream_id);
 	if (stream == NULL)
-- 
2.7.4
